/*login com o usuário postgres*/
su - postgres
-- digite a senha do usuário postgres: postgres

/* crie o usuário alan para ser o dono do BD*/
createuser alan -dPs
--digitar senha: 123456
--confirmar senha: 123456
--digitar senha administrativa do BD: computacao@raiz

/*entre no usuário postgres*/
psql
--digitar senha administrativa do BD: computacao@raiz

/*criar BD chamado uvv*/
create database uvv with
owner = 'alan'
template = template0
encoding = 'UTF8'
lc_collate = 'pt_BR.UTF-8'
lc_ctype = 'pt_BR.UTF-8'
allow_connections = true;

/*conectar o usuario alan ao BD uvv*/
\connect uvv alan;
-- digitar senha do usuário alan: 123456

/*criar esquema lojas*/
create schema lojas authorization alan;

/*tornar lojas o esquema padrão*/
alter user alan
set search_path to uvv, "$user", public;

/*CRIAÇÃO DAS TABELAS */
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id_pk PRIMARY KEY (produto_id)
);
COMMENT ON TABLE lojas.produtos IS 'Tabela de produtos';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'PK da tabela de produtos. Identifica cada produto na tabela.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Nome do produto.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preco unitário do produto.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Detalhes do produto.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Identificação de partes non-ASCII da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Arquivo de imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Charset da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Ultima atualização da imagem do produto.';


CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                logo BYTEA,
                endereco_fisico VARCHAR(512),
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                latidude NUMERIC,
                longitude NUMERIC,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id_pk PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas.lojas IS 'Tabela de lojas';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'PK da tabela de lojas. Identifica cada loja.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Logo da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Localização física da loja.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Nome da loja';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Endereço web(site) da loja.';
COMMENT ON COLUMN lojas.lojas.latidude IS 'Latidude da loja.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Longitude da loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Identificação de partes non-ASCII da logo.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Arquivo da logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Charset da logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Última atualização da logomarca da loja.';


CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id_pk PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques IS 'Tabela de estoques.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'PK da tabela de estoques. Identifica cada estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Identificação da loja no estoque. É uma FK da tabela de lojas.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Identificação do produto no estoque. É uma FK da tabela de produtos.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade do produto no estoque.';


CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes IS 'Tabela de clientes';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Coluna de ID do cliente, tem o propósito de identificação única para cada cliente.';
COMMENT ON COLUMN lojas.clientes.email IS 'Coluna de email do cliente.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Nome completo do cliente, assim como no seu RG.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Primeiro telefone de contato do cliente';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Segundo telefone de contato do cliente';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Terceiro telefone de contato do cliente.';


CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,lojas
                loja_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                CONSTRAINT pedido_id_pk PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE lojas.pedidos IS 'Tabela de pedidos';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'PK da tabela de pedidos. Identifica cada pedido.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'FK da tabela de lojas, identifica a loja onde cada pedido foi feito.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Indica o status do pedido.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Chave estrangeira da tabela clientes, identifica o cliente de cada pedido.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Data e hora da realização do pedido.';


CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                CONSTRAINT envio_id_pk PRIMARY KEY (envio_id)
);
COMMENT ON TABLE lojas.envios IS 'Tabela de envios dos pedidos.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'PK da tabela de envios. Identifica cada envio de pedido.';
COMMENT ON COLUMN lojas.envios.status IS 'Status de envio do pedido.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Identificação da loja responsável pelo envio. É uma FK da tabela de lojas.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Identificação do cliente destinatário do envio. É uma FK da tabela de clientes.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço de entrega do pedido a qual está sendo enviado.';


CREATE TABLE lojas.pedidos_itens (lojas
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedidos_itens_pk_ PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela intermediária entre produtos e pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'PFK da tabela de pedidos_itens. Identifica o pedido a qual o item pertence.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'PFK da tabela de pedidos_itens. Identifica o produto em cada pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Número da linha do item pertencente ao pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preço do produto(item) pertencente ao pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade de itens(produtos) pertencentes ao pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Identificação do envio de cada item do produto. É uma FK da tabela de envios.';


ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojaslojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
