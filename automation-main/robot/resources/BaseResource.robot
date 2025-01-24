*** Settings ***
Documentation     This is a resource file that contains keywords for the BaseResource

Variables         env.py
Library           Browser

Resource          ../resources/pages/Login.resource
Resource          ../resources/pages/CreateOrganization.resource
Resource          ../resources/pages/CreatePersonality.resource


*** Keywords ***
Start session
    [Documentation]                Start a new browser session
    Set Browser Timeout            60s
    New Browser                    browser=${BROWSER}    headless=${HEADLESS}    args=["--lang=pt-BR"]
    New Page                       ${BASE_URL}

Login in the application
    [Documentation]                Login in the application
    Start session
    Go to login page
    Submit login form              ${EMAIL}    ${PASSWORD}
    Verify Successful Login        https://dash.weni.ai/orgs


Wait and Click
    [Documentation]                Waits for an element to be visible and then clicks it
    [Arguments]                    ${element_selector}
    Wait For Elements State        ${element_selector}    visible    
    Click                          selector=${element_selector}

Wait and fill
    [Documentation]                Waits for an element to be visible and then fills it
    [Arguments]                    ${element_selector}    ${text}
    Wait For Elements State        ${element_selector}    visible    
    Fill Text                      ${element_selector}    ${text}

Show message
    [Arguments]                   ${message}
    Wait For Elements State       text=${message}    visible    
    Take Screenshot

Verify element is disabled
    [Arguments]                   ${selector}
    [Documentation]               Verifies if the specified element is disabled.
    ${states}=                    Get Element States     ${selector}
    Should Contain                ${states}              disabled
    Take Screenshot

Verify element is enabled
    [Arguments]                  ${selector}
    [Documentation]              Verifies if the specified element is enabled.
    ${states}=                   Get Element States     ${selector}
    Should Not Contain           ${states}              disabled
    Take Screenshot