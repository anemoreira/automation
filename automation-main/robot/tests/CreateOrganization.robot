*** Settings ***
Documentation     Create Organization Test

Library           Browser
Resource          ../resources/BaseResource.robot
Test Setup        Login in the application

*** Variables ***
${ORGANIZATION_NAME}                 Organização de teste
${LONG_TEXT}                         Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec nisl
${AGENT_NAME}                        Agente de teste
${GOAL}                              Automatizar a criação de uma organização e um projeto
${ERROR_MESSAGE}                     Ocorreu um erro ao criar o projeto, tente novamente mais tarde Nome da organização: Certifique-se de que este campo não tenha mais de 40 caracteres.
${PROJECT_DESCRIPTION}               Automatizando a criação de uma organização e um projeto
${PROJECT_NAME}                      Projeto de teste
${CONCLUDE_BUTTON_SELECTOR}          //button[contains(.,'Concluir')]
${START_BUTTON_SELECTOR}             //button[contains(.,'Começar')]
${SUCCES_MESSAGE}                    Projeto criado com sucesso

*** Test Cases ***
Scenario 01: Attempt to create an organization without filling mandatory fields
    [Documentation]    Test to verify the "Avançar" button is disabled when mandatory fields are not filled.
    [Template]         Verify organization mandatory fields
    [Tags]             organization_creation_validation

    organization_name=${EMPTY}           description=${EMPTY}                      project_name=${EMPTY}
    organization_name=${LONG_TEXT}       description=${EMPTY}                      project_name=${EMPTY}
    organization_name=${EMPTY}           description=${PROJECT_DESCRIPTION}        project_name=${EMPTY}
    organization_name=${LONG_TEXT}       description=${PROJECT_DESCRIPTION}        project_name=${EMPTY}
    organization_name=${EMPTY}           description=${EMPTY}                      project_name=${PROJECT_NAME}
    organization_name=${LONG_TEXT}       description=${EMPTY}                      project_name=${PROJECT_NAME}
    

Scenario 02: Attempt to create an custom agent without filling mandatory fields
    [Documentation]             Test to verify error messages when mandatory fields are not filled.
    [Template]                  Verify custom agent mandatory fields
    [Tags]                      organization_creation_validation

    AGENT_NAME=${EMPTY}                GOAL=${EMPTY}                ORGANIZATION_NAME=${ORGANIZATION_NAME}    PROJECT_DESCRIPTION=${PROJECT_DESCRIPTION}    PROJECT_NAME=${PROJECT_NAME}
    AGENT_NAME=${ORGANIZATION_NAME}    GOAL=${EMPTY}                ORGANIZATION_NAME=${ORGANIZATION_NAME}    PROJECT_DESCRIPTION=${PROJECT_DESCRIPTION}    PROJECT_NAME=${PROJECT_NAME}
    AGENT_NAME=${EMPTY}                GOAL=${ORGANIZATION_NAME}    ORGANIZATION_NAME=${ORGANIZATION_NAME}    PROJECT_DESCRIPTION=${PROJECT_DESCRIPTION}    PROJECT_NAME=${PROJECT_NAME}  

Scenario 03: Attempt to create an organization with fields exceeding character limits
    [Documentation]             Test to verify the system handles fields exceeding character limits.
    [Tags]                      organization_creation_validation

    Go to create organization page
    Fill organization fields    ${LONG_TEXT}    ${PROJECT_DESCRIPTION}    ${PROJECT_NAME}    
    Fill custom agent fields    ${AGENT_NAME}    ${GOAL}
    Wait and Click              ${CONCLUDE_BUTTON_SELECTOR}
    Show message                ${ERROR_MESSAGE}

Scenario 04: Validate full flow for organization and agent
    [Documentation]             Test to validate the full flow for organization and agent creation.
    [Tags]                      organization_creation_validation

    Go to create organization page
    Fill organization fields    ${ORGANIZATION_NAME}    ${PROJECT_DESCRIPTION}    ${PROJECT_NAME}
    Fill custom agent fields    ${AGENT_NAME}    ${GOAL}
    Wait and Click              ${CONCLUDE_BUTTON_SELECTOR}
    Show message                ${SUCCES_MESSAGE}
    Wait and Click              ${START_BUTTON_SELECTOR}
    Take Screenshot

Scenario 05: Should not be possible leaving the organization without confirmation
    [Documentation]             Test to validate the user can't leave the organization without confirmation.
    [Tags]                      organization_creation_validation

    Go To                       https://dash.weni.ai/orgs
    Wait For Elements State     //div[@class='weni-org-list__wrapper list-container']    visible
    Show message                ${ORGANIZATION_NAME}
    
    Wait and Click              //div[@class='unnnic-dropdown']
    Wait and Click              //div[@class='option danger'][contains(.,'logout Sair da organização')]
    Verify element is disabled  //button[contains(.,'Sair da organização')]

Scenario 06: Leaving the organization
    [Documentation]             Test to validate the user can leave the organization.
    [Tags]                      organization_creation_validation

    Go To                       https://dash.weni.ai/orgs
    Wait For Elements State     //div[@class='weni-org-list__wrapper list-container']    visible
    Show message                ${ORGANIZATION_NAME}

    Wait and Click              //div[@class='unnnic-dropdown']
    Wait and Click              //div[@class='option danger'][contains(.,'logout Sair da organização')]
    Take Screenshot
    Fill Text                   //input[@placeholder='Confirme o nome da organização para sair dela']    ${ORGANIZATION_NAME}
    Wait and Click              //button[contains(.,'Sair da organização')]
    Show message                Você saiu da organização Organização de teste!
    Wait For Elements State     //div[@class='weni-org-list__wrapper list-container']    hidden