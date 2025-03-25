#CENÁRIOS DA API DE CADASTRO DE USUÁRIOS
Funcionalidade: Validação da API de Cadastro de Usuários
Como cliente
Eu quero ser capaz de cadastrar uma nova conta,
Para que eu possa acessar as funcionalidades do sistema via API POST https://serverest.dev/usuarios

#CADASTRO DE USUÁRIOS

Cenario: [CADCT01] Cadastro de um novo usuário com sucesso

 Dado que a API de cadastro de usuários está disponível
   E que eu forneço os seguintes dados válidos para cadastro:
    | campo         |   valor                |
    |---------------|------------------------|
    | nome          | João da Silva          |
    | email         | joaosilva@email.com   |
    | password      | 123456                 |
    | administrador | true                  |
  Quando eu envio uma requisição POST para "/usuarios"
  Entao a API deve retornar o status code 201 (Created)
   E o response deve conter o campo "_id" com o ID do usuário cadastrado
   E o response deve conter o campo "mensagem" com o valor "Cadastro realizado com sucesso"

Cenario: [CADCT02] Cadastro de um novo administrador com sucesso
 Dado que a API de cadastro de usuários está disponível
   E que eu forneço os seguintes dados válidos para cadastro de um administrador:
    | campo         | valor                  |
    |---------------|------------------------|
    | nome          | Maria Oliveira         |
    | email         | maria.admin@email.com  |
    | password      | AdminPassword!         |
    | administrador | true                   |
  Quando eu envio uma requisição POST para "/usuarios"
  Entao a API deve retornar o status code 201 (Created)
   E o response deve conter o campo "_id" com o ID do usuário cadastrado
   E o response deve conter o campo "mensagem" com o valor "Cadastro realizado com sucesso"

Cenario: [CADCT03] Falha no cadastro devido a e-mail já existente
 Dado que a API de cadastro de usuários está disponível
   E que já existe um usuário cadastrado com o e-mail "joao.silva@email.com"
   E que eu forneço os seguintes dados para cadastro:
    | campo         | valor                  |
    |---------------|------------------------|
    | nome          | João da Silva Novo     |
    | email         | joao.silva@email.com   |
    | password      | OutraSenha             |
    | administrador | false                  |
  Quando eu envio uma requisição POST para "/usuarios"
  Entao a API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro "Este email já está sendo usado"
   E o response não deve conter o ID de um novo usuário

Cenario: [CADCT04] Falha no cadastro devido a campos obrigatórios ausentes (nome)
 Dado que a API de cadastro de usuários está disponível
   E que eu forneço os seguintes dados para cadastro com o campo "nome" ausente:
    | campo         | valor                   |
    |---------------|-------------------------|
    | email         | novo.usuario@email.com  |
    | password      | SenhaFraca              |
    | administrador | false                   |
  Quando eu envio uma requisição POST para "/usuarios"
  Entao a API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro "nome é obrigatório"

Cenario: [CADCT05] Falha no cadastro devido a campos obrigatórios ausentes (e-mail)
 Dado que a API de cadastro de usuários está disponível
   E que eu forneço os seguintes dados para cadastro com o campo "e-mail" ausente:
    | campo         | valor          |
    |---------------|----------------|
    | nome          | Novo Usuário   |
    | password      | SenhaFraca     |
    | administrador | false          |
  Quando eu envio uma requisição POST para "/usuarios"
  Entao a API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro "email é obrigatório"

Cenario: [CADCT06] Falha no cadastro devido a campos obrigatórios ausentes (password)
 Dado que a API de cadastro de usuários está disponível
   E que eu forneço os seguintes dados para cadastro com o campo "password" ausente:
    | campo         | valor                  |
    |---------------|------------------------|
    | nome          | Novo Usuário           |
    | email         | novo.usuario@email.com |
    | administrador | false                  |
  Quando eu envio uma requisição POST para "/usuarios"
  Entao a API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro "password é obrigatório"

