*** Settings ***
Library           SeleniumLibrary

*** variables ***
${BROWSER}     headlesschrome
${HOST}    http://127.0.0.1:8000

${EMAIL}    test@mail.com
${PASS-1}    123456    # correct password
${PASS-2}    xxs12s2    # wrong password

${COMPANY}    global.inc
${TITLE}    [TEST] Senior Engineering manager
${LOCATION}     Singapore
${TAGS}    engineering manager software
${JOBEMAIL}    jobs@global.co
${WEBSITE}    https://global.co
${DESCRIPTION}     Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

*** Test Cases ***

# login
# positive test
testcase-1
    Login Success
    Close Browser    

# negative test
testcase-2
    Open Browser    ${HOST}    ${BROWSER}
    Click Element     xpath://a[@href='/login']
    Page Should Contain Element   xpath://input[@name='email']
    input text        name:email       ${EMAIL}
    input text        name:password    ${PASS-2}
    Click Element     xpath://button[@type='submit']
    Page Should Not Contain Element  xpath://a[@href='/listings/manage']
    Close Browser 

# logout
testcase-3
    Login Success
    Click Element     xpath://button[@id='logout']
    Page Should Contain Element    xpath://a[@href='/login']
    Close Browser 

#post job
testcase-4
    Login Success
    Click Element     xpath://a[@href='/listings/create']
    Page Should Contain Element   xpath://input[@name='company']
    input text        name:company       ${COMPANY}
    input text        name:title       ${TITLE}
    input text        name:location       ${LOCATION}
    input text        name:email       ${JOBEMAIL}
    input text        name:website       ${WEBSITE}
    Input Text        name:tags       ${TAGS}
    Input Text        name:description       ${DESCRIPTION}
    Click Element     xpath://button[@id='create']
    Close Browser 

# delete post
testcase-5
    Login Success
    Click Element     xpath://a[@href='/listings/manage']
    Click Element     xpath://button[@id='delete']
    Close Browser
    
testcase-6
    Login Success
    Click Element     xpath://a[@href='/listings/create']
    Page Should Contain Element   xpath://input[@name='company']
    sleep     5s
    Scroll Down Until End

*** Keywords ***

Scroll Down Until End
    ${previous_height}=    Execute Javascript    return document.body.scrollHeight;
    FOR  ${i}    IN RANGE    10
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
        Sleep    1s
        ${current_height}=    Execute Javascript    return document.body.scrollHeight;
        Exit For Loop If    '${current_height}' == '${previous_height}'
        ${previous_height}=    Set Variable    ${current_height}
        Sleep    2s
    END

Login Success
    Open Browser    ${HOST}    ${BROWSER}
    Click Element     xpath://a[@href='/login']
    Page Should Contain Element   xpath://input[@name='email']
    input text        name:email       ${EMAIL}
    input text        name:password    ${PASS-1}
    Click Element     xpath://button[@type='submit']
    Page Should Contain Element   xpath://a[@href='/listings/manage']