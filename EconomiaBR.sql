-- 01 ) Banco novo!

USE MASTER;
GO

DROP DATABASE IF EXISTS IndicadoresBR;
GO

CREATE DATABASE IndicadoresBR;
GO

USE IndicadoresBR;
GO

-- 2) Tabelas "RAW" (estrutura bem simples para receber csv)
CREATE TABLE Inadimplencia_raw(
	data VARCHAR(10), -- "DD/MM/AAAA"
	valor DECIMAL(18,2)
);
CREATE TABLE Selic_raw(
	data VARCHAR(10),  -- "DD/MM/AAAA"
	valor DECIMAL(18,2)
);

-- 3) importar os CSVs
BULK INSERT Inadimplencia_raw
FROM 'C:\Users\integral\Desktop\SQL_Caio\Bases\inadimplencia.csv'
WITH (
	FIRSTROW = 2, -- pula o cabeçalho
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '0x0d0a', -- se der erro, tente este caractere
	CODEPAGE = '65001', -- utf-8 (ASCII tambem funciona) 
	TABLOCK
);

BULK INSERT selic_raw
FROM 'C:\Users\integral\Desktop\SQL_Caio\Bases\taxa_selic.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '0x0d0a', 
	CODEPAGE = '65001',
	TABLOCK
);

-- 4) conferencia rapida dos dados
SELECT TOP 5 * FROM Inadimplencia_raw;
SELECT TOP 5 * FROM Selic_raw;

-- 5) Tabelas finais ja com a data convertida para date
SELECT 
	TRY_CONVERT(DATE, data, 103) AS data, -- 103 -> DD/MM/AAAA
	valor 
INTO Inadimplencia
FROM inadimplencia_raw;

SELECT 
	TRY_CONVERT(DATE, data, 103) AS data, -- 103 -> DD/MM/AAAA
	valor 
INTO Selic
FROM Selic_raw;

-- remove as tabelas que não serão mais necessarias
DROP TABLE IF EXISTS Selic_raw;
DROP TABLE IF EXISTS Inadimplencia_raw;



-- 6)Transformar a Selic Diaria em Mensal 
-- (Pegar o ultimo valor de cada mes)
DROP TABLE IF EXISTS selic_mensal_ultimo;
-- Inicia uma CTE chamada 's' 
-- (o ';' garante o termino da instrução anterior)
;WITH s AS (
	SELECT 
		data, -- data original
		EOMONTH(data) AS mes, -- marca o mes pela 
		valor, -- taxa diaria da selic
		ROW_NUMBER() OVER ( -- numera as linhas dentro de cada mes
			PARTITION BY EOMONTH(data) -- reinicia a contagem de cada mes
			ORDER BY data DESC -- recentes primeiro (ultimo valor do mes)
		) AS rn -- rn = 1 será a ultima data disponivel naquele mes
	FROM Selic -- tabela de origem com a serie diaria da selic
)
--seleciona apenas a ultima linha da tabela, e cria a tabela final de saida
SELECT 
	mes AS data, -- renomeia mes com EOMONTH para data na tabela
	valor -- valor da taxa da ultima data existente de cada mes
INTO selic_mensal_ultimo -- cria a tabela e insere os dados nela
FROM s -- usa os dados preparados no CTE
WHERE rn = 1; -- mantem somente a linha mais recente (uma por mes)


-- 07) Usar as tabelas finais
SELECT TOP 10 * FROM inadimplencia ORDER BY data; 
SELECT TOP 12 * FROM selic_mensal_ultimo ORDER BY data; 
SELECT TOP 12 * FROM selic ORDER BY data; 

--8) JOIN mensal (inadimplencia é mensal no dia 01
-- alinhamos por mes usando o EOMONTH)
SELECT
	i.data AS data_inadimplencia,
	i.valor AS inadimplencia,
	s.valor AS selic_mensal_ultimo,
	EOMONTH(i.data) AS data_mes_alinhado
FROM Inadimplencia i
LEFT JOIN selic_mensal_ultimo s ON s.data = EOMONTH(i.data)
ORDER BY i.data
	
-- (Alternativa) Se preferir usar MÉDIA mensal da SELIC ao 
-- invés do último valor como no anterior
DROP TABLE IF EXISTS selic_mensal_media;
SELECT
	EOMONTH(data) AS data,
	AVG(valor)    AS valor
INTO selic_mensal_media
FROM selic

GROUP BY EOMONTH(data);
SELECT i.data, i.valor AS inadimplencia, s.valor AS selic_mensal_media
FROM inadimplencia ias,djçashdfçinhas;lkdfq
LEFT JOIN selic_mensal_media s ON s.data = EOMONTH(i.data)
ORDER BY i.data;