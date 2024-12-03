create table staff(
    id_staff varchar(255) not null primary key,
    nama_staff varchar(100)
);

create table barang(
    id_barang varchar(255) not null primary key,
    nama_brg varchar(100),
    stok integer check (stok >= 0),
    kondisi varchar(255) check (kondisi in ('Baik', 'Rusak', 'Hilang'))
);

create table akun_aju(
    id_akun integer not null primary key,
    nama_pengaju varchar(100),
    jenis_pengaju varchar(255) check (jenis_pengaju in ('Mahasiswa', 'Dosen'))
);

create table dosen(
    nip integer not null primary key,
    nama_dsn varchar(100),
    akun_aju_id_akun integer,
    constraint dosen_akun_aju_fk foreign key (akun_aju_id_akun)
        references akun_aju (id_akun)
);

create table mahasiswa(
    nim integer not null primary key,
    nama_mhs varchar(100),
    kelas varchar(10),
    status varchar(10),
    akun_aju_id_akun integer,
    constraint mahasiswa_akun_aju_fk foreign key (akun_aju_id_akun)
        references akun_aju (id_akun)
);

create table peminjaman(
    id_pinjam varchar(50) not null primary key,
    status_pinjam varchar(255) check (status_pinjam in (
        'Belum Diverifikasi', 'Tidak Diizinkan',
        'Sedang Dipinjam', 'Peminjaman Selesai')),
    tgl_pinjam date,
    tgl_kembali date,
    staff_id_staff varchar(255) not null,
    barang_id_barang varchar(255),
    akun_aju_id_akun integer not null,
    constraint peminjaman_staff_fk foreign key (staff_id_staff)
        references staff (id_staff),
    constraint peminjaman_barang_fk foreign key (barang_id_barang)
        references barang (id_barang),
    constraint peminjaman_akun_aju_fk foreign key (akun_aju_id_akun)
        references akun_aju (id_akun),
    constraint tgl_kembali_ck check (tgl_kembali <= tgl_pinjam + 7)
);

create table log_peminjaman(
    id_log varchar(255) not null primary key,
    status_brg varchar(255),
    tgl_log date,
    peminjaman_id_pinjam varchar(255) not null,
    constraint log_peminjaman_fk foreign key (peminjaman_id_pinjam)
        references peminjaman (id_pinjam)
);