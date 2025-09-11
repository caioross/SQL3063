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

/*

criar 3 tabelas:
professores: id / nome / email
notas: id / alunoid / cursoid / data avaliacao
pagamentos: id / alunoid / valor / datapagamento / status

*/
