*** Settings ***
Library             SeleniumLibrary
Library             ../Libraries/CustomLibrary.py


*** Variable ***
${URL}              https://developer.clashroyale.com/
${BROWSER}          chrome
${EMAIL}            breno-moreira@hotmail.com
${PASSWORD}         Teste123456
${KEY_NAME}         Nova Key
${DESCRIPTION}      Teste descrição  
${NOME_CLAN}        The resistance
${LOCALIZACAO}      Brazil


*** Keywords ***
Abrir navegador
    Open Browser                        ${URL}              ${BROWSER}

Fechar navegador
    Close Browser

Clicar no botão login em "${TIPO_TELA}"  
    Wait Until Element Is Visible       class=landing-page
    Run Keyword If                      '${TIPO_TELA}' == 'Mobile'           Clicar em login quando for mobile     
    ...  ELSE                           Clicar em login quando não for mobile
    
Inserir usuário e senha
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



### 
Clicar em login quando não for mobile
    Maximize Browser Window
    Click Element                       xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/a[2]

Clicar em my account quando não for mobile
    Click Button                        xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/div/button
    Click Link                          xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/div/ul/li[1]/a


Clicar em my account quando for mobile
    Click Element                       xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[4]/label/span
    Wait Until Element Is Visible       xpath=//*[@id="content"]/div/div[1]/div/ul[2]/li[3]/a
    Click Element                       xpath=//*[@id="content"]/div/div[1]/div/ul[2]/li[3]/a

Clicar em login quando for mobile
    Wait Until Element Is Visible       xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[4]/label/span
    Click Element                       xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[4]/label/span
    Wait Until Element Is Visible       xpath=//*[@id="content"]/div/div[1]
    Click Element                       xpath=//*[@id="content"]/div/div[1]/ul/li[2]/a


Coletar token
    Wait Until Element Is Visible       css=#content > div > div.drawer-main-container > div > div > section.account__keys > div > div > div.col-xs-light.col-xs-12.col-sm-6.col-md-5.col-md-offset-2 > ul > li:nth-child(2) > a
    Click Element                       css=#content > div > div.drawer-main-container > div > div > section.account__keys > div > div > div.col-xs-light.col-xs-12.col-sm-6.col-md-5.col-md-offset-2 > ul > li:nth-child(2) > a
    ${TOKEN}                            Get Text                xpath=//*[@id="content"]/div/div[2]/div/div/section/div/div/div[2]/form/div[1]/div/samp
    Localizar clan                      ${TOKEN}

Localizar clan
    [Arguments]                         ${TOKEN}
    Get Clan By Name                    ${NOME_CLAN}        ${LOCALIZACAO}          ${TOKEN}
