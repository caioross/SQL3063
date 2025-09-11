-- salvar como introducao.sql
USE master;
GO

DROP DATABASE IF EXISTS Escola; 
GO

CREATE DATABASE Escola;
GO

USE Escola;
GO

DROP TABLE IF EXISTS Alunos;
CREATE TABLE Alunos (
	id INT PRIMARY KEY IDENTITY(1,1),
	Nome NVARCHAR(100) NOT NULL,
	Idade INT NOT NULL,
	Email NVARCHAR(100),
	DataMatricula DATE NOT NULL
);

INSERT INTO Alunos (Nome, Idade, Email, DataMatricula)
VALUES 
	(N'Bruno Ventura', 30, N'bruno@email.com' , '2025-02-12'),
	(N'Christian Pereira', 29 , N'christian@email.com', '2023-06-01'),
	(N'Jotael Genuíno', 25 , N'jotael@gmail.com', '2020-09-14'),
	(N'Diogo Santana', 27 , N'diogo@gmail.com', '2024-08-22'),
	(N'Heitor Bueno', 18 , N'heitor@gmail.com', '2021-01-01' );

-- [01] Mostrar todos os alunos
SELECT * FROM Alunos;

-- [02] Mostrar apenas os nomes e idades
SELECT Nome, Idade 
FROM Alunos;

-- [3] Mostrar os alunos com idade maior que 26 anos
SELECT * FROM Alunos WHERE Idade > 26
/*
testes comuns:
Menor ou igual: <=
Maior ou igual: >=
Maior: >
Menor: <
igual: =
diferente: <>
*/

-- [4] desafio: mostrar apenas alunos com idades menores 
-- ou iguais a 26 anos
SELECT * FROM Alunos 
WHERE Idade <= 26;

-- [5] Mostrar os alunos em ordem alfabetica
SELECT * FROM Alunos ORDER BY Nome ASC;
-- [6] Mostrar os alunos mais novos primeiro
SELECT * FROM Alunos ORDER BY Idade ASC;

-----------  Atualizando os dados (UPDATE)  -------------
-- [7] Atualizar o email do aluno com id=?
UPDATE Alunos 
SET  Email = N'chris@seusite.com.br'
WHERE id = 2;

-- [8] Visualizar apenas o ID alterado
SELECT id, Nome, Email FROM Alunos
WHERE id = 2;

-- [9] Aumentar a idade de todos os alunos em 1 ano
UPDATE Alunos
SET Idade = Idade + 1;

-- [10] Exibir linhas alteradas
-- Somente mostrar nome e idade, e ordenar por nome crescente
SELECT Nome, Idade FROM Alunos ORDER BY Nome ASC;

-----------  Remoção de dados (DELETE)  -------------

-- [11] Remover o aluno com id = 5
DELETE FROM Alunos
WHERE id = 7;

-- [12] Remover todos os alunos com idade menor que 30 anos
DELETE FROM Alunos
WHERE Idade < 30;

-- [13] Mostrar alunos que se matricularam apos uma data
SELECT * FROM Alunos
WHERE DataMatricula > '2024-01-01';

-- [14] Mostrar Alunos cujo nome começa com a letra D
SELECT * FROM Alunos
WHERE Nome LIKE N'D%';

-- [15] Mostrar apenas os 3 alunos mais novos
SELECT TOP 3 * FROM Alunos
ORDER BY Idade ASC;

-- [16] Mostrar apenas o aluno mais velho
SELECT TOP 1 * FROM Alunos 
ORDER BY Idade DESC;

-- [17] Contar quantos alunos temos na tabela
SELECT COUNT(*) AS  TotalAlunos FROM Alunos;

-- [18] Calcular a media de idade dos alunos
SELECT AVG(Idade) AS MediaIdade FROM Alunos;
