*** Settings ***
Documentation       Template robot main suite.

Resource            variables.robot
Resource            Captcha.resource
Resource            SavePdf.resource
Resource            FillDetails.resource
Resource            CreateFolder.resource
Resource            ReadWorkSheet.resource
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



*** Tasks ***
EBRC Process
    EBRC- Create the folders according to dates and save the PDFs in corresponding folders
    Open EBRC Portal And Filling Details


