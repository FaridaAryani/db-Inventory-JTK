CREATE TABLE akun_aju (
    id_akun       INTEGER NOT NULL,
    akun_role     VARCHAR2(100),
    staf_id_staf  VARCHAR2(100),
    mahasiswa_nim INTEGER,
    dosen_nip     INTEGER 
)
LOGGING;

CREATE UNIQUE INDEX akun_aju__idx ON
    akun_aju (
        staf_id_staf
    ASC )
        LOGGING;

CREATE UNIQUE INDEX akun_aju__idxv1 ON
    akun_aju (
        mahasiswa_nim
    ASC )
        LOGGING;

CREATE UNIQUE INDEX akun_aju__idxv2 ON
    akun_aju (
        dosen_nip
    ASC )
        LOGGING;

ALTER TABLE akun_aju ADD CONSTRAINT akun_aju_pk PRIMARY KEY ( id_akun );

CREATE TABLE barang (
    id_barang  VARCHAR2(100) NOT NULL,
    nama_brg   VARCHAR2(100),
    kondisi    VARCHAR2(100),
    status_brg VARCHAR2(100)
)
LOGGING;

ALTER TABLE barang ADD CONSTRAINT barang_pk PRIMARY KEY ( id_barang );

CREATE TABLE dosen (
    nip              INTEGER NOT NULL,
    nama             VARCHAR2(100),
    akun_aju_id_akun INTEGER 
)
LOGGING;

CREATE UNIQUE INDEX dosen__idx ON
    dosen (
        akun_aju_id_akun
    ASC )
        LOGGING;

ALTER TABLE dosen ADD CONSTRAINT dosen_pk PRIMARY KEY ( nip );

CREATE TABLE log_peminjaman (
    id_log               VARCHAR2(100) NOT NULL,
    status_brg           VARCHAR2(100),
    tgl_log              DATE,
    peminjaman_id_pinjam VARCHAR2(100) NOT NULL
)
LOGGING;

ALTER TABLE log_peminjaman ADD CONSTRAINT log_peminjaman_pk PRIMARY KEY ( id_log );

CREATE TABLE mahasiswa (
    nim              INTEGER NOT NULL,
    nama_mhs         VARCHAR2(100),
    kelas            VARCHAR2(100),
    status           VARCHAR2(100),
    akun_aju_id_akun INTEGER
)
LOGGING;

CREATE UNIQUE INDEX mahasiswa__idx ON
    mahasiswa (
        akun_aju_id_akun
    ASC )
        LOGGING;

ALTER TABLE mahasiswa ADD CONSTRAINT mahasiswa_pk PRIMARY KEY ( nim );

CREATE TABLE peminjaman (
    id_pinjam        VARCHAR2(100) NOT NULL,
    status_pinjam    VARCHAR2(100),
    tgl_pinjam       DATE,
    tgl_kembali      DATE,
    barang_id_barang VARCHAR2(100) NOT NULL,
    akun_aju_id_akun INTEGER NOT NULL
)
LOGGING;

ALTER TABLE peminjaman ADD CONSTRAINT peminjaman_pk PRIMARY KEY ( id_pinjam );

CREATE TABLE staf (
    id_staf          VARCHAR2(100) NOT NULL,
    nama_staf        VARCHAR2(100),
    akun_aju_id_akun INTEGER
)
LOGGING;

CREATE UNIQUE INDEX staf__idx ON
    staf (
        akun_aju_id_akun
    ASC )
        LOGGING;

ALTER TABLE staf ADD CONSTRAINT staf_pk PRIMARY KEY ( id_staf );

ALTER TABLE akun_aju
    ADD CONSTRAINT akun_aju_dosen_fk
        FOREIGN KEY ( dosen_nip )
            REFERENCES dosen ( nip )
            NOT DEFERRABLE;

ALTER TABLE akun_aju
    ADD CONSTRAINT akun_aju_mahasiswa_fk
        FOREIGN KEY ( mahasiswa_nim )
            REFERENCES mahasiswa ( nim )
            NOT DEFERRABLE;

ALTER TABLE akun_aju
    ADD CONSTRAINT akun_aju_staf_fk
        FOREIGN KEY ( staf_id_staf )
            REFERENCES staf ( id_staf )
            NOT DEFERRABLE;

ALTER TABLE dosen
    ADD CONSTRAINT dosen_akun_aju_fk
        FOREIGN KEY ( akun_aju_id_akun )
            REFERENCES akun_aju ( id_akun )
            NOT DEFERRABLE;

ALTER TABLE log_peminjaman
    ADD CONSTRAINT log_peminjaman_peminjaman_fk
        FOREIGN KEY ( peminjaman_id_pinjam )
            REFERENCES peminjaman ( id_pinjam )
            NOT DEFERRABLE;

ALTER TABLE mahasiswa
    ADD CONSTRAINT mahasiswa_akun_aju_fk
        FOREIGN KEY ( akun_aju_id_akun )
            REFERENCES akun_aju ( id_akun )
            NOT DEFERRABLE;

ALTER TABLE peminjaman
    ADD CONSTRAINT peminjaman_akun_aju_fk
        FOREIGN KEY ( akun_aju_id_akun )
            REFERENCES akun_aju ( id_akun )
            NOT DEFERRABLE;

ALTER TABLE peminjaman
    ADD CONSTRAINT peminjaman_barang_fk
        FOREIGN KEY ( barang_id_barang )
            REFERENCES barang ( id_barang )
            NOT DEFERRABLE;

ALTER TABLE staf
    ADD CONSTRAINT staf_akun_aju_fk
        FOREIGN KEY ( akun_aju_id_akun )
            REFERENCES akun_aju ( id_akun )
            NOT DEFERRABLE;
