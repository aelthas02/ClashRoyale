*** Settings ***
Resource            ../resources/Resources.robot
Test Setup          Abrir navegador
Test Teardown       Fechar navegador


*** Test Case ***
# Caso De Teste 01: Criar nova key em Desktop
#     Clicar no botão login em "Desktop"
#     Inserir usuário e senha
#     Clicar em login 
#     Ir até o menu minha conta em "Desktop"
#     Criar uma nova chave 

# Caso De Teste 02: Criar nova key em Mobile
#     Clicar no botão login em "Mobile"
#     Inserir usuário e senha
#     Clicar em login 
#     Ir até o menu minha conta em "Mobile"
#     Criar uma nova chave 

Caso De Teste 03: Utilizando Custom Library
    Localizar clan