USE amor_e_arte;

SELECT 
    id_cliente,
    nome, 
    cpf, 
    telefone, 
    email
FROM cliente 
ORDER BY nome ASC;

SELECT 
    v.id_venda, 
    c.nome AS nome_cliente, 
    c.cpf, 
    v.data_venda, 
    v.valor_total 
FROM venda v 
INNER JOIN cliente c ON v.id_cliente = c.id_cliente 
ORDER BY v.data_venda DESC;

SELECT 
    c.id_cliente, 
    c.nome AS nome_cliente, 
    v.id_venda, 
    v.data_venda, 
    v.valor_total 
FROM cliente c 
LEFT JOIN venda v ON c.id_cliente = v.id_cliente 
ORDER BY c.id_cliente ASC;

SELECT 
    c.id_cliente, 
    c.nome AS nome_cliente, 
    COUNT(v.id_venda) AS total_compras, 
    COALESCE(SUM(v.valor_total), 0.00) AS total_gasto 
FROM cliente c 
LEFT JOIN venda v ON c.id_cliente = v.id_cliente 
GROUP BY c.id_cliente, c.nome 
ORDER BY total_compras DESC;

SELECT 
    c.id_cliente, 
    c.nome AS nome_cliente, 
    c.cpf, 
    c.telefone, 
    c.email 
FROM cliente c 
LEFT JOIN venda v ON c.id_cliente = v.id_cliente 
WHERE v.id_venda IS NULL;

