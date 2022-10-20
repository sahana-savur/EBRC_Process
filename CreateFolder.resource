*** Settings ***
Documentation       Template robot main suite.
Resource            ReadWorkSheet.resource
Library             RPA.FileSystem
Library             String
Library             monthname.py

*** Keywords ***
EBRC- Create the folders according to dates and save the PDFs in corresponding folders
    ${Start_DATE}=    Reading the Sample Worksheets
    Get Start date and creating folders    ${Start_DATE}


Creating Folders with Year and inside Month Folders
    [Arguments]    ${element}
    Log    ${element}
    ${start_date}=    Convert To String    ${element}
    ${startdate_Substring_year}=    Get Substring    ${start_date}    6    10
    Log    ${startdate_Substring_year}
    ${startdate_Substring_Month}=    Get Substring    ${start_date}    3    5
    Log    ${startdate_Substring_Month}
    Create Directory    ${OUTPUT_DIR}${/}output${/}
    Create Directory    ${OUTPUT_DIR}${/}output${/}${startdate_Substring_year}
    ${month_name}=    monthname.Month Name    ${startdate_Substring_Month}
    ${MONTH_NAME}=    Convert To Upper Case    ${month_name}
    Create Directory    ${OUTPUT_DIR}${/}output${/}${startdate_Substring_year}${/}${MONTH_NAME}


Get Start date and creating folders
    [Arguments]    ${date}
    FOR    ${element}    IN    @{date}
        Log    ${element}
        ${value}=    Print the start date    ${element}
        Log    ${value}
        Creating Folders with Year and inside Month Folders    ${value}
    END


Print the start date
    [Arguments]    ${row}
    RETURN    ${row}[Start Date]