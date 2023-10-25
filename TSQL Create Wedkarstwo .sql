-- ********************** Wedkarstwo ***************************
/*
drop table  Wedkarze CASCADE CONSTRAINTS;
drop table  Okregi CASCADE CONSTRAINTS;
drop table  Oplaty CASCADE CONSTRAINTS;
drop table  Licencje CASCADE CONSTRAINTS;
drop table  Lowiska CASCADE CONSTRAINTS;
drop table  Gatunki CASCADE CONSTRAINTS;
drop table  Rejestry CASCADE CONSTRAINTS;

drop table  RejestrLab2 CASCADE CONSTRAINTS; 
drop table  Rekordy_PZW_Czestochowa CASCADE CONSTRAINTS;
*/

CREATE TABLE  Wedkarze
(  id_Wedkarza int Constraint Wedkarze_pk Primary Key,
   nazwisko VARCHAR(40) Constraint Wedkarze_nazwisko_nt not Null,
   imiona VARCHAR(30) Constraint Wedkarze_imiona not Null,
   data_ur Date Constraint Wedkarze_data_ch check (data_ur >= '1920-01-01')
);


CREATE TABLE  Okregi
(  id_Okregu VARCHAR(40),
   adres VARCHAR(100) constraint Okregi_adres not NULL,
   numer_konta DECIMAL(26,0),
   Constraint Okregi_pk Primary Key (id_Okregu)
);


CREATE TABLE  Oplaty
(  rok int Constraint Oplaty_rok_ch check (rok>=2010),
   id_Okregu VARCHAR(40),  
   roczna_Oplata_pod DECIMAL(6,2) Constraint Oplaty_rop_ch check (roczna_Oplata_pod between 50 and 9000),
   roczna_Oplata_dod DECIMAL(6,2) Constraint Oplaty_rod_ch check (roczna_Oplata_dod between 50 and 9000),
   dzienna_Oplata DECIMAL(6,2) Constraint Oplaty_od_ch check (dzienna_Oplata between 5 and 1000),
   Constraint Oplaty_pk Primary Key (rok, id_Okregu),
   CONSTRAINT Oplaty_id_Okregu_fk FOREIGN KEY (id_Okregu) REFERENCES Okregi(id_Okregu) ON DELETE CASCADE
);



CREATE TABLE  Licencje
(  id_licencji int,
   id_Wedkarza int,
   rok int,
   id_Okregu VARCHAR(40),
   rodzaj VARCHAR(30) constraint Licencje_rodzaj_ch check(rodzaj in ('podstawowa','dodatkowa')),
   Od_dnia DATE default '1950-01-01',
   Do_dnia DATE default '1950-12-31',
   Constraint Licencje_pk Primary key (id_licencji),
   CONSTRAINT Licencje_id_Wedkarza_fk FOREIGN KEY (id_Wedkarza) REFERENCES   Wedkarze(id_Wedkarza) ON DELETE CASCADE,
   CONSTRAINT Licencje_Okregi_fk FOREIGN KEY (rok,id_Okregu) REFERENCES   Oplaty(rok,id_Okregu) ON DELETE CASCADE
);

CREATE TABLE  Lowiska
(  id_lowiska VARCHAR(20),
   id_Okregu Varchar(40),
   nazwa VARCHAR(40) constraint Lowiska_nazwa_un Unique,
   typ VARCHAR(8) constraint Lowiska_typ_ch check (typ in ('rzeka', 'zbiornik','jezioro','staw','kanal', 'inny')),
   miejscowosc VARCHAR(40),
   powierzchnia DECIMAL(7,2) constraint Lowiska_powierzchnia_ch check (powierzchnia between 0.01 and 50000),
   constraint Lowiska_pk Primary Key (id_lowiska),
   CONSTRAINT Lowiska_id_Okregu_fk FOREIGN KEY (id_Okregu) REFERENCES   Okregi(id_Okregu)
);

CREATE TABLE  Gatunki
(  id_gatunku int constraint Gatunki_id_gatunku_ch check (id_gatunku between 1 and 99),
   nazwa VARCHAR(30) constraint Gatunki_nazwa_un Unique,
   wymiar DECIMAL(4,1) constraint Gatunki_wymiar_ch check (wymiar between 10 and 200),
   limit_dzienny int constraint Gatunki_limit_ch check (limit_dzienny between 1 and 20),
   DPO int constraint Gatunki_dp_ch check (DPO between 1 and 31),
   MPO int constraint Gatunki_mp_ch check (MPO between 1 and 12),
   DKO int constraint Gatunki_dk_ch check (DKO between 1 and 31),
   MKO int constraint Gatunki_mk_ch check (MKO between 1 and 12),
   rekord_waga DECIMAL(4,1) constraint Gatunki_rek_waga_ch check (rekord_waga between 0.1 and 500),
   rekord_rok int constraint Gatunki_rek_rok_ch check (rekord_rok>=1900),
   rekord_nazwisko VARCHAR(40),
   constraint Gatunki_pk Primary Key (id_gatunku)   
);


CREATE TABLE  Rejestry
(  czas DATETIME constraint Rejestry_czas_ch check(czas>= '2010-01-01'),
   id_Wedkarza int,
   id_lowiska VARCHAR(20),
   id_gatunku int,
   dlugosc DECIMAL(4,1) constraint Rejestry_dlugosc_ch check(dlugosc between 5 and 500),
   waga DECIMAL(5,2) constraint Rejestry_waga_ch check (waga between 0.01 and 500),
   constraint Rejestry_pk Primary Key (czas,id_Wedkarza, id_lowiska),
   constraint Rejestry_id_Wedkarza_fk Foreign Key (id_Wedkarza) references  Wedkarze(id_Wedkarza),
   constraint Rejestry_id_gatunku_fk Foreign Key (id_gatunku) references  Gatunki(id_gatunku),
   constraint Rejestry_id_lowiska_fk Foreign Key (id_lowiska) references  Lowiska(id_lowiska)
 );
 
 
 
 CREATE /*GLOBAL TEMPORARY*/ TABLE RejestrLab2
 (  nazwa_tabeli VARCHAR(40),
    Data_zdarzenia Date,
    Liczba_wierszy int,
    Komunikat VARCHAR(200),
    Komentarz VARCHAR(200) 
 );
 
  CREATE TABLE Rekordy_PZW_Czestochowa 
 (  id_gatunku int constraint R_PZW_CZ_PK Primary Key,
    waga DECIMAL(6,3),
    id_wedkarza int,
    data_polowu Date,
    id_lowiska VARCHAR(20),
    komentarz VARCHAR(200)   
 );

 
 
 
 /**************************************/

