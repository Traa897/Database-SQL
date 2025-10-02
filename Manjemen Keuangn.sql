-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 02 Okt 2025 pada 15.35
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS manajemen_keuangan;
USE manajemen_keuangan;

-- --------------------------------------------------------
-- Struktur dari tabel `jurusan`
CREATE TABLE `jurusan` (
  `id_jurusan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_jurusan` varchar(100) NOT NULL,
  PRIMARY KEY (`id_jurusan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `jurusan` (`id_jurusan`, `nama_jurusan`) VALUES
(1, 'Sistem Informasi'),
(2, 'Sistem Informasi'),
(3, 'Sistem Informasi'),
(4, 'Statistika'),
(5, 'Sistem Informasi');

-- --------------------------------------------------------
-- Struktur dari tabel `kategori`
CREATE TABLE `kategori` (
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
-- Struktur dari tabel `mahasiswa`
CREATE TABLE `mahasiswa` (
  `nim` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `id_jurusan` int(11) NOT NULL,
  PRIMARY KEY (`nim`),
  KEY `id_jurusan` (`id_jurusan`),
  CONSTRAINT `mahasiswa_ibfk_1` FOREIGN KEY (`id_jurusan`) REFERENCES `jurusan` (`id_jurusan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `mahasiswa` (`nim`, `nama`, `id_jurusan`) VALUES
(10241013, 'Arman', 2),
(10241017, 'Chiko Dhiva Pramana', 1),
(10241033, 'Fitriansyah Wicaksonoaji', 1),
(10241061, 'Patra Ananda', 1),
(16241014, 'Catherine Gunawan', 3);

-- --------------------------------------------------------
-- Struktur dari tabel `pemasukan`
CREATE TABLE `pemasukan` (
  `id_pemasukan` int(11) NOT NULL AUTO_INCREMENT,
  `nim` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(12,2) NOT NULL,
  `id_sumber` int(11) NOT NULL,
  PRIMARY KEY (`id_pemasukan`),
  KEY `nim` (`nim`),
  KEY `id_sumber` (`id_sumber`),
  CONSTRAINT `pemasukan_ibfk_1` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`),
  CONSTRAINT `pemasukan_ibfk_2` FOREIGN KEY (`id_sumber`) REFERENCES `sumber` (`id_sumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `pemasukan` (`id_pemasukan`, `nim`, `tanggal`, `jumlah`, `id_sumber`) VALUES
(1, 10241033, '2025-10-01', 1300000.00, 1),
(2, 10241017, '2025-10-01', 6000000.00, 2),
(3, 10241061, '2025-10-01', 2000000.00, 1),
(4, 16241014, '2025-10-01', 4000000.00, 1),
(5, 10241013, '2025-10-02', 2500000.00, 3);

-- --------------------------------------------------------
-- Struktur dari tabel `pengeluaran`
CREATE TABLE `pengeluaran` (
  `id_pengeluaran` int(11) NOT NULL AUTO_INCREMENT,
  `nim` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(12,2) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  PRIMARY KEY (`id_pengeluaran`),
  KEY `nim` (`nim`),
  KEY `id_kategori` (`id_kategori`),
  CONSTRAINT `pengeluaran_ibfk_1` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`),
  CONSTRAINT `pengeluaran_ibfk_2` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `pengeluaran` (`id_pengeluaran`, `nim`, `tanggal`, `jumlah`, `id_kategori`) VALUES
(1, 10241033, '2025-10-01', 50000.00, 1),
(2, 10241033, '2025-10-02', 30000.00, 2),
(3, 10241017, '2025-10-01', 185000.00, 4),
(4, 10241061, '2025-10-03', 100000.00, 1),
(5, 16241014, '2025-10-04', 1300000.00, 3);

-- --------------------------------------------------------
-- Struktur dari tabel `sumber`
CREATE TABLE `sumber` (
  `id_sumber` int(11) NOT NULL AUTO_INCREMENT,
  `nama_sumber` varchar(100) NOT NULL,
  PRIMARY KEY (`id_sumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `sumber` (`id_sumber`, `nama_sumber`) VALUES
(1, 'Uang Saku'),
(2, 'Beasiswa'),
(3, 'Part-time'),
(4, 'Freelance'),
(5, 'Lain-lain');

-- --------------------------------------------------------
-- Tambahan Query SELECT (WHERE, ORDER BY, GROUP BY)

-- 1. WHERE: Cari pengeluaran mahasiswa tertentu
SELECT m.nama, p.tanggal, p.jumlah, k.nama_kategori
FROM pengeluaran p
WHERE m.nama = 'Fitriansyah Wicaksonoaji';

-- 2. ORDER BY: Urutkan pemasukan mahasiswa berdasarkan jumlah terbesar ke terkecil
SELECT m.nama, pm.tanggal, s.nama_sumber, pm.jumlah
FROM pemasukan pm
ORDER BY pm.jumlah DESC;

-- 3. GROUP BY: Hitung total pengeluaran per kategori
SELECT k.nama_kategori, SUM(p.jumlah) AS total_pengeluaran
FROM pengeluaran p
GROUP BY k.nama_kategori;

COMMIT;
