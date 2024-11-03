*** Settings ***
Documentation    Listar empresas

Library    RequestsLibrary
Library    Collections


*** Variables ***
${base_url}    https://ron-bugado.qacoders.dev.br/api
${id_get}    6704169beed30dc911c09be8
${token_expirado_get}    eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTMzMGI1NGRhOTg2MTk5NWQ0ZWIzMDIiLCJmdWxsTmFtZSI6IlFhLUNvZGVycy1TWVNBRE1JTiIsIm1haWwiOiJzeXNhZG1pbkBxYWNvZGVycy5jb20iLCJwYXNzd29yZCI6IiQyYiQxMCQxYXhmcG5ZWnBDM2hwdk9SeU5tVXdPQUVQR1RoLlMva1R6R21OVmhaSUZpSjM2NjUvUE5uTyIsImFjY2Vzc1Byb2ZpbGUiOiJTWVNBRE1JTiIsImNwZiI6IjExMTExMTExMTExIiwic3RhdHVzIjp0cnVlLCJhdWRpdCI6W3sicmVnaXN0ZXJlZEJ5Ijp7InVzZXJJZCI6IjExMTExMTExMTExMTExMTExMSIsInVzZXJMb2dpbiI6InN5c2FkbWluQHFhY29kZXJzLmNvbSJ9LCJyZWdpc3RyYXRpb25EYXRlIjoic2V4dGEtZmVpcmEsIDIwLzEwLzIwMjMsIDIwOjIwOjUyIEJSVCIsInJlZ2lzdHJhdGlvbk51bWJlciI6IjAxIiwiY29tcGFueUlkIjoiUWEuQ29kZXJzIiwiX2lkIjoiNjUzMzBiNTRkYTk4NjE5OTVkNGViMzAzIn1dLCJfX3YiOjAsImlhdCI6MTcyNTU2NDU2NSwiZXhwIjoxNzI1NjUwOTY1fQ.t1IpEyJbn9IlWSM_t2WBoeW41Or90K2O2yFL8O-x_4M

*** Test Cases ***
LISTAR TODAS AS EMPRESAS
    Pegar Token
    Listar todas as empresas

CONTAGEM DE EMPRESAS
    Contagem de empresas

LISTAR COMPANHIAPOR ID
    Listar companhia por id

LISTAR COMPANHIA UTILIZANDO TOKEN EXPIRADO
    Listar companhia utilizando token expirado


*** Keywords ***

Criar uma sessão
    ${header}    Create Dictionary    accept=application/json    ontent-Type=application/json
    Create Session    alias=listar_cia    url=${base_url}    headers=${header}    verify=true    disable_warnings=true

Pegar token
    ${body}    Create Dictionary    mail=sysadmin@qacoders.com    password=1234@Test
    Criar uma sessão
    ${pegar_token}    POST On Session    alias=listar_cia    url=/login    json=${body}
    #Log To Console    ${pegar_token.json()['token']}
    RETURN    ${pegar_token.json()["token"]}

Listar todas as empresas
    ${token}    Pegar token
    Criar uma sessão
    ${listar_all}    GET On Session    alias=listar_cia    url=/company/?token=${token}
    Log To Console    ID PARA TESTE INDIVIDUAL: ${listar_all.json()[10]['_id']}
    
Contagem de empresas
    ${token}    Pegar token
    Criar uma sessão
    ${contagem_cia}    GET On Session    alias=listar_cia    url=/company/count/?token=${token}
    Log To Console    ${contagem_cia}
    RETURN    ${contagem_cia}

Listar companhia por id
    ${token}    Pegar token
    Criar uma sessão
    ${company_id}    GET On Session    alias=listar_cia    url=/company/${id_get}/?token=${token}
    Log To Console    ${company_id.json()}

Listar companhia utilizando token expirado
        Criar uma sessão
        GET On Session    alias=listar_cia    url=/company/?token=${token_expirado_get}    expected_status=403
    
