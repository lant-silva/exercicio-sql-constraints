-- Criação do banco
CREATE DATABASE Maternidade
GO
USE Maternidade

-- Tabelas

CREATE TABLE mae(
id_mae					INT				NOT NULL	IDENTITY(1001, 1),
nome					VARCHAR(60)		NOT NULL,
logradouro_endereco		VARCHAR(100)	NOT NULL,
numero_endereco			INT				NOT NULL	CHECK(numero_endereco > 0),
cep_endereco			CHAR(8)			NOT NULL	CHECK(LEN(cep_endereco) = 8),
complemento_endereco	VARCHAR(200)	NOT NULL,
telefone				CHAR(10)		NOT NULL	CHECK(LEN(telefone) = 10),
data_nasc				DATE			NOT NULL
PRIMARY KEY (id_mae)
)

CREATE TABLE bebe(
id_bebe					INT				NOT NULL	IDENTITY(1,1),
nome					VARCHAR(60)		NOT NULL,
data_nasc				DATE			NOT NULL	DEFAULT('2023-10-17'),
altura					DECIMAL(7,2)	NOT NULL	CHECK(altura > 0),
peso					DECIMAL(4,3)	NOT NULL	CHECK(peso > 0),
id_mae					INT				NOT NULL
PRIMARY KEY (id_bebe),
FOREIGN KEY (id_mae) REFERENCES mae(id_mae)
)

CREATE TABLE medico(
crm_numero				INT				NOT NULL,
crm_uf					CHAR(2)			NOT NULL,
nome					VARCHAR(60)		NOT NULL,
telefone_celular		CHAR(11)		NOT NULL	UNIQUE CHECK(LEN(telefone_celular) = 11),
especialidade			VARCHAR(30)		NOT NULL
PRIMARY KEY (crm_numero, crm_uf),
)

CREATE TABLE bebe_medico(
id_bebe					INT				NOT NULL,
crm_numero				INT				NOT NULL,
crm_uf					CHAR(2)			NOT NULL
FOREIGN KEY (id_bebe) REFERENCES bebe(id_bebe),
FOREIGN KEY (crm_numero, crm_uf) REFERENCES medico(crm_numero, crm_uf),
)


