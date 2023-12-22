*** Settings ***
Library           SeleniumLibrary

*** variables ***


*** Test Cases ***

testcase-login-1
    Open Browser    http://127.0.0.1:8000    chrome
    Click Element     xpath://a[@href='/login']
    Page Should Contain Element   xpath://input[@name='email']
    input text        name:email       test@mail.com
    Input Text    name:password    123456
    Click Element     xpath://button[@type='submit']
    Page Should Contain Element    xpath://span[@id='welcome']
    Close Browser


testcase-login-2
    Open Browser    http://127.0.0.1:8000    chrome
    Click Element     xpath://a[@href='/login']
    Page Should Contain Element   xpath://input[@name='email']
    input text        name:email       test@mail.com
    Input Text    name:password    7uyhgt7ygu7
    Click Element     xpath://button[@type='submit']
    Page Should Not Contain Element    xpath://span[@id='welcome']
    Close Browser