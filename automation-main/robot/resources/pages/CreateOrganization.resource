*** Settings ***
Documentation     This is a resource file that contains keywords and actions for the LoginResource

Variables         ../env.py
Resource          ../BaseResource.robot
Library           Browser

*** Variables ***
${ORG_NAME_SELECTOR}                  //input[@placeholder='Defina o nome da organização']
${DESCRIPTION_SELECTOR}               //textarea[contains(@placeholder,'Descreva brevemente as suas atividades')]
${PROJECT_NAME_SELECTOR}              //input[contains(@placeholder,'Nome do projeto')]
${AGENT_NAME_SELECTOR}                //input[@placeholder='Tainá']
${GOAL_SELECTOR}                      //textarea[@placeholder='Tirar dúvidas e dar informações sobre lhamas']
${NEXT_BUTTON_SELECTOR}               //button[contains(.,'Avançar')]
${CONCLUDE_BUTTON_SELECTOR}           //button[contains(.,'Concluir')]
${CREATE_ORG_TITLE_SELECTOR}          //h1[@class='title'][contains(.,'Criar organização e projeto')]
${START_BUTTON_SELECTOR}              //button[contains(.,'Começar')]
${SUCCES_MESSAGE}                     Projeto criado com sucesso

*** Keywords ***
Go to create organization page
    [Documentation]             Navigates to the create organization page.
    Go To                       ${BASE_URL}/orgs/create
    Wait For Elements State     ${CREATE_ORG_TITLE_SELECTOR}    visible    
    Take Screenshot

Fill organization fields
    [Arguments]                ${organization_name}    ${description}    ${project_name}
    [Documentation]            Fills the fields with text exceeding the character limits.

    Wait and fill              
    ...    ${ORG_NAME_SELECTOR}    
    ...    ${organization_name}
    Wait and fill              
    ...    ${DESCRIPTION_SELECTOR}   
    ...    ${description}
    Wait and fill    
    ...    ${PROJECT_NAME_SELECTOR}   
    ...    ${project_name}    
    
    Wait and Click             ${NEXT_BUTTON_SELECTOR}
    Take Screenshot

Fill custom agent fields
    [Arguments]                ${AGENT_NAME}    ${GOAL}    
    [Documentation]            Fills the custom agent creation fields.
    
    Wait and fill              ${AGENT_NAME_SELECTOR}    ${AGENT_NAME}    
    Wait and fill              ${GOAL_SELECTOR}    ${GOAL}
    Verify element is enabled  ${CONCLUDE_BUTTON_SELECTOR}

Verify organization mandatory fields
    [Arguments]                ${organization_name}    ${description}    ${project_name}
    [Documentation]            Verifies the "Avançar" button is disabled based on the provided input fields.

    Go to create organization page

    IF    '${organization_name}' != '${EMPTY}'
        Wait and fill    ${ORG_NAME_SELECTOR}    ${organization_name}
    END

    IF    '${description}' != '${EMPTY}'
        Wait and fill    ${DESCRIPTION_SELECTOR}   ${description}
    END

    IF    '${project_name}' != '${EMPTY}'
        Wait and fill    ${PROJECT_NAME_SELECTOR}    ${project_name}
    END

    Verify element is disabled    ${NEXT_BUTTON_SELECTOR}

Verify custom agent mandatory fields
    [Arguments]                 ${AGENT_NAME}    ${GOAL}    ${ORGANIZATION_NAME}    ${PROJECT_DESCRIPTION}    ${PROJECT_NAME}    
    [Documentation]             Verifies the "Concluir" button is disabled based on the provided input fields.

    Go to create organization page
    Fill organization fields    ${ORGANIZATION_NAME}    ${PROJECT_DESCRIPTION}    ${PROJECT_NAME}

    IF    '${AGENT_NAME}' != '${EMPTY}'
        Wait and fill    ${AGENT_NAME_SELECTOR}    ${AGENT_NAME}
    END

    IF    '${GOAL}' != '${EMPTY}'
        Wait and fill    ${GOAL_SELECTOR}    ${GOAL}
    END

    Verify element is disabled    ${CONCLUDE_BUTTON_SELECTOR}

Create organization and project
    [Documentation]             Realiza o fluxo completo de criação de uma organização, projeto e agente personalizado.
    Login in the application             
    Go to create organization page
    Fill organization fields    Organização de teste    descrição    Projeto de teste

    Fill custom agent fields    Agente de teste    objetivo
    Wait and Click              ${CONCLUDE_BUTTON_SELECTOR}
    Show message                ${SUCCES_MESSAGE}
    Wait and Click              ${START_BUTTON_SELECTOR}

Leave organization
    [Documentation]            Encapsulates the steps required to leave an organization.

    Go To                       ${BASE_URL}/orgs
    Wait For Elements State     //div[@class='weni-org-list__wrapper list-container']    visible
    Show message                Organização de teste

    Wait and Click              //div[@class='unnnic-dropdown']
    Wait and Click              //div[@class='option danger'][contains(.,'logout Sair da organização')]
    Fill Text                   //input[@placeholder='Confirme o nome da organização para sair dela']    Organização de teste
    Wait and Click              //button[contains(.,'Sair da organização')]
    Show message                Você saiu da organização Organização de teste!
    Wait For Elements State     //div[@class='weni-org-list__wrapper list-container']    hidden
    Take Screenshot

