create table staff(
    id_staff varchar(255) primary key,
    nama_sf varchar(255)
);

create table barang(
    id_brg varchar(255) primary key,
    nama_brg varchar(255),
    stok integer check (stok >= 0),
    kondisi varchar(255) check (kondisi in ('Baik', 'Rusak', 'Hilang'))
);

create table mahasiswa(
    nim integer primary key,
    nama_mhs varchar(255),
    kelas varchar(50),
    status varchar(255) check (status in ('Aktif', 'Alumni'))
);

create table dosen(
    nip integer primary key,
    nama_ds varchar(255)
);

create table peminjaman(
    id_pnjm varchar(255) primary key,
    status_pnjm varchar(255) check (status_pnjm in (
        'Belum Diverifikasi', 'Tidak Diizinkan',
        'Sedang Dipinjam', 'Peminjaman Selesai')),
    tgl_pinjam date,
    tgl_kembali date,
    mahasiswa_nim integer,
    dosen_nip integer,
    staff_id_staff varchar(255),
    barang_id_brg varchar(255),
    constraint peminjaman_barang_fk foreign key (barang_id_brg) references barang (id_brg),
    constraint peminjaman_dosen_fk foreign key (dosen_nip) references dosen (nip),
    constraint peminjaman_mahasiswa_fk foreign key (mahasiswa_nim) references mahasiswa (nim),
    constraint peminjaman_staff_fk foreign key (staff_id_staff) references staff (id_staff),
    constraint tgl_kembali_ck check (tgl_kembali <= tgl_pinjam + 7)
);

create table log_peminjaman(
    id_log varchar(255) primary key,
    status_brg varchar(255),
    tgl_log date,
    peminjaman_id_pnjm varchar(255),
    constraint log_peminjaman_peminjaman_fk
        foreign key (peminjaman_id_pnjm) references peminjaman(id_pnjm)
);