/* Wedkarze*/
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10001, 'Kowalski', 'Jan', '1970-03-12');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10002, 'Nowak', 'Monika', '1990-05-22');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10003, 'Polak', 'Tadeusz', '1996-06-13');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10004, 'Drozd', 'Adam', '1986-11-05');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10005, 'Pawlak', 'Eliza', '1968-12-08');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10006, 'Kownacki', 'Andrzej', '1978-01-13');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10007, 'Wolski', 'Piotr', '1955-07-17');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10008, 'Adamczyk', 'Joanna', '1990-02-02');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10009, 'Wilk', 'Damian', '1997-06-30');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10010, 'Zachorski', 'Tomasz', '1982-03-31');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10011, 'Andrysiak', 'Anna', '1987-05-12');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10012, 'Gonera', 'Grzegorz', '1999-12-20');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10013, 'Dudka', 'Aleks', '1962-02-11');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10014, 'Kac', 'Jaroslaw', '1950-06-15');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10015, 'Matysek', 'Zenon', '1978-02-14');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10016, 'Wrona', 'Dagmara', '2000-05-11');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10017, 'Jastrzebski', 'Oskar', '1997-04-13');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10018, 'Walczak', 'Olga', '2002-02-03');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10019, 'Gawron', 'Dariusz', '1987-01-23');
insert into  Wedkarze (id_Wedkarza, nazwisko, imiona, data_ur) Values (10020, 'Lemanski', 'Tymoteusz', '2001-10-10');


/* Okregi*/
insert into  Okregi (id_Okregu, adres, numer_konta) Values ('PZW Czestochowa', 'Dabrowskiego 11 42-200 Czestochowa', 11123412341234123412341234 );
insert into  Okregi (id_Okregu, adres, numer_konta) Values ('PZW Opole', 'Wedkarska 123 46-123 Opole', 22123412341234123412341234);
insert into  Okregi (id_Okregu, adres, numer_konta) Values ('PZW Katowice', 'Wodna 3 44-310 Katowice', 33123412341234123412341234);
insert into  Okregi (id_Okregu, adres, numer_konta) Values ('Gospodarstwo Rybackie Okon', 'Wolnosci 4 42-270 Skrzydlow', 44123412341234123412341234);
insert into  Okregi (id_Okregu, adres, numer_konta) Values ('Stawy hodowlane Szczupak', 'Lesna 17a 42-287 Okolowice', 55123412341234123412341234);
insert into  Okregi (id_Okregu, adres, numer_konta) Values ('Wodna Kraina', 'Woda 14 42-254 Skoczow', 67123412341234123412342236);
insert into  Okregi (id_Okregu, adres, numer_konta) Values ('Stawy hodowlane Prusicko','Dabrowskiego 57 42-211 Prusicko', 99123412341234123412341288);


/* Oplaty*/
insert into  Oplaty Values (2018, 'PZW Czestochowa',185, 90, 15);
insert into  Oplaty  Values (2019, 'PZW Czestochowa', 190, 90, 15);
insert into  Oplaty  Values (2020, 'PZW Czestochowa', 194, 95, 20);
insert into  Oplaty  Values (2021, 'PZW Czestochowa',230, 125, 22);
insert into  Oplaty  Values (2022, 'PZW Czestochowa', 250, 140, 25);
insert into  Oplaty  Values (2018, 'PZW Opole', 205, 100, 25);
insert into  Oplaty  Values (2019, 'PZW Opole', 209, 100, 25);
insert into  Oplaty  Values (2020, 'PZW Opole', 220, 110, 30);
insert into  Oplaty  Values (2021, 'PZW Opole', 229, 140, 25);
insert into  Oplaty  Values (2022, 'PZW Opole', 270, 150, 30);
insert into  Oplaty  Values (2018, 'PZW Katowice',189, 90, 15);
insert into  Oplaty  Values (2019, 'PZW Katowice', 202, 100, 15);
insert into  Oplaty  Values (2020, 'PZW Katowice', 205, 112, 20);
insert into  Oplaty  Values (2021, 'PZW Katowice', 225, 120, 22);
insert into  Oplaty  Values (2022, 'PZW Katowice', 255, 132, 25);
insert into  Oplaty  Values (2020, 'Gospodarstwo Rybackie Okon', NULL, NULL, 35);
insert into  Oplaty  Values (2019, 'Gospodarstwo Rybackie Okon', NULL, NULL, 30);
insert into  Oplaty  Values (2018, 'Gospodarstwo Rybackie Okon', NULL, NULL, 30);
insert into  Oplaty  Values (2021, 'Gospodarstwo Rybackie Okon', NULL, NULL, 30);
insert into  Oplaty  Values (2022, 'Gospodarstwo Rybackie Okon', 400, NULL, 35);
insert into  Oplaty  Values (2020, 'Stawy hodowlane Szczupak', 500, NULL, 25);
insert into  Oplaty  Values (2019, 'Stawy hodowlane Szczupak', NULL, NULL, 25);
insert into  Oplaty  Values (2018, 'Stawy hodowlane Szczupak', NULL, NULL, 20);
insert into  Oplaty  Values (2021, 'Stawy hodowlane Szczupak', 600, NULL, 25);
insert into  Oplaty  Values (2022, 'Stawy hodowlane Szczupak', 650, NULL, 30);
insert into  Oplaty  Values (2021, 'Wodna Kraina', 400, 300, 30);
insert into  Oplaty  Values (2022, 'Wodna Kraina', 450, 350, 35);
insert into  Oplaty  Values (2021, 'Stawy hodowlane Prusicko', NULL, NULL,22);
insert into  Oplaty  Values (2022, 'Stawy hodowlane Prusicko', NULL, NULL,25);

