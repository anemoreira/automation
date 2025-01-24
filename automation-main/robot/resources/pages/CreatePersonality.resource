*** Settings ***
Documentation     This is a resource file that contains keywords and actions for the LoginResource

Variables         ../env.py
Resource          ../BaseResource.robot
Library           Browser

*** Variables ***
${ERROR_MESSAGE}               Erro ao salvar as alterações
${AGENT_NAME_INPUT}            //input[@placeholder='Tainá']
${AGENT_FUNCIONALITY_INPUT}    //input[@placeholder='Assistente de Suporte ao Cliente']
${AGENT_GOAL_INPUT}            //textarea[@placeholder='Responder perguntas dos clientes']
${AGENT_INSTRUCTIONS_INPUT}    //input[@placeholder='Você é engraçado, mas não faz piadas']
${SAVE_CHANGES_WARNING}        .quick-test-warn
${LONG_TEXT}                   Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.

*** Keywords ***
Validate empty field error
    [Arguments]                ${iframe_selector}    ${field_selector}    ${button_selector}
    [Documentation]            Validates that an error message is displayed when saving an agent with invalid fields.

    Wait and Click             ${iframe_selector} >>> text="Perfil"
    Clear Text                 ${iframe_selector} >>> ${field_selector}
    Wait and Click             ${iframe_selector} >>> ${button_selector}
    Wait For Elements State    ${iframe_selector} >>> text="${ERROR_MESSAGE}"    visible
    Take Screenshot

Create personality successfully
    [Arguments]                ${iframe_selector}    ${agent_name}    ${functionality}    ${goal}    ${save_button_selector}
    [Documentation]            Fills all mandatory fields and validates that the personality is created successfully.

    Wait and Click             ${iframe_selector} >>> text="Perfil"
    Wait and fill              ${iframe_selector} >>> ${AGENT_NAME_INPUT}            ${agent_name}
    Wait and fill              ${iframe_selector} >>> ${AGENT_FUNCIONALITY_INPUT}    ${functionality}
    Wait and fill              ${iframe_selector} >>> ${AGENT_GOAL_INPUT}            ${goal}
    Wait and Click             ${iframe_selector} >>> ${save_button_selector}
    Wait For Elements State    ${iframe_selector} >>> text="${ERROR_MESSAGE}"        hidden

Create a instruction for the agent
    [Arguments]                ${iframe_selector}    ${instructions}    ${save_button_selector}
    [Documentation]            Fills the instructions field and validates that the personality is created successfully.

    Wait and Click             ${iframe_selector} >>> text="Perfil"
    Wait and fill              ${iframe_selector} >>> ${AGENT_INSTRUCTIONS_INPUT}    ${instructions}
    Wait For Elements State    ${iframe_selector} >>> ${SAVE_CHANGES_WARNING}        visible
    Wait and Click             ${iframe_selector} >>> ${save_button_selector}
    Wait For Elements State    ${iframe_selector} >>> ${SAVE_CHANGES_WARNING}        hidden
    Wait For Elements State    ${iframe_selector} >>> text="${ERROR_MESSAGE}"        hidden

Validate character limit error
    [Arguments]                ${iframe_selector}    ${field_selector}    ${button_selector}
    [Documentation]            Validates that an error message is displayed when saving an agent with fields exceeding character limits.

    Wait and Click             ${iframe_selector} >>> text="Perfil"
    Wait and fill              ${iframe_selector} >>> ${field_selector}    ${LONG_TEXT}
    Wait and Click             ${iframe_selector} >>> ${button_selector}
    Wait For Elements State    ${iframe_selector} >>> text="${ERROR_MESSAGE}"    visible
    Take Screenshot