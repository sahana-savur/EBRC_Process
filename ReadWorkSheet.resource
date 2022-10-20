*** Settings ***
Documentation     Finance- e-BRC Process (Reading the sample excel sheet)

Library         RPA.Excel.Files
Resource        variables.robot
Library         RPA.Tables



*** Keywords ***
Reading the Sample Worksheets
    Open Workbook    ${input_Workbook_path}
    @{table}=    Read Worksheet As Table    name=Sheet1    header=True
    Sleep    3s 
    Close Workbook
    Log    ${table}
    RETURN    ${table}
   