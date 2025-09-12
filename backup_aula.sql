USE Escola;
GO

SELECT * FROM Alunos;

------ BACKUP COMPLETO -------
-- Caminho do Arquivo .BAK 

DECLARE @arquivo NVARCHAR(260) = N'C:\Users\integral\Desktop\SQL_Caio\Full_BKP_Escola.bak';

BACKUP DATABASE Escola
TO DISK = @arquivo
WITH    INIT, -- sobreescreve o arquivo de backup 
			  -- anterior se já existir
		COMPRESSION, -- torna o arquivo menor
		STATS = 10; -- progresso a cada 10%


------ BACKUP DIFERENCIAL -------
-- Caminho do Arquivo .BAK 

DECLARE @arquivo2 NVARCHAR(260) = N'C:\Users\integral\Desktop\SQL_Caio\Diff_BKP_Escola.bak';

BACKUP DATABASE Escola
TO DISK = @arquivo2
WITH	DIFFERENTIAL,
		INIT,
		COMPRESSION,
		STATS =10;

