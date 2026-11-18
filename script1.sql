-- =========================================================================
-- AULA PRÁTICA: NORMALIZAÇÃO DE DADOS (1FN, 2FN e 3FN) E MAPEAMENTO DER->SQL
-- Contexto: Módulo de Vendas / Loja de Artesanato Amor & Arte
-- =========================================================================

-- Remove o banco de dados se ele já existir para reiniciar os testes
DROP DATABASE IF EXISTS AmorEArteDB;

-- Criação e seleção do banco de dados
CREATE DATABASE AmorEArteDB;
USE AmorEArteDB;

-- =========================================================================
-- CONCEITO DE NORMALIZAÇÃO DE DADOS
-- "A chave, toda a chave, e nada além da chave!"
-- =========================================================================

-- =========================================================================
-- 1. TABELA CLIENTE (Aplicando 1FN e 3FN)
--
-- CONCEITO DER INICIAL:
-- O Cliente possui Atributo Composto (Endereço) e Atributo Multivalorado (E-mail).
-- Atributos obrigatórios do projeto "Amor & Arte": CPF (Único), Nome, Telefone e E-mail.
--
-- APLICAÇÃO DA 1ª FORMA NORMAL (1FN - ATOMICIDADE):
-- 1. Atributo Composto (Endereço): Foi DESMEMBRADO em suas partes simples e
--    atômicas: logradouro, numero, bairro, cidade, uf e cep.
-- 2. Atributo Multivalorado (E-mail): Um cliente pode ter N e-mails. Para não
--    violar a 1FN (evitando criar colunas email1, email2 ou colocar múltiplos 
--    e-mails na mesma célula separados por vírgula), o e-mail FOI REMOVIDO 
--    desta tabela e virou uma nova tabela relacionada ('ClienteEmail').
--
-- APLICAÇÃO DA 3ª FORMA NORMAL (3FN - ELIMINAÇÃO DE DEPENDÊNCIA TRANSITIVA):
-- 1. O nome do cliente NÃO depende de outro atributo não-chave.
-- 2. Se tivéssemos colocado 'nome' ou 'cpf' na tabela VENDA, teríamos violado a 3FN!
--    Esses dados ficam mantidos APENAS na tabela CLIENTE.
-- =========================================================================
CREATE TABLE Cliente (
  -- idCliente: Chave Primária Artificial (Surrogate Key)
  idCliente INT UNSIGNED NOT NULL PRIMARY KEY,

  -- Atributos Obrigatórios do Projeto Amor & Arte
  cpf VARCHAR(14) NOT NULL UNIQUE,
  nome VARCHAR(125) NOT NULL,
  telefone VARCHAR(20) NOT NULL,

  -- ATRIBUTO COMPOSTO (ENDEREÇO) DESMEMBRADO (1FN):
  -- Todos os campos são atômicos e indivisíveis.
  logradouro VARCHAR(150) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  bairro VARCHAR(60) NOT NULL,
  cidade VARCHAR(60) NOT NULL,
  uf CHAR(2) NOT NULL,
  cep CHAR(8) NOT NULL
);

-- =========================================================================
-- 1.1 TABELA CLIENTE_EMAIL (Solução da 1FN para Atributo Multivalorado)
--
-- CONCEITO:
-- Como um Cliente da Amor & Arte pode ter zero, um ou múltiplos e-mails, criamos esta
-- tabela associada. A chave primária é COMPOSTA (idCliente + email) para 
-- evitar que o mesmo e-mail seja cadastrado duas vezes para o mesmo cliente.
-- =========================================================================
CREATE TABLE ClienteEmail (
  idCliente INT UNSIGNED NOT NULL,
  email VARCHAR(100) NOT NULL,

  -- Chave Primária Composta
  PRIMARY KEY (idCliente, email),

  -- Chave Estrangeira com Integridade Referencial
  CONSTRAINT fk_cliente_email
    FOREIGN KEY (idCliente)
    REFERENCES Cliente(idCliente)
    ON DELETE CASCADE
);

-- =========================================================================
-- 2. TABELA CATEGORIA E PRODUTO (Tabelas Base para demonstrar a 2FN no Item da Venda)
--
-- CONCEITO (Amor & Arte):
-- Os produtos possuem Código do Produto (PK), Nome, Preço, Quantidade em Estoque e Categoria.
-- =========================================================================
CREATE TABLE Categoria (
  idCategoria INT UNSIGNED NOT NULL PRIMARY KEY,
  nomeCategoria VARCHAR(50) NOT NULL
);

