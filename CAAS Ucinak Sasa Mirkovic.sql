-- Kreiranje baze --
CREATE DATABASE CAAS_učinak

-- Kreiranje tabela --
CREATE TABLE Autori
(
ID_autora CHAR (3) PRIMARY KEY,
Ime_i_prezime VARCHAR (50) NOT NULL,
Mesto VARCHAR (50),
Organizacija VARCHAR (100),
Email VARCHAR (60),
Telefon VARCHAR (20),
Slika VARBINARY (max)
)

CREATE TABLE Sadržaj
(
ID_sadržaja CHAR (4) PRIMARY KEY,
Naslov VARCHAR(255) NOT NULL,
Tip_sadržaja VARCHAR(18) NOT NULL,
Format CHAR(5),
ID_autora CHAR(3) NOT NULL,
Link VARCHAR(255),
CONSTRAINT FK_autor_sadržaj FOREIGN KEY (ID_autora) REFERENCES Autori(ID_autora)
ON DELETE NO ACTION
ON UPDATE CASCADE
)

CREATE TABLE Objave
(
Datum DATE NOT NULL,
ID_objave VARCHAR(9) PRIMARY KEY,
Naslov VARCHAR(255) NOT NULL,
Platforma VARCHAR(8) NOT NULL,
ID_sadržaja CHAR(4) NOT NULL,
Broj_pregleda INTEGER,
Broj_lajkova INTEGER,
Broj_dislajkova INTEGER,
Broj_emotikona INTEGER,
Broj_komentara INTEGER,
Broj_deljenja INTEGER,
Ukupna_interakcija AS (Broj_lajkova + Broj_dislajkova + Broj_emotikona + Broj_komentara + Broj_deljenja),
CONSTRAINT FK_sadržaj_objave FOREIGN KEY (ID_sadržaja) REFERENCES Sadržaj(ID_sadržaja)
ON DELETE NO ACTION
ON UPDATE CASCADE
)

CREATE TABLE Isplate 
(
ID_isplate CHAR(4) PRIMARY KEY,
Datum_isplate DATE NOT NULL,
Visina_isplate INTEGER NOT NULL,
ID_autora CHAR(3) NOT NULL,
ID_sadržaja CHAR(4) NOT NULL,
Dodatne_aktivnosti VARCHAR(255),
Odgovorno_lice VARCHAR(13) NOT NULL,
CONSTRAINT FK_autor_isplate FOREIGN KEY (ID_autora) REFERENCES Autori(ID_autora)
ON UPDATE CASCADE
ON DELETE NO ACTION,
CONSTRAINT FK_sadržaj_isplate FOREIGN KEY (ID_sadržaja) REFERENCES Sadržaj(ID_sadržaja)
)

CREATE TABLE Promocija
(
ID INTEGER IDENTITY(1,1) PRIMARY KEY,
Datum_promocije DATE NOT NULL,
Uplaćena_sredstva INTEGER NOT NULL,
Objava VARCHAR(9) NOT NULL,
CONSTRAINT FK_objave_promocija FOREIGN KEY (Objava) REFERENCES Objave(ID_objave)
ON UPDATE CASCADE
ON DELETE CASCADE
)

CREATE TABLE Fakultetsko_osoblje
(
Autor CHAR(3) PRIMARY KEY,
Zvanje VARCHAR(100) NOT NULL,
Grana_nauke VARCHAR(100) NOT NULL,
CONSTRAINT FK_autor FOREIGN KEY (Autor) REFERENCES Autori(ID_autora)
ON UPDATE CASCADE
ON DELETE CASCADE
)

CREATE TABLE Nevladin_sektor
(
Autor CHAR(3) PRIMARY KEY,
Pozicija VARCHAR(100) NOT NULL,
CONSTRAINT FK_autor_nevladin FOREIGN KEY (Autor) REFERENCES Autori(ID_autora)
ON UPDATE CASCADE
ON DELETE CASCADE
)

CREATE TABLE Novinari
(
Autor CHAR(3) PRIMARY KEY,
Pozicija VARCHAR (100) NOT NULL,
CONSTRAINT FK_autor_novinari FOREIGN KEY (Autor) REFERENCES Autori(ID_autora)
ON UPDATE CASCADE
ON DELETE CASCADE
)

CREATE TABLE Studenti
(
Autor CHAR(3) PRIMARY KEY,
Studijski_program VARCHAR(100) NOT NULL,
Nivo_studija VARCHAR(9) NOT NULL,
CONSTRAINT FK_autor_studenti FOREIGN KEY (Autor) REFERENCES Autori(ID_autora)
ON UPDATE CASCADE
ON DELETE CASCADE
)

CREATE TABLE Faktura
(
ID_fakture INTEGER IDENTITY(1,1) PRIMARY KEY,
Datum_prijema DATE NOT NULL,
Izdavalac_fakture VARCHAR(100) NOT NULL,
Isplata CHAR(4) NOT NULL,
CONSTRAINT FK_Isplata_faktura FOREIGN KEY (Isplata) REFERENCES Isplate(ID_isplate)
ON UPDATE CASCADE
ON DELETE CASCADE
)

CREATE TABLE Poštanska_potvrda
(
ID_potvrde INTEGER IDENTITY(1,1) PRIMARY KEY,
Uplatio VARCHAR(100) NOT NULL,
Vrsta_potvrde VARCHAR(100) NOT NULL,
Isplata CHAR(4) NOT NULL,
CONSTRAINT FK_Isplata_potvrda FOREIGN KEY (Isplata) REFERENCES Isplate(ID_isplate)
ON UPDATE CASCADE
ON DELETE CASCADE
)

CREATE TABLE Ugovor
(
ID_ugovora INTEGER IDENTITY(1,1) PRIMARY KEY,
Datum_potpisivanja DATE NOT NUll,
Vrsta_ugovora VARCHAR(100) NOT NULL
)

CREATE TABLE Preko
(
ID_isplate CHAR(4) PRIMARY KEY,
ID_ugovora INTEGER NOT NULL,
CONSTRAINT FK_Isplate_preko FOREIGN KEY (ID_isplate) REFERENCES Isplate(ID_isplate)
ON UPDATE CASCADE
ON DELETE NO ACTION,
CONSTRAINT FK_Ugovor_preko FOREIGN KEY (ID_ugovora) REFERENCES Ugovor(ID_ugovora)
ON UPDATE CASCADE
ON DELETE NO ACTION
)

CREATE TABLE Izveštaj_o_učinku
(
ID_izveštaja INTEGER IDENTITY(1,1) PRIMARY KEY,
Datum_izveštaja DATE NOT NULL,
Link_drajv VARCHAR(255) NOT NULL,
Autor CHAR(3) NOT NULL,
CONSTRAINT FK_autor_izveštaj FOREIGN KEY (Autor) REFERENCES Autori(ID_autora)
ON UPDATE CASCADE
ON DELETE CASCADE
)

CREATE TABLE Potencijalni_sadržaj
(
ID_predloga INTEGER IDENTITY(1,1) PRIMARY KEY,
Predloženi_naslov VARCHAR(255),
Komentar VARCHAR(1000),
Autor CHAR(3) NOT NULL,
CONSTRAINT FK_autor_potencijalni_sadržaj FOREIGN KEY (Autor) REFERENCES Autori(ID_autora)
ON UPDATE CASCADE
ON DELETE CASCADE
)

CREATE TABLE Projekti
(
ID_projekta CHAR(4) PRIMARY KEY,
Naziv_projekta VARCHAR(255) NOT NULL,
Period_trajanja VARCHAR(50),
Donator VARCHAR(100)
)

CREATE TABLE Proizvod
(
ID_sadržaja CHAR(4) PRIMARY KEY,
ID_projekta CHAR(4) NOT NULL,
CONSTRAINT FK_Sadržaj_proizvod FOREIGN KEY (ID_sadržaja) REFERENCES Sadržaj(ID_sadržaja)
ON UPDATE CASCADE
ON DELETE NO ACTION,
CONSTRAINT FK_Projekti_proizvod FOREIGN KEY (ID_projekta) REFERENCES Projekti(ID_projekta)
ON UPDATE CASCADE
ON DELETE NO ACTION
)

CREATE TABLE Ideje
(
ID_ideje INTEGER IDENTITY(1,1) PRIMARY KEY,
Kratak_opis VARCHAR(1000),
Radni_naslov VARCHAR(100) NOT NULL,
Projekat CHAR(4) NOT NULL,
CONSTRAINT FK_projekti_ideje FOREIGN KEY (Projekat) REFERENCES Projekti(ID_projekta)
ON UPDATE CASCADE
ON DELETE CASCADE
)

CREATE TABLE Izveštaj
(
ID_izveštaja INTEGER IDENTITY(1,1) PRIMARY KEY,
Datum_izveštaja DATE NOT NULL,
Link_drajv VARCHAR(255) NOT NULL,
Projekat CHAR(4) NOT NULL,
CONSTRAINT FK_projekti_izveštaj FOREIGN KEY (Projekat) REFERENCES Projekti(ID_projekta)
ON UPDATE CASCADE
ON DELETE CASCADE
)

CREATE TABLE Jezik
(
ID_jezika INTEGER IDENTITY(1,1) PRIMARY KEY,
Naziv VARCHAR(20) NOT NULL,
Prevodilac VARCHAR(50) NOT NULL,
Email VARCHAR(60) NOT NULL
)

