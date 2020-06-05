*** Settings ***
Library             SeleniumLibrary
Resource            ./CustomKeywords.robot


*** Variable ***
${URL}              https://developer.clashroyale.com/
${BROWSER}          chrome
${EMAIL}            breno-moreira@hotmail.com
${PASSWORD}         Teste123456
${KEY_NAME}         Nova Key
${DESCRIPTION}      Teste descrição


*** Keywords ***
Abrir navegador
    Open Browser                        ${URL}                             ${BROWSER}
    ${EXISTE_COOKIES}                   Run Keyword And Return Status      Existe cookies
    Run Keyword If                      ${EXISTE_COOKIES}                  Fechar verificação de cookies

Fechar navegador
    Close Browser

Clicar no botão login em "${TIPO_TELA}"  
    Wait Until Element Is Visible       class=landing-page
    Run Keyword If                      '${TIPO_TELA}' == 'Mobile'          Clicar em login quando for mobile     
    ...  ELSE                           Clicar em login quando não for mobile
    
Inserir usuário e senha
    Wait Until Element Is Visible       id=email
    Input Text                          id=email            ${EMAIL}
    Input Text                          id=password         ${PASSWORD}

Clicar em login
    Click Button                        xpath=//*[@id="content"]/div/div[2]/div/div/div/div/div/div/form/div[4]/button

Ir até o menu minha conta em "${TIPO_TELA}"
    Wait Until Element Is Visible       xpath=//*[@id="content"]/div/div[2]/div/div/div/div/div/p[1]
    Run Keyword If                      '${TIPO_TELA}' == 'Mobile'          Clicar em my account quando for mobile     
    ...  ELSE                           Clicar em my account quando não for mobile

Criar uma nova chave
    ${IP_ADDRESS}                       Get External Ip
    Wait Until Element Is Visible       xpath=//*[@id="content"]/div/div[2]/div/div/section[2]/div/div/div[2]/p/a
    Click Element                       xpath=//*[@id="content"]/div/div[2]/div/div/section[2]/div/div/div[2]/p/a
    Input Text                          id=name             ${KEY_NAME}
    Input Text                          id=description      ${DESCRIPTION}
    Input Text                          id=range-0          ${IP_ADDRESS}
    Click Element                       xpath=//*[@id="content"]/div/div[2]/div/div/section/div/div/div[2]/form/div[5]/button
    Wait Until Element Is Visible       xpath=//*[@id="content"]/div/div[2]/div/div/section[2]/div/div/div[2]/ul/div
    Coletar token
