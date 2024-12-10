-- Insert into dosen
INSERT INTO dosen (nip, nama) VALUES (123456, 'Dr. John Doe');
INSERT INTO dosen (nip, nama) VALUES (789012, 'Prof. Jane Smith');

-- Insert into mahasiswa
INSERT INTO mahasiswa (nim, nama_mhs, kelas, status) VALUES (23011, 'Alice', '2A-D4', 'aktif');
INSERT INTO mahasiswa (nim, nama_mhs, kelas, status) VALUES (19022, 'Bob', '4B-D2', 'alumni');
INSERT INTO mahasiswa (nim, nama_mhs, kelas, status) VALUES (23033, 'Bob', '2C-D3', 'aktif');

-- Insert into staff
INSERT INTO staf (id_staf, nama_staf) VALUES ('S001', 'Charlie');
INSERT INTO staf (id_staf, nama_staf) VALUES ('S002', 'David');

-- Insert into barang
INSERT INTO barang (id_barang, nama_brg, kondisi, status_brg) VALUES ('B001', 'Terminal', 'baik', 'tersedia');
INSERT INTO barang (id_barang, nama_brg, kondisi, status_brg) VALUES ('B002', 'Terminal', 'rusak', 'tidak ada');
INSERT INTO barang (id_barang, nama_brg, kondisi, status_brg) VALUES ('B003', 'Infocus', 'baik', 'tidak ada');
INSERT INTO barang (id_barang, nama_brg, kondisi, status_brg) VALUES ('B004', 'Infocus', 'baik', 'tersedia');
INSERT INTO barang (id_barang, nama_brg, kondisi, status_brg) VALUES ('B005', 'Ekstensi', 'rusak', 'tersedia');
INSERT INTO barang (id_barang, nama_brg, kondisi, status_brg) VALUES ('B006', 'Ekstensi', 'baik', 'tidak ada');
INSERT INTO barang (id_barang, nama_brg, kondisi, status_brg) VALUES ('B007', 'Paketan', 'rusak', 'tidak ada');
