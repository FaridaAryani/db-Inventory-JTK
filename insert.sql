-- Menambah data ke tabel staff
insert into staff (id_staff, nama_sf) values ('S001', 'Budi Setiawan');
insert into staff (id_staff, nama_sf) values ('S002', 'Siti Aisyah');
insert into staff (id_staff, nama_sf) values ('S003', 'Diana Lestari');

-- Menambah data ke tabel barang
insert into barang (id_brg, nama_brg, stok, kondisi) values ('B001', 'Laptop', 10, 'Baik');
insert into barang (id_brg, nama_brg, stok, kondisi) values ('B002', 'Proyektor', 5, 'Rusak');
insert into barang (id_brg, nama_brg, stok, kondisi) values ('B003', 'Kursi Kantor', 15, 'Baik');

-- Menambah data ke tabel mahasiswa
insert into mahasiswa (nim, nama_mhs, kelas, status) values (12345, 'Andi Pratama', 'D3 A', 'Aktif');
insert into mahasiswa (nim, nama_mhs, kelas, status) values (12346, 'Budi Santoso', 'D4 B', 'Aktif');
insert into mahasiswa (nim, nama_mhs, kelas, status) values (12347, 'Siti Nurbaya', 'D3 B', 'Alumni');

-- Menambah data ke tabel dosen
insert into dosen (nip, nama_ds) values (67890, 'Dr. M. Fauzan');
insert into dosen (nip, nama_ds) values (67891, 'Dr. Rina Kumalasari');
insert into dosen (nip, nama_ds) values (67892, 'Prof. John Doe');

-- Menambah data ke tabel peminjaman
insert into peminjaman (id_pnjm, status_pnjm, tgl_pinjam, tgl_kembali, mahasiswa_nim, dosen_nip, staff_id_staff, barang_id_brg)
values ('PN001', 'Sedang Dipinjam', to_date('2024-11-01', 'YYYY-MM-DD'), to_date('2024-11-08', 'YYYY-MM-DD'), 12345, 67890, 'S001', 'B001');

insert into peminjaman (id_pnjm, status_pnjm, tgl_pinjam, tgl_kembali, mahasiswa_nim, dosen_nip, staff_id_staff, barang_id_brg)
values ('PN002', 'Sedang Dipinjam', to_date('2024-11-02', 'YYYY-MM-DD'), to_date('2024-11-09', 'YYYY-MM-DD'), 12346, 67891, 'S002', 'B003');

insert into peminjaman (id_pnjm, status_pnjm, tgl_pinjam, tgl_kembali, mahasiswa_nim, dosen_nip, staff_id_staff, barang_id_brg)
values ('PN003', 'Belum Diverifikasi', to_date('2024-11-03', 'YYYY-MM-DD'), NULL, 12345, 67892, 'S003', 'B002');
