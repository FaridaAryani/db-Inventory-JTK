CREATE OR REPLACE VIEW v_log_peminjaman AS
SELECT 
    lp.id_log,
    lp.status_brg AS log_status_brg,
    lp.tgl_log,
    p.id_pinjam,
    p.status_pinjam,
    p.tgl_pinjam,
    p.tgl_kembali,
    b.nama_brg,
    b.status_brg AS barang_status_brg,
    b.kondisi
FROM 
    log_peminjaman lp
JOIN 
    peminjaman p ON lp.peminjaman_id_pinjam = p.id_pinjam
JOIN 
    barang b ON p.barang_id_brg = b.id_brg;
    
CREATE OR REPLACE VIEW v_list_barang AS
SELECT 
    b.id_brg,
    b.nama_brg,
    b.status_brg,
    b.kondisi
FROM 
    barang b;

CREATE OR REPLACE VIEW v_list_pengaju AS
SELECT 
    a.id_akun,
    a.akun_role,
    CASE a.akun_role
        WHEN 'Mahasiswa' THEN (SELECT m.nama_mhs FROM mahasiswa m WHERE m.akun_aju_id_akun = a.id_akun)
        WHEN 'Dosen' THEN (SELECT d.nama_dsn FROM dosen d WHERE d.akun_aju_id_akun = a.id_akun)
        WHEN 'Staf' THEN (SELECT s.nama_staff FROM staf s WHERE s.akun_aju_id_akun = a.id_akun)
    END AS nama_pengaju
FROM 
    akun_aju a;
    
CREATE OR REPLACE VIEW v_list_peminjaman AS
SELECT 
    p.id_pinjam,
    p.status_pinjam,
    p.tgl_pinjam,
    p.tgl_kembali,
    b.nama_brg,
    b.status_brg AS barang_status_brg,
    b.kondisi,
    a.id_akun AS id_pengaju,
    CASE a.akun_role
        WHEN 'Mahasiswa' THEN (SELECT m.nama_mhs FROM mahasiswa m WHERE m.akun_aju_id_akun = a.id_akun)
        WHEN 'Dosen' THEN (SELECT d.nama_dsn FROM dosen d WHERE d.akun_aju_id_akun = a.id_akun)
        WHEN 'Staf' THEN (SELECT s.nama_staff FROM staf s WHERE s.akun_aju_id_akun = a.id_akun)
    END AS nama_pengaju
FROM 
    peminjaman p
JOIN 
    barang b ON p.barang_id_brg = b.id_brg
JOIN 
    akun_aju a ON p.akun_aju_id_akun = a.id_akun;
    
SELECT 
    nama_brg AS "Nama Barang",
    SUM(CASE WHEN status_brg = 'Dipinjam' THEN 1 ELSE 0 END) AS "Jumlah Dipinjam",
    SUM(CASE WHEN status_brg = 'Tersedia' THEN 1 ELSE 0 END) AS "Jumlah Tersedia",
    SUM(CASE WHEN status_brg = 'Rusak' THEN 1 ELSE 0 END) AS "Jumlah Rusak",
    SUM(CASE WHEN status_brg = 'Hilang' THEN 1 ELSE 0 END) AS "Jumlah Hilang"
FROM 
    barang
GROUP BY 
    nama_brg
ORDER BY 
    nama_brg;

CREATE OR REPLACE VIEW v_status_barang AS
SELECT 
    nama_brg AS "Nama Barang",
    SUM(CASE WHEN status_brg = 'Dipinjam' THEN 1 ELSE 0 END) AS "Jumlah Dipinjam",
    SUM(CASE WHEN status_brg = 'Tersedia' THEN 1 ELSE 0 END) AS "Jumlah Tersedia",
    SUM(CASE WHEN status_brg = 'Rusak' THEN 1 ELSE 0 END) AS "Jumlah Rusak",
    SUM(CASE WHEN status_brg = 'Hilang' THEN 1 ELSE 0 END) AS "Jumlah Hilang"
FROM 
    barang
GROUP BY 
    nama_brg
ORDER BY 
    nama_brg;
