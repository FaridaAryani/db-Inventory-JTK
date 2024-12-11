-- Intansiasi data

-- Insert data into mahasiswa
INSERT INTO mahasiswa (nim, nama_mhs, kelas, status, akun_aju_id_akun) 
VALUES (2101, 'Budi Santoso', 'IF-21-A', 'Aktif', null);

-- Insert data into mahasiswa
INSERT INTO mahasiswa (nim, nama_mhs, kelas, status, akun_aju_id_akun) 
VALUES (2102, 'Ratna P', 'IF-22-A', 'Aktif', null);

-- Insert data into mahasiswa (Alumni)
INSERT INTO mahasiswa (nim, nama_mhs, kelas, status, akun_aju_id_akun) 
VALUES (2100, 'Badas', 'IF-20-A', 'Alumni', null);

-- Insert data into mahasiswa (Alumni)
INSERT INTO mahasiswa (nim, nama_mhs, kelas, status, akun_aju_id_akun) 
VALUES (2103, 'Caca', 'IF-23-A', 'Aktif', null);

-- Insert data into dosen
INSERT INTO dosen (nip, nama_dsn, akun_aju_id_akun) 
VALUES (12345, 'Dr. Ahmad Subagio', null);

-- Insert data into dosen
INSERT INTO dosen (nip, nama_dsn, akun_aju_id_akun) 
VALUES (12347, 'Dr. Habibie Iskandar', null);

-- Insert data into staf
INSERT INTO staf (id_staff, nama_staff, akun_aju_id_akun) 
VALUES (301, 'Sri Utami', null);

-- Insert data into staf
INSERT INTO staf (id_staff, nama_staff, akun_aju_id_akun) 
VALUES (302, 'Lies Fadilah', null);

-- Insert data into barang
INSERT INTO barang (id_brg, nama_brg, status_brg, kondisi) 
VALUES (101, 'Proyektor', 'Tersedia', 'Baik');
INSERT INTO barang (id_brg, nama_brg, status_brg, kondisi) 
VALUES (102, 'Laptop', 'Dipinjam', 'Baik');
INSERT INTO barang (id_brg, nama_brg, status_brg, kondisi) 
VALUES (103, 'Kamera', 'Rusak', 'Rusak');
INSERT INTO barang (id_brg, nama_brg, status_brg, kondisi) 
VALUES (104, 'Kamera', 'Tersedia', 'Baik');
INSERT INTO barang (id_brg, nama_brg, status_brg, kondisi) 
VALUES (105, 'Laptop', 'Tersedia', 'Baik');

-- Insert data into peminjaman
INSERT INTO peminjaman (id_pinjam, status_pinjam, tgl_pinjam, tgl_kembali, barang_id_brg, akun_aju_id_akun) 
VALUES (1001, 'Sedang Dipinjam', TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-15', 'YYYY-MM-DD'), 102, 1);

-- Insert data into peminjaman
INSERT INTO peminjaman (id_pinjam, status_pinjam, tgl_pinjam, tgl_kembali, barang_id_brg, akun_aju_id_akun) 
VALUES (1002, 'Belum Diverifikasi', TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-08', 'YYYY-MM-DD'), 104, 5);

-- Insert data into log_peminjaman
INSERT INTO log_peminjaman (id_log, status_brg, tgl_log, peminjaman_id_pinjam) 
VALUES (5001, 'Dipinjam', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 1001);

