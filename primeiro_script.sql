-- Isso é um comentario de uma linha!

-- Criação do banco de dados chamado escola
CREATE DATABASE TM_Escola;

-- selecionar o banco de dados Escola para usar 
-- nas proximas instruções
USE TM_Escola;

-- criaremos a tabela chamada alunos
CREATE TABLE Alunos (
	id INT PRIMARY KEY IDENTITY(1,1),
	Nome NVARCHAR(100) NOT NULL,
	Idade INT NOT NULL,
	Email NVARCHAR(100),
	DataMatricula DATE NOT NULL
);



