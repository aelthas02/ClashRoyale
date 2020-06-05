*** Settings ***
Library             SeleniumLibrary
Library             ../Libraries/CustomLibrary.py


*** Variable *** 
${NOME_CLAN}        The resistance
${LOCALIZACAO}      Brazil


*** Keywords ***

Clicar em login quando não for mobile
    Maximize Browser Window
    Click Element                       xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/a[2]

Clicar em my account quando não for mobile
    Click Button                        xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/div/button
    Click Link                          xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/div/ul/li[1]/a


Clicar em login quando for mobile
    Set Window Size                     1000                1000
    Wait Until Element Is Visible       xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[4]/label/span
    Click Element                       xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[4]/label/span
    Wait Until Element Is Visible       xpath=//*[@id="content"]//a[contains(text(), "Log In")]
    Click Element                       xpath=//*[@id="content"]//a[contains(text(), "Log In")]
    
Clicar em my account quando for mobile
    Wait Until Element Is Visible       xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[4]/label/span
    Click Element                       xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[4]/label/span
    Wait Until Element Is Visible       xpath=//*[@id="content"]/div/div[1]/div/ul[2]/li[3]/a[contains(text(), "My Account")]
    Click Element                       xpath=//*[@id="content"]/div/div[1]/div/ul[2]/li[3]/a[contains(text(), "My Account")]

Existe cookies
    Wait Until Element Is Visible       xpath=/html/body/div[1]/div/a[contains(text(), "Got it!")]

Fechar verificação de cookies
    Click Element                       xpath=/html/body/div[1]/div/a[contains(text(), "Got it!")]

Coletar token
    Wait Until Element Is Visible       css=#content > div > div.drawer-main-container > div > div > section.account__keys > div > div > div.col-xs-light.col-xs-12.col-sm-6.col-md-5.col-md-offset-2 > ul > li:nth-child(2) > a
    Click Element                       css=#content > div > div.drawer-main-container > div > div > section.account__keys > div > div > div.col-xs-light.col-xs-12.col-sm-6.col-md-5.col-md-offset-2 > ul > li:nth-child(2) > a
    ${TOKEN}                            Get Text                xpath=//*[@id="content"]/div/div[2]/div/div/section/div/div/div[2]/form/div[1]/div/samp
    Localizar clan                      ${TOKEN}

Localizar clan
    [Arguments]                         ${TOKEN}
    Get Clan By Name                    ${NOME_CLAN}        ${LOCALIZACAO}          ${TOKEN}