CREATE TABLE Produto (
  idProduto INT UNSIGNED NOT NULL PRIMARY KEY,
  nomeProduto VARCHAR(100) NOT NULL,
  precoUnitario DECIMAL(10,2) NOT NULL,
  qtdEstoque INT UNSIGNED NOT NULL DEFAULT 0,
  idCategoria INT UNSIGNED NOT NULL,

  CONSTRAINT fk_produto_categoria
    FOREIGN KEY (idCategoria)
    REFERENCES Categoria(idCategoria)
);

-- =========================================================================
-- 3. TABELA VENDA (Aplicando a 3FN - Dependência Transitiva)
--
-- APLICAÇÃO DA 3ª FORMA NORMAL (3FN):
-- Regra: Nenhum atributo não-chave deve depender de outro atributo não-chave.
--
-- CONCEITO (Amor & Arte):
-- Venda possui Código da Venda (PK), Data/Hora, Valor Total e idCliente (FK).
--
-- VIOLAÇÃO DA 3FN (O QUE NÃO FAZER):
-- VENDA (idVenda, dataVenda, idCliente, nomeCliente)
-- Problema: idVenda determina o idCliente. Porém, nomeCliente depende de idCliente.
-- Isso geraria redundância e anomalias de atualização!
--
-- FORMA CORRETA (3FN APLICADA):
-- Armazenamos apenas a FK 'idCliente'. O nome do cliente é obtido via JOIN.
-- =========================================================================
CREATE TABLE Venda (
  idVenda INT UNSIGNED NOT NULL PRIMARY KEY,
  dataVenda DATETIME NOT NULL,
  valorTotal DECIMAL(10,2) NOT NULL,
  
  -- FK ligando ao Cliente (3FN mantida)
  idCliente INT UNSIGNED NOT NULL,

  CONSTRAINT fk_venda_cliente
    FOREIGN KEY (idCliente)
    REFERENCES Cliente(idCliente)
);

-- =========================================================================
-- 4. TABELA ITEM_VENDA (Aplicando a 2ª FORMA NORMAL - 2FN)
--
-- CONCEITO: Relacionamento N:M entre Venda e Produto.
-- A Chave Primária é COMPOSTA: (idVenda, idProduto).
-- Atributos próprios do relacionamento: quantidadeVendida e precoPraticado.
--
-- APLICAÇÃO DA 2ª FORMA NORMAL (2FN - DEPENDÊNCIA FUNCIONAL TOTAL):
-- Regra: Todos os atributos não-chave devem depender da TOTALIDADE da PK Composta.
--
-- VIOLAÇÃO DA 2FN (O QUE NÃO FAZER):
-- ITEM_VENDA (idVenda, idProduto, quantidadeVendida, precoPraticado, nomeProduto)
-- Problema: 'nomeProduto' depende APENAS de 'idProduto' (dependência parcial de um pedaço da chave).
--
-- FORMA CORRETA (2FN APLICADA):
-- 1. 'quantidadeVendida' e 'precoPraticado' dependem da Venda E do Produto ao mesmo tempo.
-- 2. 'nomeProduto' foi ISOLADO na tabela Produto!
-- =========================================================================
CREATE TABLE ItemVenda (
  idVenda INT UNSIGNED NOT NULL,
  idProduto INT UNSIGNED NOT NULL,
  quantidadeVendida INT UNSIGNED NOT NULL,
  precoPraticado DECIMAL(10,2) NOT NULL,
  
  -- Chave Primária Composta (2FN)
  PRIMARY KEY (idVenda, idProduto),

  -- Chaves Estrangeiras
  CONSTRAINT fk_item_venda
    FOREIGN KEY (idVenda)
    REFERENCES Venda(idVenda),

  CONSTRAINT fk_item_produto
    FOREIGN KEY (idProduto)
    REFERENCES Produto(idProduto)
);

-- =========================================================================
-- 5. INSERÇÃO DE DADOS (DML) - POVOAMENTO DO BANCO DE DADOS (AMOR & ARTE)
-- =========================================================================

-- Inserindo Clientes (1FN: CPF, Telefone e Endereço Atômico desmembrado)
INSERT INTO Cliente (idCliente, cpf, nome, telefone, logradouro, numero, bairro, cidade, uf, cep) VALUES
(1, '111.222.333-01', 'Ana Silva', '(11) 98765-4321', 'Rua das Flores', '120', 'Centro', 'São Paulo', 'SP', '01001000'),
(2, '222.333.444-02', 'Bruno Oliveira', '(21) 97654-3210', 'Av. Paulista', '1500', 'Bela Vista', 'São Paulo', 'SP', '01310100'),
(3, '333.444.555-03', 'Carla Souza', '(31) 96543-2109', 'Rua Brasil', '45', 'Jardins', 'Campinas', 'SP', '13010000');

