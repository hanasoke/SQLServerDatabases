/* CREATE DATABASE OjolDB;
GO

USE OjolDB;
GO */

CREATE TABLE driver (
	id_driver INT IDENTITY(1,1) PRIMARY KEY,
	nama_driver VARCHAR(100) NOT NULL,
	jenis_kelamin VARCHAR(20) NOT NULL,
	no_hp VARCHAR(20) NOT NULL UNIQUE,
	jenis_kendaraaan VARCHAR(50) NOT NULL, 
	plat_nomor VARCHAR(15) NOT NULL,
	status_driver VARCHAR(20) NOT NULL,
	tanggal_daftar DATE NOT NULL 
);
GO