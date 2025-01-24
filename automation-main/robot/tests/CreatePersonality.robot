*** Settings ***
Documentation     Create Personality Test

Library           Browser
Resource          ../resources/BaseResource.robot
Test Setup        Create organization and project
Task Teardown     Leave organization

*** Variables ***
${IFRAME_SELECTOR}                   //iframe[contains(@allow,'clipboard-read; clipboard-write; microphone; geolocation;')]
${AGENT_NAME_INPUT}                  //input[@placeholder='Tainá']
${SAVE_BUTTON}                       //button[contains(.,'Salvar alterações')]
${AGENT_FUNCIONALITY_INPUT}          //input[@placeholder='Assistente de Suporte ao Cliente']
${AGENT_GOAL_INPUT}                  //textarea[@placeholder='Responder perguntas dos clientes']
${AGENT_INSTRUCTIONS_INPUT}          //input[@placeholder='Você é engraçado, mas não faz piadas']
${CHAT_INPUT}                        //input[@placeholder='Digite uma mensagem']
${SAVE_CHANGES_WARNING}              .quick-test-warn
${VALID_AGENT_NAME}                  Teste123
${VALID_AGENT_FUNCTIONALITY}         Automação
${VALID_AGENT_GOAL}                  Responder perguntas sobre vendas
${AGENT_INSTRUCTION}                 o único produto em estoque é a coca-cola

*** Test Cases ***
Scenario 01: Should show error message when the name field is empty
    [Documentation]    Test to verify the "Salvar alterações" button is disabled when mandatory fields are not filled.
    [Tags]             personality_creation

    Validate empty field error    ${IFRAME_SELECTOR}    ${AGENT_NAME_INPUT}    ${SAVE_BUTTON}
  
Scenario 02: Should show error message when the functionality field is empty
    [Documentation]    Test to verify the "Salvar alterações" button is disabled when mandatory fields are not filled.
    [Tags]             personality_creation

    Validate empty field error    ${IFRAME_SELECTOR}    ${AGENT_FUNCIONALITY_INPUT}    ${SAVE_BUTTON}

Scenario 03: Should show error message when the goal field is empty
    [Documentation]    Test to verify the "Salvar alterações" button is disabled when mandatory fields are not filled.
    [Tags]             personality_creation

    Validate empty field error    ${IFRAME_SELECTOR}    ${AGENT_GOAL_INPUT}    ${SAVE_BUTTON}

Scenario 04: Should create a personality successfully
    [Documentation]    Test to verify the "Salvar alterações" button is enabled when all mandatory fields are filled.
    [Tags]             personality_creation

    Create personality successfully    
    ...    ${IFRAME_SELECTOR}    
    ...    ${VALID_AGENT_NAME}    
    ...    ${VALID_AGENT_FUNCTIONALITY}   
    ...    ${VALID_AGENT_GOAL}    
    ...    ${SAVE_BUTTON}

Scenario 05: Should configure general instructions for the agent successfully
    [Documentation]    Test to verify the "Salvar alterações" button is enabled when all mandatory fields are filled.
    [Tags]             personality_creation

    Create a instruction for the agent    ${IFRAME_SELECTOR}    ${AGENT_INSTRUCTION}    ${SAVE_BUTTON}

Scenario 06: Should not be possible to create a personality with fields exceeind character limits
    [Documentation]    Test to verify the system handles fields exceeding character limits.
    [Tags]             personality_creation

    Validate character limit error    ${IFRAME_SELECTOR}    ${AGENT_NAME_INPUT}    ${SAVE_BUTTON}