Cenario: [CADCT07] Falha no cadastro devido a formato de e-mail inválido
 Dado que a API de cadastro de usuários está disponível
   E que eu forneço os seguintes dados para cadastro com um formato de e-mail inválido:
    | campo         | valor          |
    |---------------|----------------|
    | nome          | Usuário Teste  |
    | email         | email_invalido |
    | password      | SenhaSegura    |
    | administrador | false          |
  Quando eu envio uma requisição POST para "/usuarios"
  Entao a API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro "email deve ser um email válido"

Cenario: [CADCT08] Falha no cadastro devido a password muito curta
 Dado que a API de cadastro de usuários está disponível
   E que eu forneço os seguintes dados para cadastro com uma senha muito curta:
    | campo         | valor              |
    |---------------|--------------------|
    | nome          | Usuário Pequeno    |
    | email         | pequeno@email.com  |
    | password      | 123                |
    | administrador | false              |
  Quando eu envio uma requisição POST para "/usuarios"
  Entao a API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro indicando que a senha deve ter um tamanho mínimo

Cenario: [CADCT08] Validação do contrato da requisição de cadastro (campos esperados)
 Dado que a API de cadastro de usuários está disponível
   E que eu forneço um payload de requisição com campos extras:
        json {
                "nome": "Usuário Extra",
                "email": "extra@email.com",
                "password": "SenhaForte",
                "administrador": false,
                "campo_extra": "valor_extra"
            }
  Quando eu envio uma requisição POST para "/usuarios" com o payload fornecido
  Entao a API deve retornar o status code 400 (Created)
   E o  response deve conter uma mensagem de erro "campo_extra não é permitido"

Cenario: [CADCT09] Validação do contrato da resposta de sucesso (campos esperados)
 Dado que a API de cadastro de usuários está disponível
   E que eu forneço dados válidos para cadastro:
    | campo         | valor                  |
    |---------------|------------------------|
    | nome          | Usuário Contrato       |
    | email         | contrato@email.com     |
    | password      | SenhaContrato          |
    | administrador | false                  |
  Quando eu envio uma requisição POST para "/usuarios"
  Entao a API deve retornar o status code 201 (Created)
   E o response deve conter o campo "_id" com o ID do usuário cadastrado
   E o response deve conter o campo "mensagem" com o valor "Usuário cadastrado com sucesso"
   E o response não deve conter campos inesperados

#Cadastrada a issue https://github.com/ServeRest/ServeRest/issues/505 para a implementação do cenário de teste abaixo
Cenario: [CADCT10] Tentativa de cadastro com método HTTP incorreto (GET)
 Dado que a API de cadastro de usuários está disponível
   E que eu forneço dados válidos para cadastro:
    | campo         | valor         |
    |---------------|---------------|
    | nome          | Usuário Get   |
    | email         | get@email.com |
    | password      | SenhaGet      |
    | administrador | false         |
  Quando eu envio uma requisição GET para "/usuarios"
  Entao a API deve retornar o status code 400 (Bad Request)

 #Cadastrada a issue https://github.com/ServeRest/ServeRest/issues/506 para a implementação do cenário de teste abaixo
Cenario: [CADCT11] Validação de tamanho máximo e mínimo dos campos: nome, e-mail e password
 Dado que a API de cadastro de usuários está disponível
   E que eu forneço os seguintes dados para cadastro com campos excedendo o tamanho máximo:
    | campo         | valor                                                                                                                                                |
    |---------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
    | nome          | "Pedro de Alcântara Francisco Antônio João Carlos Xavier de Paula Miguel Rafael Joaquim José Gonzaga Pascoal Cipriano Serafim de Bragança e Bourbon" |
    | email         | "mariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamariamaria@maria.com" |
    | password      | "X>Gh{!Z#%t!)Rc+pH-N]2[Led,r@[fXX>Gh{!Z#%t!)Rc+pH-N]2[Led,r@[fXX>Gh{!Z#%t!)Rc+pH-N]2[Led,r@[fXX>Gh{!Z#%t!)Rc+pH-N]2[Led,r@[fXX>Gh{!Z#%t!)Rc+pH-N]2[" |
    | administrador | "falsetruefalsetruefalsetruefalsetruefalsetruefalsetruefalsetruefalsetruefalsetruefalsetruefalsetruefalsetruefalsetruefalsetruefalsetruefalsetruefa" |
  Quando eu envio uma requisição POST para "/usuarios"
  Entao a API deve retornar o status code 400 (Bad Request)
     E o response deve conter uma mensagem de erro indicando que o tamanho máximo foi excedido

