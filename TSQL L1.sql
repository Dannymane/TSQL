CREATE DATABASE sklep;
USE sklep;

CREATE TABLE produkty(
    id_produktu int UNIQUE,
    nazwa VARCHAR(40) NOT NULL,
    stan DECIMAL(6,2) CHECK(stan >= 0) DEFAULT 0,
    cena DECIMAL(6,2) DEFAULT 1.23,
    wartosc AS(stan*cena) 
);

CREATE TABLE kasjerzy(
    id_kasjera int CONSTRAINT kasjerzy_pk PRIMARY KEY,
    personalia VARCHAR(40),
    data_urodzenia DATE DEFAULT '1990-01-01',
    data_zatrudnienia DATE constraint data_zatr_ch 
        CHECK(data_zatrudnienia >= '2000-01-01' and data_zatrudnienia < '2100-01-01'),
    data_zwolnienia DATE,
    pensja DECIMAL(7,2) DEFAULT 4000
);

CREATE TABLE transakcje(
    id_transakcji int CONSTRAINT transakcje_pk PRIMARY KEY,
    id_produktu int NOT NULL,
    id_sprzedawcy int,
    ilosc DECIMAL(6,2) DEFAULT 1,
    czas_transakcji TIME DEFAULT GETDATE(), 
    CONSTRAINT id_prod_fk FOREIGN KEY (id_produktu) REFERENCES produkty (id_produktu) ON DELETE CASCADE,
    CONSTRAINT id_sprz_fk FOREIGN KEY (id_sprzedawcy) REFERENCES kasjerzy (id_kasjera) ON DELETE SET NULL
)

SELECT GETDATE();
SELECT SYSDATETIME();


ALTER TABLE transakcje ADD rachunek DECIMAL(8,2);
SELECT * FROM transakcje;

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

SELECT * FROM produkty;
DELETE FROM produkty;

INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(1, 'cukier', 100, 3.95);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(2, 'chleb', 50, 5.7);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(3, 'jogurt', 20, 1.75);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(4, 'schab', 6.5, 17.2);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(5, 'piwo', 200, 3.8);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(6, 'cukierki', 10, 26);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(7, 'kurczak', 10, 14.35);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(8, 'banan', 6.5, 6.20);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(9, 'mydlo', 40, 3.5);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(10, 'pomidory', 8.5, 18.5);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(11, 'olej', 20, 6.95);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(12, 'kisiel', 150, 1.55);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(13, 'ciastka', 25, 7.80);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(14, 'plyn do naczyn', 15, 8.20);
INSERT INTO Produkty (id_produktu, nazwa, stan, cena)  VALUES(15, 'pasta do zebow', 30, 7.15);


INSERT INTO Kasjerzy VALUES (100, 'Anna Kowalska', '1996-01-01', '2016-03-11', NULL, 3700);
INSERT INTO Kasjerzy VALUES (101, 'Ewa Nowak', '1978-01-03', '2006-10-21', NULL, 4300);
INSERT INTO Kasjerzy VALUES (102, 'Jan Polak', '1999-10-01', '2020-09-18', '2023-12-31', 3600);
INSERT INTO Kasjerzy VALUES (103, 'Adam Zalas', '1987-09-21', '2012-12-14', '2021-12-31', NULL);
INSERT INTO Kasjerzy VALUES (104, 'Helena Pogonowska', '1969-11-27', '2013-03-28', NULL, 3650);
INSERT INTO Kasjerzy VALUES (105, 'Joanna Mroz', '1988-05-07', '2016-03-01', NULL, 3750);
INSERT INTO Kasjerzy VALUES (106, 'Lena Rys', '1998-07-21', '2022-01-03', '2022-01-05', NULL);
INSERT INTO Kasjerzy VALUES (107, 'Roman Tkacz', '2001-03-04', '2022-02-01', NULL, 3400);

SELECT * FROM transakcje;
DELETE FROM transakcje;
select * from produkty;

INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 1, 100, 2);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 1, 101, 1);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 2, 100, 1);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 3, 102, 5);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 4, 100, 1.35);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 5, 101, 4);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 6, 100, 0.45);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 7, 102, 1.84);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 4, 101, 1.05);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 6, 102, 1.55);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 6, 102, 0.8);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 7, 102, 2.5);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 7, 103, 1.95);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 11, 100, 2);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 11, 104, 1);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 12, 102, 8);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 12, 103, 4);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 12, 104, 5);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 12, 103, 11);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 13, 104, 2);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 14, 102, 1);
INSERT INTO Transakcje (id_transakcji, id_produktu, id_sprzedawcy, ilosc) VALUES (NEXT VALUE FOR seq_trans, 14, 101, 2);


select * from produkty;
select * from kasjerzy;
select * from transakcje;

--7

UPDATE p SET stan = p.stan - sq.ilosc
FROM produkty p JOIN (SELECT SUM(ilosc) ilosc, id_produktu FROM transakcje WHERE
rachunek IS NULL GROUP BY id_produktu) sq 
ON p.id_produktu = sq.id_produktu;

UPDATE t SET rachunek = t.ilosc*p.cena
FROM transakcje t JOIN produkty p 
ON t.id_produktu = p.id_produktu
WHERE rachunek IS NULL;



SELECT ID_PRODUKTU, SUM(ILOSC) ILOSC FROM TRANSAKCJE GROUP BY ID_PRODUKTU;
SELECT * FROM PRODUKTY; 

--8
SELECT * FROM KASJERZY;
SELECT * FROM TRANSAKCJE;

GO

CREATE VIEW Statystyki_Kasjerek AS
SELECT T.id_sprzedawcy, K.personalia, COUNT(T.ID_SPRZEDAWCY) liczba_transakcji, SUM(T.ILOSC) liczba_produktow, SUM(T.RACHUNEK) laczny_rachunek
FROM TRANSAKCJE T  JOIN kasjerzy K 
ON K.id_kasjera = T.id_sprzedawcy 
WHERE (k.data_zwolnienia is null or k.data_zwolnienia > GETDATE())
AND RIGHT(LEFT(k.personalia, CHARINDEX(' ', K.personalia + ' ') - 1), 1) = 'a'
GROUP BY t.id_sprzedawcy, k.personalia;

GO
--DROP VIEW Statystyki_Kasjerek;

SELECT * FROM Statystyki_Kasjerek ORDER BY laczny_rachunek DESC;
SELECT LEFT(personalia, CHARINDEX(' ', personalia + ' ') - 1) FROM kasjerzy;

SELECT CHARINDEX(' ', personalia) FROM kasjerzy;

--9
SELECT * FROM transakcje;
GO

CREATE VIEW Niepopularne_produkty AS
SELECT p.id_produktu, p.nazwa, p.stan, p.cena, p.wartosc
FROM produkty p FULL OUTER JOIN transakcje t 
ON p.id_produktu = t.id_produktu
WHERE t.id_produktu is null;;

GO
SELECT * FROM transakcje;
SELECT * FROM  Niepopularne_produkty;

--10
SELECT * FROM kasjerzy;

DELETE FROM kasjerzy WHERE data_zwolnienia<GETDATE()
AND id_kasjera NOT IN(SELECT DiSTINCT(id_sprzedawcy) from transakcje);
rollback;

BEGIN TRANSACTION;
DELETE FROM kasjerzy WHERE id_kasjera = 104;
ROLLBACK;


