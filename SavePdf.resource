*** Settings ***
Documentation       Template robot main suite.
Resource            variables.robot
Library             RPA.Desktop
Library             RPA.Windows
Library             monthname.py
Library             RPA.Nanonets
Library             RPA.PDF
Library             log.py
Library             DateTime
Library             monthname.py



*** Keywords ***
Save the PDF
    [Arguments]    ${detail}    ${year}    ${month_name}    ${IEC}    ${IFSC}    ${data}    ${counter}    ${now}
    ${now}=    Evaluate    datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")    modules=datetime
    Sleep    8

    #default print selection

    RPA.Desktop.Press Keys    ENTER
    Sleep    06
    Control Window    Save Print Output As
    Send Keys
    ...    id:1001
    ...    ${OUTPUT_DIR}${/}output${/}${year}${/}${month_name}${/}${counter}_${data}_${IEC}_${IFSC}_ ${detail}[Start Date].pdf
    Sleep    03
    log.Logfile
    ...    ${log_filename}
    ...    ${now}
    ...    Info
    ...    Printed at ${OUTPUT_DIR}${/}output${/}${year}${/}${month_name}${/}${counter}_${data}_${IEC}_${IFSC}_ ${detail}[Start Date].pdf Successfully
    RPA.Desktop.Press Keys    ENTER
    Sleep    02

Save the page
    [Arguments]    ${detail}    ${year}    ${month_name}    ${IEC}    ${IFSC}
    RPA.Desktop.Press Keys    ctrl    P
    Sleep    5
    RPA.Desktop.Press Keys    ENTER
    Sleep    06
    Control Window    Save Print Output As
    Send Keys
    ...    id:1001
    ...    ${OUTPUT_DIR}${/}output${/}${year}${/}${month_name}${/}${IEC}_${IFSC}_ ${detail}[Start Date].pdf
    Sleep    03
    RPA.Desktop.Press Keys    ENTER
    Sleep    02