
if db_id('TKARecordsDataWarehouse') is null
	create database TKARecordsDataWarehouse;
go

use TKARecordsDataWarehouse;

--REMOVE TABLES
if object_id('dbo.F_Performance') is not null
	drop table dbo.F_Performance;
if object_id('dbo.Band') is not null
	drop table dbo.Band;
if object_id('dbo.ZipCode') is not null
	drop table dbo.ZipCode;
if object_id('dbo.SingleDate') is not null
	drop table dbo.SingleDate;

CREATE TABLE dbo.SingleDate 
(
	ShortDate Date NOT NULL,
   Ano INT NOT NULL,
   Mes VARCHAR(45) NOT NULL,
   Dia INT NOT NULL,
   PRIMARY KEY( ShortDate )
); 

CREATE TABLE dbo.ZipCode 
(
	Zip_Code CHAR(5) NOT NULL,
	State_Name CHAR(20) NOT NULL,
    Street_Address CHAR(100) NOT NULL,
	City CHAR(50),
	Latitude DECIMAL(10,7),
	Longitude DECIMAL(10,7), 
	PRIMARY KEY( Zip_Code )
);  
   
CREATE TABLE dbo.Band 
(
	Band_Id INTEGER NOT NULL,
	Band_Name CHAR(100) NOT NULL,
	ZIP_Code CHAR(5) NOT NULL,
	Band_Status_Code CHAR(1),
	Formation_Date DATE, --FORMAT'YYYY-MM-DD'
	CONSTRAINT fk_Band_zipcode FOREIGN KEY ( ZIP_Code ) REFERENCES dbo.ZIPCODE ( Zip_Code ),
   CONSTRAINT fk_Band_formation_date FOREIGN KEY ( Formation_Date ) REFERENCES dbo.SingleDate ( ShortDate ),
	PRIMARY KEY( Band_Id )
);

CREATE TABLE dbo.F_Performance
(
   Performance_Id INT NOT NULL,
   Band_Id INT NOT NULL,
   Performance_Date Date NOT NULL,
   Zip_Code Char(5) NOT NULL,
   Liquido_Band DECIMAL(15,2) NOT NULL,
   Revenue DECIMAL(15,2) NOT NULL,
   Despesas DECIMAL(15,2) NOT NULL,
   
   CONSTRAINT fk_Performance_Band FOREIGN KEY ( Band_Id ) REFERENCES dbo.Band ( Band_Id ),
   CONSTRAINT fk_Performance_ZipCode FOREIGN KEY ( Zip_Code ) REFERENCES dbo.ZipCode ( Zip_Code ),
   CONSTRAINT fk_Performance_Date FOREIGN KEY ( Performance_Date ) REFERENCES dbo.SingleDate ( ShortDate ),
   PRIMARY KEY( Performance_Id )
);
