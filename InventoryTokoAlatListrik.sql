/* 1. Membuat database */
/* IF DB_ID(N'InventoryTokoAlatListrik') IS NULL 
BEGIN 
	CREATE DATABASE InventoryTokoAlatListrik;
END;
GO */

/* 2. Membuat tabel master */
/* IF OBJECT_ID(N'dbo.Kategori', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Kategori
    (
        KategoriID INT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_Kategori PRIMARY KEY,
        NamaKategori NVARCHAR(100) NOT NULL
            CONSTRAINT UQ_Kategori_Nama UNIQUE,
        Deskripsi NVARCHAR(255) NULL
    );
END;
GO */

SELECT * FROM Kategori;