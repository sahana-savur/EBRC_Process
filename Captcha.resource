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

*** Keywords ***
Enter Captcha
    [Arguments]    ${now}
    ${now}=    Evaluate    datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")    modules=datetime
    Add heading    Please Enter the Captcha
    Add text input    text    label=captcha
    Sleep    02
    ${result}=    Get Value From User    Please Enter the Captcha
    Log    ${result}
    log.Logfile    ${log_filename}    ${now}    Info    Entered Captcha is ${result}
    Input Text    //input[@name='captext']    ${result}
    Clear elements
    log.Logfile    ${log_filename}    ${now}    Info    Results cleared for next execution
    Click Button    //input[@name='B1']    #Show Details
    log.Logfile    ${log_filename}    ${now}    Info    Clicked on Show Details

Re Enter Details
    [Arguments]    ${detail}    ${now}
    ${now}=    Evaluate    datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")    modules=datetime
    Input Text    //input[@name='iec']    ${IEC}
    log.Logfile    ${log_filename}    ${now}    Info    Entered IEC Number
    Input Text    //input[@name='ifsc']    ${IFSC}
    log.Logfile    ${log_filename}    ${now}    Info    Entered IFSC Number
    Input Text    //input[@name='fdate']    ${detail}[Start Date]
    log.Logfile    ${log_filename}    ${now}    Info    Entered Start Date
    Input Text    //input[@name='tdate']    ${detail}[End Date]
    log.Logfile    ${log_filename}    ${now}    Info    Entered End Date