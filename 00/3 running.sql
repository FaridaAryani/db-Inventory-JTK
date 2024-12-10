-- Buat akun aju
DECLARE
    v_akun_role VARCHAR2(100);
BEGIN
    insert_akun_aju(1, v_akun_role, 'S001', 23011, NULL);
END;
/

--- buat record peminjaman (test 1: gagal | test 2: berhasil)
BEGIN
    insert_peminjaman('P003', 'sedang dipinjam', 'B002', 1);
END;
/

BEGIN
    insert_peminjaman('P001', 'sedang dipinjam', 'B001', 1);
END;
/
