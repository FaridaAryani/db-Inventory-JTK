-- Menampilkan pengaju dengan jenis 'Mahasiswa'
execute list_pengaju('Mahasiswa');

-- Menampilkan pengaju dengan jenis 'Dosen'
execute list_pengaju('Dosen');

-- Cek stok barang yang sedang dipinjam
select cek_stok_barang('B001') from dual;  -- Harus mengembalikan "Tidak Tersedia" jika barang sedang dipinjam
select cek_stok_barang('B002') from dual;  -- Harus mengembalikan "Tersedia" jika barang tidak dipinjam

-- Menampilkan peminjaman dengan status 'Belum Diverifikasi'
execute list_peminjaman('Belum Diverifikasi');

-- Menampilkan peminjaman dengan status 'Peminjaman Selesai'
execute list_peminjaman('Peminjaman Selesai');

-- Update status peminjaman menjadi 'Sedang Dipinjam' untuk memicu log
update peminjaman set status_pinjam = 'Sedang Dipinjam' where id_pinjam = 'P003';

-- Update status peminjaman menjadi 'Peminjaman Selesai' untuk memicu log
update peminjaman set status_pinjam = 'Peminjaman Selesai' where id_pinjam = 'P001';

-- Cek stok barang yang sedang dipinjam
select cek_stok_barang('B001') from dual;  -- Harus mengembalikan "Tidak Tersedia" jika barang sedang dipinjam
select cek_stok_barang('B002') from dual;  -- Harus mengembalikan "Tersedia" jika barang tidak dipinjam

-- Menampilkan log peminjaman dengan status 'Sedang Dipinjam'
execute lihat_log('Sedang Dipinjam');

-- Menampilkan log peminjaman dengan status 'Peminjaman Selesai'
execute lihat_log('Peminjaman Selesai');

-- Menampilkan barang dengan kondisi 'Baik'
execute list_barang('Baik');

-- Menampilkan barang dengan kondisi 'Rusak'
execute list_barang('Rusak');