#Cadastrada a issue https://github.com/ServeRest/ServeRest/issues/507 para correção do cenário de teste abaixo
Cenario: [CADCT12] Validação de caracteres especiais nos campos: nome, email e password
 Dado que a API de cadastro de usuários está disponível
   E que eu forneço os seguintes dados para cadastro com caracteres especiais:
    | campo         | valor                  |
    |---------------|------------------------|
    | nome          | Usuário!@#             |
    | email         | email!@#email.com      |
    | password      | Senha!@#               |
    | administrador | fal/*                  |
  Quando eu envio uma requisição POST para "/usuarios"
  Entao a API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro indicando que caracteres especiais não são permitidos

#CENÁRIOS DA API DE EDIÇÃO DE USUÁRIOS

Funcionalidade: Validação da API de Edição de Cadastro de Usuários
Como cliente
Eu quero ser capaz de editar uma conta existente,
Para que eu possa atualizar meus dados de acesso via API PUT https://serverest.dev/usuarios/:_id

#EDIÇÃO DE USUÁRIOS

Cenario: [EDTCT01] Edição de um usuário com sucesso
 Dado que a API de cadastro de usuários está disponível
   E que eu tenho um usuário cadastrado com o ID "0uxuPY0cbmQhpEz1"
   E que eu forneço os seguintes dados válidos para edição:
    | campo         | valor                  |
    |---------------|------------------------|
    | nome          | João da Silva Novo     |
    | email         | joao@email.com         |
    | password      | senha1234              |
    | administrador | false                  |
  Quando eu envio uma requisição PUT para "/usuarios/:_id" com o payload fornecido
  Entao a API deve retornar o status code 200 (OK)
   E o response deve conter o campo "mensagem" com o valor "Registro alterado com sucesso"

Cenario: [EDTCT02] Falha na edição de um usuário devido a e-mail já existente
 Dado que a API de cadastro de usuários está disponível
   E que eu tenho um usuário cadastrado com o ID "0uxuPY0cbmQhpEz1"
   E que já existe um usuário cadastrado com o e-mail ""
    E que eu forneço os seguintes dados para edição:
     | campo         | valor                  |
     |---------------|------------------------|
     | nome          | João da Silva Novo     |
     | email         | fulano@qa.com          |
     | password      | NovaSenha              |
     | administrador | false                  |
  Quando eu envio uma requisição PUT para "/usuarios/:_id" com o payload fornecido
  Entao API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro "Este email já está sendo usado"

Cenario: [EDTCT03] Falha na edição de um usuário devido a campos obrigatórios ausentes (nome)
 Dado que a API de cadastro de usuários está disponível
   E que eu tenho um usuário cadastrado com o ID "0uxuPY0cbmQhpEz1"
   E que eu forneço os seguintes dados para edição com o campo "nome" ausente:
    | campo         | valor                  |
    |---------------|------------------------|
    | email         | fulano@qa.com          |
    | password      | teste                  | 
    | administrador | true                   |
  Quando eu envio uma requisição PUT para "/usuarios/0uxuPY0cbmQhpEz1" com o payload fornecido
    Entao a API deve retornar o status code 400 (Bad Request)
     E o response deve conter uma mensagem de erro "nome é obrigatório"
 
Cenario: [EDTCT04] Falha na edição de um usuário devido a campos obrigatórios ausentes (email)
 Dado que a API de cadastro de usuários está disponível
   E que eu tenho um usuário cadastrado com o ID "0uxuPY0cbmQhpEz1"
   E que eu forneço os seguintes dados para edição com o campo "email" ausente:
    | campo         | valor                  |
    |---------------|------------------------|
    | nome          | Fulano de Tal          |
    | password      | teste                  | 
    | administrador | true                   |
  Quando eu envio uma requisição PUT para "/usuarios/0uxuPY0cbmQhpEz1" com o payload fornecido
    Entao a API deve retornar o status code 400 (Bad Request)
     E o response deve conter uma mensagem de erro "email é obrigatório"

Cenario: [EDTCT05] Falha na edição de um usuário devido a campos obrigatórios ausentes (password)
 Dado que a API de cadastro de usuários está disponível
   E que eu tenho um usuário cadastrado com o ID "0uxuPY0cbmQhpEz1"
   E que eu forneço os seguintes dados para edição com o campo "password" ausente:
    | campo         | valor                  |
    |---------------|------------------------|
    | nome          | Fulano de Tal          |
    | email         | fulano@teste.com       |
    | administrador | true                   |
  Quando eu envio uma requisição PUT para "/usuarios/0uxuPY0cbmQhpEz1" com o payload fornecido
  Entao a API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro "password é obrigatório"

Cenario: [EDTCT06] Falha na edição de um usuário devido a formato de e-mail inválido
 Dado que a API de cadastro de usuários está disponível
   E que eu tenho um usuário cadastrado com o ID "0uxuPY0cbmQhpEz1"
   E que eu forneço os seguintes dados para edição com um formato de e-mail inválido:
    | campo         | valor                  |
    |---------------|------------------------|
    | nome          | Fulano de Tal          |
    | email         | email_invalido         |
    | password      | teste                  |
    | administrador | true                   |
  Quando eu envio uma requisição PUT para "/usuarios/0uxuPY0cbmQhpEz1" com o payload fornecido
  Entao a API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro "email deve ser um email válido" 

Cenario: [EDTCT07] Validação do contrato da requisição de edição (campos esperados)
 Dado que a API de cadastro de usuários está disponível
   E que eu tenho um usuário cadastrado com o ID "0uxuPY0cbmQhpEz1"
   E que eu forneço um payload de requisição com campos extras:
        json {
                "nome": "Usuário Extra",
                "email": "  ",
                "password": "SenhaForte", 
                "administrador": false,
                "campo_extra": "valor_extra"
            }
  Quando eu envio uma requisição PUT para "/usuarios/0uxuPY0cbmQhpEz1" com o payload fornecido
  Entao a API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro "campo_extra não é permitido"

# CONSULTA DE USUÁRIOS

Funcionalidade: Validação da API de Consulta de Usuários
Como cliente
Eu quero ser capaz de consultar um usuário específico,
Para que eu possa visualizar os dados de um usuário via API GET https://serverest.dev/usuarios/:_id

Cenario: [CSTCT01] Consulta de um usuário específico com sucesso
 Dado que a API de cadastro de usuários está disponível
   E que eu tenho um usuário cadastrado com o ID "0uxuPY0cbmQhpEz1"
  Quando eu envio uma requisição GET para "/usuarios/0uxuPY0cbmQhpEz1"
  Entao a API deve retornar o status code 200 (OK)
   E o response deve conter o campo "nome" com o nome do usuário consultado
   E o response deve conter o campo "email" com o e-mail do usuário consultado
   E o response deve conter o campo "administrador" com o valor true ou false
   E o response deve conter o campo "_id" com o ID do usuário consultado
  
Cenario: [CSTCT02] Consulta de um usuário inexistente
 Dado que a API de cadastro de usuários está disponível
   E que eu não tenho um usuário cadastrado com o ID "0uxuPY0cbmQhpEz1"
  Quando eu envio uma requisição GET para "/usuarios/0uxuPY0cbmQhpEz1"
  Entao a API deve retornar o status code 404 (Not Found)
   E o response deve conter uma mensagem de erro "Usuário não encontrado"

#Cadastrada a issue https://github.com/ServeRest/ServeRest/issues/508 para correção do cenário de teste abaixo
Cenario: [CSTCT03] Consulta de um usuário com ID inválido
 Dado que a API de cadastro de usuários está disponível
  Quando eu envio uma requisição GET para "/usuarios/****ccc"
  Entao a API deve retornar o status code 400 (Bad Request)
   E o response deve conter uma mensagem de erro "Usuário não encontrado"

#CENÁRIOS DA API DE EXCLUSÃO DE USUÁRIOS

Funcionalidade: Validação da API de Exclusão de Usuários
Como cliente
Eu quero ser capaz de excluir um usuário específico,
Para que eu possa remover um usuário via API DELETE https://serverest.dev/usuarios/:_id

#EXCLUSÃO DE USUÁRIOS

Cenario: [DELCT01] Exclusão de um usuário com sucesso
 Dado que a API de cadastro de usuários está disponível
   E que eu tenho um usuário cadastrado com o ID "JyT8jbBSph8ukjeU"
  Quando eu envio uma requisição DELETE para "/usuarios/JyT8jbBSph8ukjeU"
  Entao a API deve retornar o status code 200 (OK)
   E o response deve conter o campo "mensagem" com o valor "Registro excluído com sucesso"


Cenario: [DELCT02] Exclusão de um usuário inexistente
  Dado que a API de cadastro de usuários está disponível
    E que eu não tenho um usuário cadastrado com o ID "JyT8jbBSph8ukjeU"
    Quando eu envio uma requisição DELETE para "/usuarios/JyT8jbBSph8ukjeU"
    Entao a API deve retornar o status code 404 (Not Found)
    E o response deve conter uma mensagem de erro "Nenhum registro excluído"

Cenario: [DELCT03] Exclusão de um usuário com ID inválido
  Dado que a API de cadastro de usuários está disponível
    Quando eu envio uma requisição DELETE para "/usuarios/****ccc"
    Entao a API deve retornar o status code 400 (Bad Request)
    E o response deve conter uma mensagem de erro "Nenhum registro excluído"


#TESTE DE PERFORMANCE E CARGA

Funcionalidade: Testes de performance e carga
Como cliente
Eu quero ser capaz de medir o tempo de resposta da API sob diferentes cargas,
Para que eu possa garantir que a API atenda aos requisitos de desempenho

Cenario: Medir o desempenho da API POST de Cadastro de Produtos http://localhost:3000/produtos ao utilizar 5 usuários simultâneos por 5 minutos
 Dado que a API de cadastro de usuários está disponível
  E que eu tenho 5 usuários cadastrados
  Quando cada usuário enviar 2 requisições POST para "http://localhost:3000/produtos" simultaneamente
  Entao a API deve retornar o status code 201 (Created) para todas as requisições
  E o tempo médio de resposta deve ser inferior a 100ms
 
Cenario: Medir o desempenho da API POST de Cadastro de Carrinho http://localhost:3000/carrinhos ao utilizar 5 usuários simultâneos por 5 minutos
  Dado que a API de cadastro de usuários está disponível
   E que eu tenho 5 usuários cadastrados
    Quando cada usuário enviar 1 requisição POST para "http://localhost:3000/carrinhos" simultaneamente
    Entao a API deve retornar o status code 201 (Created) para todas as requisições
    E o tempo médio de resposta deve ser inferior a 100ms

Cenario: Medir o desempenho da API DELETE de Conclusão de Compra http://localhost:3000/carrinhos/concluir-compra ao utilizar 5 usuários simultâneos por 5 minutos
  Dado que a API de cadastro de usuários está disponível
    E que eu tenho 5 usuários cadastrados
    Quando cada usuário enviar 1 requisição POST para "http://localhost:3000/carrinhos/concluir-compra" simultaneamente
    Entao a API deve retornar o status code 201 (Created) para todas as requisições
    E o tempo médio de resposta deve ser inferior a 100ms

Cenario: Medir o desempenho da API GET de Listar Produtos http://localhost:3000/produtos ao utilizar 5 usuários simultâneos por 5 minutos
  Dado que a API de cadastro de usuários está disponível
    E que eu tenho 5 usuários cadastrados
Quando cada usuário enviar 1 requisição GET para "http://localhost:3000/produtos" simultaneamente
  Entao a API deve retornar o status code 200 (OK) para todas as requisições
  E o tempo médio de resposta deve ser inferior a 100ms
 








    #Testes de segurança: Tentativas de injeção de SQL ou outros ataques (se aplicável).
    #

