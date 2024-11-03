*** Settings***
Documentation    Testes Sprint 13
Library     RequestsLibrary
Library     String
Library     Collections
Library     OperatingSystem

*** Variables ***
${base_url}      https://ron-bugado.qacoders.dev.br/api/
${token}         eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmRiNWQ4NDFkZjU1NDE1MGU2ZDY0YmQiLCJmdWxsTmFtZSI6IlFhLUNvZGVycy1TWVNBRE1JTiIsIm1haWwiOiJzeXNhZG1pbkBxYWNvZGVycy5jb20iLCJwYXNzd29yZCI6IiQyYiQxMCR1NGcwYm81OTlFa1E4RGZSeGw4bHlPTzhiaDZ5QnlyRlVhN2k5cDV0N2pycElFaUx6MzJMLiIsImFjY2Vzc1Byb2ZpbGUiOiJTWVNBRE1JTiIsImNwZiI6IjExMTExMTExMTExIiwic3RhdHVzIjp0cnVlLCJhdWRpdCI6W3sicmVnaXN0ZXJlZEJ5Ijp7InVzZXJJZCI6IjExMTExMTExMTExMTExMTExMSIsInVzZXJMb2dpbiI6InN5c2FkbWluQHFhY29kZXJzLmNvbSJ9LCJyZWdpc3RyYXRpb25EYXRlIjoic2V4dGEtZmVpcmEsIDA2LzA5LzIwMjQsIDE2OjUyOjM2IEJSVCIsInJlZ2lzdHJhdGlvbk51bWJlciI6IjAxIiwiY29tcGFueUlkIjoiUWEuQ29kZXJzIiwiX2lkIjoiNjZkYjVkODQxZGY1NTQxNTBlNmQ2NGJlIn1dLCJfX3YiOjAsImlhdCI6MTcyODU3MDcwNywiZXhwIjoxNzI4NjU3MTA3fQ.PWHMHNx0yeLUBtbW-HY2rdnudAbz_A39lhstThgax08
${id_vazio}      " "
${id_menor}      670
${id_maior}      6707e624eed30dc911c4b5132555555555
${ID_USUARIO}    6707e624eed30dc911c4b513

*** Test Cases ***
 
Deletar Usuarios
    Criar Sessao
    Massa de Dados Usuario
    Login Usuario
    Criar Usuario
    Deletar usuário por ID 
    
*** Keywords ***
Criar Sessao
    ${headers}    Create Dictionary    accept=application/json    content-Type=application/json    authorization=${token}
    Create Session    alias=develop    url=${base_url}   headers=${headers}    timeout=120  verify=true 

Massa de Dados Usuario
    ${palavra_randomica_1}    Generate Random String    length=8    chars=[LETTERS]
    ${palavra_randomica_1}    Convert To Lower Case    ${palavra_randomica_1}
    ${numero_randomico_cpf}    Generate Random String    length=11   chars=[NUMBERS]
    ${fullName_randomico}    Generate Random String        length=10    chars=[LETTERS]    
    Set Test Variable    ${FULLNAME}    A${fullName_randomico}    
    Set Test Variable    ${CPF}     ${numero_randomico_cpf}        
    Set Test Variable    ${EMAIL}    ${palavra_randomica_1}@qacoders.com.br        
    Log                  ${EMAIL}
        
Login Usuario
    ${headers}    Create Dictionary    accept=application/json   Content-Type=application/json    
    Create Session    alias=develop    url=${base_url}   headers=${headers}    timeout=120  verify=true 
     ${body}          Create Dictionary  
    ...  mail=sysadmin@qacoders.com
    ...  password=1234@Test
    ${resposta}    POST On Session     alias=develop    url=login    json=${body}
    Set Global Variable    ${TOKEN}    ${resposta.json()["token"]}   # seta a variavel token e mostra o caminho 
    Log To Console    Token: ${TOKEN} 

Criar Usuario 
    ${body}    Create Dictionary 
    ...    fullName=${FULLNAME}
    ...    mail=${EMAIL}
    ...    password=1234@Test 
    ...    accessProfile=ADMIN
    ...    cpf=${CPF}
    ...    confirmPassword=1234@Test
    Log    ${body}
    Criar Sessao
    ${resposta}    POST On Session    alias=develop    url=user    json=${body}
    Status Should Be    201    ${resposta}
    Log    ${resposta.json()}
    Set Suite Variable    ${ID_USUARIO}     ${resposta.json()["user"]["_id"]}
    Set Test Variable     ${RESPOSTA}       ${resposta.json()}
 

Deletar usuário por ID 
    ${resposta_delete_user}    DELETE On Session       alias=develop    url=user/${ID_USUARIO}    
    Set Test Variable    ${resposta_delete_user}    ${resposta_delete_user.json()}
