-- Insert into dosen
INSERT INTO dosen (nip, nama_dsn) VALUES (12345, 'Dr. John Doe');
INSERT INTO dosen (nip, nama_dsn) VALUES (12678, 'Prof. Jane Smith');

-- Insert into mahasiswa
INSERT INTO mahasiswa (nim, nama_mhs, kelas, status) VALUES (22311, 'Alice', '2A-D4', 'aktif');
INSERT INTO mahasiswa (nim, nama_mhs, kelas, status) VALUES (21922, 'Chad', '4B-D2', 'alumni');
INSERT INTO mahasiswa (nim, nama_mhs, kelas, status) VALUES (22333, 'Bob', '2C-D3', 'aktif');

-- Insert into staff
INSERT INTO staf (id_staff, nama_staff) VALUES ('30001', 'Charlie');
INSERT INTO staf (id_staff, nama_staff) VALUES ('30002', 'David');

-- Insert into barang
INSERT INTO barang (id_brg, nama_brg, kondisi, status_brg) VALUES ('1001', 'Terminal', 'baik', 'tersedia');
INSERT INTO barang (id_brg, nama_brg, kondisi, status_brg) VALUES ('1002', 'Terminal', 'rusak', 'tidak ada');
INSERT INTO barang (id_brg, nama_brg, kondisi, status_brg) VALUES ('2003', 'Infocus', 'baik', 'tidak ada');
INSERT INTO barang (id_brg, nama_brg, kondisi, status_brg) VALUES ('2004', 'Infocus', 'baik', 'tersedia');
INSERT INTO barang (id_brg, nama_brg, kondisi, status_brg) VALUES ('3005', 'Ekstensi', 'rusak', 'tersedia');
INSERT INTO barang (id_brg, nama_brg, kondisi, status_brg) VALUES ('3006', 'Ekstensi', 'baik', 'tidak ada');
INSERT INTO barang (id_brg, nama_brg, kondisi, status_brg) VALUES ('4007', 'Paketan', 'rusak', 'tidak ada');

COMMIT;