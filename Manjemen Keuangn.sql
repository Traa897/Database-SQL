-- phpMyAdmin SQL Dump (Revisi Lengkap)
-- Database: `keuangan_mahasiswa`

-- --------------------------------------------------------
-- Struktur tabel dan data awal (dari file sebelumnya)
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `kategori` (
  `id_kategori` int(11) NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(50) NOT NULL,
  PRIMARY KEY (`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`) VALUES
(1, 'Makan'),
(2, 'Transportasi'),
(3, 'Tempat Tinggal'),
(4, 'Kuliah'),
(5, 'Lain-lain');

-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `mahasiswa` (
  `id_mahasiswa` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `jurusan` varchar(100) NOT NULL,
  PRIMARY KEY (`id_mahasiswa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `mahasiswa` (`id_mahasiswa`, `nama`, `jurusan`) VALUES
(1, 'Fitriansyah Wicaksonoaji', 'Sistem Informasi'),
(2, 'Chiko Dhiva Pramana', 'Sistem Informasi'),
(3, 'Patra Ananda', 'Sistem Informasi'),
(4, 'Catherine Gunawan', 'Statistika'),
(5, 'Arman', 'Teknik Sistem Informasi');

-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `pemasukan` (
  `id_pemasukan` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal` date NOT NULL,
  `jumlah` decimal(12,2) NOT NULL,
  `sumber` varchar(100) DEFAULT NULL,
  `id_mahasiswa` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pemasukan`),
  KEY `id_mahasiswa` (`id_mahasiswa`),
  CONSTRAINT `pemasukan_ibfk_1` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `pemasukan` (`id_pemasukan`, `tanggal`, `jumlah`, `sumber`, `id_mahasiswa`) VALUES
(1, '2025-10-01', 1300000.00, 'Uang Saku', 1),
(2, '2025-10-01', 6000000.00, 'Beasiswa', 2),
(3, '2025-10-01', 2000000.00, 'Uang Saku', 3),
(4, '2025-10-01', 4000000.00, 'Uang Saku', 4),
(5, '2025-10-02', 2500000.00, 'Part-time', 5);

-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `pengeluaran` (
  `id_pengeluaran` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal` date NOT NULL,
  `jumlah` decimal(12,2) NOT NULL,
  `id_mahasiswa` int(11) DEFAULT NULL,
  `id_kategori` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pengeluaran`),
  KEY `id_mahasiswa` (`id_mahasiswa`),
  KEY `id_kategori` (`id_kategori`),
  CONSTRAINT `pengeluaran_ibfk_1` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`),
  CONSTRAINT `pengeluaran_ibfk_2` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `pengeluaran` (`id_pengeluaran`, `tanggal`, `jumlah`, `id_mahasiswa`, `id_kategori`) VALUES
(1, '2025-10-01', 50000.00, 1, 1),
(2, '2025-10-01', 30000.00, 1, 2),
(3, '2025-10-02', 185000.00, 2, 4),
(4, '2025-10-03', 100000.00, 3, 1),
(5, '2025-10-04', 1300000.00, 4, 3);

-- --------------------------------------------------------
-- QUERY SELECT TAMBAHAN (untuk keperluan tugas)
-- --------------------------------------------------------

-- 1. Menampilkan nama mahasiswa dan total pengeluaran mereka (JOIN + GROUP BY)
SELECT m.nama, SUM(p.jumlah) AS total_pengeluaran
FROM mahasiswa m
GROUP BY m.nama;

-- 2. Menampilkan daftar pemasukan lebih dari 2 juta (WHERE + ORDER BY)
SELECT m.nama, pm.sumber, pm.jumlah
FROM pemasukan pm
WHERE pm.jumlah > 2000000
ORDER BY pm.jumlah DESC;

-- 3. Menampilkan kategori pengeluaran dan rata-rata jumlahnya (GROUP BY)
SELECT k.nama_kategori, AVG(pg.jumlah) AS rata_rata_pengeluaran
FROM pengeluaran pg
GROUP BY k.nama_kategori;
