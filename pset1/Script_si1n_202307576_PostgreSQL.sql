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

/*conectar o usuario bernardo ao BD uvv*/
\connect uvv bernardo;
-- digitar senha do usuário alan: 123456

/*criar esquema lojas*/
create schema lojas authorization alan;

/*tornar lojas o esquema padrão*/
alter user alan
set search_path to elmasri, "$user", public;


/*Criação das tabelas*/

CREATE TABLE 	produtos (

                produto_id 				        NUMERIC(38) NOT NULL,
                nome 				              VARCHAR(255) NOT NULL,
                preco_unitario 			      NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type 		      VARCHAR(512),
                imagem_arquivo 			      VARCHAR(512),
                imagem_charset 			      VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id_pk  PRIMARY KEY (produto_id)
);


COMMENT ON TABLE produtos 						   							                         IS 'Tabela de produtos';
COMMENT ON COLUMN produtos.produto_id 			   							                   IS 'PK da tabela de produtos. Identifica cada produto na tabela.';
COMMENT ON COLUMN si1n_202307576_postgresql.produtos.nome 					           IS 'Nome do produto.';
COMMENT ON COLUMN si1n_202307576_postgresql.produtos.preco_unitario 		       IS 'Preco unitário do produto.';
COMMENT ON COLUMN si1n_202307576_postgresql.produtos.detalhes 				         IS 'Detalhes do produto.';
COMMENT ON COLUMN si1n_202307576_postgresql.produtos.imagem 				           IS 'Imagem do produto.';
COMMENT ON COLUMN si1n_202307576_postgresql.produtos.imagem_mime_type 		     IS 'Identificação de partes non-ASCII da imagem do produto.';
COMMENT ON COLUMN si1n_202307576_postgresql.produtos.imagem_arquivo 		       IS 'Arquivo de imagem do produto.';
COMMENT ON COLUMN si1n_202307576_postgresql.produtos.imagem_charset 		       IS 'Charset da imagem do produto.';
COMMENT ON COLUMN si1n_202307576_postgresql.produtos.imagem_ultima_atualizacao IS 'Ultima atualização da imagem do produto.';


CREATE TABLE si1n_202307576_postgresql.lojas (

                loja_id 				        NUMERIC(38) NOT NULL,
                logo BYTEA,
                endereco_fisico 		    VARCHAR(512),
                nome					          VARCHAR(255) NOT NULL,
                endereco_web 			      VARCHAR(100),
                latidude 				        NUMERIC,
                longitude 				      NUMERIC,
                logo_mime_type 			    VARCHAR(512),
                logo_arquivo 			      VARCHAR(512),
                logo_charset 			      VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id_pk 	PRIMARY KEY (loja_id)
);

COMMENT ON TABLE si1n_202307576_postgresql.lojas 						              IS 'Tabela de lojas';
COMMENT ON COLUMN si1n_202307576_postgresql.lojas.loja_id 				        IS 'PK da tabela de lojas. Identifica cada loja.';
COMMENT ON COLUMN si1n_202307576_postgresql.lojas.logo 				            IS 'Logo da loja.';
COMMENT ON COLUMN si1n_202307576_postgresql.lojas.endereco_fisico 		    IS 'Localização física da loja.';
COMMENT ON COLUMN si1n_202307576_postgresql.lojas.nome 					          IS 'Nome da loja';
COMMENT ON COLUMN si1n_202307576_postgresql.lojas.endereco_web 			      IS 'Endereço web(site) da loja.';
COMMENT ON COLUMN si1n_202307576_postgresql.lojas.latidude 				        IS 'Latidude da loja.';
COMMENT ON COLUMN si1n_202307576_postgresql.lojas.longitude 			        IS 'Longitude da loja.';
COMMENT ON COLUMN si1n_202307576_postgresql.lojas.logo_mime_type 		      IS 'Identificação de partes non-ASCII da logo.';
COMMENT ON COLUMN si1n_202307576_postgresql.lojas.logo_arquivo 			      IS 'Arquivo da logo da loja.';
COMMENT ON COLUMN si1n_202307576_postgresql.lojas.logo_charset 			      IS 'Charset da logo da loja.';
COMMENT ON COLUMN si1n_202307576_postgresql.lojas.logo_ultima_atualizacao IS 'Última atualização da logomarca da loja.';