--delete from  Licencje
 
/* Licencje*/ 
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'PZW Czestochowa', 2018, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'PZW Opole', 2018, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10001, 'PZW Katowice', 2018, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'PZW Czestochowa', 2019, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'PZW Opole', 2019, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10001, 'PZW Katowice', 2019, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'PZW Czestochowa', 2020, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10001, 'PZW Opole', 2020, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10001, 'PZW Katowice', 2020, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'PZW Czestochowa', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'PZW Czestochowa', 2022, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'PZW Opole', 2021, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'PZW Opole', 2022, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10001, 'PZW Katowice', 2021, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10001, 'PZW Katowice', 2022, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'Gospodarstwo Rybackie Okon', 2018, 'dodatkowa', '2018-08-18','2018-08-18');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'Stawy hodowlane Szczupak', 2019, 'dodatkowa', '2019-05-07','2019-05-08');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'Stawy hodowlane Szczupak', 2020, 'dodatkowa', '2020-05-09','2020-05-10');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'Stawy hodowlane Szczupak', 2020, 'dodatkowa', '2020-11-09','2020-11-15');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10001, 'Stawy hodowlane Szczupak', 2020, 'dodatkowa', '2020-12-23','2020-12-24');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Czestochowa', 2018, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Opole', 2018, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Katowice', 2018, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Czestochowa', 2019, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Opole', 2019, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Katowice', 2019, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Czestochowa', 2020, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Opole', 2020, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Katowice', 2020, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Czestochowa', 2021, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Czestochowa', 2022, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Opole', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Opole', 2022, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Katowice', 2021, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10002, 'PZW Katowice', 2022, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10002, 'Gospodarstwo Rybackie Okon', 2019, 'dodatkowa', '2019-08-01','2019-08-18');


insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Czestochowa', 2018, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Czestochowa', 2019, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Czestochowa', 2020, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Opole', 2018, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Opole', 2019, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Opole', 2020, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Katowice', 2018, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Katowice', 2019, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Katowice', 2020, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Czestochowa', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Czestochowa', 2022, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Opole', 2021, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Opole', 2022, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Katowice', 2021, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10003, 'PZW Katowice', 2022, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10003, 'Stawy hodowlane Szczupak', 2020,  'dodatkowa', '2020-05-17','2020-05-18');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10003, 'Stawy hodowlane Szczupak', 2020,  'dodatkowa', '2020-07-09','2020-07-17');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1), 10003, 'Stawy hodowlane Szczupak', 2021,  'podstawowa');


insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10004, 'PZW Czestochowa', 2018, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10004, 'PZW Czestochowa', 2019, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10004, 'PZW Czestochowa', 2020, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10004, 'PZW Opole', 2018, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10004, 'PZW Opole', 2019, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10004, 'PZW Opole', 2020, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10004, 'PZW Czestochowa', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10004, 'PZW Czestochowa', 2022, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10004, 'PZW Opole', 2021, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10004, 'PZW Opole', 2022, 'dodatkowa');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10005, 'PZW Czestochowa', 2018, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10005, 'PZW Czestochowa', 2019, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10005, 'PZW Czestochowa', 2020, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10005, 'PZW Katowice', 2018, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10005, 'PZW Katowice', 2019, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10005, 'PZW Katowice', 2020, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10005, 'PZW Czestochowa', 2021, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10005, 'PZW Czestochowa', 2022, 'dodatkowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10005, 'PZW Katowice', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10005, 'PZW Katowice', 2022, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1), 10005, 'Stawy hodowlane Szczupak', 2022,  'podstawowa');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10006, 'PZW Czestochowa', 2018, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10006, 'PZW Czestochowa', 2019, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10006, 'PZW Czestochowa', 2020, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10006, 'PZW Czestochowa', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10006, 'PZW Czestochowa', 2022, 'podstawowa');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10007, 'PZW Czestochowa', 2018, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10007, 'PZW Czestochowa', 2019, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10007, 'PZW Czestochowa', 2020, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10007, 'PZW Czestochowa', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10007, 'PZW Czestochowa', 2022, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1), 10007, 'Gospodarstwo Rybackie Okon', 2022,  'podstawowa');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10008, 'PZW Czestochowa', 2018, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10008, 'PZW Czestochowa', 2019, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10008, 'PZW Czestochowa', 2020, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10008, 'PZW Czestochowa', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10008, 'PZW Czestochowa', 2022, 'podstawowa');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10009, 'PZW Katowice', 2018, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10009, 'PZW Katowice', 2019, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10009, 'PZW Katowice', 2020, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10009, 'PZW Katowice', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10009, 'PZW Katowice', 2022, 'podstawowa');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10010, 'PZW Opole', 2018, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10010, 'PZW Opole', 2019, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10010, 'PZW Opole', 2020, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10010, 'PZW Opole', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10010, 'PZW Opole', 2022, 'podstawowa');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10017, 'PZW Czestochowa', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10017, 'PZW Czestochowa', 2022, 'podstawowa');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'PZW Czestochowa', 2019, 'dodatkowa', '2019-07-11','2019-07-14');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'PZW Katowice', 2019, 'dodatkowa', '2019-07-19','2019-07-22');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'PZW Czestochowa', 2020, 'dodatkowa', '2020-06-28','2020-07-01');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'PZW Czestochowa', 2020, 'dodatkowa', '2020-08-22','2020-08-23');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'Gospodarstwo Rybackie Okon', 2019, 'dodatkowa', '2019-05-11','2019-05-11');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'Stawy hodowlane Szczupak', 2019, 'dodatkowa', '2019-07-22','2019-07-23');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'Gospodarstwo Rybackie Okon', 2020, 'dodatkowa', '2020-08-28','2020-08-28');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'Stawy hodowlane Szczupak', 2020, 'dodatkowa', '2020-05-05','2020-05-06');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'PZW Czestochowa', 2021, 'dodatkowa', '2021-06-10','2021-06-13');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'PZW Katowice', 2021, 'dodatkowa', '2021-07-11','2021-07-11');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'PZW Czestochowa', 2021, 'dodatkowa', '2021-08-29','2021-09-01');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'PZW Czestochowa', 2021, 'dodatkowa', '2021-09-14','2021-09-15');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'Gospodarstwo Rybackie Okon', 2021, 'dodatkowa', '2021-04-11','2021-04-11');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'Stawy hodowlane Szczupak', 2021, 'dodatkowa', '2021-06-21','2021-06-23');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'Gospodarstwo Rybackie Okon', 2021, 'dodatkowa', '2021-07-23','2021-07-28');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10010, 'Stawy hodowlane Szczupak', 2021, 'dodatkowa', '2021-08-06','2021-08-09');


insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10011, 'PZW Czestochowa', 2022, 'podstawowa');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1), 10013, 'PZW Czestochowa', 2021, 'dodatkowa', '2021-07-11','2021-07-14');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1), 10013, 'PZW Katowice', 2021, 'dodatkowa', '2021-07-19','2021-07-22');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1), 10013, 'PZW Czestochowa', 2022, 'dodatkowa', '2022-02-18','2022-02-19');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1), 10013, 'PZW Czestochowa', 2022, 'dodatkowa', '2022-03-22','2022-03-22');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1), 10014, 'Gospodarstwo Rybackie Okon', 2021, 'dodatkowa', '2021-05-01','2021-05-03');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1), 10014, 'Stawy hodowlane Szczupak', 2021, 'dodatkowa', '2021-05-05','2021-05-05');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1), 10014, 'Gospodarstwo Rybackie Okon', 2021, 'dodatkowa', '2021-06-21','2021-06-23');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1), 10014, 'Stawy hodowlane Szczupak', 2021, 'dodatkowa', '2021-07-15','2021-07-16');


insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia) 
Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10015, 'Wodna Kraina', 2022, 'dodatkowa', '2022-04-01','2022-04-01');

insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj, od_dnia, do_dnia)
Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),10016, 'Wodna Kraina', 2022, 'dodatkowa', '2022-04-01','2022-04-01');


insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10018, 'PZW Czestochowa', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10018, 'PZW Czestochowa', 2022, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10019, 'PZW Czestochowa', 2022, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10020, 'PZW Czestochowa', 2021, 'podstawowa');
insert into  Licencje (id_licencji, id_Wedkarza, id_Okregu, rok, rodzaj)  Values (ISNULL((SELECT MAX(id_licencji) + 1 From Licencje), 1),  10020, 'PZW Czestochowa', 2022, 'podstawowa');






/* Lowiska*/
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('C20','PZW Czestochowa','Warta','rzeka',NULL,NULL);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('C11','PZW Czestochowa','Poraj','zbiornik','Poraj',496);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('C40','PZW Czestochowa','Pilica','rzeka',NULL,NULL);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('C30','PZW Czestochowa','Liswarta','rzeka',NULL,NULL);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('C36','PZW Czestochowa','Ostrowy','zbiornik','Ostrowy',38);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('C02','PZW Czestochowa','Zielona','zbiornik','Zielona',51.8);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('C63','PZW Czestochowa','Koniecpol','zbiornik','Koniecpol',9.5);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('C24','PZW Czestochowa','Amerykan','zbiornik','Zloty Potok',4.4);

insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('002','PZW Katowice','Pogoria III','zbiornik','Dabrowa Gornicza',207);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('012','PZW Katowice','Chechlo','zbiornik','Trzebinia',54);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('013','PZW Katowice','Paprocany','zbiornik','Tychy',122.34);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('037','PZW Katowice','Kanal Gliwicki','kanal',NULL,NULL);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('029','PZW Katowice','Wisla','rzeka',NULL,NULL);

insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('1','PZW Opole','Odra','rzeka',NULL,NULL);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('4','PZW Opole','Mala Panew','rzeka',NULL,NULL);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('13','PZW Opole','Turawa','zbiornik',NULL, NULL);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('15','PZW Opole','Nysa','zbiornik',NULL, NULL);

insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('L01','Gospodarstwo Rybackie Okon','Stawy Skrzydlow','staw','Skrzydlow',20);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('L02','Stawy hodowlane Szczupak','Stawy Okolowice','staw','Okolowice',47.5);

insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('B01',NULL,'Staw w Pacanowie','staw','Pacanow',0.5);

insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('L03','Wodna Kraina','Staw Maluszyn','staw','Maluszyn',3.2);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('L04','Stawy hodowlane Prusicko','Stawy Prusicko','staw','Prusicko',2.5);
insert into  Lowiska (id_lowiska, id_Okregu, nazwa, typ, miejscowosc, powierzchnia) Values 
('B02',NULL,'Zwirownia','staw','Rudniki',2.5);


