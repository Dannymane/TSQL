CREATE TABLE  stanowiska
(  stanowisko	NVARCHAR(25),
   placa_min	DECIMAL(8,2), 
   placa_max	DECIMAL(8,2), 
   staz_min int, -- w miesiacach
   dod_funkcyjny NVARCHAR(3) constraint stanowiska_dod_fun_ch check(dod_funkcyjny in ('Tak', 'Nie')), 
   CONSTRAINT stanowiska_PK PRIMARY KEY (stanowisko)
);

CREATE TABLE  dzialy 
(  id_dzialu	int,
   nazwa	NVARCHAR(15),   
   adres	NVARCHAR(150),
   CONSTRAINT dzialy_PK PRIMARY KEY (id_dzialu)
);

CREATE TABLE pracownicy (
  nr_akt DECIMAL(4,0),
  nazwisko	NVARCHAR(25),
  imiona NVARCHAR(25),
  stanowisko NVARCHAR(25),
  przelozony	DECIMAL(4,0) CONSTRAINT pracownicy_FK_przelozony REFERENCES  pracownicy(nr_akt),
  data_ur DATE,
  data_zatr DATE,
  data_zwol DATE,
  placa DECIMAL(8,2), 
  dod_funkcyjny DECIMAL(8,2),
  dod_staz DECIMAL(2,0) constraint pracownicy_staz_ch check(dod_staz between 0 and 20),
  koszt_ubezpieczenia DECIMAL(5,2) constraint pracownicy_ubezp_ch check (koszt_ubezpieczenia>=0),
  id_dzialu int,
  CONSTRAINT pracownicy_PK PRIMARY KEY (nr_akt),
  CONSTRAINT pracownicy_dzial_FK FOREIGN KEY (id_dzialu) REFERENCES  dzialy (id_dzialu),
  CONSTRAINT pracownicy_stan_FK FOREIGN KEY (stanowisko) REFERENCES  stanowiska (stanowisko) 
);

commit;

--*************************************************
INSERT INTO  dzialy VALUES (10, 'Zarzad', 'ul. Warszawska 123 42-205 Czestochowa');
INSERT INTO  dzialy VALUES (20, 'Produkcja', 'ul. Poznanska 12/34 42-217 Czestochowa');
INSERT INTO  dzialy VALUES (30, 'Logistyka', 'ul. Gdańska 19 34-323 Katowice');
INSERT INTO  dzialy VALUES (40, 'Administracja', 'al. Armii Krajowej 8 00-012 Warszawa');
INSERT INTO  dzialy VALUES (50, 'Badania', 'ul. Warszawska 123 42-205 Czestochowa');
INSERT INTO  dzialy VALUES (60, 'Ksiegowosc','ul. Wroclawska 323 97-501 Radomsko');
INSERT INTO  dzialy VALUES (70, 'Sprzedaz', 'al. Wolnosci 78/80 42-207 Czestochowa');
INSERT INTO  dzialy VALUES (80, 'Magazyn', 'ul. Poznanska 12/34 42-217 Czestochowa');
INSERT INTO  dzialy VALUES (90, 'Serwis', 'ul. Wroclawska 321 97-501 Radomsko');
INSERT INTO  dzialy VALUES (100, 'BHP', NULL);

select * from  dzialy;

