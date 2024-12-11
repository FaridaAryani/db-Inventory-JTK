CREATE TABLE akun_aju (
    id_akun   INTEGER NOT NULL,
    akun_role VARCHAR2(100)
);

ALTER TABLE akun_aju ADD CONSTRAINT akun_aju_pk PRIMARY KEY ( id_akun );

CREATE TABLE barang (
    id_brg     INTEGER NOT NULL,
    nama_brg   VARCHAR2(100),
    status_brg VARCHAR2(100),
    kondisi    VARCHAR2(100)
);

ALTER TABLE barang ADD CONSTRAINT barang_pk PRIMARY KEY ( id_brg );

CREATE TABLE dosen (
    nip              INTEGER NOT NULL,
    nama_dsn         VARCHAR2(100),
    akun_aju_id_akun INTEGER 
);

CREATE UNIQUE INDEX dosen__idx ON
    dosen (
        akun_aju_id_akun
    ASC );

ALTER TABLE dosen ADD CONSTRAINT dosen_pk PRIMARY KEY ( nip );

CREATE TABLE log_peminjaman (
    id_log               INTEGER NOT NULL,
    status_brg           VARCHAR2(100),
    tgl_log              DATE,
    peminjaman_id_pinjam INTEGER NOT NULL
);

ALTER TABLE log_peminjaman ADD CONSTRAINT log_peminjaman_pk PRIMARY KEY ( id_log );

CREATE TABLE mahasiswa (
    nim              INTEGER NOT NULL,
    nama_mhs         VARCHAR2(100),
    kelas            VARCHAR2(100),
    status           VARCHAR2(100),
    akun_aju_id_akun INTEGER 
);

CREATE UNIQUE INDEX mahasiswa__idx ON
    mahasiswa (
        akun_aju_id_akun
    ASC );

ALTER TABLE mahasiswa ADD CONSTRAINT mahasiswa_pk PRIMARY KEY ( nim );

CREATE TABLE peminjaman (
    id_pinjam        INTEGER NOT NULL,
    status_pinjam    VARCHAR2(100),
    tgl_pinjam       DATE,
    tgl_kembali      DATE,
    barang_id_brg    INTEGER NOT NULL,
    akun_aju_id_akun INTEGER
);

ALTER TABLE peminjaman ADD CONSTRAINT peminjaman_pk PRIMARY KEY ( id_pinjam );

CREATE TABLE staf (
    id_staff         INTEGER NOT NULL,
    nama_staff       VARCHAR2(100),
    akun_aju_id_akun INTEGER 
);

CREATE UNIQUE INDEX staf__idx ON
    staf (
        akun_aju_id_akun
    ASC );

ALTER TABLE staf ADD CONSTRAINT staf_pk PRIMARY KEY ( id_staff );

ALTER TABLE dosen
    ADD CONSTRAINT dosen_akun_aju_fk FOREIGN KEY ( akun_aju_id_akun )
        REFERENCES akun_aju ( id_akun );

ALTER TABLE log_peminjaman
    ADD CONSTRAINT log_peminjaman_peminjaman_fk FOREIGN KEY ( peminjaman_id_pinjam )
        REFERENCES peminjaman ( id_pinjam );

ALTER TABLE mahasiswa
    ADD CONSTRAINT mahasiswa_akun_aju_fk FOREIGN KEY ( akun_aju_id_akun )
        REFERENCES akun_aju ( id_akun );

ALTER TABLE peminjaman
    ADD CONSTRAINT peminjaman_akun_aju_fk FOREIGN KEY ( akun_aju_id_akun )
        REFERENCES akun_aju ( id_akun );

ALTER TABLE peminjaman
    ADD CONSTRAINT peminjaman_barang_fk FOREIGN KEY ( barang_id_brg )
        REFERENCES barang ( id_brg );

ALTER TABLE staf
    ADD CONSTRAINT staf_akun_aju_fk FOREIGN KEY ( akun_aju_id_akun )
        REFERENCES akun_aju ( id_akun );
