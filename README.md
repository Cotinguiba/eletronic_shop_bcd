# 📱💻 Eletronics Shop — Banco de Dados Relacional & Cloud Azure

Este repositório contém a documentação completa, a modelagem lógica, os scripts SQL e o passo a passo de hospedagem em nuvem (Microsoft Azure) para o banco de dados da **Eletronics Shop**.

🚀 **Link para o Deploy do Front-end:** *(Insira o link da página aqui assim que finalizar o deploy)*

---

## 📄 Sumário
1. [Domínio do Banco de Dados](#1-domínio-do-banco-de-dados)
2. [Contextualização](#2-contextualização)
3. [Proposta de Melhoria](#3-proposta-de-melhoria)
4. [Modelagem Lógica do Banco de Dados](#4-modelagem-lógica-do-banco-de-dados)
5. [Aplicação das Formas Normais (1FN a 4FN)](#5-aplicação-das-formas-normais-1fn-a-4fn)
6. [Instruções SQL e Consultas](#6-instruções-sql-e-consultas)
7. [Passo a Passo Detalhado: Criação do Ambiente no Microsoft Azure](#7-passo-a-passo-detalhado-criação-do-ambiente-no-microsoft-azure)
8. [Passo a Passo: Exportação e Importação do Dump (Estrutura e Dados)](#8-passo-a-passo-exportação-e-importação-do-dump-estrutura-e-dados)
9. [Estrutura do Repositório](#9-estrutura-do-repositório)

---

## 1. Domínio do Banco de Dados
**Eletronics Shop** — Comércio varejista especializado na gestão de estoque, vendas e controle de garantia para produtos eletrônicos (foco em celulares e notebooks).

---

## 2. Contextualização
A **Eletronics Shop** utilizava um sistema desktop desenvolvido em Java que mantinha seus produtos gravados temporariamente na memória RAM (`ArrayList<Eletronico>`).

### Problemas enfrentados sem um SGBD Relacional:
* **Volatilidade e Perda de Dados:** Ao encerrar o programa, todo o cadastro de produtos e estoque era perdido.
* **Ausência de Histórico de Vendas:** Não havia registro de clientes, data de compras, itens vendidos ou faturamento.
* **Inconsistência de Especificações:** Atributos específicos (ex: `memoriaRam` ou `processador`) ficavam misturados na memória sem validações rigorosas.
* **Falta de Segurança e Concorrência:** Impossibilidade de múltiplos acessos simultâneos ou auditoria sobre movimentações.

---

## 3. Proposta de Melhoria
Implementação de um **SGBD Relacional (MySQL)** com arquitetura de herança relacional (*Class Table Inheritance*). Mapeamos a classe abstrata `Eletronico` para uma tabela pai e as subclasses `Celular` e `Notebook` para tabelas filhas especializadas, além de incorporar tabelas para controle de clientes e vendas.

---

## 4. Modelagem Lógica do Banco de Dados

### Tabelas e Campos:
* **`eletronico`** (Pai): `id_eletronico` (PK), `nome`, `marca`, `preco_base`, `prazo_garantia_meses`, `termos_garantia`.
* **`celular`** (Especialização): `id_eletronico` (PK, FK), `memoria_ram`, `taxa_imposto`.
* **`notebook`** (Especialização): `id_eletronico` (PK, FK), `processador`, `taxa_imposto`.
* **`cliente`**: `id_cliente` (PK), `nome`, `email`, `telefone`.
* **`venda`**: `id_venda` (PK), `id_cliente` (FK), `data_venda`, `valor_total`.
* **`item_venda`**: `id_item` (PK), `id_venda` (FK), `id_eletronico` (FK), `quantidade`, `preco_praticado`.

### Cardinalidades:
* `eletronico` (1) <----> (0..1) `celular` / `notebook` (Herança)
* `cliente` (1) <----> (N) `venda` (1:N)
* `venda` (1) <----> (N) `item_venda` <----> (1) `eletronico` (N:M)

---

## 5. Aplicação das Formas Normais (1FN a 4FN)

* **1FN (Primeira Forma Normal):** Atendida. Todos os campos possuem valores atômicos e indivisíveis. Não há atributos multivalorados ou colunas repetidas.
* **2FN (Segunda Forma Normal):** Atendida. O sistema está na 1FN e todas as tabelas possuem chaves primárias bem definidas, com atributos não-chave dependendo da totalidade da chave.
* **3FN (Terceira Forma Normal):** Atendida. Eliminação de dependências transitivas através do isolamento das características específicas nas tabelas filhas `celular` e `notebook`.
* **4FN (Quarta Forma Normal):** Atendida. Inexistência de dependências multivaloradas independentes na mesma tabela.

---

## 6. Instruções SQL e Consultas

Os scripts para criação das tabelas, carga inicial de dados e as 15 consultas contextualizadas estão salvos no repositório.

---

## 7. Passo a Passo Detalhado: Criação do Ambiente no Microsoft Azure

Abaixo está o procedimento ilustrado passo a passo para o provisionamento e configuração do banco de dados na Azure.

### Passo 1: Acessar o Serviço de Servidores Flexíveis do Azure para MySQL
Acesse o Portal do Azure, navegue até a seção de **Servidores flexíveis do Banco de Dados do Azure para MySQL** e clique no botão **+ Criar** para iniciar o provisionamento da nova instância.

![Passo 1 - Tela de Criação](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/main/Passo%20a%20passo%20azure/1%20-Tela%20de%20Cria%C3%A7%C3%A3o.png?raw=true)

---

### Passo 2: Selecionar o Tipo de Implantação (Criação Avançada)
Na tela de seleção do modelo de implantação, selecione a opção **Servidor flexível** e clique no botão **Criação Avançada** para ter controle total sobre o grupo de recursos, credenciais e regras de rede.

![Passo 2 - Seleção de Criação Avançada](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/Passo%20a%20passo%20azure/2%20-Sele%C3%A7%C3%A3o%20de%20cria%C3%A7%C3%A3o%20avan%C3%A7ada.png?raw=true)

---

### Passo 3: Navegação pelas Abas de Configuração
O formulário de criação é estruturado nas abas: **Básico**, **Rede**, **Configuração adicional**, **Rótulos** e **Revisar + criar**.

![Passo 3 - Abas de Configuração](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/Passo%20a%20passo%20azure/3%20-%20Abas%20de%20configura%C3%A7%C3%A3o.png?raw=true)

---

### Passo 4: Configuração dos Detalhes do Projeto
Na aba **Básico**, em *Detalhes do projeto*, selecione a sua **Assinatura** ativa (ex: `Azure subscription 1`) e defina ou crie o **Grupo de recursos** (`bcd_senai`).

![Passo 4 - Detalhes do Projeto](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/Passo%20a%20passo%20azure/4%20-%20Detalhes%20do%20projeto.png?raw=true)

---

### Passo 5: Configuração dos Detalhes do Servidor
Preencha os parâmetros do banco de dados:
* **Nome do servidor:** `atividade4-bcd`
* **Região:** `Brazil Southeast`
* **Versão MySQL:** `8.4`

![Passo 5 - Detalhes do Servidor](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/Passo%20a%20passo%20azure/5%20-%20Detalhes%20do%20servidor.png?raw=true)

---

### Passo 6: Seleção da Carga de Trabalho e Computação
Defina o porte e recurso de hardware da instância:
* **Tipo de carga de trabalho:** `Standard`
* **Computação + armazenamento:** `Uso Geral, D2ds_v4` (2 vCores, 8 GiB RAM, 64 GiB de armazenamento)
* **Zona de disponibilidade:** `Nenhuma preferência`

![Passo 6 - Computação e Carga de Trabalho](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/Passo%20a%20passo%20azure/6%20-%20Configura%C3%A7%C3%B5es%20de%20trabalho%2C%20computa%C3%A7%C3%A3o%20e%20zona.png?raw=true)

---

### Passo 7: Configuração de Alta Disponibilidade
Na seção *Alta disponibilidade*, selecione a opção **Desabilitado (SLA de 99,9%)** para otimizar os custos em ambiente de desenvolvimento.

![Passo 7 - Disponibilidade](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/Passo%20a%20passo%20azure/7%20-%20Disponibilidade.png?raw=true)

---

### Passo 8: Configuração do Método de Autenticação e Credenciais
Na seção *Autenticação*, configure as permissões de logon do administrador:
* **Método de autenticação:** `MySQL somente autenticação`
* **Logon do administrador:** `paulo_bcd_teste`
* **Senha:** *(Definida e confirmada)*

![Passo 8 - Autenticação](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/Passo%20a%20passo%20azure/8%20-%20Autentica%C3%A7%C3%A3o.png?raw=true)

---

### Passo 9: Configuração de Conectividade de Rede e Acesso Público
Na aba **Rede**, defina os parâmetros para acesso externo:
* **Método de conectividade:** `Acesso público (endereços IP permitidos) e pontos de extremidade privados`
* **Porta do banco de dados:** `3306`
* **Acesso público:** Marque a opção `Permitir acesso público a este recurso pela Internet usando um endereço IP público`.

![Passo 9 - Conectividade e Acesso](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/Passo%20a%20passo%20azure/9%20-%20Conectividade%20e%20acesso.png?raw=true)

---

### Passo 10: Configuração de Regras de Firewall
Libere as conexões de entrada na porta `3306`:
* Marque **"Permitir o acesso público de qualquer serviço do Azure de dentro do Azure para esse servidor"**.
* Crie a regra de firewall (ex: `AllowAll`) autorizando o intervalo de IPs necessário para conexão remota.

![Passo 10 - Regras de Firewall](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/Passo%20a%20passo%20azure/9%20-%20Regras%20de%20firewall.png?raw=true)

---

### Passo 11: Acompanhamento da Implantação
Após validar e clicar em **Criar**, aguarde o provisionamento no Azure (`atividade4-bcd`). A tela exibirá o status da operação em andamento até a conclusão.

![Passo 11 - Implantação em Andamento](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/Passo%20a%20passo%20azure/11%20-%20Implanta%C3%A7%C3%A3o.png?raw=true)

---

### Calculadora e Estimativa de Custos no Azure

A Azure disponibiliza o detalhamento financeiro estimado para a execução da instância MySQL na nuvem, calculado da seguinte forma:

![Bônus - Calculadora de Preços](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/Passo%20a%20passo%20azure/Calculadora%20de%20pre%C3%A7os.png?raw=true)

#### Composição do Custo Estimado (Total: USD 151.18 / mês):
1. **Computação (USD 142.35/mês):** Referente a 2 vCores da máquina `Standard_D2ds_v4` (USD 71.17 por vCore).
2. **Armazenamento (USD 8.83/mês):** Referente aos 64 GiB de disco alocados (USD 0.14 por GiB).
3. **IOPS de Dimensionamento Automático:** Cobrado dinamicamente de acordo com a quantidade de requisições por milhão.
4. **Retenção de Backup & Largura de Banda:** Cobrança por armazenamento adicional de backups mantidos e dados de saída transferidos fora da região (dados de entrada são gratuitos).

---

## 8. Passo a Passo: Exportação e Importação do Dump (Estrutura e Dados)

Abaixo está o procedimento ilustrado para gerar a cópia física de segurança (dump) e restaurar o banco de dados utilizando o MySQL Workbench conectado ao Azure.

### Passo 1: Acessar o Menu Server no MySQL Workbench
Com o MySQL Workbench aberto e conectado ao banco de dados hospedado no Azure, navegue até a barra de menu superior e clique na opção **Server**.

![Passo 1 - Acessar Menu Server](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/DUMP%20AZURE/1%20-%20SERVER.png?raw=true)

---

### Passo 2: Selecionar a Opção Data Export
No menu suspenso que se abre ao clicar em *Server*, selecione a opção **Data Export** para abrir o assistente de exportação do banco de dados.

![Passo 2 - Selecionar Data Export](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/DUMP%20AZURE/2%20-%20DATA%20EXPORT.png?raw=true)

---

### Passo 3: Seleção do Schema, Tabelas e Tipo de Dump
Na aba **Object Selection**:
* Selecione o schema **`eletronic_shop`** no painel esquerdo.
* Certifique-se de que todas as tabelas desejadas (`celular`, `cliente`, `eletronico`, `item_venda`, `notebook`, `venda`) estejam marcadas no painel direito.
* No menu suspenso inferior, selecione a opção **Dump Structure and Data** para exportar tanto a DDL (estrutura) quanto a DML (dados).

![Passo 3 - Dump Structure and Data](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/DUMP%20AZURE/3%20-%20DUMP%20STRUCTURE.png?raw=true)

---

### Passo 4: Definir Opções de Exportação e Destino do Arquivo
Na seção **Export Options**:
* Selecione a opção **Export to Self-Contained File** para consolidar todo o banco em um único arquivo `.sql`.
* Defina o caminho do diretório e o nome do arquivo final de saída (ex: `eletronic_shop.sql`).
* Clique no botão **Start Export** no canto inferior direito para iniciar o processo de geração do dump.

![Passo 4 - Export File](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/DUMP%20AZURE/4%20-%20EXPORT%20FILE.png?raw=true)

---

### Passo 5: Iniciar o Processo de Importação/Restauração
Caso precise importar ou restaurar o banco de dados em uma nova instância:
* Acesse **Server** > **Data Import**.
* Na aba **Import from Disk**, selecione a opção **Import from Self-Contained File** (ou *Import from Dump Project Folder*) e indique o caminho onde o arquivo `.sql` está salvo.

![Passo 5 - Data Import](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/DUMP%20AZURE/5%20-%20DATA%20IMPORT.png?raw=true)

---

### Passo 6: Criação do Schema Destino no Data Import
Na seção **Default Target Schema**:
* Clique no botão **New...**.
* No modal *Create Schema*, digite o nome do banco de dados destino (`eletronic_shop`).
* Clique em **OK** para confirmar a criação do novo schema.

![Passo 6 - Default Target Schema](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/DUMP%20AZURE/6%20-%20DEFAULT%20TARGET.png?raw=true)

---

### Passo 7: Executar a Importação do Banco de Dados
Acesse a aba **Import Progress**:
* Verifique o log inicial de preparação do schema.
* Clique no botão **Start Import** localizado no canto inferior direito para executar a restauração de toda a estrutura e dos dados.

![Passo 7 - Start Import](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/DUMP%20AZURE/7%20-%20START%20IMPORT.png?raw=true)

---

### Passo 8: Conclusão e Confirmação da Importação
Aguarde a barra de progresso atingir 100% e exibir o status **Import Completed**. O log indicará que a execução do script no servidor Azure foi concluída com sucesso (`Import of ... has finished`).

![Passo 8 - Import Completo](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/DUMP%20AZURE/8%20-%20IMPORT%20COMPLETO.png?raw=true)

---

### Passo 9: Verificação do Banco no Portal do Azure
Por fim, acesse o Portal do Azure e navegue até a opção **Bancos de dados** do servidor `atividade4-bcd`. Confirme que o banco de dados `eletronic_shop` consta na lista de schemas do usuário com a codificação `utf8mb4`.

![Passo 9 - Verificação no Azure](https://github.com/Cotinguiba/eletronic_shop_bcd/blob/develop/DUMP%20AZURE/9%20-%20Verifica%C3%A7%C3%A3o.png?raw=true)

---

## 9. Estrutura do Repositório

```text
.
├── index.html                   # Front-end explicativo da atividade
├── README.md                    # Documentação detalhada da atividade
├── Passo a passo azure/         # Imagens do processo de configuração na Azure
├── DUMP AZURE/                  # Imagens do processo de exportação e importação do dump
└── (scripts/dumps) .sql         # Scripts do Banco de Dados