INSERT INTO  stanowiska VALUES ('Prezes', 10000, 25000, 96, 'Tak');
INSERT INTO  stanowiska VALUES ('Czlonek zarzadu', 7000, 12000, 60, 'Tak');
INSERT INTO  stanowiska VALUES ('Dyrektor', 5000, 10000, 48, 'Tak');
INSERT INTO  stanowiska VALUES ('Kierownik', 4000, 7500, 36, 'Tak');
INSERT INTO  stanowiska VALUES ('Glowny ksiegowy', 5000, 10000, 60, 'Nie');
INSERT INTO  stanowiska VALUES ('Starszy ksiegowy', 3500, 7500, 36, 'Nie');
INSERT INTO  stanowiska VALUES ('Ksiegowy', 2500, 5000, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Glowny informatyk', 5000, 10000, 48, 'Nie');
INSERT INTO  stanowiska VALUES ('Informatyk', 2500, 7000, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Technolog', 2500, 5000, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Monter', 2500, 5000, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Operator', 3000, 5000, 12, 'Nie');
INSERT INTO  stanowiska VALUES ('Logistyk', 2700, 4500, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Starszy logistyk', 3500, 6000, 24, 'Nie');
INSERT INTO  stanowiska VALUES ('Przedstawiciel handlowy', 2300, 5000, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Sprzedawca', 2300, 3700, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Starszy sprzedawca', 3200, 4800, 12, 'Nie');
INSERT INTO  stanowiska VALUES ('Magazynier', 2300, 3200, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Starszy magazynier', 2800, 3900, 24, 'Nie');
INSERT INTO  stanowiska VALUES ('Referent', 2300, 3200, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Starszy referent', 3500, 4900, 36, 'Nie');
INSERT INTO  stanowiska VALUES ('Pracownik gospodarczy', 2300, 3000, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Technik', 2300, 3200, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Kierowca', 2400, 4500, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Serwisant', 2400, 3500, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Starszy serwisant', 3200, 4500, 12, 'Nie');
INSERT INTO  stanowiska VALUES ('Laborant', 2500, 3500, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Manager', 3000, 6000, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Praktykant', 2300, 2700, NULL, 'Nie');
INSERT INTO  stanowiska VALUES ('Konserwator', 2800, 3800, 12, 'Nie');
INSERT INTO  stanowiska VALUES ('Specjalista ds. bhp', 3600, 4500, NULL, 'Nie');

select * from  stanowiska;


INSERT INTO  pracownicy VALUES (1234, 'Michalski', 'Adam', 'Prezes', NULL,
  '1950-07-11', '1981-08-15', NULL, 12000, 5500, 20, 200, 10);
INSERT INTO  pracownicy VALUES (1250, 'Nowakowska', 'Anna', 'Czlonek zarzadu', 1234,    
  '1973-12-15', '2001-01-01', NULL, 10000, 3500, 17, 150, 10);
INSERT INTO  pracownicy VALUES (1266, 'Tybur', 'Andrzej', 'Czlonek zarzadu', 1234,      
  '1968-02-05', '2010-01-01', NULL, 8500, 3000, 7, 150, 10);
INSERT INTO  pracownicy VALUES (1279, 'Olszewska', 'Olga', 'Czlonek zarzadu', 1234,     
  '1975-10-27', '1998-10-01', NULL, 8000, 3500, 20, NULL, 10);
INSERT INTO  pracownicy VALUES (1200, 'Gmoch', 'Adam', 'Prezes', NULL,
  '1944-07-11', '1975-11-01', '2009-07-31', 8900, 3500, 20, NULL, 10);
INSERT INTO  pracownicy VALUES (1210, 'Biernat', 'Grzegorz', 'Czlonek zarzadu', 1234,   
  '1967-07-13', '1993-06-01', '2009-12-31', 7000, 2500, 15, 120, 10);
INSERT INTO  pracownicy VALUES (2022, 'Kurowski', 'Zenon', 'Dyrektor', 1234,
  '1971-03-05', '1996-07-01', NULL, 7000, 2000, 20, 100, 20);
INSERT INTO  pracownicy VALUES (2030, 'Kowalski', 'Karol', 'Dyrektor', 1234,
  '1966-02-03', '2006-05-01', NULL, 6000, 2000, 12, 100, 30);
INSERT INTO  pracownicy VALUES (2040, 'Kowalski', 'Janusz', 'Dyrektor', 1234,
  '1976-11-05', '2009-05-01', NULL, 7000, 2000, 9, 100, 40);
INSERT INTO  pracownicy VALUES (2050, 'Kurowski','Piotr', 'Dyrektor', 1234,
  '1967-09-28', '2003-12-01', NULL, 8000, 2000, 14, NULL, 50);
INSERT INTO  pracownicy VALUES (2060, 'Piech', 'Roman', 'Dyrektor', 1234,
  '1972-03-25', '1999-08-01', NULL, 9000, 2000, 19, 100, 60);
INSERT INTO  pracownicy VALUES (2070, 'Ujma', 'Maria', 'Dyrektor', 1234,
  '1977-01-07', '2015-01-01', NULL, 7000, 2000, 5, 100, 70);
INSERT INTO  pracownicy VALUES (2080, 'Janczak', 'Malgorzata', 'Dyrektor', 1234,        
  '1970-03-16', '2011-07-01', NULL, 7500, 2000, 7, NULL, 80);
INSERT INTO  pracownicy VALUES (2090, 'Drozd', 'Tomasz', 'Dyrektor', 1234,
  '1969-02-02', '2002-05-01', NULL, 6500, 2000, 16, 100, 90);
INSERT INTO  pracownicy VALUES (2120, 'Klich', 'Zbigniew', 'Dyrektor', 1200,
  '1946-08-17', '1983-01-01', '2005-07-01', 5300, 1500, 20, NULL, 20);
INSERT INTO  pracownicy VALUES (2170, 'Zaton', 'Roman', 'Dyrektor', 1234,
  '1958-11-05', '2007-01-01', '2014-12-31', 6200, 1500, 6, 80, 70);
INSERT INTO  pracownicy VALUES (2420, 'Moscicki', 'Jan', 'Kierownik', 2022,
  '1954-12-19', '1986-06-01', '2018-06-30', 5000, 1200, 20, NULL, 20);
INSERT INTO  pracownicy VALUES (2520, 'Oskarowicz', 'Jan', 'Kierownik', 2022,
  '1974-12-05', '2000-11-01', NULL, 5500, 1200, 18, 100, 20);
INSERT INTO  pracownicy VALUES (2620, 'Mroz', 'Adrian', 'Kierownik', 2022,
  '1979-11-03', '2005-01-01', NULL, 5700, 1200, 13, NULL, 20);
INSERT INTO  pracownicy VALUES (2720, 'Deszcz', 'Michal', 'Kierownik', 2022,
  '1982-08-19', '2007-10-01', NULL, 5400, 1200, 11, NULL, 20);
INSERT INTO  pracownicy VALUES (2801, 'Okrasa', 'Henryk', 'Monter', 2520,
  '1977-11-05', '1998-11-01', NULL, 3500, NULL, 20, NULL, 20);
INSERT INTO  pracownicy VALUES (2802, 'Biernacki', 'Jan', 'Monter', 2520,
  '1993-12-05', GETDATE()-265, GETDATE()+465, 3000, NULL, 1, NULL, 20);
INSERT INTO  pracownicy VALUES (2803, 'Czapla', 'Damian', 'Monter', 2520,
  '1997-12-05', GETDATE()-165, GETDATE()+200, 2800, NULL, 1, NULL, 20);
INSERT INTO  pracownicy VALUES (2808, 'Chomnicki', 'Adrian', 'Monter', 2520,
  '1993-12-05', '2004-01-01', '2019-09-30', 2600, NULL, 12, NULL, 20);
INSERT INTO  pracownicy VALUES (2804, 'Andrzejewski', 'Waclaw', 'Technolog', 2620,      
  '1971-12-05', '1996-11-01', NULL, 3500, NULL, 20, 50, 20);
INSERT INTO  pracownicy VALUES (2805, 'Janicki', 'Tomasz', 'Technolog', 2620,
  '1998-12-05', GETDATE()-115, GETDATE()+250, 2500, NULL, 1, NULL, 20);
INSERT INTO  pracownicy VALUES (2806, 'Nowowiejski', 'Ryszard', 'Technolog', 2620,      
  '1987-12-05', '2011-10-01', NULL, 3100, NULL, 7, 50, 20);
INSERT INTO  pracownicy VALUES (2812, 'Remien', 'Norbert', 'Technolog', 2620,
  '1986-04-05', '2009-03-01', '2020-05-31', 2800, NULL, 9, 50, 20);
INSERT INTO  pracownicy VALUES (2809, 'Kopacz', 'Aldona', 'Technolog', 2420,
  '1981-02-06', '2006-04-01', '2017-01-31', 3450, NULL, 8, 50, 20);
INSERT INTO  pracownicy VALUES (2807, 'Polak', 'Mateusz', 'Operator', 2720,
  '1988-06-05', '2010-06-01', NULL, 3500, NULL, 8, NULL, 20);
INSERT INTO  pracownicy VALUES (2811, 'Drozda', 'Grzegorz', 'Operator', 2720,
  '1984-10-15', '2006-10-01', NULL, 3100, NULL, 12, 50, 20);
INSERT INTO  pracownicy VALUES (2815, 'Pruszek', 'Roman', 'Operator', 2720,
  '1968-03-27', '1990-01-01', NULL, 4500, NULL, 20, 50, 20);
INSERT INTO  pracownicy VALUES (2817, 'Lewandowski', 'Jacek', 'Operator', 2720,
  '1948-03-27', '1982-09-01', '2015-09-30', 4200, NULL, 20, 50, 20);
INSERT INTO  pracownicy VALUES (2818, 'Kulach', 'Marcin', 'Technik', 2720,
  '1997-12-30', GETDATE()-10, GETDATE()+355, 2500, NULL, 0, NULL, 20);
INSERT INTO  pracownicy VALUES (3101, 'Majewska', 'Maria', 'Starszy logistyk', 2030,    
  '1958-10-09', '1985-02-01', NULL, 4800, NULL, 20, 100, 30);
INSERT INTO  pracownicy VALUES (3103, 'Morwaski', 'Roman', 'Starszy logistyk', 2030,    
  '1957-12-19', '1986-06-01', '2015-12-31', 5400, NULL, 20, 100, 30);
INSERT INTO  pracownicy VALUES (3107, 'Mizera', 'Jagoda', 'Logistyk', 2030,
  '1992-04-29', '2007-02-01', NULL, 3400, NULL, 11, 50, 30);
INSERT INTO  pracownicy VALUES (3111, 'Biernacki', 'Adrian', 'Logistyk', 2030,
  '1989-01-03', '2016-06-01', NULL, 3700, NULL, 4, 50, 30);
INSERT INTO  pracownicy VALUES (3115, 'Turek', 'Agnieszka', 'Logistyk', 2030,
  '1993-05-12', GETDATE()-195,  GETDATE()+170, 3200, NULL, 0, NULL, 30);
INSERT INTO  pracownicy VALUES (3121, 'Turek', 'Adam', 'Kierowca', 2030,
  '1988-05-12', '2011-11-01',  NULL, 3500, NULL, 7, NULL, 30);
INSERT INTO  pracownicy VALUES (3122, 'Krawiec', 'Patryk', 'Kierowca', 2030,
  '1987-06-16', '2007-01-01',  NULL, 3800, NULL, 11, 50, 30);
INSERT INTO  pracownicy VALUES (3123, 'Machaj', 'Tomasz', 'Kierowca', 2030,
  '1993-05-12', '2018-07-01',  NULL, 3200, NULL, 2, NULL, 30);
INSERT INTO  pracownicy VALUES (3124, 'Turek', 'Adam', 'Kierowca', 2030,
  '1995-07-11', GETDATE()-270,  GETDATE()+450, 3100, NULL, 0, NULL, 30);
INSERT INTO  pracownicy VALUES (4101, 'Majewska', 'Dorota', 'Starszy referent', 2040,   
  '1965-12-13', '1989-08-01', '2017-04-30', 4200, 250, 20, 50, 40);
INSERT INTO  pracownicy VALUES (4102, 'Michon', 'Teresa', 'Starszy referent', 2040,     
  '1978-02-16', '2001-01-01', NULL, 4700, 250, 18, 100, 40);
INSERT INTO  pracownicy VALUES (4111, 'Zych', 'Daria', 'Referent', 2040,
  '1979-01-29', '2003-02-01', '2016-12-31', 3000, NULL, 11, NULL, 40);
INSERT INTO  pracownicy VALUES (4112, 'Bach', 'Agnieszka', 'Referent', 2040,
  '1983-06-07', '2011-01-01', NULL, 2800, NULL, 8, 50, 40);
INSERT INTO  pracownicy VALUES (4113, 'Bilska', 'Agnieszka', 'Referent', 2040,
  '1987-06-07', GETDATE()-35, GETDATE()+330, 2700, NULL, 0, NULL, 40);
INSERT INTO  pracownicy VALUES (4121, 'Lara', 'Pawel', 'Pracownik gospodarczy', 2040,   
  '1968-10-09', '1989-05-01', NULL, 2600, NULL, 20, NULL, 40);
INSERT INTO  pracownicy VALUES (4122, 'Kowal', 'Krystian', 'Pracownik gospodarczy', 2040,
  '1974-08-02', '1996-04-01', NULL, 2500, NULL, 20, NULL, 40);
INSERT INTO  pracownicy VALUES (4131, 'Rorat', 'Adam', 'Technik', 2040,
  '1969-11-11', '1990-11-01', NULL, 2900, NULL, 20, 50, 40);
INSERT INTO  pracownicy VALUES (4141, 'Drab', 'Krzysztof', 'Glowny informatyk', 2040,   
  '1981-10-09', '2007-10-01', NULL, 6500, 500, 11, 50, 40);
INSERT INTO  pracownicy VALUES (4142, 'Krawczyk', 'Arkadiusz', 'Informatyk', 2040,      
  '1983-10-09', '2015-11-01', NULL, 4700, NULL, 5, 50, 40);
INSERT INTO  pracownicy VALUES (4143, 'Kalinowski', 'Mariusz', 'Informatyk', 2040,      
  '1993-10-09', GETDATE()-200, GETDATE()+170, 3500, NULL, 0, NULL, 40);
INSERT INTO  pracownicy VALUES (5101, 'Kubica', 'Anna', 'Laborant', 2050,
  '1982-04-13', '2006-12-01', NULL, 3000, NULL, 12, 50, 50);
INSERT INTO  pracownicy VALUES (5102, 'Janik', 'Agata', 'Laborant', 2050,
  '1991-02-17', '2017-10-01', NULL, 2800, NULL, 3, 50, 50);
INSERT INTO  pracownicy VALUES (5103, 'Czech', 'Mariola', 'Laborant', 2050,
  '1986-07-01', '2008-10-01', '2009-09-30', 2700, NULL, 0, 50, 50);
INSERT INTO  pracownicy VALUES (5111, 'Boral', 'Angelika', 'Praktykant', 2050,
  '1981-05-21', '2006-10-01', '2008-09-30', 2300, NULL, 1, 50, 50);
INSERT INTO  pracownicy VALUES (5112, 'Kowalik', 'Marcelina', 'Praktykant', 2050,       
  '1987-03-18', '2010-10-01', '2011-09-30', 2300, NULL, 0, NULL, 50);
INSERT INTO  pracownicy VALUES (5113, 'Malinowska', 'Karina', 'Praktykant', 2050,       
  '1992-02-19', '2019-11-01', '2020-10-31', 2300, NULL, 0, NULL, 50);
INSERT INTO  pracownicy VALUES (5114, 'Kostrzewa', 'Natalia', 'Praktykant', 2050,       
  '1992-09-30', GETDATE()-120, '2023-12-31', 2300, NULL, 0, 50, 50);        
INSERT INTO  pracownicy VALUES (6101, 'Halbiniak', 'Ramona', 'Glowny ksiegowy', 2060,   
  '1954-04-17', '1983-11-01', '2016-04-30', 8000, 1000, 20, 100, 60);
INSERT INTO  pracownicy VALUES (6102, 'Kalota', 'Rafal', 'Glowny ksiegowy', 2060,       
  '1965-12-03', '1997-01-01', NULL, 8200, 1000, 20, 50, 60);
INSERT INTO  pracownicy VALUES (6111, 'Gancarek', 'Wioletta', 'Starszy ksiegowy', 2060, 
  '1977-06-09', '2005-06-01', NULL, 5500, NULL, 13, NULL, 60);
INSERT INTO  pracownicy VALUES (6112, 'Ignaczak', 'Dagmara', 'Starszy ksiegowy', 2060,  
  '1985-03-15', '2009-10-01', NULL, 4900, NULL, 9, 50, 60);
INSERT INTO  pracownicy VALUES (6121, 'Ludomierska', 'Jagoda', 'Ksiegowy', 2060,        
  '1981-03-15', '2009-11-01', '2020-12-31', 4000, NULL, 9, 50, 60);
INSERT INTO  pracownicy VALUES (6122, 'Rokosa', 'Kamil', 'Ksiegowy', 2060,
  '1987-03-15', '2015-01-01', NULL, 4000, NULL, 5, 50, 60);
INSERT INTO  pracownicy VALUES (6123, 'Taranek', 'Barbara', 'Ksiegowy', 2060,
  '1977-11-06', '2004-08-01', NULL, 4200, NULL, 14, 50, 60);
INSERT INTO  pracownicy VALUES (6124, 'Kos', 'Patyrycja', 'Ksiegowy', 2060,
  '1993-03-15', GETDATE()-40, GETDATE()+325, 2500, NULL, 0, NULL, 60);
INSERT INTO  pracownicy VALUES (6125, 'Goral', 'Joanna', 'Ksiegowy', 2060,
  '1958-05-28', '1988-03-01', NULL, 4300, NULL, 20, 50, 60);
INSERT INTO  pracownicy VALUES (7101, 'Adamowicz', 'Pawel', 'Przedstawiciel handlowy', 2070,
  '1991-01-17', GETDATE()-360, GETDATE()+370, 2600, NULL, 1, 50, 70);

INSERT INTO  pracownicy VALUES (7102, 'Zygon', 'Czeslaw', 'Przedstawiciel handlowy', 2170,
  '1981-11-10', '2004-01-01', '2007-12-31', 2800, NULL, 3, 50, 70);
INSERT INTO  pracownicy VALUES (7103, 'Rzepka', 'Piotr', 'Przedstawiciel handlowy', 2070,
  '1992-03-07', '2015-12-01', NULL, 3400, NULL, 5, 50, 70);
INSERT INTO  pracownicy VALUES (7111, 'Chlad', 'Pawel', 'Starszy sprzedawca', 2170,     
  '1971-11-17', '1997-11-01', '2010-04-30', 3700, NULL, 12, 50, 70);
INSERT INTO  pracownicy VALUES (7112, 'Zamojski', 'Grzegorz', 'Starszy sprzedawca', 2070,
  '1987-11-17', '2014-01-01', NULL, 3900, NULL, 6, 50, 70);
INSERT INTO  pracownicy VALUES (7113, 'Chlad', 'Pawel', 'Starszy sprzedawca', 2070,     
  '1985-08-02', '2016-01-01', NULL, 3400, NULL, 5, 50, 70);
INSERT INTO  pracownicy VALUES (7121, 'Chwilczynski', 'Jacek', 'Sprzedawca', 2070,      
  '1986-11-17', '2014-01-01', NULL, 2900, NULL, 6, NULL, 70);
INSERT INTO  pracownicy VALUES (7122, 'Grzeszczak', 'Anna', 'Sprzedawca', 2070,
  '1990-04-17', '2017-04-01', NULL, 2800, NULL, 3, 50, 70);
INSERT INTO  pracownicy VALUES (7123, 'Pawlak', 'Pawel', 'Sprzedawca', 2070,
  '1995-10-21', GETDATE()-100, GETDATE()+620, 2300, NULL, 0, 50, 70);

INSERT INTO  pracownicy VALUES (8101, 'Abresz', 'Leszek', 'Starszy magazynier', 2080,   
  '1976-02-12', '1997-10-01', NULL, 3400, NULL, 20, 50, 80);
INSERT INTO  pracownicy VALUES (8111, 'Zjawiony', 'Leopold', 'Magazynier', 2080,        
  '1967-07-06', '1992-01-01', '2017-10-31', 3000, NULL, 20, 50, 80);
INSERT INTO  pracownicy VALUES (8112, 'Klinowski', 'Jan', 'Magazynier', 2080,
  '1992-07-31', '2018-01-01', NULL, 2700, NULL, 2, NULL, 80);
INSERT INTO  pracownicy VALUES (8113, 'Drzyzga', 'Lukasz', 'Magazynier', 2080,
  '1999-10-08', GETDATE()-65, GETDATE()+300, 2300, NULL, 0, NULL, 80);
INSERT INTO  pracownicy VALUES (8121, 'Nowak', 'Jan', 'Operator', 2080,
  '1981-02-22', '2004-05-01', NULL, 3700, NULL, 14, NULL, 80);
INSERT INTO  pracownicy VALUES (8131, 'Niezgoda', 'Jakub', 'Kierowca', 2080,
  '1988-01-22', '2014-06-01', NULL, 3200, NULL, 6, 50, 80);
INSERT INTO  pracownicy VALUES (8132, 'Lubaszewski', 'Blazej', 'Kierowca', 2080,        
  '1993-12-24', GETDATE()-430, GETDATE()+300, 3000, NULL, 1, NULL, 80);
INSERT INTO  pracownicy VALUES (9111, 'Janikowski', 'Kazimierz', 'Starszy serwisant', 2090,
  '1952-02-12', '1979-01-01', NULL, 4200, NULL, 20, 50, 90);
INSERT INTO  pracownicy VALUES (9121, 'Mizera', 'Marcin', 'Serwisant', 2090,
  '1965-04-11', '1986-06-01', NULL, 3500, NULL, 20, 50, 90);
INSERT INTO  pracownicy VALUES (9122, 'Gruca', 'Mariusz', 'Starszy serwisant', 2090,    
  '1974-01-25', '1996-10-01', NULL, 3200, NULL, 20, NULL, 90);
INSERT INTO  pracownicy VALUES (9131, 'Wolski', 'Dariusz', 'Praktykant', 2090,
  '1997-09-03', GETDATE()-65, GETDATE()+300, 2300, NULL, 0, NULL, 90);
INSERT INTO  pracownicy VALUES (111, 'Wrobel', 'Jerzy', 'Kierowca', 1234,
  '1981-04-02', '2007-07-01', NULL, 3500, NULL, 10, NULL, NULL);
INSERT INTO  pracownicy VALUES (121, 'Radziejewska', 'Katarzyna', 'Manager', 1234,      
  '1976-12-12', '1999-08-01', '2016-08-31', 2950, NULL, 14, 50, NULL);
INSERT INTO  pracownicy VALUES (122, 'Olszewska', 'Klaudia', 'Manager', 1234,
  '1984-11-21', '2009-01-01', '2023-12-31', 4500, NULL, 9, 100, NULL);
SELECT * From pracownicy;
commit;

-- aktualizacja stazu w zaleznosci od roku realizacji zajec :)

UPDATE  pracownicy SET dod_staz = 
  CASE 
    WHEN DATEDIFF(YEAR, data_zatr, GETDATE()) between 1 and 20 THEN DATEDIFF(YEAR, data_zatr, GETDATE())
    WHEN DATEDIFF(YEAR, data_zatr, GETDATE()) > 20 THEN 20 
  ELSE 0
END;

/*
update  pracownicy set dod_staz = 
case 
when 
  Trunc(Months_between(GETDATE(), 'YY'), data_zatr)/12) between 1 and 20 THEN  Trunc(Months_between(GETDATE(), 'YY'), data_zatr)/12) 
when Trunc(Months_between(GETDATE(), 'YY'), data_zatr)/12) > 20 THEN 20 
else 0
END;
*/

--select * from  pracownicy;
--delete from  pracownicy;

DECLARE @StartDate DATE = '2022-01-01';
DECLARE @EndDate DATE = '2024-09-01';
PRINT DATEDIFF(YEAR, @EndDate, @StartDate); -- -2
PRINT DATEDIFF(MONTH, @StartDate, @EndDate); -- 32