/* Gatunki*/
INSERT INTO  Gatunki VALUES (1, 'KARP', 30, 3,NULL, NULL, NULL, NULL, 34, 2011, 'SCHAFER');
INSERT INTO  Gatunki VALUES (2, 'LIN', 25, 4, NULL, NULL, NULL, NULL, 4.5, 2004, 'SMYCZEK');
INSERT INTO  Gatunki VALUES (3, 'LESZCZ', NULL, NULL, NULL, NULL, NULL, NULL, 6.95, 2008, 'JAWORSKI');
INSERT INTO  Gatunki VALUES (4, 'AMUR', 40, NULL, NULL, NULL,NULL, NULL, 39.2, 1998, 'LAWNICKI');
INSERT INTO  Gatunki VALUES (5, 'WEGORZ', 50, 2, 15, 6, 15, 7, 6.43, 1994, 'LISOWSKI');
INSERT INTO  Gatunki VALUES (6, 'BRZANA', 40, 3, 1 , 1 , 30, 6, 7, 2000, 'TRYMERS');
INSERT INTO  Gatunki VALUES (7, 'SWINKA', 25, NULL, 1, 1, 15, 5, 2.38, 2013, 'WLODARCZYK');
INSERT INTO  Gatunki VALUES (8, 'JAZ', 25, NULL, NULL, NULL, NULL, NULL, 5.1, 1973, 'ZBIEGEN');
INSERT INTO  Gatunki VALUES (9, 'SZCZUPAK', 50, 2, 1, 1, 30, 4, 20.8, 1976, 'POWLACZUK');
INSERT INTO  Gatunki VALUES (10, 'SANDACZ', 50, 2, 1, 1, 31, 5, 14.2, 2004, 'SZWED');
INSERT INTO  Gatunki VALUES (11, 'SUM', 70, 1, 1, 11, 30, 6, 105, 2012, 'WIESYK');
INSERT INTO  Gatunki VALUES (12, 'KLEN', 40, NULL, NULL, NULL, NULL, NULL, 3.71, 2008, 'WRANA');
INSERT INTO  Gatunki VALUES (13, 'PSTRAG POTOKOWY', 30, 3, 1, 9, 31, 12, 5.52, 1995, 'MILEK');
INSERT INTO  Gatunki VALUES (14, 'PSTRAG ZRODLANY', NULL, NULL, NULL, NULL, NULL, NULL, 2.52, 2008, 'PIECHOCKI');
INSERT INTO  Gatunki VALUES (15, 'OKON', NULL, NULL, NULL, NULL, NULL, NULL, 2.69, 2011, 'WIECZOREK');
INSERT INTO  Gatunki VALUES (16, 'LIPIEN', 30, 3, 1, 3, 31, 5, 1.35, 1971, 'BRACH');
INSERT INTO  Gatunki VALUES (17, 'PLOC', NULL, NULL, NULL, NULL, NULL, NULL, 1.57, 2011, 'MAJEK');
INSERT INTO  Gatunki VALUES (18, 'MIETUS', 25, NULL, 1, 12, 28, 2, 4.06, 2013, 'KOZAK');
INSERT INTO  Gatunki VALUES (19, 'INNE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO  Gatunki VALUES (20, 'BOLEN', 40, 2, 1, 1, 30, 4, 8.49, 2014, 'GLOS');
INSERT INTO  Gatunki VALUES (21, 'KARAS', NULL, NULL, NULL, NULL, NULL, NULL, 4.1, 2014, 'POPINSKI');
INSERT INTO  Gatunki VALUES (22, 'JELEC', 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO  Gatunki VALUES (23, 'SIEJA', 35, 2, 1, 10, 31, 12, 3.75, 1986, 'DEBSKI');
 

/* Rejestry*/
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-04-24 15:10:00', 10001,'C11',1,45,1.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-04-24 15:45:00', 10001,'C11',3, 56, 1.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-04-24 17:05:00', 10001,'C11', 3, 40, 0.85);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-06-14 5:10:00', 10001,'C11', 1, 51, 2.6);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-04-24 15:10:00', 10001,'C20', 9, 61, 2.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-24 15:10:00', 10001,'C20', 9, 63, 2.35);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-10-24 15:10:00', 10001,'C11', 10, 58, 1.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-03-24', 10001,'C11',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-04 18:10:00', 10001,'C11', 1, 45, 1.6);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-04 19:20:00', 10001,'C11', 1, 49, 1.9);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-04 19:50:00', 10001,'C11', 3, 43, 0.9);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-25', 10001,'1',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-10-23 18:10:00', 10001,'13', 10, 67, 2.85);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-10-23 22:05:00', 10001,'13', 10, 57, 1.65);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-24', 10001,'C40',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-23 08:10:00', 10001,'C40', 17, 27, 0.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-23 08:15:00', 10001,'C40', 17, 25, 0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-23 08:20:00', 10001,'C40', 17, 30, 0.35);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-23 08:35:00', 10001,'C40', 17, 24, 0.20);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-23 08:55:00', 10001,'C40', 17, 34, 0.4);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-24', 10001,'002',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-24', 10001,'012',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-24', 10001,'012',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-05-03 8:40:00', 10001,'B01', 3, 45, 1.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-05-03 9:20:00', 10001,'B01', 3, 35, 0.6);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-02-10 10:00:00', 10001,'C20', 9, 61,1.95);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-02-10 11:00:00', 10001,'C20', 10, 54, 1.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-24 8:10:00', 10001, 'C11', 9, 69, 2.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-06-18 17:20:00', 10001, '013', 4, 85, 5.3);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-05-01 15:10:00', 10002,'C20', 9, 51, 1.05);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-07-14 8:55:00', 10002,'C11', 3, 38, 0.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-02-03', 10002,'029', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-06-21', 10002,'C11', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-06-21', 10002, 'C20', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-14', 10002,'C30',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-17', 10002,'C36',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-17', 10002,'C11',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-04 11:10:00', 10002,'C11', 4, 58, 2.1);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-14 14:50:00', 10002,'C11', 1, 52, 2.6);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-11-04 17:45:00', 10002,'C11', 10, 53, 1.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-24', 10002,'C11',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-21 09:10:00', 10002,'C20', 15, 22, 0.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-21 09:15:00', 10002,'C20', 17, 27, 0.30);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-21 09:25:00', 10002,'C20', 15, 30, 0.45);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-24 10:15:00', 10002,'002',9, 59,1.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-24 12:35:00', 10002,'012',9, 65,2.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-17 14:25:00', 10002,'1',1, 62,4.1);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-10-23 18:10:00', 10002,'13', 10, 67, 2.85);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-10-23 22:05:00', 10002,'13', 10, 57, 1.65);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-06-18 18:20:00', 10002, '013', 4, 70, 3.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-06-18 8:15:00', 10002, 'B01', 4, 68, 2.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-12 15:10:00', 10002, 'C20', 9, 70, 3.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-12 17:00:00', 10002, 'C40', 10, 71, 3.05);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-18 9:15:00', 10002, 'C24', 13, 42, 0.85);


insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-04-24 5:10:00', 10003,'012',1,53,2.75);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-06-24 14:45:00', 10003,'13',3, 52, 1.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-24 17:35:00', 10003,'C11', 3, 43, 0.95);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-05-14 15:10:00', 10003,'002', 1, 51, 2.5);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-04-28 12:15:00', 10003,'C40', 9, 71, 3.85);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-21 13:00:00', 10003,'029', 9, 60, 2.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-11-24 21:15:00', 10003,'L01', 1, 58, 3.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-01-14', 10003,'C02',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-17', 10003,'C30',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-02-04 14:10:00', 10003,'C40', 13, 42, 0.6);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-14 9:05:00', 10003,'C30', 14, 38, 0.5);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-14 11:45:00', 10003,'C02', 1, 45, 1.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-14', 10003,'C30',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-17', 10003,'C30',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-01', 10003,'C30',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-25 08:10:00', 10003,'C20', 21, 21, 0.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-25 09:15:00', 10003,'C20', 21, 27, 0.30);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-25 10:25:00', 10003,'C20', 21, 25, 0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-24 09:15:00', 10003,'037',3, 49,1.9);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-24 11:35:00', 10003,'037',3, 52,2.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-19 8:25:00', 10003,'15',1, 42,1.1);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-11 12:10:00', 10003,'15', 3, 41, 0.85);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-13 23:25:00', 10003,'15', 10, 54, 1.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-30 06:15:00', 10003,'B01', 2, 38, 0.85);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-09-01 05:25:00', 10003,'B01', 9, 54, 1.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-10-30 06:15:00', 10003,'L01', 4, 55, 2.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-10-30 08:55:00', 10003,'L01', 9, 65, 2.45);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-11-03 4:55:00', 10003,'L02', 11, 88, 4.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-11-03 12:05:00', 10003,'L02', 1, 60, 4.85);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-09-13 18:55:00', 10003,'L01', 1, 42, 1.05);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-09-23 15:55:00', 10003,'L02', 11, 95, 5.05);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-12-06 19:35:00', 10003,'1', 11, 65, 2.4);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-08-08 22:10:00', 10003, '1', 9, 74, 3.1);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-01-24 15:45:00', 10004,'C40',15, 23,0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-01-24 15:55:00', 10004,'C40',15, 26,0.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-01-24 16:10:00', 10004,'C40',17, 28,0.4);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-09-04 4:45:00', 10004,'1',11, 114, 9.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-21 22:35:00', 10004,'13', 10, 62, 2.4);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-21 23:55:00', 10004,'13', 10, 68,3.4);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-05-12 15:10:00', 10004,'4', 9, 51, 1.0);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-06-21 10:15:00', 10004,'C40', 9, 55, 1.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-22 13:00:00', 10004,'C36', 1, 44, 1.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-11-14 21:15:00', 10004,'C02', 4, 50, 2.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-05-03', 10004,'4', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-06-01', 10004,'C11', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-14', 10004,'C40',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-17', 10004,'C30',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-24 14:10:00', 10004,'C20', 8, 35, 0.6);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-25 13:05:00', 10004,'C20', 8, 38, 0.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-27 13:45:00', 10004,'C40', 17, 25, 0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-19', 10004,'4',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-17', 10004,'4',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-03-22 22:20:00', 10004, 'C11', 11, 62, 2.1);


insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-02-24 12:45:00', 10005,'C20',15, 21,0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-02-24 12:55:00', 10005,'C20',15, 23,0.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-02-24 14:10:00', 10005,'C20',15, 29,0.4);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-09-04 4:45:00', 10005,'037',3, 63, 3.05);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-07-21 22:35:00', 10005,'037', 10, 52, 1.4);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-06-21 23:55:00', 10005,'029', 10, 56,1.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-05-12 15:10:00', 10005,'029', 9, 53, 1.10);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-21 10:15:00', 10005,'C40', 9, 54, 1.20);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-21 13:00:00', 10005,'C30', 9, 64, 2.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-23 4:20:00', 10005,'C63', 1, 48, 3.05);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-23 7:25:00', 10005,'C63', 9, 68, 2.35);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-28 5:25:00', 10005,'C24', 14, 35, 0.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-11-14 21:15:00', 10005,'C02', 2, 40, 1.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-05-03', 10005,'037', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-05-03', 10005,'012', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-06-01', 10005,'012', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-06-01', 10005,'037', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-03-03', 10005,'C40', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-06-01', 10005,'C40', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-06-01', 10005,'C20', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-01', 10005,'013',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-05', 10005,'013',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-05', 10005,'012',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-05', 10005,'037',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-03 04:10:00', 10005,'013', 2, 39, 0.75);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-14 14:25:00', 10005,'013', 1, 48, 2.1);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-04 16:10:00', 10005,'037', 3, 45, 1.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-24 18:05:00', 10005,'037', 3, 48, 1.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-24 13:45:00', 10005,'037', 15, 35, 0.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-19', 10005,'C20',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-17', 10005,'C40',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-10 10:00:00', 10005, 'C02', 1, 55, 3.05);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-06-18 3:20:00', 10005, '1', 10, 55, 1.6);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-06-18 3:50:00', 10005, '1', 10, 62, 2.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-06-18 23:10:00', 10005, 'B01', 10, 52, 1.1);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-06-01', 10006,'C11', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-06-11', 10006,'C11', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-06-21', 10006,'C20', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-21', 10006,'C30', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-10-01', 10006,'C36', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-03-21', 10006,'C40', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-03-14', 10006,'C40',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-03-17', 10006,'C11',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-04 11:40:00', 10006,'C20', 18, 37, 0.5);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-14 12:05:00', 10006,'C20', 18, 38, 0.55);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-24 13:45:00', 10006,'C40', 18, 41, 0.75);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-02 17:10:00', 10006,'C11', 3, 35, 0.6);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-09 19:05:00', 10006,'C02', 1, 38, 0.85);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-24 13:45:00', 10006,'C36', 2, 35, 0.75);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-21 23:45:00', 10006,'C30', 9, 60, 1.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-01', 10006,'C20',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-06 11:40:00', 10006,'C11', 3, 50, 1.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-06 12:40:00', 10006,'C11', 3, 55, 2.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-06 13:40:00', 10006,'C11', 10, 65, 2.5);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-06 14:40:00', 10006,'C11', 9, 60, 1.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-06 15:40:00', 10006,'C11', 4, 53, 2.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-06 16:40:00', 10006,'C11', 21, 32, 0.7);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-13 10:40:00', 10006,'C63', 3, 52, 2.1);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-15 16:45:00', 10006,'C63', 1, 43, 1.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-16', 10006,'C63',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-16', 10006,'C24',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-16', 10006,'C40',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-06-21 11:15:00', 10007,'C40', 9, 58, 1.35);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-22 12:00:00', 10007,'C36', 1, 42, 1.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-11-14 23:15:00', 10007,'C02', 4, 43, 1.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-04', 10007,'C20',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-07', 10007,'C30',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-04', 10007,'C40',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-07', 10007,'C11',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-06 11:40:00', 10007,'C20', 9, 57, 1.5);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-13 12:05:00', 10007,'C20', 9, 58, 1.65);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-14 13:45:00', 10007,'C40', 9, 71, 2.85);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-10-12 17:10:00', 10007,'C11', 10, 62, 2.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-10-19 19:05:00', 10007,'C02', 2, 37, 0.75);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-11-14 13:45:00', 10007,'C36', 4, 45, 1.45);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-11-11 23:45:00', 10007,'C30', 9, 51, 0.9);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-03', 10007,'C40',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-04-19 12:15:00', 10007,'C40', 9, 48, 0.7);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-27 11:15:00', 10008,'C40', 3, 52, 2.35);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-06-26 12:00:00', 10008,'C36', 1, 46, 1.55);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-12-11 23:15:00', 10008,'C02', 2, 35, 0.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-11-21', 10008,'C30', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-11-23', 10008,'C24', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-11-27', 10008,'C63', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-21', 10008,'C02', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-22', 10008,'C11', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-01', 10008,'C20',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-02', 10008,'C20',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-03', 10008,'C20',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-09', 10008,'C20',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-01', 10008,'C11',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-01', 10008,'C20',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-01', 10008,'C40',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-02', 10008,'C11',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-13', 10008,'C11',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-14', 10008,'C11',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-07', 10008,'C11',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-17', 10008,'C40',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-10-27', 10008,'C40',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-10-27', 10008,'C20',null, null,null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-05-01 16:50:00', 10008,'B01', 1, 35, 0.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-05-02', 10008,'B01', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-05-03 14:50:00', 10008,'B01', 10, 67, 2.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-05-15 12:00:00', 10008, '012', 3, 57, 1.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-05-15 13:00:00', 10008, '012', 3, 59, 2.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-05-15 14:00:00', 10008, '012', 3, 63, 2.7);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-12-21', 10009,'037', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-06-21', 10009,'029', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-09-22', 10009,'029', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-11-21', 10009,'012', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-21', 10009,'002', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-22', 10009,'013', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-06 18:40:00', 10009,'029', 12, 47, 1.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-08 20:40:00', 10009,'029', 12, 43, 1.0);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-16 14:40:00', 10009,'029', 7, 37, 0.5);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-03 06:40:00', 10009,'029', 20, 62, 2.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-09-18 10:40:00', 10009,'037', 21, 37, 0.95);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-10-09 17:40:00', 10009,'037', 21, 34, 0.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-05-28 5:00:00', 10009,'C11', 10, 62, 2.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-29 15:00:00', 10009,'C11', 10, 61, 2.1);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-24 5:10:00', 10010,'1', 6, 56, 1.55);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-25 6:45:00', 10010,'4', 15, 24, 0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-01 7:05:00', 10010,'1', 7, 35, 0.35);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-14 5:10:00', 10010,'13', 10, 59, 1.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-06-11 15:10:00', 10010,'15', 9, 81, 4.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-10-04 15:10:00', 10010,'1', 1, 47, 1.65);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-10-16 15:10:00', 10010,'1', 20, 66, 2.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-02-24 17:15:00', 10010,'L02', 1, 50, 2.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-05-01', 10010,'1', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-05-02', 10010,'15', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-06-28', 10010,'C11', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-06-29 7:15:00', 10010,'C11', 9, 58, 1.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-06-29 12:10:00', 10010,'C11', 3, 46, 1.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-06-29 18:40:00', 10010,'C11', 1, 40, 1.1);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-06-30', 10010,'C11', NULL, NULL, NULL);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-07-01 6:50:00', 10010,'C11', 10, 63, 2.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-03-16 19:40:00', 10010,'1', 3, 47, 1.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-03-18 13:40:00', 10010,'1', 3, 43, 1.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-26 15:40:00', 10010,'4', 17, 27, 0.35);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-13 16:40:00', 10010,'4', 9, 52, 1.0);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-08 12:40:00', 10010,'13', 10, 67, 2.75);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-09-19 14:40:00', 10010,'15', 10, 58, 1.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-10', 10010, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-11 12:40:00', 10010,'C11', 1, 75, 7.25);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-12 23:40:00', 10010,'C63', 10, 55, 1.55);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-19 2:10:00', 10010,'C63', 10, 59, 1.80);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-22 06:20:00', 10010,'C63', 9, 52, 1.00);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-12 4:50:00', 10010,'C24', 17, 25, 0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-12 5:50:00', 10010,'C24', 17, 31, 0.32);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-12 6:10:00', 10010,'C24', 17, 22, 0.15);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-12', 10010, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-13', 10010, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-29', 10010, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-30 05:20:00', 10010,'C11', 1, 81, 9.85);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-31', 10010, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-09-01', 10010, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-09-14 17:40:00', 10010,'C11', 1, 68, 6.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-09-15', 10010, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-11', 10010, '029', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-04-11', 10010, 'L01', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-27 11:40:00', 10010,'L01', 1, 58, 4.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-27 12:55:00', 10010,'L01', 1, 62, 5.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-22', 10010, 'L02', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-08 23:10:00', 10010,'L02', 1, 55, 3.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-12 7:30:00', 10010,'C11', 1, 55, 3.1);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-16 8:35:00', 10010,'C11', 3, 47, 1.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-07-14 17:30:00', 10010,'C11', 1, 62, 4.3);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2019-08-16 8:35:00', 10010,'C11', 3, 47, 1.2);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-11', 10011, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-20', 10011, 'C20', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-18 12:00:00', 10011, 'C11', 3, 42, 0.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-02 14:15:00', 10011, 'C40', 17, 25, 0.20);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-25', 10011, 'C40', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-08-12 21:00:00', 10011, 'C36', 5, 56, 0.4);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-08-04 21:00:00', 10011, 'C36', 5, 62, 0.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2018-08-01 22:00:00', 10011, 'C36', 5, 72, 1.2);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-11', 10013, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-12', 10013, 'C63', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-13', 10013, 'C63', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-13', 10013, 'C24', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-19', 10013, '037', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-18 10:00:00', 10013, 'C40', 13, 40, 0.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-22 11:15:00', 10013, 'C40', 13, 42, 0.75);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-01 04:45:00', 10014, 'L01', 1, 40, 0.9);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-02 14:55:00', 10014, 'L01', 2, 42, 1.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-03', 10014, 'L01', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-05 17:30:00', 10014, 'L02', 1, 45, 1.35);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-21 19:50:00', 10014, 'L01', 1, 38, 0.8);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-22 16:40:00', 10014, 'L01', 2, 47, 1.95);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-23 00:00:00', 10014, 'L01', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-15 07:05:00', 10014, 'L02', 2, 40, 1.05);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-16 06:20:00', 10014, 'L02', 2, 48, 2.15);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-03-01 9:50:00', 10015, 'L03', 9, 46, 0.55);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-03-01 10:50:00', 10015, 'L03', 9, 55, 1.1);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-03-01 11:20:00', 10015, 'L03', 1, 44, 1.2);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-03-01 17:30:00', 10015, 'B02', 9, 58, 1.4);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-03-01 16:40:00', 10016, 'L01', 1, 46, 1.7);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-03-02 12:45:00', 10016, 'L01', 1, 50, 2.5);
 

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-11', 10017, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-18', 10017, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-12', 10017, 'C40', null, null, null);


insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-05-14', 10018, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-06-18', 10018, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-13 19:40:00', 10018, 'C63', 3, 46, 1.5);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-13 21:20:00', 10018, 'C63', 3, 42, 1.05);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-13 23:05:00', 10018, 'C63', 1, 48, 3.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-07-25 13:05:00', 10018, 'B02', 9, 49, 3.15);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-19', 10018, 'C24', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-09-21', 10018, 'C40', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-11-11', 10018, 'C63', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-12 9:15:00', 10018, 'C11', 17, 28, 0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-12 9:30:00', 10018, 'C11', 17, 25, 0.22);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-12 9:55:00', 10018, 'C11', 17, 32, 0.35);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-12 10:10:00', 10018, 'C11', 17, 30, 0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-12 10:50:00', 10018, 'C11', 15, 28, 0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-21', 10018, 'C11', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-02 15:25:00', 10018, 'B01', 10, 59, 1.95);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-19', 10019, 'C40', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-01-21', 10019, 'C40', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-02', 10019, 'C30', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-12 9:05:00', 10019, 'C02', 15, 28, 0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-12 9:20:00', 10019, 'C02', 15, 24, 0.22);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-12 10:55:00', 10019, 'C02', 15, 30, 0.35);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-12 11:10:00', 10019, 'C02', 15, 27, 0.25);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-12 12:50:00', 10019, 'C02', 3, 38, 0.65);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-12 13:10:00', 10019, 'C02', 17, 34, 0.45);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-12 13:30:00', 10019, 'C02', 3, 42, 0.95);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-13', 10019, 'C02', null, null, null);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2022-02-15 14:25:00', 10019, 'C02', 1, 43, 1.1);

insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2020-06-12 10:25:00', 10020, 'B01', 9, 62, 1.80);
insert into  Rejestry (czas, id_Wedkarza, id_lowiska, id_gatunku, dlugosc, waga) Values
('2021-08-22 23:25:00', 10020, 'B02', 1, 38, 0.85);



INSERT INTO Rekordy_PZW_Czestochowa (id_gatunku, waga, id_wedkarza, data_polowu, id_lowiska, komentarz)  
Select id_gatunku, 0, NULL, NULL, NULL, NULL from Gatunki;
 


commit;


select * from  Rejestry; 
select * from  Licencje; 
select * from  Oplaty;
select * from  Wedkarze;
select * from  Lowiska;

select * from RejestrLab2;
select * from Rekordy_PZW_Czestochowa;

 

