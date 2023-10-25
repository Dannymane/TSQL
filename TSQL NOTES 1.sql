select name from sys.schemas;

CREATE DATABASE practice;
DROP DATABASE practice;
SELECT * FROM practice;

USE practice;   --switch to practice database

CREATE TABLE  Wedkarze
(  id_Wedkarza int Constraint Wedkarze_pk Primary Key,
   nazwisko VARCHAR(40) Constraint Wedkarze_nazwisko_nt not Null,
   imiona VARCHAR(30) Constraint Wedkarze_imiona not Null,
   data_ur DATE Constraint Wedkarze_data_ch CHECK (data_ur >= '1920-01-01')
);

ALTER TABLE Wedkarze
ALTER COLUMN imiona VARCHAR(40);

SELECT table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE';

insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) 
    Values (10001, 'Kowalski', 'Jan', '1970-03-12');

SELECT GETDATE();     -- 2023-10-02 10:16:24.023
SELECT SYSDATETIME(); -- 2023-10-02 10:16:35.1963970

ALTER TABLE kasjerzy ADD CONSTRAINT data_zwol_check
    CHECK(data_zwolnienia > data_urodzenia and data_zwolnienia > data_zatrudnienia);

CREATE SEQUENCE seq_trans
START WITH 100
INCREMENT BY 12
MINVALUE 100
MAXVALUE 99999999
NO CYCLE;

DROP SEQUENCE seq_trans;
SELECT NEXT VALUE FOR seq_trans;

ALTER TABLE TRANSAKCJE ADD CONSTRAINT FK FOREIGN KEY (ID_PRODUKTU) REFERENCES PRODUKTY (ID_PRODUKTU);

SELECT CHARINDEX(' ', personalia) FROM kasjerzy; --index of first ' '
SELECT RIGHT(personalia, 1) FROM kasjerzy; --last character
SELECT LEFT(personalia, CHARINDEX(' ', personalia + ' ') - 1) FROM kasjerzy; --first word

BEGIN TRANSACTION;
DELETE FROM kasjerzy WHERE id_kasjera = 104;
ROLLBACK;

PRINT '1''2'; -- 1'2

DECLARE @Counter INT = 1;
DECLARE @MaxCount INT = 10;
DECLARE @SqlStatement NVARCHAR(MAX);
-- N before string indicates that the string may include UNICODE symbols (non-latin)
WHILE @Counter <= @MaxCount
BEGIN
    SET @SqlStatement = N'PRINT ''' + 'Number: ' + CAST(@Counter AS NVARCHAR(10)) + '''';

    -- Execute the dynamic SQL
    EXEC sp_executesql @SqlStatement;

    SET @Counter = @Counter + 1;
END;

DECLARE @StartDate DATE = '2022-01-01';
DECLARE @EndDate DATE = '2024-09-01';
PRINT DATEDIFF(YEAR, @EndDate, @StartDate); -- -2
PRINT DATEDIFF(MONTH, @StartDate, @EndDate); -- 32

