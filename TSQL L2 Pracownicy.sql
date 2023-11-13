DECLARE @variable NVARCHAR(4)
DECLARE @statement NVARCHAR(400)

SET @variable = '100';
SET @statement = 'SELECT * FROM kasjerzy WHERE id_kasjera = ' + @variable 

exec(@statement);

DECLARE @st2 NVARCHAR(100)
DECLARE @v2 int

SET @v2 = 100
SET @st2 = 'SELECT * FROM kasjerzy WHERE id_kasjera =' + CAST(@v2 as nvarchar(30))
exec(@st2);

SET @variable = '100';
SELECT @variable; --won't work
PRINT @variable; --won't work

SELECT * FROM kasjerzy;

BEGIN TRANSACTION;
GO
CREATE PROCEDURE uspDynamiDMLsql(@sal float, @empid int) AS
BEGIN
	DECLARE @sql nvarchar(max),
            @salstr nvarchar(30),
            @empstr varchar(1000)

    -- cast float and int parameters to string
    SET @salstr  = CAST(@sal as nvarchar(30));
    SET @empstr  = CAST(@empid as nvarchar(1000));

    -- build dynamic upate statement
    SET @sql = 'update Employee SET Salary = ' + @salstr +
                'WHERE EmpId = ' +  @empstr 

    --execute dynamic statement
    EXEC(@sql)
END

GO

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

GO
CREATE PROCEDURE printNumbers(@number int) AS
BEGIN
    DECLARE @currentNumber INT
    SET @currentNumber = 1;

    WHILE(@currentNumber <= @number)
    BEGIN
        PRINT CAST(@currentNumber AS VARCHAR(10));
        SET @currentNumber = @currentNumber + 1;
    END
END

EXEC printNumbers 10;

GO
CREATE PROCEDURE task1 AS
BEGIN
    DECLARE @currentNumber int

    SET @currentNumber = 0

    WHILE(@currentNumber < 10)
    BEGIN
        SET @currentNumber = @currentNumber + 1;
        IF @currentNumber%2 = 0 
        BEGIN
            PRINT 'Liczba '+CAST(@currentNumber AS VARCHAR(4))+' jest podzielna przez 2';
            CONTINUE;
        END
        IF @currentNumber%3 = 0 
        BEGIN
            PRINT 'Liczba '+CAST(@currentNumber AS VARCHAR(4))+' jest podzielna przez 3';
            CONTINUE;
        END
        IF @currentNumber%5 = 0 
        BEGIN
            PRINT 'Liczba '+CAST(@currentNumber AS VARCHAR(4))+' jest podzielna przez 5';
            CONTINUE;
        END
        PRINT 'Liczba '+CAST(@currentNumber AS VARCHAR(4))+' nie jest podzielna przez 2,3 i 5'
    END
END

exec task1;

GO
-- 1
DECLARE @end2 int, @counter2 int;
SET @end2 = 10;
SET @counter2 = 1;

DECLARE @st2 NVARCHAR(120), @message NVARCHAR(100);

