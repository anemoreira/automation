*** Settings ***
Documentation     Application Login Test
Library           Browser
Resource          ../resources/BaseResource.robot
Test Setup        Start session

*** Variables ***
${INVALID_EMAIL}        emailinvalido.com
${INVALID_PASSWORD}     1234
${EXPECTED_MESSAGE}     Invalid username or password.


*** Test Cases ***
Scenario 01: Should log in with valid credentials
    Submit login form          ${EMAIL}    ${PASSWORD}
    Verify Successful Login    ${BASE_URL}/orgs

Scenario 02: Should not log in with invalid credentials
    [Tags]                     login_invalid_credentials
    [Template]                 Login with verify message
    [Documentation]            This test case should not log in with invalid credentials

    username=${EMPTY}                           password=${EMPTY}                  output_message=${EXPECTED_MESSAGE}
    username=${EMAIL}                           password=senha-invalida            output_message=${EXPECTED_MESSAGE}
    username=emailquenaoexiste@gmail.com        password=${PASSWORD}               output_message=${EXPECTED_MESSAGE}