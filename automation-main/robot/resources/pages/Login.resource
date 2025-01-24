*** Settings ***
Documentation     This is a resource file that contains keywords and actions for the LoginResource

Variables         ../env.py
Resource          ../BaseResource.robot
Library           Browser

*** Keywords ***
Go to login page
    [Documentation]             Go to the login page
    Go To                       ${BASE_URL}  
    Wait For Elements State     xpath=//input[contains(@name,'username')]      visible    timeout=30s
    Take Screenshot

Submit login form
    [Arguments]                 ${email}    ${password}
    [Documentation]             Submit the login form with the given credentials
    Fill Text                   xpath=//input[contains(@name,'username')]      ${email}
    Fill Text                   xpath=//input[contains(@type,'password')]      ${password}   
    Wait and Click              xpath=//button[contains(@class,'login-button')]

Login with verify message
    [Arguments]                 ${username}    ${password}    ${output_message}
    [Documentation]             This keyword should log in with invalid credentials
    Go to login page
    Submit login form           ${username}    ${password}
    Show message                ${output_message}

Verify Successful Login
    [Arguments]                 ${expected_url}
    [Documentation]             Verify if the login was successful
    Wait For Navigation         ${expected_url}      
    Wait For Elements State     xpath=//h1[contains(.,'Suas organizações')]         visible    timeout=30s
    Wait For Elements State     xpath=//button[contains(.,'Criar organização')]     visible    timeout=30s
    Take Screenshot    