WHILE @counter2 <= @end2
BEGIN

    SET @message = CONCAT('Liczba ', CAST(@counter2 AS NVARCHAR(2)),' nie jest podzielna przez 2, 3 i 5');

    IF @counter2 % 5 = 0
    BEGIN
        SET @message = 'Liczba ' + CAST(@counter2 AS NVARCHAR(2)) + ' jest podzielna przez 5';
    END;

    IF @counter2 % 3 = 0
    BEGIN
        SET @message = CONCAT('Liczba ', CAST(@counter2 AS NVARCHAR(2)), ' jest podzielna przez 3');
    END;

    IF @counter2 % 2 = 0
    BEGIN
        SET @message = CONCAT('Liczba ', CAST(@counter2 AS NVARCHAR(2)), ' jest podzielna przez 2');
    END;

    SET @st2 = CONCAT('PRINT ''', @message, '''');
    exec(@st2);
    SET @counter2 = @counter2+1;
END;

--2
BEGIN TRANSACTION;
CREATE TABLE RejestrLab2(
    nazwa_tabeli NVARCHAR(25),
    dzien DATE,
    liczba_wierszy int,
    komunikat NVARCHAR(200)
);
SELECT * FROM RejestrLab2;
ROLLBACK; -- removes table

--3 
CREATE DATABASE HR;
USE HR;
select * from dzialy;

--3.1
GO
CREATE PROCEDURE addDzial(@name NVARCHAR(100), @address NVARCHAR(200)) AS
BEGIN
    DECLARE @departmentNo int,
            @sql NVARCHAR(300)

    SET @departmentNo = (SELECT MAX(id_dzialu) FROM dzialy)+10;
    SET @sql = 'INSERT INTO dzialy (id_dzialu, nazwa, adres) VALUES(' + 
        CAST(@departmentNo AS NVARCHAR(5)) + ', ''' + @name + ''', ''' + @address + ''');';
    EXEC(@sql);
END;

GO 
--DROP PROCEDURE addDzial;

EXEC addDzial @name = 'Kadry', @address = 'Czestochowa';
SELECT * FROM dzialy;

--3.2
-- z płacą mieszczącą się w połowie widełek
-- płacowych zdefiniowanych dla jego stanowiska i o numerze akt o 100 większym od aktualnie najwyższego
-- numeru akt (kolumna nr_akt) w firmie
-- @firstName VARCHAR(100) = 'undefined', @birthDate DATE = null, @employmentDate DATE = GETDATE(), @unEmploymentDate DATE = null)
GO
CREATE PROCEDURE AddWorker(@bossId INT = 1200,  @lastName VARCHAR(100), @post VARCHAR(100), @Department VARCHAR(100)) AS
BEGIN
    DECLARE @nr_akt int,
            @placa Decimal(6,2),
            @id_dzialu int,
            @sqlStatement VARCHAR(400)
    SET @nr_akt = (SELECT MAX(nr_akt) from pracownicy) + 100;
    SET @placa = (SELECT AVG(placa) FROM pracownicy WHERE stanowisko = @post);
    SET @id_dzialu = (SELECT id_dzialu FROM dzialy WHERE nazwa = @Department);

    SET @sqlStatement = 'INSERT INTO pracownicy (nr_akt, nazwisko, stanowisko, przelozony, placa, id_dzialu) VALUES (' +
        CAST(@nr_akt AS VARCHAR(10)) + ', ''' + @lastName + ''', ''' + @post + ''', ' + CAST(@bossId AS VARCHAR(5)) +
        ', ' + CAST(@placa AS VARCHAR(8)) + ', ' + CAST(@id_dzialu AS VARCHAR(5)) + ');';

    EXEC(@sqlStatement);
END


BEGIN TRANSACTION;
EXEC AddWorker @lastName = 'Adamski', @post = 'Dyrektor', @Department = 'Kadry';
commit;

SELECT * FROM pracownicy;
SELECT * FROM dzialy;

--3.3
-- dodaje 2 pracownika
-- dzial Logistyka
-- stanowisko logistyk 
-- najwyzsza placa wsrod logistykow
-- przelozony jest dyrektor z dzialu logistyka
GO
CREATE PROCEDURE AddWorker2(@dzial NVARCHAR(100), @stanowisko NVARCHAR(100), @imiona NVARCHAR(200), @nazwisko NVARCHAR(200)) AS
BEGIN
    DECLARE 
        @sql NVARCHAR(500),
        @przelozony INT,
        @placa INT,
        @id_dzialu INT,
        @nr_akt INT
    
    SET @nr_akt = (SELECT MAX(nr_akt) from pracownicy) + 1;
    SET @id_dzialu = (SELECT id_dzialu from dzialy WHERE nazwa = @dzial);
    SET @przelozony = (SELECT TOP 1 nr_akt FROM pracownicy WHERE stanowisko = 'dyrektor' AND id_dzialu = @id_dzialu);
    SET @placa = (SELECT max(placa) FROM pracownicy WHERE stanowisko = @stanowisko);
    SET @sql = 'INSERT INTO pracownicy (id_dzialu, stanowisko, przelozony, placa, imiona, nazwisko, nr_akt) VALUES ('
        + CAST(@id_dzialu AS NVARCHAR(4)) 
        + ', ''' + @stanowisko 
        + ''', ' + CAST(@przelozony AS NVARCHAR(12)) 
        + ', ' + CAST(@placa AS NVARCHAR(12)) 
        + ', ''' + @imiona 
        + ''', ''' + @nazwisko 
        + ''', ' + CAST(@nr_akt AS NVARCHAR(20)) + ');';
    exec(@sql);

END;
DROP PROCEDURE AddWorker2;

Begin TRANSACTION;
exec AddWorker2 @dzial='logistyka', @stanowisko='logistyk', @imiona='Adam', @nazwisko='Konieczko';
exec AddWorker2 @dzial='logistyka', @stanowisko='logistyk', @imiona='Zamojski', @nazwisko='Robert';
ROLLBACK;

SELECT TOP 1 * FROM pracownicy WHERE id_dzialu =(SELECT id_dzialu FROM dzialy WHERE nazwa = 'logistyka') AND stanowisko = 'dyrektor';

GO
CREATE PROCEDURE GetUserByID
    @UserID INT
AS
BEGIN
    -- Properly parameterized query
    SELECT * FROM pracownicy WHERE nr_akt = @UserID;
END;


exec GetUserByID @UserID=111;

DECLARE @int INT
SET @int = 'das1'
PRINT CAST(@int AS NVARCHAR(10));

GO
CREATE PROCEDURE FindWorkers(
    @nr_akt INT = null,
    @nazwisko NVARCHAR(100) = null,
    @imiona NVARCHAR(100) = null,
    @stanowisko NVARCHAR(30) = null,
    @przelozony INT = null
) AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)
    SET @sql = 'SELECT * FROM pracownicy WHERE -1=-1';

    IF @nr_akt IS NOT NULL SET @sql = @sql + ''' AND nr_akt = ' + CAST(@nr_akt AS NVARCHAR(10)) + '''';
    IF @nazwisko IS NOT NULL SET @sql = @sql + ''' AND nazwiso = ''%''' + @nazwisko + '''%''';
    IF @imiona IS NOT NULL SET @sql = @sql + ''' AND imiona = ''%''' + @imiona + '''%''';
    IF @stanowisko IS NOT NULL SET @sql = @sql + ''' AND stanowisko = ''%''' + @stanowisko + '''%''';
    IF @przelozony IS NOT NULL SET @sql = @sql + ''' AND przelozony = ' + CAST(@przelozony AS NVARCHAR(10)) + '''';

    exec(@sql);
END;

--DROP PROCEDURE FindWorkers;

EXEC FindWorkers @nr_akt = 111;