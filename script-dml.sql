-- ========================================================================= 
-- BANCO DE DADOS: Amor &amp; Arte (Loja de Artesanato) 
-- ARQUIVO: script-dml.sql (Povoamento Orientado a Cenários de Negócio - DML) 
-- ========================================================================= 

USE amor_e_arte;

-- ========================================================================= 
-- Cenário 1 — Configuração Inicial do Negócio: Cadastro dos Fornecedores 
-- A equipe de compras cadastrou os 5 principais fornecedores de insumos 
-- e matérias-primas para suprir o estoque da loja. 
-- =========================================================================

INSERT INTO fornecedor (id_fornecedor, cnpj, nome_fantasia, telefone, cidade_uf) VALUES
(1, '12.345.678/0001-90', 'Armarinho &amp; Fios Brasil', '(11) 3322-1100', 'São Paulo/SP'),
(2, '98.765.432/0001-10', 'Cerâmicas &amp; Argilas do Sertão', '(81) 3456-7890', 'Caruaru/PE'),
(3, '45.678.901/0001-23', 'Tintas &amp; Telas Belas Artes', '(21) 2509-4321', 'Rio de Janeiro/RJ'),
(4, '33.444.555/0001-66', 'Madeiras Esculpidas Nordeste', '(71) 3241-8899', 'Salvador/BA'),
(5, '55.666.777/0001-44', 'Tecidos &amp; Bordados Artesanais', '(31) 3123-4567', 'Belo Horizonte/MG');

-- ========================================================================= 
-- Cenário 2 — Configuração do Catálogo: Cadastro das Categorias Principais 
-- Para organizar a loja física e o catálogo online, foram criadas as 5 categorias 
-- de produtos com suas respectivas políticas de desconto. 
-- =========================================================================

INSERT INTO categoria (id_categoria, nome_categoria, descricao, desconto_padrao) VALUES
(1, 'Cerâmica e Argila', 'Peças utilitárias e decorativas moldadas à mão', 0.00), 
(2, 'Bordados e Crochê', 'Toalhas, mantas e artigos confeccionados em fios', 5.00), 
(3, 'Pintura em Tela', 'Quadros e artes visuais em tinta acrílica e óleo', 0.00), 
(4, 'Esculturas em Madeira', 'Artesanatos entalhados em madeiras nobres e de reuso', 10.00), 
(5, 'Insumos e Armarinho', 'Linhas, agulhas, pincéis e telas para artesãos', 0.00);

-- =========================================================================
-- Cenário 3 — Formação do Estoque Inicial de Produtos
-- Os primeiros 5 produtos e insumos artesanais foram cadastrados vinculando
-- cada item à sua respectiva categoria e fornecedor correspondente.
-- =========================================================================

INSERT INTO produto (id_produto, nome_produto, preco_base, qtd_estoque, id_categoria, id_fornecedor) VALUES
(1, 'Vaso de Cerâmica Pintado à Mão', 75.00, 15, 1, 2),
(2, 'Toalha de Mesa em Crochê', 120.00, 10, 2, 1),
(3, 'Tela Paisagem do Sertão 40x60', 250.00, 5, 3, 3),
(4, 'Carranca Esculpida em Jacarandá', 180.00, 8, 4, 4),
(5, 'Kit Fios de Algodão Multicores', 45.00, 30, 5, 5);

-- =========================================================================
-- Cenário 4 — Inauguração da Loja e Cadastro dos Primeiros Clientes
-- Durante a semana de inauguração, 5 clientes da comunidade local realizaram
-- seu cadastro para realizar compras na Amor & Arte.
-- =========================================================================

INSERT INTO cliente (id_cliente, cpf, nome, telefone, data_cadastro) VALUES
(1, '111.222.333-01', 'Ana Silva', '(11) 98765-4321', '2026-03-01'),
(2, '222.333.444-02', 'Bruno Oliveira', '(21) 97654-3210', '2026-03-01'),
(3, '333.444.555-03', 'Carla Souza', '(31) 96543-2109', '2026-03-02'),
(4, '444.555.666-04', 'Diego Ferreira', '(41) 95432-1098', '2026-03-03'),
(5, '555.666.777-05', 'Elena Santos', '(51) 94321-0987', '2026-03-04');

-- ========================================================================= 
-- Cenário 5 — Registro de Contatos Eletrônicos (Atributos Multivalorados) 
-- Para manter o contato e enviar novidades, foram cadastrados os e-mails 
-- dos clientes (incluindo clientes com mais de um e-mail). 
-- ========================================================================= 

INSERT INTO cliente_email (id_cliente, email, tipo_email, principal) VALUES 
(1, 'ana.silva@email.com', 'Pessoal', 'S'), (1, 'ana.atelier@email.com', 'Trabalho', 'N'), -- Ana possui 2 e-mails registrados
(2, 'bruno.oliveira@email.com', 'Pessoal', 'S'), 
(3, 'carla.souza@email.com', 'Pessoal', 'S'), 
(4, 'diego.ferreira@email.com', 'Trabalho', 'S'); 

-- ========================================================================= 
-- Cenário 6 — Primeiras Transações Comerciais (Registro de Vendas) 
-- A loja registrou 5 vendas realizadas entre o primeiro e o segundo mês de operação. 
-- ========================================================================= 

INSERT INTO venda (id_venda, data_venda, valor_total, status_venda, id_cliente) VALUES 
(101, '2026-03-05 10:30:00', 270.00, 'Concluída', 1), 
(102, '2026-03-06 14:20:00', 250.00, 'Concluída', 1), 
(103, '2026-03-07 16:45:00', 120.00, 'Concluída', 2), 
(104, '2026-03-08 11:15:00', 180.00, 'Concluída', 3), 
(105, '2026-03-09 15:00:00', 90.00, 'Concluída', 4); 

-- ========================================================================= 
-- Cenário 7 — Composição dos Pedidos (Itens Vendidos em cada Venda) 
-- Detalhamento dos produtos e quantidades adquiridas em cada uma das 5 vendas. 
-- ========================================================================= 

INSERT INTO item_venda (id_venda, id_produto, quantidade_vendida, preco_praticado, desconto_item) VALUES 
(101, 1, 2, 75.00, 0.00), -- Venda 101: 2 Vasos de Cerâmica 
(101, 2, 1, 120.00, 0.00), -- Venda 101: 1 Toalha de Crochê 
(102, 3, 1, 250.00, 0.00), -- Venda 102: 1 Tela Paisagem 
(103, 2, 1, 120.00, 0.00), -- Venda 103: 1 Toalha de Crochê 
(104, 4, 1, 180.00, 0.00); -- Venda 104: 1 Carranca em Madeira 

-- ========================================================================= 
-- Cenário 8 — Liquidação Financeira (Baixa dos Pagamentos) 
-- Registro das formas de pagamento utilizadas para quitar cada uma das 5 vendas. 
-- ========================================================================= 

INSERT INTO pagamento (id_pagamento, forma_pagamento, valor_pago, data_pagamento, id_venda) VALUES 
(1, 'Pix', 270.00, '2026-03-05 10:32:00', 101), 
(2, 'Cartão de Crédito', 250.00, '2026-03-06 14:22:00', 102), 
(3, 'Cartão de Débito', 120.00, '2026-03-07 16:46:00', 103), 
(4, 'Pix', 180.00, '2026-03-08 11:16:00', 104), 
(5, 'Dinheiro', 90.00, '2026-03-09 15:01:00', 105);