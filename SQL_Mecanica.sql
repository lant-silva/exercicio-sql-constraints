CREATE TABLE Mecanica
GO 
USE Mecanica

CREATE TABLE cliente(
id				INT				NOT NULL	IDENTITY(3401, 15),
nome			VARCHAR(100)	NOT NULL,
logradouro		VARCHAR(200)	NOT NULL,
numero			INT				NOT NULL	CHECK(numero > 0),
cep				CHAR(8)			NOT NULL	CHECK(LEN(cep) = 8),
complemento		VARCHAR(255)	NOT NULL
PRIMARY KEY (id)
)

CREATE TABLE telefone_cliente(
id_cliente		INT				NOT NULL,
telefone		VARCHAR(11)		NOT NULL	CHECK(LEN(telefone) >= 10)
PRIMARY KEY(telefone)
FOREIGN KEY(id_cliente) REFERENCES cliente(id)
)

CREATE TABLE veiculo(
placa			CHAR(7)			NOT NULL	CHECK(LEN(placa) = 7),
marca			VARCHAR(30)		NOT NULL,
modelo			VARCHAR(30)		NOT NULL,
cor				VARCHAR(15)		NOT NULL,
ano_fabricacao	INT				NOT NULL	CHECK(ano_fabricacao > 1997),
ano_modelo		INT				NOT NULL	CHECK((ano_modelo > 1997) AND (ano_modelo = ano_fabricacao) AND (ano_modelo = ano_fabricacao + 1)),
data_aquisicao	DATE			NOT NULL,
id_cliente		INT				NOT NULL
PRIMARY KEY (placa)
FOREIGN KEY (id_cliente) REFERENCES cliente(id)
)

CREATE TABLE peca(
id				INT				NOT NULL	IDENTITY(3411, 7),
nome			VARCHAR(30)		NOT NULL	UNIQUE,
preco			DECIMAL(4,2)	NOT NULL	CHECK(preco > 0),
estoque			INT				NOT NULL	CHECK(estoque > 10)
PRIMARY KEY (id)
)

CREATE TABLE categoria(
id				INT				NOT NULL	IDENTITY(1,1),
categoria		VARCHAR(10)		NOT NULL	,
valor_hora		DECIMAL(4,2)	NOT NULL	CHECK(valor_hora > 0)
PRIMARY KEY (id),
CONSTRAINT chk_cat_hora	CHECK((categoria = 'Estagiario' AND valor_hora >= 15) OR (categoria = 'Nivel 1' AND valor_hora >= 25) OR (categoria = 'Nivel 2' AND valor_hora >= 35) OR (categoria = 'Nivel 3' AND valor_hora >= 50))
)

CREATE TABLE funcionario(
id				INT				NOT NULL	IDENTITY(101, 1),
nome			VARCHAR(60)		NOT NULL,
logradouro		VARCHAR(200)	NOT NULL,
numero			INT				NOT NULL,
telefone		CHAR(11)		NOT NULL	CHECK(LEN(telefone) >= 10),
categoria_hab	VARCHAR(2)	NOT NULL	CHECK((categoria_hab = 'A') OR (categoria_hab = 'B') OR (categoria_hab = 'C') OR (categoria_hab = 'D') OR (categoria_hab = 'E')),
id_categoria	INT				NOT NULL
PRIMARY KEY (id)
FOREIGN KEY (id_categoria) REFERENCES categoria(id)
)

CREATE TABLE reparo(
placa_veiculo	CHAR(7)			NOT NULL,
id_funcionario	INT				NOT NULL,
id_peca			INT				NOT NULL,
id_data			DATE			NOT NULL	DEFAULT('2023-10-17'),
custo_total		DECIMAL(4,2)	NOT NULL	CHECK(custo_total > 0),
tempo			INT				NOT NULL	CHECK(tempo > 0)
PRIMARY KEY (id_data)
FOREIGN KEY (placa_veiculo) REFERENCES veiculo(placa),
FOREIGN KEY (id_funcionario) REFERENCES funcionario(id),
FOREIGN KEY (id_peca) REFERENCES peca(id)
)

