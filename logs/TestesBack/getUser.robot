*** Settings***
Documentation    Testes Sprint 13
Library     RequestsLibrary
Library     String
Library     Collections
Library     OperatingSystem


*** Variables ***
${base_url}    https://ron-bugado.qacoders.dev.br/api/
${id_user}     64c83ab4ff1812cf46e4b7c9
${token}       eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmRiNWQ4NDFkZjU1NDE1MGU2ZDY0YmQiLCJmdWxsTmFtZSI6IlFhLUNvZGVycy1TWVNBRE1JTiIsIm1haWwiOiJzeXNhZG1pbkBxYWNvZGVycy5jb20iLCJwYXNzd29yZCI6IiQyYiQxMCR1NGcwYm81OTlFa1E4RGZSeGw4bHlPTzhiaDZ5QnlyRlVhN2k5cDV0N2pycElFaUx6MzJMLiIsImFjY2Vzc1Byb2ZpbGUiOiJTWVNBRE1JTiIsImNwZiI6IjExMTExMTExMTExIiwic3RhdHVzIjp0cnVlLCJhdWRpdCI6W3sicmVnaXN0ZXJlZEJ5Ijp7InVzZXJJZCI6IjExMTExMTExMTExMTExMTExMSIsInVzZXJMb2dpbiI6InN5c2FkbWluQHFhY29kZXJzLmNvbSJ9LCJyZWdpc3RyYXRpb25EYXRlIjoic2V4dGEtZmVpcmEsIDA2LzA5LzIwMjQsIDE2OjUyOjM2IEJSVCIsInJlZ2lzdHJhdGlvbk51bWJlciI6IjAxIiwiY29tcGFueUlkIjoiUWEuQ29kZXJzIiwiX2lkIjoiNjZkYjVkODQxZGY1NTQxNTBlNmQ2NGJlIn1dLCJfX3YiOjAsImlhdCI6MTcyODE1Mjg0OSwiZXhwIjoxNzI4MjM5MjQ5fQ.uPS3Rvn0UU_kN6GoJLk07iZ_wZ2-IGs_sm36odaijuo


*** Test Cases ***
Listar Usuarios 
    Criar Sessao 
    Listar todos alunos cadastrados
    Listar Usuario Cadastrado por ID

   

*** Keywords ***
Criar Sessao
    ${headers}    Create Dictionary    accept=application/json    content-Type=application/json    authorization=${token}
    Create Session    alias=develop   url=${base_url}    headers=${headers}    timeout=120   verify=true 


Listar todos alunos cadastrados
    Criar Sessao
    ${resposta}    GET On Session    alias=develop    url=user    expected_status=200     
    
    
Listar Usuario Cadastrado por ID
    Criar Sessao    
    ${resposta}    GET On Session    alias=develop    url=user/6701a608eed30dc911c09959    expected_status=200 

