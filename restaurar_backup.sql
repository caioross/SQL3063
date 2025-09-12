-- restaurando um backup full
USE master;
GO

ALTER DATABASE Escola SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
RESTORE DATABASE Escola
FROM DISK = N'C:\Users\integral\Desktop\SQL_Caio\Full_BKP_Escola.bak'
WITH	REPLACE, -- permite sobrescrever
		stats = 10;

ALTER DATABASE Escola SET MULTI_USER;
GO

-- restaurando um backup DIFERENCIAL
USE MASTER;
GO

ALTER DATABASE Escola SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- 1) Restaura o Full sem finalizar (NORECOVERY)
RESTORE DATABASE Escola
FROM DISK = N'C:\Users\integral\Desktop\SQL_Caio\Full_BKP_Escola.bak'
WITH	REPLACE,
		NORECOVERY,
		STATS = 10;

-- 2) Aplica o DIFF e finaliza (RECOVERY)
RESTORE DATABASE Escola
FROM DISK = N'C:\Users\integral\Desktop\SQL_Caio\Diff_BKP_Escola.bak' 
WITH	RECOVERY,
		STATS = 10;

ALTER DATABASE Escola SET MULTI_USER;
GO