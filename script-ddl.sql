-- =========================================================================
-- BANCO DE DADOS: Amor &amp; Arte (Loja de Artesanato)
-- ARQUIVO: script-ddl.sql (Definição de Estrutura de Dados - DDL)
-- =========================================================================

DROP DATABASE IF EXISTS amor_e_arte;
CREATE DATABASE amor_e_arte;
USE amor_e_arte;

-- =========================================================================
-- 1. TABELA FORNECEDOR (Tabela Pai - Insumos e Matérias-Primas)
-- =========================================================================

CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    nome_fantasia VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    cidade_uf VARCHAR(60) NOT NULL
);

-- =========================================================================
-- 2. TABELA CATEGORIA (Tabela Pai - Classificação dos Produtos)
-- =========================================================================

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL,
    descricao VARCHAR(150) NOT NULL,
    desconto_padrao DECIMAL(5,2) NOT NULL DEFAULT 0.00 CHECK (desconto_padrao >= 0)
);

-- =========================================================================
-- 3. TABELA CLIENTE (Tabela Pai - Consumidores e Artesãos)
-- =========================================================================

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- =========================================================================
-- 4. TABELA CLIENTE_EMAIL (Tabela Filha de Cliente - 1FN / Multivalorado)
-- =========================================================================

CREATE TABLE cliente_email (
    id_cliente INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    tipo_email VARCHAR(20) NOT NULL DEFAULT 'Pessoal' CHECK (tipo_email IN ('Pessoal', 'Trabalho', 'Outro')),
    principal CHAR(1) NOT NULL DEFAULT 'S' CHECK (principal IN ('S', 'N')),
    PRIMARY KEY (id_cliente, email),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
);

-- =========================================================================
-- 5. TABELA PRODUTO (Tabela Filha de Categoria e Fornecedor)
-- =========================================================================

CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco_base DECIMAL(10,2) NOT NULL CHECK (preco_base > 0),
    qtd_estoque INT NOT NULL DEFAULT 0 CHECK (qtd_estoque >= 0),
    id_categoria INT NOT NULL,
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

-- =========================================================================
-- 6. TABELA VENDA (Tabela Filha de Cliente)
-- =========================================================================

CREATE TABLE venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    data_venda DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) NOT NULL CHECK (valor_total >= 0),
    status_venda VARCHAR(20) NOT NULL DEFAULT 'Concluída' CHECK (status_venda IN ('Pendente', 'Concluída', 'Cancelada')),
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- =========================================================================
-- 7. TABELA ITEM_VENDA (Tabela Associativa N:M entre Venda e Produto)
-- =========================================================================

CREATE TABLE item_venda (
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade_vendida INT NOT NULL CHECK (quantidade_vendida > 0),
    preco_praticado DECIMAL(10,2) NOT NULL CHECK (preco_praticado > 0),
    desconto_item DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (desconto_item >= 0),
    PRIMARY KEY (id_venda, id_produto),
    FOREIGN KEY (id_venda) REFERENCES venda(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- =========================================================================
-- 8. TABELA PAGAMENTO (Tabela Filha de Venda)
-- =========================================================================

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    forma_pagamento VARCHAR(30) NOT NULL CHECK (forma_pagamento IN ('Pix', 'Cartão de Crédito', 'Cartão de Débito', 'Dinheiro', 'Boleto')),
    valor_pago DECIMAL(10,2) NOT NULL CHECK (valor_pago > 0),
    data_pagamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_venda INT NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES venda(id_venda)
);