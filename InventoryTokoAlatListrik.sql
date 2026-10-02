/* 1. Membuat database */
IF DB_ID(N'InventoryTokoAlatListrik') IS NULL 
BEGIN 
	CREATE DATABASE InventoryTokoAlatListrik;
END;
GO

/* 2. Membuat tabel master */
IF OBJECT_ID(N'dbo.Kategori', N'U') IS NULL
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
GO

/* SELECT * FROM Kategori; */ 

IF OBJECT_ID(N'dbo.Supplier', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Supplier
    (
        SupplierID INT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_Supplier PRIMARY KEY,
        NamaSupplier NVARCHAR(150) NOT NULL,
        NamaKontak NVARCHAR(100) NULL,
        NoTelepon VARCHAR(25) NULL,
        Email VARCHAR(150) NULL,
        Alamat NVARCHAR(255) NULL
    );
END;
GO

/* SELECT * FROM Supplier; */

IF OBJECT_ID(N'dbo.Produk', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Produk
    (
        ProdukID INT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_Produk PRIMARY KEY,
        KodeProduk VARCHAR(30) NOT NULL
            CONSTRAINT UQ_Produk_Kode UNIQUE,
        NamaProduk NVARCHAR(150) NOT NULL,
        KategoriID INT NOT NULL,
        SupplierID INT NOT NULL,
        Satuan NVARCHAR(30) NOT NULL
            CONSTRAINT DF_Produk_Satuan DEFAULT N'Pcs',
        HargaBeli DECIMAL(18,2) NOT NULL
            CONSTRAINT CK_Produk_HargaBeli CHECK (HargaBeli >= 0),
        HargaJual DECIMAL(18,2) NOT NULL
            CONSTRAINT CK_Produk_HargaJual CHECK (HargaJual >= 0),
        StokMinimum INT NOT NULL
            CONSTRAINT DF_Produk_StokMinimum DEFAULT 0
            CONSTRAINT CK_Produk_StokMinimum CHECK (StokMinimum >= 0),
        Stok INT NOT NULL
            CONSTRAINT DF_Produk_Stok DEFAULT 0
            CONSTRAINT CK_Produk_Stok CHECK (Stok >= 0),
        StatusAktif BIT NOT NULL
            CONSTRAINT DF_Produk_StatusAktif DEFAULT 1,

        CONSTRAINT FK_Produk_Kategori
            FOREIGN KEY (KategoriID) REFERENCES dbo.Kategori(KategoriID),

        CONSTRAINT FK_Produk_Supplier
            FOREIGN KEY (SupplierID) REFERENCES dbo.Supplier(SupplierID)
    );
END;
GO

/* SELECT * FROM Produk; */

/* 3. Membuat tabel transaksi pembelian */
IF OBJECT_ID(N'dbo.Pembelian', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Pembelian
    (
        PembelianID INT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_Pembelian PRIMARY KEY,
        NomorFaktur VARCHAR(30) NOT NULL
            CONSTRAINT UQ_Pembelian_NomorFaktur UNIQUE,
        TanggalPembelian DATE NOT NULL,
        SupplierID INT NOT NULL,
        TotalPembelian DECIMAL(18,2) NOT NULL
            CONSTRAINT DF_Pembelian_Total DEFAULT 0,
        Keterangan NVARCHAR(255) NULL,

        CONSTRAINT FK_Pembelian_Supplier
            FOREIGN KEY (SupplierID) REFERENCES dbo.Supplier(SupplierID)
    );
END;
GO

IF OBJECT_ID(N'dbo.DetailPembelian', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.DetailPembelian
    (
        DetailPembelianID INT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_DetailPembelian PRIMARY KEY,
        PembelianID INT NOT NULL,
        ProdukID INT NOT NULL,
        Jumlah INT NOT NULL
            CONSTRAINT CK_DetailPembelian_Jumlah CHECK (Jumlah > 0),
        HargaBeli DECIMAL(18,2) NOT NULL
            CONSTRAINT CK_DetailPembelian_HargaBeli CHECK (HargaBeli >= 0),
        Subtotal AS (Jumlah * HargaBeli) PERSISTED,

        CONSTRAINT FK_DetailPembelian_Pembelian
            FOREIGN KEY (PembelianID) REFERENCES dbo.Pembelian(PembelianID),

        CONSTRAINT FK_DetailPembelian_Produk
            FOREIGN KEY (ProdukID) REFERENCES dbo.Produk(ProdukID)
    );
END;
GO

/* 4. Membuat tabel transaksi penjualan */

IF OBJECT_ID(N'dbo.Penjualan', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Penjualan
    (
        PenjualanID INT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_Penjualan PRIMARY KEY,
        NomorNota VARCHAR(30) NOT NULL
            CONSTRAINT UQ_Penjualan_NomorNota UNIQUE,
        TanggalPenjualan DATETIME2(0) NOT NULL
            CONSTRAINT DF_Penjualan_Tanggal DEFAULT SYSDATETIME(),
        NamaPelanggan NVARCHAR(150) NULL,
        TotalPenjualan DECIMAL(18,2) NOT NULL
            CONSTRAINT DF_Penjualan_Total DEFAULT 0,
        Keterangan NVARCHAR(255) NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.DetailPenjualan', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.DetailPenjualan
    (
        DetailPenjualanID INT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_DetailPenjualan PRIMARY KEY,
        PenjualanID INT NOT NULL,
        ProdukID INT NOT NULL,
        Jumlah INT NOT NULL
            CONSTRAINT CK_DetailPenjualan_Jumlah CHECK (Jumlah > 0),
        HargaJual DECIMAL(18,2) NOT NULL
            CONSTRAINT CK_DetailPenjualan_HargaJual CHECK (HargaJual >= 0),
        Subtotal AS (Jumlah * HargaJual) PERSISTED,

        CONSTRAINT FK_DetailPenjualan_Penjualan
            FOREIGN KEY (PenjualanID) REFERENCES dbo.Penjualan(PenjualanID),

        CONSTRAINT FK_DetailPenjualan_Produk
            FOREIGN KEY (ProdukID) REFERENCES dbo.Produk(ProdukID)
    );
END;
GO

/* 5. Membuat tabel riwayat stok */

IF OBJECT_ID(N'dbo.RiwayatStok', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RiwayatStok
    (
        RiwayatStokID INT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_RiwayatStok PRIMARY KEY,
        ProdukID INT NOT NULL,
        TanggalTransaksi DATETIME2(0) NOT NULL
            CONSTRAINT DF_RiwayatStok_Tanggal DEFAULT SYSDATETIME(),
        JenisTransaksi VARCHAR(20) NOT NULL
            CONSTRAINT CK_RiwayatStok_Jenis
            CHECK (JenisTransaksi IN ('PEMBELIAN', 'PENJUALAN', 'PENYESUAIAN')),
        Jumlah INT NOT NULL
            CONSTRAINT CK_RiwayatStok_Jumlah CHECK (Jumlah <> 0),
        Referensi VARCHAR(30) NULL,
        Keterangan NVARCHAR(255) NULL,

        CONSTRAINT FK_RiwayatStok_Produk
            FOREIGN KEY (ProdukID) REFERENCES dbo.Produk(ProdukID)
    );
END;
GO

/* 6. Contoh data kategori */

IF NOT EXISTS (SELECT 1 FROM dbo.Kategori)
BEGIN
    INSERT INTO dbo.Kategori
        (NamaKategori, Deskripsi)
    VALUES
        (N'Kabel dan Aksesoris', N'Kabel listrik dan perlengkapannya'),
        (N'Saklar dan Stop Kontak', N'Saklar, fitting, dan stop kontak'),
        (N'Lampu', N'Lampu LED dan lampu lainnya'),
        (N'Peralatan Instalasi', N'Peralatan untuk instalasi listrik'),
        (N'Peralatan Pengaman', N'MCB, fuse, dan pengaman listrik');
END;
GO

/* 7. Contoh data supplier */

IF NOT EXISTS (SELECT 1 FROM dbo.Supplier)
BEGIN
    INSERT INTO dbo.Supplier
        (NamaSupplier, NamaKontak, NoTelepon, Email, Alamat)
    VALUES
        (N'PT Sinar Terang Elektrik', N'Budi Santoso',
         '021-5551001', 'sales@sinarterang.co.id',
         N'Jakarta Barat'),

        (N'CV Maju Jaya Teknik', N'Andi Wijaya',
         '022-5552002', 'order@majujaya.co.id',
         N'Bandung'),

        (N'PT Cahaya Abadi', N'Siti Rahma',
         '031-5553003', 'marketing@cahayaabadi.co.id',
         N'Surabaya');
END;
GO

/* 8. Contoh data produk */

IF NOT EXISTS (SELECT 1 FROM dbo.Produk)
BEGIN
    INSERT INTO dbo.Produk
        (KodeProduk, NamaProduk, KategoriID, SupplierID, Satuan,
         HargaBeli, HargaJual, StokMinimum, Stok)
    VALUES
        ('KBL-NYM-2X15',
         N'Kabel NYM 2 x 1.5 mm',
         1, 1, N'Meter', 8500, 11000, 100, 500),

        ('KBL-NYM-3X25',
         N'Kabel NYM 3 x 2.5 mm',
         1, 1, N'Meter', 15000, 19000, 75, 300),

        ('SKL-TGL-01',
         N'Saklar Tunggal',
         2, 2, N'Pcs', 12000, 17000, 20, 80),

        ('STK-UNV-01',
         N'Stop Kontak Universal',
         2, 2, N'Pcs', 18000, 25000, 20, 60),

        ('LMP-LED-12W',
         N'Lampu LED 12 Watt',
         3, 3, N'Pcs', 18000, 28000, 25, 100),

        ('LMP-LED-18W',
         N'Lampu LED 18 Watt',
         3, 3, N'Pcs', 25000, 38000, 20, 75),

        ('TST-OBENG-01',
         N'Tespen Obeng',
         4, 2, N'Pcs', 7000, 12000, 15, 50),
         
         ('MCB-1P-06A',
         N'MCB 1 Pole 6A',
         5, 1, N'Pcs', 35000, 48000, 10, 30);
END;
GO

/* 9. Contoh transaksi pembelian */

IF NOT EXISTS (SELECT 1 FROM dbo.Pembelian)
BEGIN
    INSERT INTO dbo.Pembelian
        (NomorFaktur, TanggalPembelian, SupplierID, TotalPembelian, Keterangan)
    VALUES
        ('PB-2026-0001', '2026-01-05', 1, 0,
         N'Pembelian stok awal kabel dan MCB'),

        ('PB-2026-0002', '2026-01-07', 2, 0,
         N'Pembelian saklar dan alat instalasi');
END;
GO

INSERT INTO dbo.DetailPembelian
    (PembelianID, ProdukID, Jumlah, HargaBeli)
SELECT 1, ProdukID, 100, HargaBeli
FROM dbo.Produk
WHERE KodeProduk = 'KBL-NYM-2X15'
AND NOT EXISTS
(
    SELECT 1
    FROM dbo.DetailPembelian
    WHERE PembelianID = 1
      AND ProdukID = dbo.Produk.ProdukID
);

INSERT INTO dbo.DetailPembelian
    (PembelianID, ProdukID, Jumlah, HargaBeli)
SELECT 1, ProdukID, 10, HargaBeli
FROM dbo.Produk
WHERE KodeProduk = 'MCB-1P-06A'
AND NOT EXISTS
(
    SELECT 1
    FROM dbo.DetailPembelian
    WHERE PembelianID = 1
      AND ProdukID = dbo.Produk.ProdukID
);

INSERT INTO dbo.DetailPembelian
    (PembelianID, ProdukID, Jumlah, HargaBeli)
SELECT 2, ProdukID, 20, HargaBeli
FROM dbo.Produk
WHERE KodeProduk = 'SKL-TGL-01'
AND NOT EXISTS
(
    SELECT 1
    FROM dbo.DetailPembelian
    WHERE PembelianID = 2
      AND ProdukID = dbo.Produk.ProdukID
);
GO

/* Memperbarui total pembelian */
UPDATE P
SET TotalPembelian =
(
    SELECT COALESCE(SUM(DP.Subtotal), 0)
    FROM dbo.DetailPembelian AS DP
    WHERE DP.PembelianID = P.PembelianID
)
FROM dbo.Pembelian AS P;
GO

/* 10. Contoh transaksi penjualan */

IF NOT EXISTS (SELECT 1 FROM dbo.Penjualan)
BEGIN
    INSERT INTO dbo.Penjualan
        (NomorNota, TanggalPenjualan, NamaPelanggan, TotalPenjualan, Keterangan)
    VALUES
        ('PJ-2026-0001', '2026-01-10 09:30:00',
         N'Bapak Joko', 0, N'Pembelian kebutuhan rumah'),

        ('PJ-2026-0002', '2026-01-11 14:15:00',
         N'Ibu Rina', 0, N'Pembelian lampu dan stop kontak');
END;
GO

INSERT INTO dbo.DetailPenjualan
    (PenjualanID, ProdukID, Jumlah, HargaJual)
SELECT 1, ProdukID, 20, HargaJual
FROM dbo.Produk
WHERE KodeProduk = 'KBL-NYM-2X15'
AND NOT EXISTS
(
    SELECT 1
    FROM dbo.DetailPenjualan
    WHERE PenjualanID = 1
      AND ProdukID = dbo.Produk.ProdukID
);

INSERT INTO dbo.DetailPenjualan
    (PenjualanID, ProdukID, Jumlah, HargaJual)
SELECT 1, ProdukID, 2, HargaJual
FROM dbo.Produk
WHERE KodeProduk = 'MCB-1P-06A'
AND NOT EXISTS
(
    SELECT 1
    FROM dbo.DetailPenjualan
    WHERE PenjualanID = 1
      AND ProdukID = dbo.Produk.ProdukID
);

INSERT INTO dbo.DetailPenjualan
    (PenjualanID, ProdukID, Jumlah, HargaJual)
SELECT 2, ProdukID, 5, HargaJual
FROM dbo.Produk
WHERE KodeProduk = 'LMP-LED-12W'
AND NOT EXISTS
(
    SELECT 1
    FROM dbo.DetailPenjualan
    WHERE PenjualanID = 2
      AND ProdukID = dbo.Produk.ProdukID
);

INSERT INTO dbo.DetailPenjualan
    (PenjualanID, ProdukID, Jumlah, HargaJual)
SELECT 2, ProdukID, 2, HargaJual
FROM dbo.Produk
WHERE KodeProduk = 'STK-UNV-01'
AND NOT EXISTS
(
    SELECT 1
    FROM dbo.DetailPenjualan
    WHERE PenjualanID = 2
      AND ProdukID = dbo.Produk.ProdukID
);
GO

/* Memperbarui total penjualan */
UPDATE P
SET TotalPenjualan =
(
    SELECT COALESCE(SUM(DPJ.Subtotal), 0)
    FROM dbo.DetailPenjualan AS DPJ
    WHERE DPJ.PenjualanID = P.PenjualanID
)
FROM dbo.Penjualan AS P;
GO

/* 11. Mencatat riwayat stok */
INSERT INTO dbo.RiwayatStok
    (ProdukID, JenisTransaksi, Jumlah, Referensi, Keterangan)
SELECT DP.ProdukID, 'PEMBELIAN', DP.Jumlah,
       P.NomorFaktur, N'Stok masuk dari pembelian'
FROM dbo.DetailPembelian AS DP
INNER JOIN dbo.Pembelian AS P
    ON P.PembelianID = DP.PembelianID
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.RiwayatStok AS RS
    WHERE RS.Referensi = P.NomorFaktur
      AND RS.ProdukID = DP.ProdukID
      AND RS.JenisTransaksi = 'PEMBELIAN'
);

INSERT INTO dbo.RiwayatStok
    (ProdukID, JenisTransaksi, Jumlah, Referensi, Keterangan)
SELECT DPJ.ProdukID, 'PENJUALAN', -DPJ.Jumlah,
       PJ.NomorNota, N'Stok keluar dari penjualan'
FROM dbo.DetailPenjualan AS DPJ
INNER JOIN dbo.Penjualan AS PJ
    ON PJ.PenjualanID = DPJ.PenjualanID
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.RiwayatStok AS RS
    WHERE RS.Referensi = PJ.NomorNota
      AND RS.ProdukID = DPJ.ProdukID
      AND RS.JenisTransaksi = 'PENJUALAN'
);
GO

/* 12. Contoh query melihat stok */
SELECT
    P.KodeProduk,
    P.NamaProduk,
    K.NamaKategori,
    S.NamaSupplier,
    P.Satuan,
    P.HargaBeli,
    P.HargaJual,
    P.StokMinimum,
    P.Stok,
    CASE
        WHEN P.Stok <= P.StokMinimum THEN N'Perlu Restok'
        ELSE N'Aman'
    END AS StatusStok
FROM dbo.Produk AS P
INNER JOIN dbo.Kategori AS K
    ON K.KategoriID = P.KategoriID
INNER JOIN dbo.Supplier AS S
    ON S.SupplierID = P.SupplierID
ORDER BY P.NamaProduk;
GO