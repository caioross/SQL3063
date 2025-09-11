USE Escola;

-- exclui a tabela cursos e matriculas caso elas já existam
DROP TABLE IF EXISTS Cursos;
DROP TABLE IF EXISTS Matriculas;

-- cria a tabela cursos 
CREATE TABLE Cursos(
	id INT PRIMARY KEY IDENTITY(1,1),
	NomeCurso NVARCHAR(100) NOT NULL,
	CargaHoraria INT NOT NULL
);

INSERT INTO Cursos (NomeCurso, CargaHoraria)
VALUES
    ('SQL 01', 40),
    ('Python Básico',32),
	('Power BI', 70),
    ('Excel Avançado',16),
    ('PHP',80);
	
CREATE TABLE Matriculas (
    id INT PRIMARY KEY IDENTITY(1,1),
    AlunoId INT NOT NULL,
    CursoId INT NOT NULL,
    DataInscricao DATE NOT NULL,

    FOREIGN KEY (AlunoId) REFERENCES Alunos(id),
    FOREIGN KEY (CursoId) REFERENCES Cursos(id)
);

INSERT INTO Matriculas (AlunoId, CursoId, DataInscricao)
VALUES
    (1,1, '2025-09-11'),
    (2,2, '2025-05-20'),
    (8,3, '2025-02-12'),
    (9,5, '2025-02-01'),
	(10,4, '2025-02-01'),
	(11,3, '2025-02-01'),
    (12,2, '2025-09-15');


-- INNER JOIN
-- mostrar apenas alunos matriculados
SELECT a.Nome, a.Email, c.NomeCurso, m.DataInscricao
FROM Alunos a

INNER JOIN Matriculas m ON a.id = m.AlunoId
INNER JOIN Cursos c ON c.id = m.CursoId

ORDER BY a.Nome;

INSERT INTO Alunos (Nome, Idade, Email, DataMatricula)
VALUES 
	(N'Caio Rossi', 38, N'caio@email.com' , '2025-02-12'),
	(N'Thami Lima', 31 , N'thami@email.com', '2023-06-01');

-- LEFT JOIN
-- mostrar todos os aluno mesmo sem matricula
SELECT a.Nome, c.NomeCurso, m.DataInscricao
FROM Alunos a

LEFT JOIN Matriculas m ON a.id = m.AlunoId
LEFT JOIN Cursos c ON c.id = m.CursoId

ORDER BY m.DataInscricao;

-- RIGHT JOIN
-- mostrar todos os cursos mesmo sem alunos
SELECT 
	c.NomeCurso AS Cursos,
	m.DataInscricao AS Datas, 
	a.Nome AS 'Nome Aluno'
FROM Cursos c

RIGHT JOIN Matriculas m ON c.id = m.CursoId
RIGHT JOIN Alunos a ON a.id = m.AlunoId

ORDER BY c.NomeCurso;


---- Bloco dos Profis
DROP TABLE IF EXISTS Professores;
CREATE TABLE Professores(
	id INT PRIMARY KEY IDENTITY(1,1),
	Nome NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100)
);

INSERT INTO Professores (Nome, Email) 
VALUES
	('Caio Ross', 'kio199@gmail.com'),
	('Sibeli Power', 'Sibeli@ig.com'),
	('Genilson', 'genilson@hotmail.com');

SELECT * FROM Professores;

----- bloco nas notas
DROP TABLE IF EXISTS Notas;
CREATE TABLE Notas(
	id INT PRIMARY KEY IDENTITY(1,1),
	AlunoId INT NOT NULL,
	CursoId INT NOT NULL,
	Nota INT NOT NULL,
	DataAvaliacao DATE NOT NULL

	FOREIGN KEY (AlunoId) REFERENCES Alunos(id),
	FOREIGN KEY (CursoId) REFERENCES Cursos(id)
);

INSERT INTO Notas (AlunoId, CursoId, Nota, DataAvaliacao)
VALUES 
	(1,1,8,'2024-04-12'),
	(8,2,7,'2024-05-11'),
	(9,3,6,'2024-06-16'),
	(10,4,5,'2024-07-02'),
	(11,3,4,'2024-08-02');

SELECT * FROM Notas;

------- Bloco de Pagamentos
DROP TABLE IF EXISTS Pagamentos
CREATE TABLE Pagamentos(
	id INT PRIMARY KEY IDENTITY(1,1),
	AlunoId INT NOT NULL,
	Valor INT NOT NULL,
	DataPagamento DATE NOT NULL,
	Situacao NVARCHAR(10) NOT NULL,

	FOREIGN KEY (AlunoId) REFERENCES Alunos(id)
);
INSERT INTO Pagamentos (AlunoId, Valor, DataPagamento, Situacao)
VALUES 
	(1, 300, '2022-09-01', 'Pago'),
	(8, 300, '2022-09-02', 'Atrasado'),
	(9, 500, '2022-09-01', 'Pendente'),
	(10, 300, '2025-06-01', 'Pago'),
	(11, 400, '2023-08-01', 'Atrasado'),
	(12, 500, '2024-10-01', 'Pendente');

--- Mostrar notas dos alunos em cada curso
SELECT 
	a.Nome AS Aluno,
	c.NomeCurso AS Curso,
	n.Nota,
	n.DataAvaliacao AS Data
FROM Notas n

INNER JOIN Alunos a ON a.id = n.AlunoId
INNER JOIN Cursos c ON c.id = n.CursoId

ORDER BY n.DataAvaliacao DESC

--- Média de notas por curso
SELECT c.NomeCurso, AVG(n.Nota) AS 'Media Notas'
FROM Notas n
INNER JOIN Cursos c ON c.id = n.CursoId
GROUP BY c.NomeCurso
ORDER BY 'Media Notas' DESC;

--- mostrar situação de pagamento por aluno
SELECT a.Nome, p.Valor, p.DataPagamento, p.Situacao
FROM Pagamentos p
INNER JOIN Alunos a ON a.id = p.AlunoId
ORDER BY p.DataPagamento DESC;

--- quantidade de alunos por situação de pagamento
SELECT p.Situacao, COUNT(*) AS Quantidade
FROM Pagamentos p
GROUP BY p.Situacao