CREATE TABLE Titlov
(
ID_jezika INTEGER NOT NULL,
ID_objave VARCHAR(9) NOT NULL,
Datum_izrade DATE NOT NULL,
Pismo VARCHAR(20) NOT NULL,
CONSTRAINT FK_Jezik_titlovi FOREIGN KEY (ID_jezika) REFERENCES Jezik(ID_jezika)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT FK_Objava_titlovi FOREIGN KEY (ID_objave) REFERENCES Objave(ID_objave)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT PK_titl PRIMARY KEY (ID_jezika, ID_objave)
)
-- Unošenje podataka za tabelu Autori --
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('001','Saša Mirković','Beograd','Centar za antiautoritarne studije',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('002','Aleksandar Molnar','Beograd','Filozofski fakultet',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('003','Dušan Pavlović','Beograd','Fakultet političkih nauka',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('004','Slobodan Antonić','Beograd','Filozofski fakultet',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('005','Miodrag Zec','Beograd','Filozofski fakultet',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('006','Ognjen Radonjić','Beograd','Filozofski fakultet',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('007','Đorđe Pavićević','Beograd','Fakultet političkih nauka',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('008','Nataša Jovanović Ajzenhamer','Beograd','Filozofski fakultet',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('009','Ratko Nikolić','Beograd','Centar za antiautoritarne studije',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('010','Milena Marić','Beograd','Centar za antiautoritarne studije',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('011','Dragoljub Petrović','Beograd','Danas',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('012','Jovana Gligorijević','Beograd','Vreme',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('013','Idro Seferi','Beograd',NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('014','Slobodan Georgiev','Beograd','BIRN',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('015','Aleksandar Đorđević','Beograd','BIRN',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('016','Stevan Dojčinović','Beograd','KRIK',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('017','Miloš Milovanović','Beograd','N1',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('018','Vuk Dinić','Niš','Filozofski fakultet',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('019','Milan Pešović','Beograd','Students for Liberty - Srbija',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('020','Irina Koprivica','Nikšić','Fakultet političkih nauka',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('021','Miljana Miletić','Beograd','Kulturni kišobran',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('022','Milan Blagojević','Beograd','Fakultet političkih nauka',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('023','Aleksandar Ivković','Beograd','Centar savremene politike',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('024','Mirza Ramusović','Novi Pazar','Državni univerzitet u Novom Pazaru',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('025','CAAS','Beograd',NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('026','Ana Jovanić','Beograd','Pravni fakultet',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('027','Tatjana Čanak','Beograd',NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('028','Ivana Jeremić','Beograd','CINS',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('029','Slobodan Kremenjak','Beograd',NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('030','Dino Jahić','Beograd','CINS',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('031','Milica Šarić','Beograd','CINS',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('032','Vladimir Kostić','Beograd',NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('033','Ana Jelenović','Beograd',NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('034','Julija Kojić',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('035','Kristina Koturanović',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('036','Tamara Urošević',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('037','Nikolija Čodanović',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('038','Jovana Georgievski',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('039','Boban Stojanović','Beograd','FPN',NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('040','Strahinja Mavrenski','Beograd',NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('041','Ana Stevanović',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('042','Katarina Tadić',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('043','Ivan Ratković',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('044','Stefan Petrović',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('045','Jelena Radivojević',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('046','Dejan Ćupurdija',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('047','Magdalena Ivanović',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('048','Vesna Radojević',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('049','Aleksandar Đokić',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('050','Vladimir Mitrović',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('051','Marija Vukićević',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('052','Atlas Network',NULL,NULL,NULL,NULL,NULL);
INSERT INTO Autori(ID_autora,Ime_i_prezime,Mesto,Organizacija,Email,Telefon,Slika) VALUES ('053','Vanja Ratković',NULL,NULL,NULL,NULL,NULL);

-- Unošenje podataka za tabelu Sadržaj --

INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S001','CAAS Akademija političke filozofije','Reklama','Video',001,'https://www.youtube.com/watch?v=QKa_NJXAjtg&t=1s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S002','Teorija države','Lekcija','Video',002,'https://www.youtube.com/watch?v=ix7MYZaWrOw&t=49s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S003','Institucionalizam','Lekcija','Video',003,'https://www.youtube.com/watch?v=vZ5Rvtf2DxM&t=105s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S004','Teorije moći','Lekcija','Video',004,'https://www.youtube.com/watch?v=br0_ailI4Ko&t=1767s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S005','Autoritarizam i populizam','Lekcija','Video',001,'https://www.youtube.com/watch?v=UwuiIqxQkcA&t=155s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S006','Ekonomska istorija SFRJ','Lekcija','Video',005,'https://www.youtube.com/watch?v=0-4lEnGA-c4&t=76s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S007','Istorija ekonomske misli','Lekcija','Video',006,'https://www.youtube.com/watch?v=ruH98QAbsqA&t=354s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S008','Pravo i pravda','Lekcija','Video',007,'https://www.youtube.com/watch?v=C3jYBkbh38k&t=33s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S009','Demokratija','Lekcija','Video',008,'https://www.youtube.com/watch?v=DA9APLtAHx8&t=22s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S010','Ljudi na misiji','Film','Video',009,'https://www.youtube.com/watch?v=5R6jZl6pJ10&t=50s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S011','Pravo na rad','Film','Video',010,'https://www.youtube.com/watch?v=lw9_0nF8Ic8&t=54s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S012','Reportaža "Pravo na rad"','Vesti','Video',025,'https://www.youtube.com/watch?v=l6MH7xHP_Tg&t=1s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S013','Tribina "Pravo na rad"','Tribina','Video',025,'https://www.youtube.com/watch?v=24NfN9vU65A&t=288s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S014','Intervju Aleksandar Stevanović','Intervju','Video',001,'https://www.youtube.com/watch?v=ZkDkAW_CuHE&t=10s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S015','Intervju Ivan Despotović','Intervju','Video',010,'https://www.youtube.com/watch?v=qhqrshVr8po&t=31s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S016','Intervju Ivana Pavlović','Intervju','Video',001,'https://www.youtube.com/watch?v=_N4msv3jrnw&t=1s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S017','Intervju Ljupka Mihajlovska','Intervju','Video',001,'https://www.youtube.com/watch?v=_sylWAMrGTc&t=3s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S018','Reklama Draža Petrović','Reklama','Video',011,'https://www.youtube.com/watch?v=3q9ZQ476xTg&t=3s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S019','Novinarstvo u dnevnoj štampi','Lekcija','Video',011,'https://www.youtube.com/watch?v=7L3zMa-K1Vc&t=20s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S020','Reklama Jovana Gligorijević','Reklama','Video',012,'https://www.youtube.com/watch?v=QFudlJWxM3E&t=4s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S021','Novinarstvo u nedeljniku','Lekcija','Video',012,'https://www.youtube.com/watch?v=A0QGxHZQCvw&t=21s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S022','Reklama Idro Seferi','Reklama','Video',013,'https://www.youtube.com/watch?v=e8xvITZU8LA&t=37s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S023','Reportaža i istraživanje','Lekcija','Video',013,'https://www.youtube.com/watch?v=5cs0Lp0BiEI&t=42s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S024','Reklama Slobodan Georgiev','Reklama','Video',014,'https://www.youtube.com/watch?v=sfBiuLm4lNI');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S025','Novinarstvo i javni interes','Lekcija','Video',014,'https://www.youtube.com/watch?v=msLPghsQDqw&t=1s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S026','Reklama Aleksandar Đorđević','Reklama','Video',015,'https://www.youtube.com/watch?v=XEF5EL8pBqs');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S027','Anatomija istraživačke priče','Lekcija','Video',015,'https://www.youtube.com/watch?v=gYdapBu32tg&t=4s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S028','Reklama Stevan Dojčinović','Reklama','Video',016,'https://www.youtube.com/watch?v=tdzRhzNfAoA&t=6s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S029','Intervju Nemanja Radivojević','Intervju','Video',010,'https://www.youtube.com/watch?v=fujNHctJ5JI');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S030','Tehnike istraživačkog novonarstva','Lekcija','Video',016,'https://www.youtube.com/watch?v=Zitn94ehCm8&t=6s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S031','Reklama Miloš Milovanović','Reklama','Video',017,'https://www.youtube.com/watch?v=94kcwVkCJuI&t=3s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S032','Predstavljanje knjige Socijalizam: propala ideja koja ne odumire','Vlog','Video',001,'https://www.youtube.com/watch?v=JUUlCaUnaiU&t=7s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S033','Tehnike javnog nastupa','Lekcija','Video',017,'https://www.youtube.com/watch?v=aNsUPdJsvPE&t=9s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S034','Tribina "Afera Krušik i pritisci na medije 2019"','Tribina','Video',025,'https://www.youtube.com/watch?v=buXUmx2KpNw&t=11s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S035','Tribina "Najbolje istraživačke priče 2019"','Tribina','Video',025,'https://www.youtube.com/watch?v=dGlTWVhTo3c&t=14s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S036','Tribina "Dometi medijske strategije 2019"','Tribina','Video',025,'https://www.youtube.com/watch?v=a6cw7nej7iQ&t=13s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S037','Intervju Vojislav Stevanović','Intervju','Video',001,'https://www.youtube.com/watch?v=sKEDdBAkBoQ');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S038','Intervju Vuk Cvijić','Intervju','Video',001,'https://www.youtube.com/watch?v=V7P9XVbApyQ');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S039','Intervju Katarina Živanović','Intervju','Video',001,'https://www.youtube.com/watch?v=uX875utQS-0');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S040','Intervju Dragana Pećo','Intervju','Video',001,'https://www.youtube.com/watch?v=a5QnNruGkBk');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S041','Intervju Milica Šarić','Intervju','Video',001,'https://www.youtube.com/watch?v=T3MW4nM7VRs');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S042','Intervju Natalija Jovanović','Intervju','Video',001,'https://www.youtube.com/watch?v=r5Cfo8ZibN0');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S043','Intervju Nedim Sejdinović','Intervju','Video',001,'https://www.youtube.com/watch?v=MbaRVKaIOck');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S044','Indeks autoritarnog populizma 2018','Vesti','Tekst',001,'https://www.caas.rs/indeks-autoritarnog-populizma/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S045','Putešestvije Mojsija Đukanovića','Blog','Tekst',001,'https://www.caas.rs/putesestvije-mojsija-dukanovica/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S046','Šta koči liberalizaciju','Blog','Tekst',018,'https://www.caas.rs/sta-koci-liberalizaciju/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S047','Svak je rođen da po jednom umre - državni udar živi dovjeka','Blog','Tekst',001,'https://www.caas.rs/svak-je-roden-da-po-jednom-umre-drzavni-udar-zivi-dovjeka/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S048','Od ranije poznati građanima','Blog','Tekst',010,'https://www.caas.rs/od-ranije-poznati-gradanima/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S049','Kad više nema nade, jedino što imamo je nada','Blog','Tekst',010,'https://www.caas.rs/kad-vise-nema-nade-jedino-sto-imamo-je-nada/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S050','Pravo na sreću','Blog','Tekst',010,'https://www.caas.rs/pravo-na-srecu/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S051','Slavska politikologija','Blog','Tekst',010,'https://www.caas.rs/slavska-politikologija/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S052','Ne postoji ono što se nedovoljno želi','Blog','Tekst',010,'https://www.caas.rs/ne-postoji-ono-sto-se-nedovoljno-zeli/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S053','Poslednji čas','Blog','Tekst',010,'https://www.caas.rs/poslednji-cas/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S054','Valorizacija kulture na crnogorski način','Blog','Tekst',020,'https://www.caas.rs/valorizacija-kulture-na-crnogorski-nacin/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S055','Free trade for a just world - Serbia','Vlog','Video',010,'https://www.youtube.com/watch?v=nl1SuTkXcJM&feature=youtu.be&fbclid=IwAR0AtJTWWtI382KdD5vLatBvYyWmaSgZd8cGqN-hpY5jZ0SIZjJURdbUK1A');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S056','Sims: napredna verzija','Blog','Tekst',021,'https://www.caas.rs/sims-napredna-verzija/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S057','Nemamo bolju Srbiju','Blog','Tekst',010,'https://www.caas.rs/nemamo-bolju-srbiju/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S058','Trideset godina od pada Zida - Evropa na raskrsnici','Vesti','Tekst',025,'https://www.caas.rs/trideset-godina-od-pada-zida-evropa-na-raskrsnici/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S059','Tajna slobode','Blog','Tekst',010,'https://www.caas.rs/tajna-slobode/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S060','Vikar Vučićevog petka','Blog','Tekst',010,'https://www.caas.rs/vikar-vucicevog-petka/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S061','Govori slobodno','Blog','Tekst',018,'https://www.caas.rs/govori-slobodno/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S062','Drugo zašto','Blog','Tekst',010,'https://www.caas.rs/drugo-zasto/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S063','Jeste hladno, ali mora da se izdrži','Blog','Tekst',010,'https://www.caas.rs/jeste-hladno-ali-mora-da-se-izdrzi/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S064','Koalicija za propast - posao u Rusiji','Blog','Tekst',010,'https://www.caas.rs/koalicija-za-propast-posao-u-rusiji/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S065','Probali smo - upoznati Gorbačova','Blog','Tekst',010,'https://www.caas.rs/probali-smo-upoznati-gorbacova/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S066','Kad istekne rok, stavi drugu etiketu','Blog','Tekst',018,'https://www.caas.rs/kad-istekne-rok-stavi-drugu-etiketu/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S067','Černobilj - bezbedno za gledanje bez zaštitne opreme, posebno bez ružičastih naočara','Blog','Tekst',010,'https://www.caas.rs/cernobilj/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S068','Destabilokratija','Blog','Tekst',010,'https://www.caas.rs/destabilokratija/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S069','Pod njegovim okom - nova sezona Sluškinjine priče','Blog','Tekst',010,'https://www.caas.rs/pod-njegovim-okom-nova-sezona-sluskinjine-price/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S070','Kud koji, mili moji','Blog','Tekst',010,'https://www.caas.rs/drzava-bez-drustva/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S071','Konkurs za eseje - Akademija političke filozofije','Konkurs','Tekst',025,'https://www.caas.rs/konkurs-za-eseje-akademija-politicke-filozofije/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S072','Intervju Adam Barta','Intervju','Tekst',001,'https://www.caas.rs/sumnjam-da-ce-srbija-uskoro-biti-deo-eu/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S073','Armija kontrolora','Blog','Tekst',010,'https://www.caas.rs/armija-kontrolora/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S074','Razočarani i ljuti','Blog','Tekst',010,'https://www.caas.rs/razocarani-i-ljuti/https:/www.caas.rs/crnac-u-kuci-slon-u-sobi/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S075','Crnac u kući i slon u sobi','Blog','Tekst',010,'https://www.caas.rs/crnac-u-kuci-slon-u-sobi/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S076','Kapitalizam - "bolesnik koji umire" već dva i po veka?','Esej','Tekst',022,'https://www.caas.rs/kapitalizam-bolesnik-koji-umire-vec-dva-po-veka/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S077','Sve boje bogorodice','Blog','Tekst',019,'https://www.caas.rs/sve-boje-bogorodice/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S078','Ponovno buđenje nacionalnih država ili njihov poslednji trzaj (Evropa od 2016. do danas)?','Esej','Tekst',023,'https://www.caas.rs/ponovno-budenje-nacionalnih-drzava-ili-njihov-poslednji-trzaj-evropa-od-2016-danas/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S079','Autoritarni populizam - izazov evropskim vrednostima ili bauk?','Esej','Tekst',024,'https://www.caas.rs/autoritarni-populizam-izazov-evropskim-vrednostima-ili-bauk/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S080','Zarobljeni u bedi','Blog','Tekst',010,'https://www.caas.rs/zarobljeni-u-bedi/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S081','(Ne)samostalno određivanje pravila','Blog','Tekst',018,'https://www.caas.rs/nesamostalno-odredivanje-pravila/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S082','Šta smo (u)radili 2019.','Vesti','Tekst',025,'https://www.caas.rs/sta-smo-uradili-2019/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S083','KO O ČEMU, ZAKON O POŠTENJU','Vlog','Video',026,'https://www.youtube.com/watch?v=5u7ZAF5LVoI');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S084','BEOGRADSKI IZBORI 2018 - INTERVJU SA BOBANOM STOJANOVIĆEM','Intervju','Video',027,'https://www.youtube.com/watch?v=oFiQgQfgIl8');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S085','REFORMA USTAVA ILI CAREVO NOVO ODELO - INTERVJU SA STRAHINJOM MAVRENSKIM','Intervju','Video',001,'https://www.youtube.com/watch?v=RP0C_5gjbBQ');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S086','HAOS U SKUPŠTINI! - INTERVJU SA DR ANOM STEVANOVIĆ','Intervju','Video',009,'https://www.youtube.com/watch?v=kEER5CHnQq4');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S087','EVROINTEGRACIJE I DIJALOG O KOSOVU - INTERVJU SA KATARINOM TADIĆ','Intervju','Video',001,'https://www.youtube.com/watch?v=kzF8_Hezcq4');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S088','RAT PROTIV MAFIJE, ALI NE ONE NA VLASTI - INTERVJU SA JELENOM RADIVOJEVIĆ (KRIK)','Intervju','Video',027,'https://www.youtube.com/watch?v=NorJtWkTOyQ');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S089','CAAS NA LIBERTYCON-U U BEOGRADU 2018','Reportaža','Video',025,'https://www.youtube.com/watch?v=A4BTb1jZa-I');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S090','KAKO NARODI POSTAJU BOGATI? - DEIRDRE MCCLOSKEY','Intervju','Video',001,'https://www.youtube.com/watch?v=qkbdRhhsoTA');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S091','RAT PROTIV DROGE JE LAŽ - MARK "PRINCE OF POT" EMERY','Intervju','Video',009,'https://www.youtube.com/watch?v=dgh9FfPCiCk');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S092','LAŽNE VESTI, POSTISTINA I RAT KOJI SAMO ŠTO NIJE - INTERVJU SA VESNOM RADOJEVIĆ (KRIK)','Intervju','Video',009,'https://www.youtube.com/watch?v=aXUgVjv-PUA');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S093','LJUDI IMAJU PRAVO DA PROMENE VLAST - JAMES LARK','Intervju','Video',001,'https://www.youtube.com/watch?v=uvch9DDysT0');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S094','TERRY KIBBE @LIBERTYCON 2018.','Intervju','Video',009,'https://www.youtube.com/watch?v=yi6zg0FOEIk');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S095','EVROPSKA UNIJA - ZA ILI PROTIV?','Intervju','Video',001,'https://www.youtube.com/watch?v=vD4wSlY81l4');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S096','YARON BROOKE @LIBERTYCON 2018.','Intervju','Video',009,'https://www.youtube.com/watch?v=IJ8VAOAFZ-Q');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S097','IVANA JEREMIĆ @LIBERTYCON 2018.','Intervju','Video',009,'https://www.youtube.com/watch?v=ymXLDFbdSO4');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S098','TANJA PORČNIK @LIBERTYCON 2018.','Intervju','Video',001,'https://www.youtube.com/watch?v=xLrXqPLsRx8');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S099','FREE MARKET ROADSHOW - EKONOMSKI FAKULTET, BEOGRAD 2018.','Reportaža','Video',025,'https://www.youtube.com/watch?v=5T0n9gAVMQg');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S100','RICARDO AVELAR @LIBERTYCON 2018.','Intervju','Video',009,'https://www.youtube.com/watch?v=ntHZLVF1tW4');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S101','BRIAN O''SHEA @LIBERTYCON 2018.','Intervju','Video',001,'https://www.youtube.com/watch?v=z81gYOxVRyc');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S102','DAVID FRIEDMAN @LIBERTYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=OCCaAGxRB7s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S103','PIETER CLEPPE @FREE MARKET ROADSHOW','Intervju','Video',009,'https://www.youtube.com/watch?v=k416z34CIY4');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S104','MARIO FANTINI @FREE MARKET ROADSHOW','Intervju','Video',010,'https://www.youtube.com/watch?v=-qK3bsUXmwc');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S105','NIMA SANANDAJI @FREE MARKET ROADSHOW','Intervju','Video',010,'https://www.youtube.com/watch?v=rocqzgMr2-s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S106','DANICA POPOVIĆ @FREE MARKET ROADSHOW','Intervju','Video',009,'https://www.youtube.com/watch?v=xuX6Jvc7caw');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S107','JELENA PAVLOVIĆ @FREE MARKET ROADSHOW','Intervju','Video',009,'https://www.youtube.com/watch?v=IRqKDBtkq6M');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S108','MATHILDE BERGER-PERRIN @LIBERTYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=tWItc678ikE');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S109','MARIA CHAPLIA @LIBERTYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=-UQcJh4brZo');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S110','ADMIR ČAVALIĆ @LIBERTYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=KYOX2cOvRjI');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S111','MARIAM GOGOLSHILI @LIBERTYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=8fU7YuAydV8');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S112','TIM ANDREWS @LIBERTYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=sIQiy9rtweE');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S113','ALEKSANDAR KOKOTOVIĆ @LIBERTYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=glSaSHe-EhI');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S114','WOLF VON LAER @LIBERYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=66ScKeylYWM');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S115','MILOŠ NIKOLIĆ @LIBERTYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=4GO564t76WM');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S116','KATE ANDREWS @LIBERTYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=GghI2joob7s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S117','LIBERTY FORUM - THINK TANK SHARK TANK, COPENHAGEN 2018.','Reportaža','Video',025,'https://www.youtube.com/watch?v=Bo7pGsC1Txo');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S118','LINDA WHETSTONE @LIBERTY FORUM, COPENHAGEN 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=128MSUksFjk');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S119','TOM PALMER @LIBERTY FORUM, COPENHAGEN 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=aCg5V1HJdXQ');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S120','BARBARA COLM @LIBERTY FORUM, COPENHAGEN 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=qU8FK4fVEoA');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S121','LAWSON BADER @LIBERTY FORUM, COPENHAGEN 2018.','Intervju','Video',010,NULL);
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S122','JULIO ALEJANDRO @LIBERTYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=Qt8pmAOLF8g');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S123','ALEKSA BURMAZOVIĆ @LIBERTYCON 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=eqOkVrO7Vns');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S124','KARIN SVANBORG SJOVALL @LIBERTY FORUM, COPENHAGEN 2018.','Intervju','Video',010,'https://www.youtube.com/watch?v=lZ6G2GfagNM');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S125','ZAR I BLEJANJE IMA CENU?','Animacija','Video',025,'https://www.youtube.com/watch?v=cz_5r2LXL5s');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S126','NAPREDNA PRETRAGA DRUŠTVENIH MREŽA','Lekcija','Video',028,'https://www.youtube.com/watch?v=dpRHZz5qDok');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S127','PRAVO I GRAĐANSKO NOVINARSTVO','Lekcija','Video',029,'https://www.youtube.com/watch?v=9qlzoQTQtbQ');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S128','GRAĐANSKO NOVINARSTVO 101 - IZVORI I TEME','Lekcija','Video',016,'https://www.youtube.com/watch?v=wGuHXpjj2EY');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S129','BEZBEDNOST U GRAĐANSKOM NOVINARSTVU','Lekcija','Video',030,'https://www.youtube.com/watch?v=Ya8qwTmv09k');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S130','FACT-CHECKING I KAKO PREPOZNATI LAŽNE VESTI','Lekcija','Video',031,'https://www.youtube.com/watch?v=hC56fend1TE');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S131','CAAS AKADEMIJA GRAĐANSKOG NOVINARSTVA','Reklama','Video',028,'https://www.youtube.com/watch?v=DopgXWbvhPE');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S132','BAZE PODATAKA KAO IZVOR INFORMACIJA','Lekcija','Video',032,'https://www.youtube.com/watch?v=lA8Z4nbpWh0');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S133','ZAPOŠLJAVANJE MLADIH: SLUČAJ "ČEKAJUĆI GODOA"','GrađanskaReportaža','Video',033,'https://www.youtube.com/watch?v=usleltB2szM');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S134','ZLOUPOTREBE U RADU OMLADINSKIH ZADRUGA','GrađanskaReportaža','Video',034,'https://www.youtube.com/watch?v=nfEi7p4fah0');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S135','KOSOVSKA MITROVICA, ŠTA SAD?','GrađanskaReportaža','Video',035,'https://www.youtube.com/watch?v=uou8Zrfvj9g');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S136','TRGOVINA LJUDIMA U SRBIJI','GrađanskaReportaža','Video',036,'https://www.youtube.com/watch?v=iSPy8yscPFw');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S137','KOLIKO KOŠTA STUDENTSKA DIPLOMA?','GrađanskaReportaža','Video',021,'https://www.youtube.com/watch?v=axlrBBhz0j4');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S138','ZAŠTO (NE)PROPADA BAZEN BANJICA?','GrađanskaReportaža','Video',037,'https://www.youtube.com/watch?v=VAziIs_eBdc');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S139','PUŠTENI PSI I KARIKATURE SA HITLEROM','GrađanskaReportaža','Video',038,'https://www.youtube.com/watch?v=4zGJn-CLPQ8');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S140','ANTONELA RIHA NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Intervju','Video',021,'https://www.youtube.com/watch?v=e04SA5Z89g8');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S141','JOVANA GLIGORIJEVIĆ (VREME) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Intervju','Video',021,'https://www.youtube.com/watch?v=jamAqK_Rqos');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S142','VESNA MALIŠIĆ (NIN) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Intervju','Video',021,'https://www.youtube.com/watch?v=fTL903wGARI');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S143','DINA ĐORĐEVIĆ (CINS) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Intervju','Video',037,'https://www.youtube.com/watch?v=zQW4mNopZ5M');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S144','STEVAN DOJČINOVIĆ (KRIK) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Intervju','Video',037,'https://www.youtube.com/watch?v=0VD-9KGHRCw');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S145','BOJAN CVEJIĆ (DANAS) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Intervju','Video',037,'https://www.youtube.com/watch?v=_f7Dbxl0VsM');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S146','MILAN ZIROJEVIĆ (JUŽNE VESTI) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Intervju','Video',035,'https://www.youtube.com/watch?v=Feqw6PACsFQ');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S147','MILICA ŠARIĆ (CINS) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Intervju','Video',035,'https://www.youtube.com/watch?v=91oMP9Q8LKk');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S148','TEŠA TEŠANOVIĆ (BALKAN INFO) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Intervju','Video',035,NULL);
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S149','PANEL "SLOBODA MEDIJA U SRBIJI" 15.12.2018.','Tribina','Video',025,'https://www.youtube.com/watch?v=RQdL_rJfGcQ');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S150','PANEL "NAJBOLJE ISTRAŽIVAČKE PRIČE U 2018" 15.12.2018.','Tribina','Video',025,'https://www.youtube.com/watch?v=GHyP8xkpkV4');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S151','PANEL "BEZBEDNOST NOVINARA U 2018" 15.12.2018.','Tribina','Video',025,'https://www.youtube.com/watch?v=QovPLskfEkE');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S152','IZBORI U BEOGRADU: KAMPANJA I AKTERI','Blog','Tekst',039,'https://www.caas.rs/izbori-u-beogradu-kampanja-akteri/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S153','REFORMA USTAVA: CAREVO NOVO ODELO','Blog','Tekst',040,'https://www.caas.rs/blog-strahinja-mavrenski-reforma-ustava-carevo-novo-odelo/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S154','KRAĐA VREMENA I GLASANJE NA ZVONCE: ZLOUPOTREBA SKUPŠTINSKIH PROCEDURA','Blog','Tekst',041,'https://www.caas.rs/blog-dr-ana-stevanovic-krada-vremena-glasanje-na-zvonce-zloupotreba-skupstinskih-procedura/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S155','DIJALOG BEOGRADA I PRIŠTINE: RAT DRUGIM SREDSTVIMA ILI ISTINSKA NORMALIZACIJA?','Blog','Tekst',042,'https://www.caas.rs/dijalog-beograda-pristine-rat-drugim-sredstvima-ili-istinska-normalizacija/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S156','KOMUNIZAM ĆE UVEK BITI NASILAN','Animacija','Video',025,'https://www.caas.rs/komunizam-ce-uvek-biti-nasilan/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S157','O GOVORU MRŽNJE','Blog','Tekst',043,'https://www.caas.rs/ivan-ratkovic-o-govoru-mrznje/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S158','POVAMPIRENI TANJUG I DONOŠENJE NOVE MEDIJSKE STRATEGIJE U SENCI NEPOŠTOVANJA PRETHODNE','Blog','Tekst',044,'https://www.caas.rs/povampireni-tanjug-donosenje-nove-medijske-strategije-u-senci-nepostovanja-prethodne/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S159','RAT PROTIV MAFIJE, ALI NE ONE NA VLASTI','Blog','Tekst',045,'https://www.caas.rs/rat-protiv-mafije-ali-ne-one-na-vlasti/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S160','UJEDINJENI U NESLAGANJU: O KULTURI JAVNE DEBATE','Blog','Tekst',046,'https://www.caas.rs/ujedinjeni-u-neslaganju-o-kulturi-javne-debate/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S161','DINO JAHIĆ: KORUPCIJA JE APSOLUTNO ZASTUPLJENA U SVAKOM SEGMENTU OVOG DRUŠTVA','Intervju','Tekst',047,'https://www.caas.rs/dino-jahic-korupcija-je-apsolutno-zastupljena-u-svakom-segmentu-ovog-drustva/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S162','ČIJI JE NIŠKI AERODROM?','Intervju','Tekst',044,'https://www.caas.rs/ciji-je-niski-aerdorom/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S163','ZNATE LI KOLIKO LJUDI JE UBIO KOMUNIZAM?','Reklama','Video',025,NULL);
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S164','POSUMNJAJTE I PROVERITE DA BISTE PROGLEDALI','Blog','Tekst',048,'https://www.caas.rs/posumnjajte-i-proverite-da-biste-progledali/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S165','MINISTARSTVO ZA OPSTANAK U SRBIJI','KolumnaDanas','Tekst',010,'https://www.danas.rs/dijalog/licni-stavovi/ministarstvo-za-opstanak-u-srbiji/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S166','NIŠLIJE PONOVO NA ULICAMA: "NE DAMO AERODROM!"','Blog','Tekst',044,'https://www.caas.rs/nislije-ponovo-na-ulicama-ne-damo-aerodrom/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S167','PODIGNIMO U VIS ČELA, MI - JUNACI RADA SVOG','Blog','Tekst',010,'https://www.caas.rs/podignimo-u-vis-cela-mi-junaci-rada-svog/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S168','KADA SE SLIKOVNICA ZAMERI NATALITETU','Blog','Tekst',044,'https://www.caas.rs/kad-se-slikovnica-zameri-natalitetu/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S169','NEŠTO OPASNO NIJE U REDU SA TVOJOM DRŽAVOM','KolumnaDanas','Tekst',010,'https://www.danas.rs/dijalog/licni-stavovi/nesto-opasno-nije-u-redu-sa-tvojom-drzavom/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S170','JUŽNE VESTI META PORESKE UPRAVE, INSPEKTORI OTIŠLI KORAK DALJE','Intervju','Tekst',049,'https://www.caas.rs/juzne-vesti-meta-poreske-uprave-inspektori-otisli-korak-dalje/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S171','AKO SE VI NE BAVITE POLITIKOM, ONA SE BAVI VAMA','KolumnaDanas','Tekst',010,'https://www.danas.rs/dijalog/licni-stavovi/ako-se-vi-ne-bavite-politikom-ona-se-bavi-vama/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S172','DRŽAVA JE NAJVEĆI KRIMINALAC','Intervju','Tekst',050,'https://www.caas.rs/drzava-je-najveci-kriminalac/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S173','BOG JE STVORIO LJUDE, ALI IH CZ 99 ČINI RAVNOPRAVNIM','Intervju','Tekst',025,'https://www.caas.rs/bog-je-stvorio-ljude-ali-ih-cz-99-cini-ravnopravnim/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S174','NE ZNAMO ŠTA NAS JE SNAŠLO','KolumnaDanas','Tekst',010,'https://www.danas.rs/dijalog/licni-stavovi/neznamo-sta-nas-je-snaslo/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S175','VESELO, KAO NA AUTOPSIJI','Intervju','Tekst',051,'https://www.caas.rs/veselo-kao-na-autopsiji/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S176','RATKO NIKOLIĆ’S SELFIE CITIZEN JOURNALISM PROJECT WINS 2018 EUROPE THINK TANK SHARK TANK COMPETITION','Vesti','Tekst',052,'https://www.atlasnetwork.org/news/article/ratko-nikolis-selfie-citizen-journalism-project-wins-2018-europe-think-tank');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S177','PROJEKAT "SELFI GRAĐANSKO NOVINARSTVO" - POBEDNIK MEĐUNARODNOG TAKMIČENJA U KOPENHAGENU','Vesti','Tekst',025,'https://www.caas.rs/caas-ov-novi-projekat-selfi-gradansko-novinarstvo-pobednik-medunarodnog-takmicenja-u-kopenhagenu/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S178','ZAŠTO U SRBIJI IZOSTAJU MASOVNI PROTESTI?','KolumnaDanas','Tekst',010,'https://www.danas.rs/dijalog/licni-stavovi/zasto-u-srbiji-izostaju-masovni-protesti/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S179','(K)VARLJIVO LETO ''68.','Blog','Tekst',043,'https://www.caas.rs/kvarljivo-leto-68/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S180','PARALELNI UNIVERZUM','Blog','Tekst',010,'https://www.caas.rs/paralelni-univerzum/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S181','TRŽIŠNA PRAVILA BI TREBALO DA VAŽE ZA SVE','Intervju','Tekst',025,'https://www.caas.rs/trzisna_pravila_bi_trebalo_da_vaze_za_sve/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S182','KRIMIĆ SE NASTAVLJA - LAŽNI NESTANAK NESTALOG NOVINARA','Blog','Tekst',044,'https://www.caas.rs/krimic-se-nastavlja-lazni-nestanak-nestalog-novinara/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S183','SPORTSKI RIBOLOV I ORGANIZOVANI KRIMINAL','Blog','Tekst',010,'https://www.caas.rs/sportski-ribolov-organizovani-kriminal/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S184','AKO MI DOĐEMO NA VLAST…','Blog','Tekst',010,'https://www.caas.rs/ako-mi-dodemo-na-vlast/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S185','DUBOKA DRŽAVA I PLITKA DRŽAVA','Blog','Tekst',043,'https://www.caas.rs/duboka-drzava-plitka-drzava/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S186','BOSTONSKA ČAJANKA','Blog','Tekst',010,NULL);
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S187','U DIVLJINI SE UMIRE OD SRAMOTE','Blog','Tekst',010,'https://www.caas.rs/u-divljini-se-umire-od-sramote/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S188','POTONUO JE OVAJ TITANIK','Blog','Tekst',021,'https://www.caas.rs/potonuo-je-ovaj-titanik/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S189','U EU ČOKOLADA NIJE ČOKOLADA AKO NIJE PO NEMAČKIM STANDARDIMA','Intervju','Tekst',001,'https://www.caas.rs/u-eu-cokolada-nije-cokolada-ako-nije-po-nemackim-standardima/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S190','VODIČ ZA INTERACIJU SA POLICIJOM','Blog','Tekst',019,'https://www.caas.rs/vodic-za-interakciju-sa-policijom/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S191','CIRKUS SPOLJNE POLITIKE','Blog','Tekst',001,'https://www.caas.rs/cirkus-spoljne-politike/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S192','KOLIKO NOVA MEDIJSKA STRATEGIJA MOŽE DA UTIČE NA MEDIJE U SRBIJI?','Blog','Tekst',049,'https://www.caas.rs/koliko-nova-medijska-strategija-moze-da-utice-na-medije/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S193','POPULIZAM ĆEMO ZAMENITI POPULIZMOM','Blog','Tekst',018,'https://www.caas.rs/populizam-cemo-zameniti-populizmom/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S194','ČIJE INTERESE ŠTITI "MINIMALAC"?','Animacija','Video',025,NULL);
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S195','NIKOLA JELIĆ - MIKRI MAUS: NAŠA MUZIKA JE ANTIPROPAGANDA SVEGA','Intervju','Tekst',053,'https://www.caas.rs/nikola-jelic-mikri-maus-nasa-muzika-je-antipropaganda-svega/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S196','ZID U GLAVI','Blog','Tekst',010,'https://www.caas.rs/zid-u-glavi/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S197','SVET PREVAZILAZI LJUDSKU MISAO','Intervju','Tekst',010,'https://www.caas.rs/svet-prevazilazi-ljudsku-misao/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S198','TRI LUSTRACIJE ZA GOSPODINA','Blog','Tekst',010,'https://www.caas.rs/tri-lustracije-za-gospodina/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S199','KONKURS ZA CAAS ŠKOLU NOVINARSTVA 2018.','Konkurs','Tekst',025,'https://www.caas.rs/konkurs-za-caas-skolu-novinarstva-2018/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S200','POPULIZAM JE POSLEDICA CENTRALIZACIJE','Intervju','Tekst',010,'https://www.caas.rs/populizam-je-posledica-centralizacije/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S201','ISKUSTVA POLAZNIKA - CAAS ŠKOLA NOVINARSTVA 2017.','Intervju','Video',025,'https://www.caas.rs/media-matters-2017-caas-skola-novinarstva-praksa-u-krik-u-iskustva-polaznika/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S202','BEZ STRASTI NE VREDI NI POČINJATI','Intervju','Tekst',010,'https://www.caas.rs/ne-vredi-pocinjati-nesto-bez-strasti/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S203','BUDUĆNOST TURSKE NIJE SVETLA','Intervju','Tekst',010,'https://www.caas.rs/buducnost-turske-nije-svetla/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S204','NIJE MUDRO KLADITI SE PROTIV TRAMPA','Intervju','Tekst',009,'https://www.caas.rs/nije-mudro-kladiti-se-protiv-trampa/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S205','JOVANA GLIGORIJEVIĆ - DANAS JE JAKO TEŠKO BITI POLITIČKI NOVINAR','Intervju','Tekst',049,'https://www.caas.rs/jovana-gligorijevic-danas-je-jako-tesko-biti-politicki-novinar-zato-sto-ste-vi-prinudeni-stalno-da-krsite-jedno-od-osnovnih-pravila-profesije-je-da-imate-drugu-stranu/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S206','MIT O SKANDINAVSKOM SOCIJALIZMU I KREATIVNA DESTRUKCIJA','Blog','Tekst',043,'https://www.caas.rs/mit-o-skandinavskom-socijalizmu-kreativna-destrukcija/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S207','FONDACIJU IMAŠ, A ČLANSKU KARTU NEMAŠ','Blog','Tekst',010,'https://www.caas.rs/fondaciju-imas-clansku-kartu-nemas/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S208','SUBVENCIJE SU POKLANJANJE SOPSTVENOG NOVCA STRANCIMA','Intervju','Tekst',010,'https://www.caas.rs/subvencije-su-poklanjanje-sopstvenog-novca-strancima/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S209','SELFI GRAĐANSKO NOVINARSTVO','Konkurs','Tekst',025,'https://www.caas.rs/selfi-gradansko-novinarstvo/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S210','MEDIJSKI FRAS','Blog','Tekst',010,'https://www.caas.rs/1352-2/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S211','PUSTOŠ NEKONSOLIDOVANE DEMOKRATIJE','Blog','Tekst',010,'https://www.caas.rs/pustos-nekonsolidovane-demokratije/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S212','POZIVAMO VAS NA KONFERENCIJU "SLOBODA MEDIJA U SRBIJI 2018" 15. DECEMBRA U MEDIJA CENTRU','Vesti','Tekst',025,'https://www.caas.rs/pozivamo-vas-na-konferenciju-sloboda-medija-u-srbiji-2018-15-decembra-u-medija-centru/');
INSERT INTO Sadržaj(ID_sadržaja,Naslov,Tip_sadržaja,Format,ID_autora,Link) VALUES ('S213','NASILJE NAD NOVINARIMA I MEDIJIMA NIJE METAFORA','Izveštaj','Tekst',025,'https://www.caas.rs/nasilje-nad-novinarima-medijima-nije-metafora/');

-- Unos podataka za tabelu Isplate --

INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I001','07/06/2019',23500,002,'S002',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I002','07/06/2019',47000,003,'S003','Pregledanje eseja','Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I003','07/06/2019',23500,004,'S004',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I004','07/06/2019',23500,005,'S006',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I005','07/06/2019',23500,006,'S007',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I006','07/06/2019',23500,007,'S008',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I007','07/06/2019',23500,008,'S009',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I008','03/12/2019',23500,011,'S019',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I009','03/12/2019',23500,012,'S021',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I010','03/12/2019',23500,013,'S023',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I011','03/12/2019',23500,014,'S025',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I012','03/12/2019',23500,015,'S027',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I013','03/12/2019',23500,016,'S030',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I014','03/12/2019',47000,017,'S033',NULL,'Milena Marić');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I015','2019/09/19',11750,022,'S076',NULL,'Saša Mirković');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I016','2019/09/21',11750,023,'S078',NULL,'Saša Mirković');
INSERT INTO Isplate(ID_isplate,Datum_isplate,Visina_isplate,ID_autora,ID_sadržaja,Dodatne_aktivnosti,Odgovorno_lice) VALUES ('I017','2019/09/24',11750,024,'S079',NULL,'Saša Mirković');

-- Unos podataka za tabelu Objave --

INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180105','F1/2018','KO O ČEMU, ZAKON O POŠTENJU','Facebook','S083',2527,66,0,0,86,12);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190108','F1/2019','Indeks autoritarnog populizma','Facebook','S044',525,9,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180326','F10/2018','O GOVORU MRŽNJE','Facebook','S157',340,27,0,1,9,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190319','F10/2019','Poslednji čas','Facebook','S053',1187,16,0,3,2,7);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181008','F100/2018','FONDACIJU IMAŠ, A ČLANSKU KARTU NEMAŠ','Facebook','S207',88,14,0,6,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181011','F101/2018','SUBVENCIJE SU POKLANJANJE SOPSTVENOG NOVCA STRANCIMA','Facebook','S208',68,25,0,1,1,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181024','F102/2018','SELFI GRAĐANSKO NOVINARSTVO','Facebook','S209',18,6,0,1,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181024','F103/2018','CAAS AKADEMIJA GRAĐANSKOG NOVINARSTVA','Facebook','S131',15764,149,0,39,3,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181025','F104/2018','MEDIJSKI FRAS','Facebook','S210',25,8,0,0,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181101','F105/2018','PUSTOŠ NEKONSOLIDOVANE DEMOKRATIJE','Facebook','S211',26,7,0,1,2,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181105','F106/2018','GRAĐANSKO NOVINARSTVO 101 - IZVORI I TEME','Facebook','S128',4307,55,0,3,5,16);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181107','F107/2018','BEZBEDNOST U GRAĐANSKOM NOVINARSTVU','Facebook','S129',2512,19,0,0,0,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181109','F108/2018','BAZE PODATAKA KAO IZVOR INFORMACIJA','Facebook','S132',3432,12,0,2,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181112','F109/2018','NAPREDNA PRETRAGA DRUŠTVENIH MREŽA','Facebook','S126',3297,43,0,2,4,7);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180328','F11/2018','POVAMPIRENI TANJUG I DONOŠENJE NOVE MEDIJSKE STRATEGIJE U SENCI NEPOŠTOVANJA PRETHODNE','Facebook','S158',535,54,0,8,8,9);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190321','F11/2019','Valorizacija kulture na crnogorski način','Facebook','S054',6714,61,0,10,0,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181114','F110/2018','FACT-CHECKING I KAKO PREPOZNATI LAŽNE VESTI','Facebook','S130',2873,11,0,1,1,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181119','F111/2018','PRAVO I GRAĐANSKO NOVINARSTVO','Facebook','S127',2944,12,0,2,8,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181129','F112/2018','POZIVAMO VAS NA KONFERENCIJU "SLOBODA MEDIJA U SRBIJI 2018" 15. DECEMBRA U MEDIJA CENTRU','Facebook','S212',345,61,0,2,6,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181211','F113/2018','KOSOVSKA MITROVICA, ŠTA SAD?','Facebook','S135',4337,27,0,4,3,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181211','F114/2018','ZLOUPOTREBE U RADU OMLADINSKIH ZADRUGA','Facebook','S134',3190,70,0,4,16,17);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181212','F115/2018','ZAPOŠLJAVANJE MLADIH: SLUČAJ "ČEKAJUĆI GODOA"','Facebook','S133',2118,27,0,3,3,8);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181212','F116/2018','TRGOVINA LJUDIMA U SRBIJI','Facebook','S136',3704,89,0,12,7,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181212','F117/2018','KOLIKO KOŠTA STUDENTSKA DIPLOMA?','Facebook','S137',3496,85,0,7,15,12);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181212','F118/2018','ZAŠTO (NE)PROPADA BAZEN BANJICA?','Facebook','S138',2725,33,0,8,7,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181212','F119/2018','PUŠTENI PSI I KARIKATURE SA HITLEROM','Facebook','S139',4114,49,0,4,0,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180331','F12/2018','EVROINTEGRACIJE I DIJALOG O KOSOVU - INTERVJU SA KATARINOM TADIĆ','Facebook','S087',3779,34,0,9,7,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190325','F12/2019','Free Trade for a Just World: Serbia','Facebook','S055',13923,22,0,2,7,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181216','F120/2018','ANTONELA RIHA NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Facebook','S140',1698,40,0,2,0,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181216','F121/2018','JOVANA GLIGORIJEVIĆ (VREME) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Facebook','S141',1759,34,0,3,2,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181216','F122/2018','VESNA MALIŠIĆ (NIN) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Facebook','S142',1499,21,0,1,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','F123/2018','MILAN ZIROJEVIĆ (JUŽNE VESTI) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Facebook','S146',1424,11,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','F124/2018','BOJAN CVEJIĆ (DANAS) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Facebook','S145',1518,14,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','F125/2018','MILICA ŠARIĆ (CINS) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Facebook','S147',1464,10,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','F126/2018','DINA ĐORĐEVIĆ (CINS) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Facebook','S143',1679,15,0,4,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','F127/2018','STEVAN DOJČINOVIĆ (KRIK) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Facebook','S144',1562,32,0,0,0,7);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','F128/2018','TEŠA TEŠANOVIĆ (BALKAN INFO) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Facebook','S148',3052,48,0,3,46,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181219','F129/2018','PANEL "SLOBODA MEDIJA U SRBIJI" 15.12.2018.','Facebook','S149',56,10,0,3,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180403','F13/2018','RAT PROTIV MAFIJE, ALI NE ONE NA VLASTI','Facebook','S159',1570,116,0,4,18,14);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190401','F13/2019','Sims: napredna verzija','Facebook','S056',1143,26,0,1,1,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181219','F130/2018','PANEL "NAJBOLJE ISTRAŽIVAČKE PRIČE U 2018" 15.12.2018.','Facebook','S150',31,7,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181219','F131/2018','PANEL "BEZBEDNOST NOVINARA U 2018" 15.12.2018.','Facebook','S151',54,6,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181219','F132/2018','NASILJE NAD NOVINARIMA I MEDIJIMA NIJE METAFORA','Facebook','S213',135,54,0,2,6,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180405','F14/2018','UJEDINJENI U NESLAGANJU: O KULTURI JAVNE DEBATE','Facebook','S160',514,61,0,4,13,11);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190402','F14/2019','Nemamo bolju Srbiju','Facebook','S057',829,10,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180409','F15/2018','RAT PROTIV MAFIJE, ALI NE ONE NA VLASTI - INTERVJU SA JELENOM RADIVOJEVIĆ (KRIK)','Facebook','S088',4101,63,0,9,17,18);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190412','F15/2019','Trideset godina od pada Zida - Evropa na raskrsnici','Facebook','S058',509,5,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180411','F16/2018','DINO JAHIĆ: KORUPCIJA JE APSOLUTNO ZASTUPLJENA U SVAKOM SEGMENTU OVOG DRUŠTVA','Facebook','S161',146,16,0,2,2,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190416','F16/2019','Tajna slobode','Facebook','S059',823,19,0,0,1,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180416','F17/2018','ČIJI JE NIŠKI AERODROM?','Facebook','S162',821,107,0,9,50,7);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190422','F17/2019','Vikar Vučićevog petka','Facebook','S060',16637,32,0,1,3,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180417','F18/2018','ZNATE LI KOLIKO LJUDI JE UBIO KOMUNIZAM?','Facebook','S163',13402,153,0,75,221,21);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190425','F18/2019','Govori slobodno','Facebook','S061',1275,33,0,0,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180417','F19/2018','POSUMNJAJTE I PROVERITE DA BISTE PROGLEDALI','Facebook','S164',1769,217,0,13,40,25);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190508','F19/2019','CAAS Akademija političke filozofije','Facebook','S001',23952,79,0,12,2,8);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180205','F2/2018','IZBORI U BEOGRADU: KAMPANJA I AKTERI','Facebook','S152',1746,76,0,0,42,8);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190114','F2/2019','Putešestvije Mojsija Đukanovića','Facebook','S045',1069,20,0,6,3,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180420','F20/2018','CAAS NA LIBERTYCON-U U BEOGRADU 2018','Facebook','S089',1083,36,0,7,4,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190508','F20/2019','Država - prof. Aleksandar Molnar','Facebook','S002',9613,52,0,7,21,11);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180424','F21/2018','KAKO NARODI POSTAJU BOGATI? - DEIRDRE MCCLOSKEY','Facebook','S090',2011,45,0,8,9,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190510','F21/2019','Drugo zašto','Facebook','S062',488,14,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180426','F22/2018','RAT PROTIV DROGE JE LAŽ - MARK "PRINCE OF POT" EMERY','Facebook','S091',3638,26,0,7,2,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190514','F22/2019','Institucionalizam - prof. Dušan Pavlović','Facebook','S003',8838,36,0,3,12,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180427','F23/2018','MINISTARSTVO ZA OPSTANAK U SRBIJI','Facebook','S165',1359,205,0,4,40,27);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190516','F23/2019','Jeste hladno, ali mora da se izdrži','Facebook','S063',879,15,0,1,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180427','F24/2018','LAŽNE VESTI, POSTISTINA I RAT KOJI SAMO ŠTO NIJE - INTERVJU SA VESNOM RADOJEVIĆ (KRIK)','Facebook','S092',12315,119,0,30,11,16);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190516','F24/2019','Moć - prof. Slobodan Antonić','Facebook','S004',7977,39,0,4,7,7);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180428','F25/2018','NIŠLIJE PONOVO NA ULICAMA: "NE DAMO AERODROM!"','Facebook','S166',1161,89,0,7,35,8);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190523','F25/2019','Koalicija za propast - Posao u Rusiji','Facebook','S064',676,11,0,3,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180428','F26/2018','LJUDI IMAJU PRAVO DA PROMENE VLAST - JAMES LARK','Facebook','S093',947,15,0,2,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190527','F26/2019','Autoritarizam i populizam - Saša Mirković','Facebook','S005',6942,80,0,15,1,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180430','F27/2018','PODIGNIMO U VIS ČELA, MI - JUNACI RADA SVOG','Facebook','S167',136,61,0,0,1,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190528','F27/2019','Probali smo - Upoznati Gorbačova','Facebook','S065',592,6,0,1,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180501','F28/2018','TERRY KIBBE @LIBERTYCON 2018.','Facebook','S094',905,14,0,2,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190530','F28/2019','Kad istekne rok, stavi drugu etiketu','Facebook','S066',1288,13,0,5,7,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180501','F29/2018','BRIAN O''SHEA @LIBERTYCON 2018.','Facebook','S101',972,19,0,3,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190603','F29/2019','Postsocijalistička tranzicija - prof. Miodrag Zec','Facebook','S006',1895,53,0,5,4,9);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180212','F3/2018','BEOGRADSKI IZBORI 2018 - INTERVJU SA BOBANOM STOJANOVIĆEM','Facebook','S084',4881,33,0,1,0,8);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190116','F3/2019','Šta koči liberalizaciju?','Facebook','S046',743,11,0,0,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180501','F30/2018','RICARDO AVELAR @LIBERTYCON 2018.','Facebook','S100',876,21,0,3,3,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190605','F30/2019','Černobilj - bezbedno i poželjno za gledanje bez zaštitne opreme, posebno bez ružičastih naočara','Facebook','S067',1684,27,0,1,5,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180503','F31/2018','EVROPSKA UNIJA - ZA ILI PROTIV?','Facebook','S095',1370,90,0,3,16,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190607','F31/2019','Destabilokratija','Facebook','S068',632,9,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180504','F32/2018','YARON BROOKE @LIBERTYCON 2018.','Facebook','S096',867,18,0,1,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190610','F32/2019','Istorija ekonomske misli - Prof. Ognjen Radonjić','Facebook','S007',7990,37,0,3,2,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180507','F33/2018','KADA SE SLIKOVNICA ZAMERI NATALITETU','Facebook','S168',923,103,0,7,33,9);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190612','F33/2019','Pod njegovim okom - nova sezona Sluškinjine priče','Facebook','S069',1211,25,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180508','F34/2018','NEŠTO OPASNO NIJE U REDU SA TVOJOM DRŽAVOM','Facebook','S169',2843,305,0,38,111,50);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190617','F34/2019','Pravo i pravda - prof. Đorđe Pavićević','Facebook','S008',10476,66,0,6,1,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180508','F35/2018','IVANA JEREMIĆ @LIBERTYCON 2018.','Facebook','S097',1083,21,0,1,0,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190620','F35/2019','Kud koji, mili moji','Facebook','S070',730,11,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180510','F36/2018','TANJA PORČNIK @LIBERTYCON 2018.','Facebook','S098',1322,48,0,3,2,9);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190624','F36/2019','Demokratija, pojam i praksa - Nataša Jovanović Ajzenhamer','Facebook','S009',10554,25,0,2,1,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180510','F37/2018','FREE MARKET ROADSHOW - EKONOMSKI FAKULTET, BEOGRAD 2018.','Facebook','S099',1978,20,0,5,2,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190701','F37/2019','Konkurs za eseje - akademija političke filozofije','Facebook','S071',53035,108,0,14,12,17);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180514','F38/2018','JUŽNE VESTI META PORESKE UPRAVE, INSPEKTORI OTIŠLI KORAK DALJE','Facebook','S170',1025,45,0,19,2,10);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190701','F38/2019','Ljudi na misiji (2019) - dokumentarni film','Facebook','S010',256054,755,0,94,72,112);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180515','F39/2018','PIETER CLEPPE @FREE MARKET ROADSHOW','Facebook','S013',1269,12,0,1,0,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190719','F39/2019','Sumnjam da će Srbija uskoro biti deo EU','Facebook','S072',951,18,0,1,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180219','F4/2018','REFORMA USTAVA: CAREVO NOVO ODELO','Facebook','S153',772,59,0,2,8,7);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190122','F4/2019','Svak je rođen da po jednom umre - državni udar živi dovjeka','Facebook','S047',1024,28,0,2,0,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180516','F40/2018','MARIO FANTINI @FREE MARKET ROADSHOW','Facebook','S104',1089,11,0,1,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190725','F40/2019','Armija kontrolora','Facebook','S073',917,11,0,0,11,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180517','F41/2018','NIMA SANANDAJI @FREE MARKET ROADSHOW','Facebook','S105',1161,28,0,0,1,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190806','F41/2019','Razočarani i ljuti','Facebook','S074',1207,14,0,0,1,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180518','F42/2018','AKO SE VI NE BAVITE POLITIKOM, ONA SE BAVI VAMA','Facebook','S171',2176,183,0,26,69,32);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190807','F42/2019','Teorija države - prof. Aleksandar Molnar','Facebook','S002',6341,73,0,5,5,7);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180518','F43/2018','DANICA POPOVIĆ @FREE MARKET ROADSHOW','Facebook','S106',1345,48,0,3,3,9);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190810','F43/2019','Institucionalizam - Prof Dušan Pavlović','Facebook','S003',6761,61,0,3,4,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180518','F44/2018','DAVID FRIEDMAN @LIBERTYCON 2018.','Facebook','S102',1020,10,0,2,1,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190814','F44/2019','CAAS Akademija političke filozofije','Facebook','S001',6597,63,0,12,6,8);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180519','F45/2018','JELENA PAVLOVIĆ @FREE MARKET ROADSHOW','Facebook','S107',1030,18,0,5,3,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190816','F45/2019','Postsocijalistička tranzicija - prof. Miodrag Zec','Facebook','S006',65065,233,0,15,25,25);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180520','F46/2018','MATHILDE BERGER-PERRIN @LIBERTYCON 2018.','Facebook','S108',2300,41,0,11,2,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190819','F46/2019','Istorija ekonomske misli - Prof. Ognjen Radonjić','Facebook','S007',23485,51,0,12,12,8);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180521','F47/2018','DRŽAVA JE NAJVEĆI KRIMINALAC','Facebook','S172',4367,510,0,22,50,91);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190821','F47/2019','Pravo i pravda - prof. Đorđe Pavićević','Facebook','S008',16461,33,0,2,1,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180522','F48/2018','BOG JE STVORIO LJUDE, ALI IH CZ 99 ČINI RAVNOPRAVNIM','Facebook','S173',2420,165,0,9,62,24);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190823','F48/2019','Demokratija, pojam i praksa - Nataša Jovanović Ajzenhamer','Facebook','S009',20290,29,0,0,5,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180524','F49/2018','MARIA CHAPLIA @LIBERTYCON 2018.','Facebook','S109',1621,86,0,18,27,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190827','F49/2019','Autoritarizam i populizam - Saša Mirković','Facebook','S005',22124,34,0,4,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180227','F5/2018','REFORMA USTAVA ILI CAREVO NOVO ODELO - INTERVJU SA STRAHINJOM MAVRENSKIM','Facebook','S085',3254,23,0,1,1,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190214','F5/2019','Od ranije poznati građanima','Facebook','S048',864,15,0,0,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180528','F50/2018','NE ZNAMO ŠTA NAS JE SNAŠLO','Facebook','S174',693,56,0,2,11,13);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190917','F50/2019','Crnac u kući slon u sobi','Facebook','S075',597,18,0,0,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180528','F51/2018','VESELO, KAO NA AUTOPSIJI','Facebook','S175',282,32,0,4,7,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190918','F51/2019','Kapitalizam - "bolesnik koji umire" već dva i po veka?','Facebook','S076',1314,30,0,0,9,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180530','F52/2018','RATKO NIKOLIĆ’S SELFIE CITIZEN JOURNALISM PROJECT WINS 2018 EUROPE THINK TANK SHARK TANK COMPETITION','Facebook','S176',1141,162,0,36,3,7);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190919','F52/2019','Sve boje bogorodice','Facebook','S077',1760,46,0,2,26,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180531','F53/2018','PROJEKAT "SELFI GRAĐANSKO NOVINARSTVO" - POBEDNIK MEĐUNARODNOG TAKMIČENJA U KOPENHAGENU','Facebook','S177',24,17,0,1,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190920','F53/2019','Ponovno buđenje nacionalnih država ili njihov poslednji trzaj (Evropa od 2016. do danas)?','Facebook','S078',727,16,0,0,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180601','F54/2018','ADMIR ČAVALIĆ @LIBERTYCON 2018.','Facebook','S110',1097,12,0,1,3,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190923','F54/2019','Autoritarni populizam: izazov evropskim vrednostima ili bauk?','Facebook','S079',979,40,0,0,4,7);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180601','F55/2018','MARIAM GOGOLSHILI @LIBERTYCON 2018.','Facebook','S111',1143,18,0,2,0,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191023','F55/2019','Izložba i premijera filma "Pravo na rad" UK Stari Grad','Facebook','S012',2335,72,0,10,0,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180605','F56/2018','ZAŠTO U SRBIJI IZOSTAJU MASOVNI PROTESTI?','Facebook','S178',2054,126,0,12,187,23);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191024','F56/2019','Zarobljeni u bedi','Facebook','S080',876,48,0,7,26,8);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180606','F57/2018','TIM ANDREWS @LIBERTYCON 2018.','Facebook','S112',954,18,0,1,1,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191025','F57/2019','Tribina "Pravo na rad" UK Stari grad 18.10.2019.','Facebook','S013',571,10,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180607','F58/2018','ALEKSANDAR KOKOTOVIĆ @LIBERTYCON 2018.','Facebook','S113',989,12,0,2,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191026','F58/2019','Nameti na rad mogu da budu manji - narodni poslanik Aleksandar Stevanović','Facebook','S014',772,14,0,0,3,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180611','F59/2018','(K)VARLJIVO LETO ''68.','Facebook','S179',1191,78,0,10,21,10);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191027','F59/2019','(Ne)samostalno određivanje pravila','Facebook','S081',797,24,0,1,23,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180306','F6/2018','KRAĐA VREMENA I GLASANJE NA ZVONCE: ZLOUPOTREBA SKUPŠTINSKIH PROCEDURA','Facebook','S154',1632,101,0,0,17,13);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190219','F6/2019','Kad više nema nade, jedino što imamo je nada','Facebook','S049',934,13,0,1,1,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180612','F60/2018','PARALELNI UNIVERZUM','Facebook','S180',1687,92,0,3,8,20);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191028','F60/2019','Ekonomsko osnaživanje mladih, obezbeđuje njihov bolji položaj u društvu - Ivan Despotović "Libero"','Facebook','S015',2678,111,0,6,4,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180613','F61/2018','WOLF VON LAER @LIBERYCON 2018.','Facebook','S114',941,13,0,4,5,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191030','F61/2019','Pravo na rad (2019) - dokumentarni film','Facebook','S011',94791,377,0,49,75,117);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180618','F62/2018','TRŽIŠNA PRAVILA BI TREBALO DA VAŽE ZA SVE','Facebook','S181',228,30,0,1,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191031','F62/2019','Preduzetnička kultura u Srbiji je na niskom nivou - Ivana Pavlović (Nova Ekonomija)','Facebook','S016',592,11,0,1,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180620','F63/2018','MILOŠ NIKOLIĆ @LIBERTYCON 2018.','Facebook','S115',1125,24,0,1,2,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191104','F63/2019','Svi smo mi preduzetnici - Ljupka Mihajlovska, narodna poslanica','Facebook','S017',640,14,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180620','F64/2018','KRIMIĆ SE NASTAVLJA - LAŽNI NESTANAK NESTALOG NOVINARA','Facebook','S182',1177,33,0,0,0,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191109','F64/2019','Mangupi u Arkanovim redovima - Dragoljub Draža Petrović, Danas','Facebook','S018',1630,51,0,8,0,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180621','F65/2018','KATE ANDREWS @LIBERTYCON 2018.','Facebook','S116',63,5,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191111','F65/2019','Dragoljub Draža Petrović - novinarstvo u dnevnoj štampi','Facebook','S019',45579,286,0,17,14,21);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180628','F66/2018','LIBERTY FORUM - THINK TANK SHARK TANK, COPENHAGEN 2018.','Facebook','S117',125,9,0,2,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191113','F66/2019','Dobar urednik je dobar mentor - Jovana Gligorijević, Vreme','Facebook','S020',707,11,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180629','F67/2018','LINDA WHETSTONE @LIBERTY FORUM, COPENHAGEN 2018.','Facebook','S118',102,8,0,1,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191115','F67/2019','Jovana Gligorijević - Novinarstvo u nedeljniku','Facebook','S021',31772,75,0,7,0,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180629','F68/2018','TOM PALMER @LIBERTY FORUM, COPENHAGEN 2018.','Facebook','S119',96,10,0,0,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191117','F68/2019','Dobra reportaža je složena slagalica - Idro seferi','Facebook','S022',608,8,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180630','F69/2018','SPORTSKI RIBOLOV I ORGANIZOVANI KRIMINAL','Facebook','S183',22,5,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191118','F69/2019','Reportaža i izveštavanje - Idro Seferi','Facebook','S023',22482,20,0,2,1,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180314','F7/2018','HAOS U SKUPŠTINI! - INTERVJU SA DR ANOM STEVANOVIĆ','Facebook','S086',8194,137,0,18,31,22);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190226','F7/2019','Pravo na sreću','Facebook','S050',583,16,0,1,0,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180701','F70/2018','BARBARA COLM @LIBERTY FORUM, COPENHAGEN 2018.','Facebook','S120',951,14,0,3,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191120','F70/2019','Novinarstvo je način da se otkrije istina - Slobodan Georgiev, BIRN','Facebook','S024',671,16,0,1,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180701','F71/2018','LAWSON BADER @LIBERTY FORUM, COPENHAGEN 2018.','Facebook','S121',64,10,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191122','F71/2019','Novinarstvo i javni interes - Slobodan Georgiev, BIRN','Facebook','S025',29124,134,0,6,2,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180702','F72/2018','AKO MI DOĐEMO NA VLAST…','Facebook','S184',353,33,0,3,2,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191123','F72/2019','Istraživačko novinarstvo je privilegija','Facebook','S026',650,12,0,2,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180702','F73/2018','DUBOKA DRŽAVA I PLITKA DRŽAVA','Facebook','S185',607,57,0,8,20,7);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191125','F73/2019','Anatomija istraživačke priče - Aleksandar Đorđević, BIRN','Facebook','S027',26489,104,0,8,1,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180710','F74/2018','BOSTONSKA ČAJANKA','Facebook','S186',311,23,0,4,7,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191127','F74/2019','Istraživački novinar ima čelične živce - Stevan Dojčinović, KRIK','Facebook','S028',535,10,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180712','F75/2018','JULIO ALEJANDRO @LIBERTYCON 2018.','Facebook','S122',103,14,0,0,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191128','F75/2019','Država bi trebalo da napravi ambijent za razvoj - Nemanja Radojević, narodni poslanik','Facebook','S029',858,27,0,0,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180713','F76/2018','ALEKSA BURMAZOVIĆ @LIBERTYCON 2018.','Facebook','S123',137,18,0,0,1,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191129','F76/2019','Tehnike istraživačkog novinarstva - Stevan Dojčinović, KRIK','Facebook','S030',23701,67,0,5,1,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180714','F77/2018','KARIN SVANBORG SJOVALL @LIBERTY FORUM, COPENHAGEN 2018.','Facebook','S124',174,18,0,1,5,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191130','F77/2019','Nije dovoljno samo da se pojaviš - Miloš Milovanović, N1','Facebook','S031',936,22,0,1,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180716','F78/2018','U DIVLJINI SE UMIRE OD SRAMOTE','Facebook','S187',198,27,0,2,15,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191201','F78/2019','Socijalizam: propala ideja koja ne odumire','Facebook','S032',1815,73,0,11,6,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180723','F79/2018','POTONUO JE OVAJ TITANIK','Facebook','S188',212,68,0,8,1,8);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191202','F79/2019','Tehnike javnog nastupa - Miloš Milovanović, N1','Facebook','S033',34471,118,0,9,3,7);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180321','F8/2018','DIJALOG BEOGRADA I PRIŠTINE: RAT DRUGIM SREDSTVIMA ILI ISTINSKA NORMALIZACIJA?','Facebook','S155',841,34,0,0,28,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190305','F8/2019','Slavska politikologija','Facebook','S051',628,5,0,0,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180730','F80/2018','U EU ČOKOLADA NIJE ČOKOLADA AKO NIJE PO NEMAČKIM STANDARDIMA','Facebook','S189',626,56,0,4,9,8);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191218','F80/2019','Tribina: Afera Krušik i pritisci na medije 2019','Facebook','S034',25444,154,0,5,13,20);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180802','F81/2018','VODIČ ZA INTERACIJU SA POLICIJOM','Facebook','S190',2106,94,0,3,8,20);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191219','F81/2019','Tribina: Najbolje istraživačke priče u Srbiji 2019','Facebook','S035',16840,27,0,3,11,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180806','F82/2018','CIRKUS SPOLJNE POLITIKE','Facebook','S191',1372,52,0,10,10,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191220','F82/2019','Tribina: Dometi medijske strategije 2019','Facebook','S036',17351,14,0,0,5,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180808','F83/2018','KOLIKO NOVA MEDIJSKA STRATEGIJA MOŽE DA UTIČE NA MEDIJE U SRBIJI?','Facebook','S192',78,50,0,2,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191221','F83/2019','Vojislav Stevanović (N1): "Na javnom servisu nema nikakvih informacija o aferi Krušik"','Facebook','S037',473,9,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180810','F84/2018','POPULIZAM ĆEMO ZAMENITI POPULIZMOM','Facebook','S193',48,19,0,0,1,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191221','F84/2019','Vuk Cvijić (NIN): "Afera Krušik je ujedinila domaće slobodne medije"','Facebook','S038',400,13,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180815','F85/2018','ČIJE INTERESE ŠTITI "MINIMALAC"?','Facebook','S194',3649,117,0,28,54,22);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191222','F85/2019','Katarina Živanović (Danas): "Afera sa ruskim špijunom je samo pokušaj da se skrene pažnja sa afere Krušik"','Facebook','S039',538,6,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180820','F86/2018','NIKOLA JELIĆ - MIKRI MAUS: NAŠA MUZIKA JE ANTIPROPAGANDA SVEGA','Facebook','S195',847,63,0,7,3,3);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191222','F86/2019','Dragana Pećo (KRIK): "Milenijum tim ustupio auto i stan bratu ministra finansija Siniše Malog"','Facebook','S040',1466,26,0,1,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180823','F87/2018','ZID U GLAVI','Facebook','S196',326,23,0,0,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191223','F87/2019','Milica Šarić (CINS): "Ove godine smo najbolje priče imali o REM-u"','Facebook','S041',893,8,0,0,1,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180828','F88/2018','SVET PREVAZILAZI LJUDSKU MISAO','Facebook','S197',45,21,0,0,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191223','F88/2019','Natalija Jovanović (BIRN): "Naša najznačajnija priča ove godine je svakako afera Krušik"','Facebook','S042',591,5,0,1,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180829','F89/2018','ZAR I BLEJANJE IMA CENU?','Facebook','S125',4462,89,0,29,43,19);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191224','F89/2019','Nedim Sejdinović (NDNV): "Medijska strategija će verovatno ostati mrtvo slovo na papiru"','Facebook','S043',522,5,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180323','F9/2018','KOMUNIZAM ĆE UVEK BITI NASILAN','Facebook','S156',22902,388,0,84,392,68);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190312','F9/2019','Ne postoji ono što se nedovoljno želi','Facebook','S052',1510,22,0,2,3,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180831','F90/2018','TRI LUSTRACIJE ZA GOSPODINA','Facebook','S198',51,15,0,1,2,4);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191230','F90/2019','Šta smo (u)radili 2019.','Facebook','S082',11587,71,0,17,10,6);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180901','F91/2018','KONKURS ZA CAAS ŠKOLU NOVINARSTVA 2018.','Facebook','S199',491,45,0,3,15,9);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180910','F92/2018','POPULIZAM JE POSLEDICA CENTRALIZACIJE','Facebook','S200',30,10,0,1,0,2);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180910','F93/2018','KONKURS ZA CAAS ŠKOLU NOVINARSTVA 2018.','Facebook','S199',851,40,0,3,0,5);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180912','F94/2018','ISKUSTVA POLAZNIKA - CAAS ŠKOLA NOVINARSTVA 2017.','Facebook','S201',3561,36,0,11,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180913','F95/2018','BEZ STRASTI NE VREDI NI POČINJATI','Facebook','S202',20,7,0,2,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180917','F96/2018','BUDUĆNOST TURSKE NIJE SVETLA','Facebook','S203',21,6,0,2,2,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180924','F97/2018','NIJE MUDRO KLADITI SE PROTIV TRAMPA','Facebook','S204',148,9,0,0,5,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180925','F98/2018','JOVANA GLIGORIJEVIĆ - DANAS JE JAKO TEŠKO BITI POLITIČKI NOVINAR','Facebook','S205',47,11,0,0,0,1);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181003','F99/2018','MIT O SKANDINAVSKOM SOCIJALIZMU I KREATIVNA DESTRUKCIJA','Facebook','S206',594,68,0,5,41,13);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180104','Y1/2018','KO O ČEMU, ZAKON O POŠTENJU','Youtube','S083',573,21,7,0,3,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190507','Y1/2019','CAAS Akademija političke filozofije','Youtube','S001',1771,25,4,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180427','Y10/2018','LAŽNE VESTI, POSTISTINA I RAT KOJI SAMO ŠTO NIJE - INTERVJU SA VESNOM RADOJEVIĆ (KRIK)','Youtube','S092',9308,15,1,0,15,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190701','Y10/2019','Ljudi na misiji (2019) - dokumentarni film','Youtube','S010',4182,55,2,0,3,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180428','Y11/2018','LJUDI IMAJU PRAVO DA PROMENE VLAST - JAMES LARK','Youtube','S093',967,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191019','Y11/2019','Pravo na rad (2019) - dokumentarni film','Youtube','S011',4052,97,2,0,10,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180501','Y12/2018','TERRY KIBBE @LIBERTYCON 2018.','Youtube','S094',141,3,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191023','Y12/2019','Izložba i premijera filma "Pravo na rad" UK Stari Grad','Youtube','S012',132,8,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180503','Y13/2018','EVROPSKA UNIJA - ZA ILI PROTIV?','Youtube','S095',203,9,1,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191025','Y13/2019','Tribina "Pravo na rad" UK Stari Grad 18.10.2019.','Youtube','S013',56,2,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180504','Y14/2018','YARON BROOKE @LIBERTYCON 2018.','Youtube','S096',84,5,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191026','Y14/2019','Nameti na rad mogu biti manji - narodni poslanik Aleksandar Stevanović','Youtube','S014',190,8,3,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180508','Y15/2018','IVANA JEREMIĆ @LIBERTYCON 2018.','Youtube','S097',236,6,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191028','Y15/2019','Ekonomsko osnaživanje mladih obezbeđuje njihov bolji položaj u društvu - Ivan Despotović "Libero"','Youtube','S015',58,4,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180510','Y16/2018','TANJA PORČNIK @LIBERTYCON 2018.','Youtube','S098',427,5,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191030','Y16/2019','Preduzetnička kultura u Srbiji je na niskom nivou - Ivana Pavlović (Nova ekonomija)','Youtube','S016',94,7,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180510','Y17/2018','FREE MARKET ROADSHOW - EKONOMSKI FAKULTET, BEOGRAD 2018.','Youtube','S099',2206,12,2,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191104','Y17/2019','Svi smo mi preduzetnici - Ljupka Mihajlovska','Youtube','S017',135,6,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180513','Y18/2018','RICARDO AVELAR @LIBERTYCON 2018.','Youtube','S100',41,3,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191109','Y18/2019','Mangupi u Arkanovim redovima - Dragoljub Draža Petrović','Youtube','S018',831,16,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180513','Y19/2018','BRIAN O''SHEA @LIBERTYCON 2018.','Youtube','S101',2438,5,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191111','Y19/2019','Dragoljub Petrović - Novinarstvo u dnevnoj štampi (Škola novinarstva)','Youtube','S019',762,18,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180212','Y2/2018','BEOGRADSKI IZBORI 2018 - INTERVJU SA BOBANOM STOJANOVIĆEM','Youtube','S084',284,11,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190507','Y2/2019','Teorija države - Prof Aleksandar Molnar','Youtube','S002',22338,53,1,0,5,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180514','Y20/2018','DAVID FRIEDMAN @LIBERTYCON 2018.','Youtube','S102',548,5,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191113','Y20/2019','Dobar urednik je dobar mentor mladim novinarima - Jovana Gligorijević','Youtube','S020',94,7,1,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180515','Y21/2018','PIETER CLEPPE @FREE MARKET ROADSHOW','Youtube','S013',39,3,1,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191115','Y21/2019','Novinarstvo u nedeljniku - Jovana Gligorijević, nedeljnik Vreme','Youtube','S021',208,6,4,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180516','Y22/2018','MARIO FANTINI @FREE MARKET ROADSHOW','Youtube','S104',30,2,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191117','Y22/2019','Reportaža je kao slaganje slagalice - Idro Seferi','Youtube','S022',61,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180517','Y23/2018','NIMA SANANDAJI @FREE MARKET ROADSHOW','Youtube','S105',37,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191118','Y23/2019','Reportaža i istraživanje','Youtube','S023',176,5,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180518','Y24/2018','DANICA POPOVIĆ @FREE MARKET ROADSHOW','Youtube','S016',484,8,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191120','Y24/2019','Novinarstvo je način da se otkrije istina - Slobodan Georgijev, BIRN','Youtube','S024',94,8,1,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180519','Y25/2018','JELENA PAVLOVIĆ @FREE MARKET ROADSHOW','Youtube','S107',138,1,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191122','Y25/2019','Novinarstvo i javni interes - Slobadn Georgijev, BIRN','Youtube','S025',505,11,1,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180520','Y26/2018','MATHILDE BERGER-PERRIN @LIBERTYCON 2018.','Youtube','S108',125,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191123','Y26/2019','Kada saznate da otac ministra policije - Aleksandar Đorđević, BIRN','Youtube','S026',167,6,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180524','Y27/2018','MARIA CHAPLIA @LIBERTYCON 2018.','Youtube','S109',151,4,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191125','Y27/2019','Anatomija istraživačke priče - Aleksandar Đorđević, BIRN','Youtube','S027',348,13,1,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180531','Y28/2018','ADMIR ČAVALIĆ @LIBERTYCON 2018.','Youtube','S110',32,1,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191127','Y28/2019','Istraživački novinar ima čelične živce - Stevan Dojčinović, KRIK','Youtube','S028',68,4,1,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180601','Y29/2018','MARIAM GOGOLSHILI @LIBERTYCON 2018.','Youtube','S111',29,1,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191128','Y29/2019','Država bi trebalo da napravi ambijent za razvoj - Nemanja Radivojević, narodni poslanik','Youtube','S029',159,4,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180227','Y3/2018','REFORMA USTAVA ILI CAREVO NOVO ODELO - INTERVJU SA STRAHINJOM MAVRENSKIM','Youtube','S085',4626,12,4,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190514','Y3/2019','Institucionalizam - Prof Dušan Pavlović','Youtube','S003',9971,31,2,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180606','Y30/2018','TIM ANDREWS @LIBERTYCON 2018.','Youtube','S112',12,2,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191129','Y30/2019','Tehnike istraživačkog novinarstva - Stevan Dojčinović, KRIK','Youtube','S030',397,16,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180607','Y31/2018','ALEKSANDAR KOKOTOVIĆ @LIBERTYCON 2018.','Youtube','S113',48,5,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191130','Y31/2019','Nije dovoljno samo da se pojaviš - Miloš Milovanović','Youtube','S031',110,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180613','Y32/2018','WOLF VON LAER @LIBERYCON 2018.','Youtube','S114',8,2,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191201','Y32/2019','Socijalizam: Propala ideja koja ne odumire','Youtube','S032',269,14,0,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180620','Y33/2018','MILOŠ NIKOLIĆ @LIBERTYCON 2018.','Youtube','S115',61,4,1,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191202','Y33/2019','Tehnike javnog nastupa - Miloš Milovanović, N1','Youtube','S033',453,13,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180621','Y34/2018','KATE ANDREWS @LIBERTYCON 2018.','Youtube','S116',163,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191218','Y34/2019','Afera Krušik i pritisci na medije 2019','Youtube','S034',1488,34,1,0,3,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180628','Y35/2018','LIBERTY FORUM - THINK TANK SHARK TANK, COPENHAGEN 2018.','Youtube','S117',22,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191218','Y35/2019','Najbolje istraživačke priče u Srbiji 2019','Youtube','S035',237,11,0,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180629','Y36/2018','LINDA WHETSTONE @LIBERTY FORUM, COPENHAGEN 2018.','Youtube','S118',42,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191218','Y36/2019','Dometi medijske strategije 2019','Youtube','S036',99,3,1,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180629','Y37/2018','TOM PALMER @LIBERTY FORUM, COPENHAGEN 2018.','Youtube','S119',13,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191220','Y37/2019','Vojislav Stevanović (N1): "Na javnom servisu nema nikakvih informacija o aferi Krušik"','Youtube','S037',53,4,0,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180701','Y38/2018','BARBARA COLM @LIBERTY FORUM, COPENHAGEN 2018.','Youtube','S120',79,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191220','Y38/2019','Vuk Cvijić (NIN): "Afera Krušik je ujedinila domaće slobodne medije"','Youtube','S038',171,9,0,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180701','Y39/2018','LAWSON BADER @LIBERTY FORUM, COPENHAGEN 2018.','Youtube','S121',14,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191220','Y39/2019','Katarina Živanović (Danas): "Ruski špijun je samo pokušaj da se skrene pažnja sa afere Krušik"','Youtube','S039',121,5,1,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180314','Y4/2018','HAOS U SKUPŠTINI! - INTERVJU SA DR ANOM STEVANOVIĆ','Youtube','S086',4825,33,3,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190520','Y4/2019','Teorije moći - Prof Slobodan Antonić','Youtube','S004',32737,106,3,0,10,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180712','Y40/2018','JULIO ALEJANDRO @LIBERTYCON 2018.','Youtube','S122',31,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191220','Y40/2019','Dragana Pećo (KRIK): "Milenijum tim ustupio auto i stan bratu ministra finansija Siniše Malog"','Youtube','S040',46,1,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180713','Y41/2018','ALEKSA BURMAZOVIĆ @LIBERTYCON 2018.','Youtube','S123',102,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191220','Y41/2019','Milica Šarić (CINS): "Ove godine smo najbolje priče imali o REM-u"','Youtube','S041',27,1,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180714','Y42/2018','KARIN SVANBORG SJOVALL @LIBERTY FORUM, COPENHAGEN 2018.','Youtube','S124',65,3,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191220','Y42/2019','Natalija Jovanović (BIRN): "Naša najznačajnija priča ove godine je svakako afera Krušik"','Youtube','S042',73,4,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180829','Y43/2018','ZAR I BLEJANJE IMA CENU?','Youtube','S125',27699,28,5,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20191220','Y43/2019','Nedim Sejdinović (NDNV): "Medijska strategija će verovatno ostati mrtvo slovo na papiru"','Youtube','S043',45,2,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181023','Y44/2018','NAPREDNA PRETRAGA DRUŠTVENIH MREŽA','Youtube','S126',3941,21,0,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181023','Y45/2018','PRAVO I GRAĐANSKO NOVINARSTVO','Youtube','S127',4662,22,0,0,4,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181023','Y46/2018','GRAĐANSKO NOVINARSTVO 101 - IZVORI I TEME','Youtube','S128',3890,27,1,0,4,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181023','Y47/2018','BEZBEDNOST U GRAĐANSKOM NOVINARSTVU','Youtube','S129',5373,18,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181023','Y48/2018','FACT-CHECKING I KAKO PREPOZNATI LAŽNE VESTI','Youtube','S130',7913,24,3,0,7,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181024','Y49/2018','CAAS AKADEMIJA GRAĐANSKOG NOVINARSTVA','Youtube','S131',79413,21,1,0,4,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180330','Y5/2018','EVROINTEGRACIJE I DIJALOG O KOSOVU - INTERVJU SA KATARINOM TADIĆ','Youtube','S087',3832,18,3,0,9,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190527','Y5/2019','Autoritarizam i populizam - Saša Mirković','Youtube','S005',913,18,0,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181024','Y50/2018','BAZE PODATAKA KAO IZVOR INFORMACIJA','Youtube','S132',3799,20,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181211','Y51/2018','ZAPOŠLJAVANJE MLADIH: SLUČAJ "ČEKAJUĆI GODOA"','Youtube','S133',2710,9,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181211','Y52/2018','ZLOUPOTREBE U RADU OMLADINSKIH ZADRUGA','Youtube','S134',4588,10,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181211','Y53/2018','KOSOVSKA MITROVICA, ŠTA SAD?','Youtube','S135',6679,17,3,0,7,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181211','Y54/2018','TRGOVINA LJUDIMA U SRBIJI','Youtube','S136',22784,21,0,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181211','Y55/2018','KOLIKO KOŠTA STUDENTSKA DIPLOMA?','Youtube','S137',9626,14,1,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181212','Y56/2018','ZAŠTO (NE)PROPADA BAZEN BANJICA?','Youtube','S138',3575,12,1,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181212','Y57/2018','PUŠTENI PSI I KARIKATURE SA HITLEROM','Youtube','S139',5231,5,0,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181216','Y58/2018','ANTONELA RIHA NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Youtube','S140',1295,4,1,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181216','Y59/2018','JOVANA GLIGORIJEVIĆ (VREME) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Youtube','S141',1820,4,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180409','Y6/2018','RAT PROTIV MAFIJE, ALI NE ONE NA VLASTI - INTERVJU SA JELENOM RADIVOJEVIĆ (KRIK)','Youtube','S088',6448,18,1,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190603','Y6/2019','Tranzicija od kolektivizma ka individualizmu (Ekonomska istorija SFRJ) - Prof Miodrag Zec','Youtube','S006',58993,1070,47,0,116,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181216','Y60/2018','VESNA MALIŠIĆ (NIN) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Youtube','S142',4366,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','Y61/2018','DINA ĐORĐEVIĆ (CINS) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Youtube','S143',1039,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','Y62/2018','STEVAN DOJČINOVIĆ (KRIK) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Youtube','S144',1167,4,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','Y63/2018','BOJAN CVEJIĆ (DANAS) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Youtube','S145',5281,3,1,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','Y64/2018','MILAN ZIROJEVIĆ (JUŽNE VESTI) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Youtube','S146',5246,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','Y65/2018','MILICA ŠARIĆ (CINS) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Youtube','S147',1118,3,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181217','Y66/2018','TEŠA TEŠANOVIĆ (BALKAN INFO) NA KONFERENCIJI "SLOBODA MEDIJA U SRBIJI 2018"','Youtube','S148',5154,5,5,0,4,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181219','Y67/2018','PANEL "SLOBODA MEDIJA U SRBIJI" 15.12.2018.','Youtube','S149',1293,2,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181219','Y68/2018','PANEL "NAJBOLJE ISTRAŽIVAČKE PRIČE U 2018" 15.12.2018.','Youtube','S150',545,2,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20181219','Y69/2018','PANEL "BEZBEDNOST NOVINARA U 2018" 15.12.2018.','Youtube','S151',1140,2,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180419','Y7/2018','CAAS NA LIBERTYCON-U U BEOGRADU 2018','Youtube','S089',2629,11,3,0,1,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190610','Y7/2019','Istorija ekonomske misli - Prof Ognjen Radonjić','Youtube','S007',2977,61,3,0,6,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180423','Y8/2018','KAKO NARODI POSTAJU BOGATI? - DEIRDRE MCCLOSKEY','Youtube','S090',219,4,1,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190617','Y8/2019','Pravo i pravda - Prof Đorđe Pavićević','Youtube','S008',1180,18,0,0,2,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20180426','Y9/2018','RAT PROTIV DROGE JE LAŽ - MARK "PRINCE OF POT" EMERY','Youtube','S091',138,5,0,0,0,0);
INSERT INTO Objave(Datum,ID_objave,Naslov,Platforma,ID_sadržaja,Broj_pregleda,Broj_lajkova,Broj_dislajkova,Broj_emotikona,Broj_komentara,Broj_deljenja) VALUES ('20190624','Y9/2019','Demokratija kao pojam i praksa - Nataša Jovanović','Youtube','S009',760,13,0,0,0,0);