-- Inserindo E-mails (1FN: Atributo Multivalorado resolvido em nova tabela)
INSERT INTO ClienteEmail (idCliente, email) VALUES
(1, 'ana.silva@email.com'),
(1, 'ana.trabalho@email.com'), -- Ana com 2 e-mails!
(2, 'bruno.oliveira@email.com');
-- Carla Souza (idCliente 3) não tem e-mail cadastrado ainda.

-- Inserindo Categorias de Artesanato
INSERT INTO Categoria (idCategoria, nomeCategoria) VALUES
(1, 'Cerâmica e Argila'),
(2, 'Bordados e Crochê'),
(3, 'Pintura em Tela');

-- Inserindo Produtos Artesanais e Insumos
INSERT INTO Produto (idProduto, nomeProduto, precoUnitario, qtdEstoque, idCategoria) VALUES
(10, 'Vaso de Cerâmica Pintado à Mão', 75.00, 15, 1),
(20, 'Toalha de Mesa em Crochê', 120.00, 10, 2),
(30, 'Tela Paisagem do Sertão 40x60', 250.00, 5, 3);

-- Inserindo Vendas (3FN: Apenas a FK idCliente + Atributos de Venda)
INSERT INTO Venda (idVenda, dataVenda, valorTotal, idCliente) VALUES
(101, '2026-03-01 10:30:00', 270.00, 1),
(102, '2026-03-02 14:20:00', 250.00, 1),
(103, '2026-03-05 16:45:00', 120.00, 2);

-- Inserindo Itens das Vendas (2FN: Atributos dependem de idVenda + idProduto)
INSERT INTO ItemVenda (idVenda, idProduto, quantidadeVendida, precoPraticado) VALUES
(101, 10, 2, 75.00),  -- Venda 101 tem 2 Vasos de Cerâmica
(101, 20, 1, 120.00), -- Venda 101 tem 1 Toalha de Crochê
(102, 30, 1, 250.00), -- Venda 102 tem 1 Tela Paisagem
(103, 20, 1, 120.00); -- Venda 103 tem 1 Toalha de Crochê

-- =========================================================================
-- 6. CONSULTAS DEMONSTRATIVAS DAS FORMAS NORMAIS (DQL)
-- =========================================================================

-- -------------------------------------------------------------------------
-- DEMONSTRAÇÃO DA 1FN (Consultando Atributos Multivalorados via JOIN)
-- Exibe todos os e-mails da cliente Ana Silva.
-- -------------------------------------------------------------------------
SELECT 
    c.nome AS 'Cliente',
    c.cpf AS 'CPF',
    e.email AS 'E-mail Cadastrado'
FROM Cliente c
INNER JOIN ClienteEmail e ON c.idCliente = e.idCliente
WHERE c.idCliente = 1;

-- -------------------------------------------------------------------------
-- DEMONSTRAÇÃO DA 2FN E 3FN (Reconstruindo as Informações via JOIN)
-- Como não duplicamos o nome do cliente na venda (3FN) e nem o nome do produto 
-- nos itens (2FN), usamos JOIN para juntar as tabelas sem redundância de dados!
-- -------------------------------------------------------------------------
SELECT 
    v.idVenda AS 'Nº Venda',
    v.dataVenda AS 'Data/Hora',
    c.nome AS 'Cliente',
    prod.nomeProduto AS 'Produto Artesanal',
    cat.nomeCategoria AS 'Categoria',
    item.quantidadeVendida AS 'Qtd',
    item.precoPraticado AS 'Preço Un.',
    (item.quantidadeVendida * item.precoPraticado) AS 'Subtotal'
FROM Venda v
INNER JOIN Cliente c ON v.idCliente = c.idCliente
INNER JOIN ItemVenda item ON v.idVenda = item.idVenda
INNER JOIN Produto prod ON item.idProduto = prod.idProduto
INNER JOIN Categoria cat ON prod.idCategoria = cat.idCategoria
ORDER BY v.idVenda;

-- -------------------------------------------------------------------------
-- DEMONSTRAÇÃO COM FILTROS E AGREGAÇÃO (WHERE, GROUP BY, COUNT)
-- Exibe o total gasto por cada cliente nas suas compras na Amor & Arte.
-- -------------------------------------------------------------------------
SELECT 
    c.nome AS 'Cliente',
    c.cpf AS 'CPF',
    COUNT(DISTINCT v.idVenda) AS 'Total de Vendas',
    SUM(item.quantidadeVendida * item.precoPraticado) AS 'Valor Total Gasto'
FROM Cliente c
INNER JOIN Venda v ON c.idCliente = v.idCliente
INNER JOIN ItemVenda item ON v.idVenda = item.idVenda
GROUP BY c.idCliente, c.nome, c.cpf
ORDER BY `Valor Total Gasto` DESC;
```