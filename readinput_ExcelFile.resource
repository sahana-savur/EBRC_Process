*** Settings ***
Documentation     Finance- e-BRC Process (Reading the sample excel sheet)
Library           RPA.Excel.Files
Library           RPA.Tables
Library           RPA.Windows
Library           Collections
Resource          variables.robot


*** Keywords ***
Reading the Sample Worksheet
    Open Workbook    ${input_Workbook_path}
    @{table}=    Read Worksheet As Table    name=Sheet1    header=True
    Sleep    3s 
    Close Workbook
    Log    ${table}
    RETURN    ${table}
   

Minimal task
    Log    Done.
