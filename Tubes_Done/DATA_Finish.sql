-- Tambah data staff
insert into staff values ('S001', 'Staff 1');

-- Tambah data barang
insert into barang values ('B001', 'Laptop', 10, 'Baik');
insert into barang values ('B002', 'Proyektor', 5, 'Baik');

-- Tambah data akun pengaju
insert into akun_aju values (1, 'John Doe', 'Mahasiswa');
insert into akun_aju values (2, 'Jane Smith', 'Dosen');

-- Tambah data mahasiswa
insert into mahasiswa values (1001, 'John Doe', 'IF1', 'Aktif', 1);

-- Tambah data dosen
insert into dosen values (2001, 'Jane Smith', 2);

-- Tambah data peminjaman
insert into peminjaman values ('P001', 'Sedang Dipinjam', SYSDATE, SYSDATE + 7, 'S001', 'B001', 1);
