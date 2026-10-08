/* CREATE DATABASE OjolDB;
GO

USE OjolDB;
GO */

/* CREATE TABLE driver (
	id_driver INT IDENTITY(1,1) PRIMARY KEY,
	nama_driver VARCHAR(100) NOT NULL,
	jenis_kelamin VARCHAR(20) NOT NULL,
	no_hp VARCHAR(20) NOT NULL UNIQUE,
	jenis_kendaraan VARCHAR(50) NOT NULL, 
	plat_nomor VARCHAR(15) NOT NULL UNIQUE,
	status_driver VARCHAR(20) NOT NULL,
	tanggal_daftar DATE NOT NULL 
);
GO */

/* DROP TABLE driver;
GO */

/* INSERT INTO driver
    (nama_driver, jenis_kelamin, no_hp, jenis_kendaraan, plat_nomor, status_driver, tanggal_daftar)
VALUES
    ('Andi Saputra', 'Laki-laki', '081234567801', 'Motor', 'B 1234 ABC', 'Aktif', '2026-01-10'),

    ('Budi Santoso', 'Laki-laki', '081234567802', 'Motor', 'B 2345 DEF', 'Aktif', '2026-01-15'),

    ('Citra Lestari', 'Perempuan', '081234567803', 'Motor', 'B 3456 GHI', 'Aktif', '2026-02-01'),

    ('Dedi Kurniawan', 'Laki-laki', '081234567804', 'Mobil', 'B 4567 JKL', 'Nonaktif', '2026-02-10'),

    ('Eka Pratama', 'Laki-laki', '081234567805', 'Motor', 'B 5678 MNO', 'Aktif', '2026-02-20');
GO */

/* SELECT * FROM driver; */

/* SELECT * 
FROM driver 
WHERE status_driver = 'Aktif'; */

/* SELECT * 
FROM driver 
WHERE jenis_kendaraan = 'Mobil'; */

/* UPDATE driver 
SET status_driver = 'Aktif'
WHERE id_driver = 4; */ 

/* SELECT * FROM driver 
ORDER BY nama_driver ASC; */

/* INSERT INTO driver
    (nama_driver, jenis_kelamin, no_hp, jenis_kendaraan, plat_nomor, status_driver, tanggal_daftar)
VALUES
	('Suryadarma', 'Laki-laki', '085813536258', 'Mobil', 'B 5478 TUK', 'Nonaktif', '2026-04-04'),
    ('Hanas Bayu Pratama', 'Laki-laki', '085819536158', 'Mobil', 'B 5478 HAN', 'Aktif', '2026-01-10');
GO */ 

/* SELECT * FROM driver; */

/* Menghapus semua data tabel */  
/* DELETE FROM driver; */ 

/* DELETE FROM driver 
WHERE id_driver = 7; */

/* INSERT INTO driver
    (nama_driver, jenis_kelamin, no_hp, jenis_kendaraan, plat_nomor, status_driver, tanggal_daftar)
VALUES
	('Nakano Miku', 'Perempuan', '085813536228', 'Motor', 'B 5474 TUK', 'Aktif', '2026-04-04'),
    ('Mitsuba AOI', 'Motor', '085819536157', 'Mobil', 'B 8374 AOI', 'Aktif', '2026-01-10');
GO */

/* UPDATE driver 
SET jenis_kelamin = 'Perempuan'
WHERE nama_driver = 'Mitsuba AOI'; */

/* CREATE TABLE pegawai (
	id_pegawai INT IDENTITY(1,1) PRIMARY KEY,
	nama_pegawai VARCHAR(100) NOT NULL, 
	jenis_kelamin VARCHAR(20) NOT NULL, 
	jabatan VARCHAR(50) NOT NULL,
	no_hp VARCHAR(20) NOT NULL UNIQUE,
	alamat VARCHAR(200),
	status_pegawai VARCHAR(20) NOT NULL,
);
GO */

/* INSERT INTO pegawai
    (nama_pegawai, jenis_kelamin, jabatan, no_hp, alamat, status_pegawai)
VALUES
    ('Andi Saputra', 'Laki-laki', 'Admin', '081234567801', 'Bekasi', 'Aktif'),

    ('Budi Santoso', 'Laki-laki', 'Customer Service', '081234567802', 'Jakarta', 'Aktif'),

    ('Citra Lestari', 'Perempuan', 'Finance', '081234567803', 'Depok', 'Aktif'),

    ('Dewi Anggraini', 'Perempuan', 'HRD', '081234567804', 'Bogor', 'Aktif'),

    ('Eko Pratama', 'Laki-laki', 'IT Support', '081234567805', 'Tangerang', 'Nonaktif');
GO */

/* SELECT * FROM pegawai; */

/* SELECT * FROM pegawai 
WHERE status_pegawai = 'Aktif'; */

/* SELECT * FROM pegawai 
WHERE jabatan = 'Admin'; */

/* SELECT *
FROM pegawai
WHERE nama_pegawai LIKE '%Andi%'; */