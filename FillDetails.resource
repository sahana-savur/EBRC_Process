*** Settings ***
Documentation       Template robot main suite.
Resource            variables.robot
Library             RPA.Browser.Selenium    auto_close=${False}
Library             RPA.Desktop
Library             Dialogs
Library             RPA.Dialogs
Library             RPA.Excel.Files
Library             RPA.Windows
Library             String
Library             monthname.py
Library             RPA.Windows
Library             Process
Library             RPA.Nanonets
Library             RPA.PDF
Library             log.py
Resource            readinput_ExcelFile.resource
Library             DateTime
Library             String
Library             Collections
Library             RPA.FileSystem
Library             RPA.FTP
Library             monthname.py
Library             RPA.Desktop.OperatingSystem
Resource            Captcha.resource
Resource            SavePdf.resource


*** Keywords ***
Open EBRC Portal And Filling Details
    Open Available Browser    http://dgftebrc.nic.in:8100/BRCQueryTrade/index.jsp    maximized=True#loop
    Sleep    10s
    ${now}=    Evaluate    datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")    modules=datetime
    Log    ${now}
    log.Logfile    ${log_filename}    ${now}    Info    This should pass
    ${details}=    Get the list of people from the Excel file    ${now}
    log.Logfile    ${log_filename}    ${now}    Info    Input Excel File Read Complete
    FOR    ${detail}    IN    @{details}
        Input form dialog in browser    ${detail}    ${IEC}    ${IFSC}    ${now}
        Open Available Browser    http://dgftebrc.nic.in:8100/BRCQueryTrade/index.jsp    maximized=True
        log.Logfile    ${log_filename}    ${now}    Info    Record Entered Successfully
    END
    Sleep    5s
    [Teardown]    Close All Browsers

Get the list of people from the Excel file
    [Arguments]    ${now}
    ${now}=    Evaluate    datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")    modules=datetime
    RPA.Excel.Files.Open Workbook    SampleData.xlsx
    log.Logfile    ${log_filename}    ${now}    Info    Excel File Read Successfully
    ${table}=    Read Worksheet As Table    header=True
    Close Workbook
    log.Logfile    ${log_filename}    ${now}    Info    Excel File Closed Successfully
    RETURN    ${table}

Input form dialog in browser
    [Arguments]    ${detail}    ${IEC}    ${IFSC}    ${now}
    ${now}=    Evaluate    datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")    modules=datetime
    Input Text    //input[@name='iec']    ${IEC}
    log.Logfile    ${log_filename}    ${now}    Info    Entered IEC Number
    Input Text    //input[@name='ifsc']    ${IFSC}
    log.Logfile    ${log_filename}    ${now}    Info    Entered IFSC Number
    Input Text    //input[@name='fdate']    ${detail}[Start Date]
    log.Logfile    ${log_filename}    ${now}    Info    Entered Start Date
    Input Text    //input[@name='tdate']    ${detail}[End Date]
    log.Logfile    ${log_filename}    ${now}    Info    Entered End Date
    Enter Captcha    ${now}
    ${sample_text}=    rpa.browser.selenium.Get Text    xpath://b//font[1]
    ${sample_text_converted}=    Convert To String    ${sample_text}
    Sleep    2s
    Get Length    ${sample_text_converted.strip()}
    Get Length    ${sample_text}
    Get Length    ${expected_text}
    TRY
        WHILE    "${expected_text}[2]"!="${sample_text_converted}[2]"    limit=1
            Re Enter Details    ${detail}    ${now}
            Enter Captcha    ${now}
            ${sample_text}=    rpa.browser.selenium.Get Text    xpath://b//font[1]
            ${sample_text_converted}=    Convert To String    ${sample_text}
            ${captcha_counter}=    Evaluate    ${captcha_counter}+1
            ${message}=    Set variable    Pass
        END
    EXCEPT    WHILE loop was aborted    type=start
        log.Logfile    ${log_filename}    ${now}    Info    The loop did not finish within the limit.
        ${message}=    Set variable    Fail
        Log    The loop did not finish within the limit.
    END
    IF    '${message}' == "Pass"
        Entering Other Details    ${detail}    ${now}
    ELSE
        log.Logfile    ${log_filename}    ${now}    Info    next record
        Close All Browsers
    END

Entering Other Details
    [Arguments]    ${detail}    ${now}
    ${now}=    Evaluate    datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")    modules=datetime
    @{month_num}=    Split String    ${detail}[Start Date]    .
    Log    ${month_num}[1]
    log.Logfile    ${log_filename}    ${now}    Info    ${month_num}[1]

    ${mnum}=    Set Variable    ${month_num}[1]
    ${month_name}=    monthname.Full Month Name    ${mnum}
    ${month_name}=    Convert To Upper Case    ${month_name}
    log.Logfile    ${log_filename}    ${now}    Info    ${month_name}
    Log    ${month_name}
    ${year}=    Set Variable    ${month_num}[2]
    log.Logfile    ${log_filename}    ${now}    Info    ${year}
    Save the page    ${detail}    ${year}    ${month_name}    ${IEC}    ${IFSC}
    log.Logfile    ${log_filename}    ${now}    Info    First Page Captured Successfully
    Sleep    02
    ${rows}=    Get Element Count    //body[1]/div[2]/center[1]/table[1]/tbody/tr
    Log    ${rows}
    log.Logfile    ${log_filename}    ${now}    Info    ${rows} count present
    ${rows}=    Evaluate    ${rows}-1
    FOR    ${counter}    IN RANGE    ${rows}
        ${count}=    evaluate    ${counter}+2
        ${count2}=    evaluate    ${counter}+3
        Log    ${count}
        ${data}=    rpa.browser.Selenium.Get Text    //body[1]/div[2]/center[1]/table[1]/tbody[1]/tr[${count}]/td[4]
        Log    ${data}
        log.Logfile    ${log_filename}    ${now}    Info    ${data}
        ${data}=    Convert To String    ${data}
        # ${data2}=    Convert To String    ${data2}
        # Log    ${data2}

        Click Element    //body[1]/div[2]/center[1]/table[1]/tbody[1]/tr[${count}]/td[11]
        log.Logfile    ${log_filename}    ${now}    Info    Clicking print for ${counter} record
        Log    ${count}

        Save the PDF    ${detail}    ${year}    ${month_name}    ${IEC}    ${IFSC}    ${data}    ${counter}    ${now}
        log.Logfile    ${log_filename}    ${now}    Info    Saved PDF's Successfully
    END
    log.Logfile    ${log_filename}    ${now}    Info    Closed browsers Successfully
    [Teardown]    Close All Browsers
