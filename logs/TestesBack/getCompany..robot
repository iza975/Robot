*** Settings ***
Documentation    Testes Comapany
Library     RequestsLibrary
Library     String
Library     Collections
Library     OperatingSystem
Library    SeleniumLibrary

*** Variables ***
${base_url}              https://ron-bugado.qacoders.dev.br/api/      
${ID_COMPANY}            67082d70eed30dc911c4becb


*** Test Cases ***
Cadastro De empresa
    Login Usuario
    Criar Sessao
    Criar empresa 
    Mostrar empresa por ID
    Listar empresa
    Deletar Empresa por ID
    Contar Empresa
    Atualizar Status de Empresa por ID
    Atualizar dados de Empresa por ID
    Atualizar endereço da Empresa por ID
  

        
*** Keywords ***
Login Usuario
    ${headers}    Create Dictionary    accept=application/json   Content-Type=application/json    
    Create Session    alias=develop    url=${base_url}   headers=${headers}    timeout=120  verify=true 
     ${body}          Create Dictionary  
    ...  mail=sysadmin@qacoders.com
    ...  password=1234@Test
    ${resposta}    POST On Session     alias=develop    url=login    json=${body}
    Set Global Variable    ${TOKEN}    ${resposta.json()["token"]}   # seta a variavel token e mostra o caminho 
    Log To Console    Token: ${TOKEN} 


Criar Sessao
    ${headers}    Create Dictionary    Content-Type=application/json    authorization=${TOKEN}
    Create Session    alias=develop    url=${base_url}   headers=${headers}    timeout=120  verify=true 


Criar empresa 
    ${address}    Create Dictionary
    ...    zipCode=04777001
    ...    city=São Paulo
    ...    state=SP
    ...    district=Rua das Flores
    ...    street=Avenida Interlagos
    ...    number=50
    ...    complement=de 4503 ao fim - lado ímpar
    ...    country=Brasil
       
    ${address}    Create List    ${address}
    ${body}     Create Dictionary        
    ...    corporateName=Trezwe do rapppp
    ...    registerCompany=12126456000123   # 13 numeros
    ...    mail=tesdddt@tesl.com
    ...    matriz=Teste
    ...    responsibleContact=Marcio
    ...    telephone=99999999999999
    ...    serviceDescription=Testes
    ...    address=${address}

    ${headers}=    Create Dictionary    Content-Type=application/json    authorization=${TOKEN}   
    ${resposta}=   POST On Session    alias=develop    url=company/   json=${body}    headers=${headers}
    Log To Console    ${resposta.json()}    # log para verificar a resposta da api
    Log To Console    O ID é    ${resposta.json()["newCompany"]["_id"]}  # log do Id retornado pela resposta
    Set Global Variable    ${ID_COMPANY}    ${resposta.json()["newCompany"]["_id"]}  # Seta a variavel  do ID criado e  mostrar ele vai pegar 
 

Mostrar empresa por ID
    ${headers}    Create Dictionary    content-Type=application/json    authorization=${TOKEN}
    ${resposta_mostrar}    GET On Session    alias=develop    url=url=company/${ID_COMPANY}
    Log To Console    ${resposta_mostrar.json()["msg"]}  

Listar empresa
    ${headers}    Create Dictionary    content-Type=application/json    authorization=${TOKEN}
    ${resposta_listar}    GET On Session    alias=develop    url=company/    expected_status=200   
    Log To Console    ${resposta_listar.json()["msg"]}  

Deletar Empresa por ID
    ${headers}    Create Dictionary    content-Type=application/json    authorization=${TOKEN}
    ${resposta_deletar}    DELETE On Session    alias=develop     url=company/${ID_COMPANY}     headers={headers}
    Set Test Variable    ${resposta_deletar}    ${resposta_deletar.json()}
    Log To Console    ${resposta_deletar.json()["msg"]}
    Log TO Console    ${resposta_deletar.json()}
       
Contar Empresa
    ${headers}    Create Dictionary    content-Type=application/json    authorization=${TOKEN}
    ${resposta_contar}    GET On Session    alias=develop    url=company/    headers={headers}   
    Log To Console     ${resposta_deletar.json()["msg"]}

Atualizar Status de Empresa por ID
    ${headers}    Create Dictionary    accept=application/json    content-Type=application/json     authorization=${TOKEN}   
    Create Session    alias=develop    url=${base_url}   headers=${headers}    timeout=120  verify=true 
    ${body}          Create Dictionary 
    ...    status:false
     ${resposta_status}    PUT On Session     alias=develop    url=company/    json=${body}    headers={headers}    
    Log To Console     ${resposta_status.json()["msg"]}  
    
Atualizar dados de Empresa por ID
    ${headers}    Create Dictionary    accept=application/json    content-Type=application/json     authorization=${TOKEN}   
    Create Session    alias=develop    url=${base_url}   headers=${headers}    timeout=120  verify=true 
    ${body}          Create Dictionary
    ...    corporateName:Teste do Teste
    ...    registerCompany:12126456000155
    ...    mail:test@test.com
    ...    matriz:Teste
    ...    responsibleContact:Marcio
    ...    telephone:99999999999999
    ...    serviceDescription:Testes
   ${resposta_Dados}    PUT On Session     alias=develop    url=company/    json=${body}    headers={headers}    
    Log To Console     ${resposta_Dados.json()["msg"]}  
    
Atualizar endereço da Empresa por ID
    ${headers}    Create Dictionary    accept=application/json    content-Type=application/json     authorization=${TOKEN}   
    Create Session    alias=develop    url=${base_url}   headers=${headers}    timeout=120  verify=true 
    ${address}    Create Dictionary   
    ...    zipCode=04777001
    ...    city=São Paulo
    ...    state=SP
    ...    district=Rua das Flores
    ...    street=Avenida Interlagos
    ...    number=50
    ...    complement=de 4503 ao fim - lado ímpar
    ...    country=Brasil 
   ${resposta_endereço}    PUT On Session     alias=develop    url=company/    json=${address}    headers={headers}    
    Log To Console     ${resposta_endereço.json()["msg"]}  


