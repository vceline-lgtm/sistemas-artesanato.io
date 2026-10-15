USE amor_e_arte;

INSERT INTO categoria (id_categoria, nome_categoria) VALUES (1, 'Cerâmica e Argila');
INSERT INTO categoria (id_categoria, nome_categoria) VALUES (2, 'Bordados e Crochê');
INSERT INTO categoria (id_categoria, nome_categoria) VALUES (3, 'Pintura em Tela'); 
INSERT INTO categoria (id_categoria, nome_categoria) VALUES (4, 'Esculturas em Madeira');

INSERT INTO cliente (id_cliente, nome, cpf, telefone, email) VALUES (1, 'Ana Silva', '12345678901', '11987654321', 'ana.silva@email.com');
INSERT INTO cliente (id_cliente, nome, cpf, telefone, email) VALUES (2, 'Bruno Oliveira', '222.333.444-02', '(21) 97654-3210', 'bruno.oliveira@email.com');
INSERT INTO cliente (id_cliente, nome, cpf, telefone, email) VALUES (3, 'Carla Souza', '333.444.555-03', '(31) 96543-2109', 'carla.souza@email.com');
INSERT INTO cliente (id_cliente, nome, cpf, telefone, email) VALUES (4, 'Diego Ferreira', '444.555.666-04', '(41) 95432-1098', 'diego.ferreira@email.com');
INSERT INTO cliente (id_cliente, nome, cpf, telefone, email) VALUES (5, 'Elena Santos', '555.666.777-05', '(51) 94321-0987', 'elena.santos@email.com');
INSERT INTO cliente (id_cliente, nome, cpf, telefone, email) VALUES (6, 'Fernando Lima', '666.777.888-06', '(61) 93210-9876', 'fernando.lima@email.com');
INSERT INTO cliente (id_cliente, nome, cpf, telefone, email) VALUES (7, 'Gabriela Costa', '777.888.999-07', '(71) 92109-8765', 'gabriela.costa@email.com');
INSERT INTO cliente (id_cliente, nome, cpf, telefone, email) VALUES (8, 'Heitor Mendes', '888.999.000-08', '(81) 91098-7654', 'heitor.mendes@email.com');

INSERT INTO item_venda (id_venda, id_produto, quantidade_vendida, preco_praticado) VALUES (1, 1, 2, 75.00);
INSERT INTO item_venda (id_venda, id_produto, quantidade_vendida, preco_praticado) VALUES (2, 2, 1, 85.50);
INSERT INTO item_venda (id_venda, id_produto, quantidade_vendida, preco_praticado) VALUES (3, 3, 1, 210.00);
INSERT INTO item_venda (id_venda, id_produto, quantidade_vendida, preco_praticado) VALUES (13, 4, 1, 180.00);
INSERT INTO item_venda (id_venda, id_produto, quantidade_vendida, preco_praticado) VALUES (13, 1, 1, 75.00);