CREATE TABLE si1n_202307576_postgresql.estoques (

                estoque_id 				       NUMERIC(38) NOT NULL,
                loja_id 				         NUMERIC(38) NOT NULL,
                produto_id 				       NUMERIC(38) NOT NULL,
                quantidade 				       NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id_pk PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE si1n_202307576_postgresql.estoques 			      IS 'Tabela de estoques.';
COMMENT ON COLUMN si1n_202307576_postgresql.estoques.estoque_id IS 'PK da tabela de estoques. Identifica cada estoque.';
COMMENT ON COLUMN si1n_202307576_postgresql.estoques.loja_id 	  IS 'Identificação da loja no estoque. É uma FK da tabela de lojas.';
COMMENT ON COLUMN si1n_202307576_postgresql.estoques.produto_id IS 'Identificação do produto no estoque. É uma FK da tabela de produtos.';
COMMENT ON COLUMN si1n_202307576_postgresql.estoques.quantidade IS 'Quantidade do produto no estoque.';


CREATE TABLE si1n_202307576_postgresql.clientes (

                cliente_id 			       NUMERIC(38) NOT NULL,
                email 				         VARCHAR(255) NOT NULL,
                nome 			             VARCHAR(255) NOT NULL,
                telefone1 			       VARCHAR(20),
                telefone2 			       VARCHAR(20),
                telefone3 			       VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);

COMMENT ON TABLE si1n_202307576_postgresql.clientes 			      IS 'Tabela de clientes';
COMMENT ON COLUMN si1n_202307576_postgresql.clientes.cliente_id IS 'Coluna de ID do cliente, tem o propósito de identificação única para cada cliente.';
COMMENT ON COLUMN si1n_202307576_postgresql.clientes.email 	   	IS 'Coluna de email do cliente.';
COMMENT ON COLUMN si1n_202307576_postgresql.clientes.nome 	   	IS 'Nome completo do cliente, assim como no seu RG.';
COMMENT ON COLUMN si1n_202307576_postgresql.clientes.telefone1 	IS 'Primeiro telefone de contato do cliente';
COMMENT ON COLUMN si1n_202307576_postgresql.clientes.telefone2 	IS 'Segundo telefone de contato do cliente';
COMMENT ON COLUMN si1n_202307576_postgresql.clientes.telefone3 	IS 'Terceiro telefone de contato do cliente.';


CREATE TABLE si1n_202307576_postgresql.pedidos (

                pedido_id 				      NUMERIC(38) NOT NULL,
                loja_id 				        NUMERIC(38) NOT NULL,
                status 					        VARCHAR(15) NOT NULL,
                cliente_id 				      NUMERIC(38) NOT NULL,
                data_hora 				      TIMESTAMP NOT NULL,
                CONSTRAINT pedido_id_pk PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE si1n_202307576_postgresql.pedidos 			       IS 'Tabela de pedidos';
COMMENT ON COLUMN si1n_202307576_postgresql.pedidos.pedido_id  IS 'PK da tabela de pedidos. Identifica cada pedido.';
COMMENT ON COLUMN si1n_202307576_postgresql.pedidos.loja_id    IS 'FK da tabela de lojas, identifica a loja onde cada pedido foi feito.';
COMMENT ON COLUMN si1n_202307576_postgresql.pedidos.status 	   IS 'Indica o status do pedido.';
COMMENT ON COLUMN si1n_202307576_postgresql.pedidos.cliente_id IS 'Chave estrangeira da tabela clientes, identifica o cliente de cada pedido.';
COMMENT ON COLUMN si1n_202307576_postgresql.pedidos.data_hora  IS 'Data e hora da realização do pedido.';


CREATE TABLE si1n_202307576_postgresql.envios (

                envio_id 			         NUMERIC(38) NOT NULL,
                status 				         VARCHAR(15) NOT NULL,
                loja_id 			         NUMERIC(38) NOT NULL,
                cliente_id 			       NUMERIC(38) NOT NULL,
                endereco_entrega 	     VARCHAR(512) NOT NULL,
                CONSTRAINT envio_id_pk PRIMARY KEY (envio_id)
);

COMMENT ON TABLE si1n_202307576_postgresql.envios 					        IS 'Tabela de envios dos pedidos.';
COMMENT ON COLUMN si1n_202307576_postgresql.envios.envio_id 		    IS 'PK da tabela de envios. Identifica cada envio de pedido.';
COMMENT ON COLUMN si1n_202307576_postgresql.envios.status 			    IS 'Status de envio do pedido.';
COMMENT ON COLUMN si1n_202307576_postgresql.envios.loja_id 			    IS 'Identificação da loja responsável pelo envio. É uma FK da tabela de lojas.';
COMMENT ON COLUMN si1n_202307576_postgresql.envios.cliente_id 		  IS 'Identificação do cliente destinatário do envio. É uma FK da tabela de clientes.';
COMMENT ON COLUMN si1n_202307576_postgresql.envios.endereco_entrega IS 'Endereço de entrega do pedido a qual está sendo enviado.';


CREATE TABLE si1n_202307576_postgresql.pedidos_itens (

                pedido_id 					         NUMERIC(38) NOT NULL,
                produto_id 					         NUMERIC(38) NOT NULL,
                numero_da_linha 			       NUMERIC(38) NOT NULL,
                preco_unitario 				       NUMERIC(10,2) NOT NULL,
                quantidade 					         NUMERIC(38) NOT NULL,
                envio_id 					           NUMERIC(38),
                CONSTRAINT pedidos_itens_pk_ PRIMARY KEY (pedido_id, produto_id)
);

COMMENT ON TABLE si1n_202307576_postgresql.pedidos_itens 				          IS 'Tabela intermediária entre produtos e pedidos.';
COMMENT ON COLUMN si1n_202307576_postgresql.pedidos_itens.pedido_id 	    IS 'PFK da tabela de pedidos_itens. Identifica o pedido a qual o item pertence.';
COMMENT ON COLUMN si1n_202307576_postgresql.pedidos_itens.produto_id 	    IS 'PFK da tabela de pedidos_itens. Identifica o produto em cada pedido.';
COMMENT ON COLUMN si1n_202307576_postgresql.pedidos_itens.numero_da_linha IS 'Número da linha do item pertencente ao pedido.';
COMMENT ON COLUMN si1n_202307576_postgresql.pedidos_itens.preco_unitario  IS 'Preço do produto(item) pertencente ao pedido.';
COMMENT ON COLUMN si1n_202307576_postgresql.pedidos_itens.quantidade 	    IS 'Quantidade de itens(produtos) pertencentes ao pedido.';
COMMENT ON COLUMN si1n_202307576_postgresql.pedidos_itens.envio_id 		    IS 'Identificação do envio de cada item do produto. É uma FK da tabela de envios.';


/*Criação das chaves estrangeiras e compostas*/

ALTER TABLE si1n_202307576_postgresql.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES si1n_202307576_postgresql.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE si1n_202307576_postgresql.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES si1n_202307576_postgresql.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE si1n_202307576_postgresql.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES si1n_202307576_postgresql.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE si1n_202307576_postgresql.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES si1n_202307576_postgresql.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE si1n_202307576_postgresql.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES si1n_202307576_postgresql.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE si1n_202307576_postgresql.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES si1n_202307576_postgresql.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE si1n_202307576_postgresql.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES si1n_202307576_postgresql.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE si1n_202307576_postgresql.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES si1n_202307576_postgresql.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
