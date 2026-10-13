# sistemas-artesanato.io
## Especificação do Modelo de Entidade e Relacionamento (MER) - Amor &amp; Arte

## 1. Entidades

* **Cliente**: Representa o consumidor que adquire as peças artesanais e materiais na loja.
* **Venda**: Representa o registro de cada transação comercial/pedido efetuado na loja.
* **Produto**: Representa os artigos artesanais e suprimentos disponíveis para comercialização.
* **Categoria**: Representa a classificação e agrupamento dos produtos (ex: "Bordados", "Cerâmica", "Pintura em Tela").

---

## 2. Relacionamentos e Cardinalidades

* **[Cliente] (1) <realiza> (N) [Venda]**
  * *Explicação*: Um Cliente pode realizar N Vendas na loja ao longo do tempo, mas cada Venda pertence a apenas 1 Cliente.
* **[Venda] (N) <contém> (M) [Produto]**
  * *Explicação*: Uma Venda pode conter M Produtos artesanais diferentes, e um mesmo Produto pode estar presente em N Vendas distintas.
* **[Produto] (N) <pertence> (1) [Categoria]**
  * *Explicação*: Vários Produtos (N) podem ser classificados em 1 Categoria, enquanto cada Categoria abrange N Produtos.

---

## 3. Sugestão de Atributos

### Cliente
* **`cpf`** (Chave Primária - PK): Identificador único do cliente.
* `nome`: Nome completo do cliente.
* `telefone`: Telefone de contato.
* `email`: Endereço de e-mail do cliente.

### Venda
* **`cod_venda`** (Chave Primária - PK): Identificador único da compra/pedido.
* `data_hora`: Data e horário de realização da venda.
* `valor_total`: Valor total acumulado do pedido.

### Produto
* **`cod_produto`** (Chave Primária - PK): Identificador único do produto artesanal.
* `nome_produto`: Nome e descrição da peça.
* `preco`: Preço unitário cadastrado do produto.
* `qtd_estoque`: Quantidade de unidades disponíveis em estoque.

### Categoria
* **`cod_categoria`** (Chave Primária - PK): Identificador único da categoria.
* `nome_categoria`: Nome da categoria de artesanato.

### Atributos do Relacionamento `contém`
* **`quantidade_vendida`**: Quantidade de unidades daquele produto adquiridas na venda.
* **`preco_praticado`**: Preço unitário efetivamente cobrado pela peça no momento daquela compra específica.

---

## 4. Diagrama Entidade e Relacionamento (DER)

Abaixo está a representação visual do Modelo Entidade-Relacionamento Conceitual para a loja Amor & Arte:

<img width="751" height="803" alt="image" src="https://github.com/user-attachments/assets/575de0f8-2e27-440b-9e76-e03dbd2bacfe" />

