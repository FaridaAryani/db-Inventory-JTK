-- Prosedur untuk membuat akun baru
DECLARE
    v_id_akun   NUMBER := 101;                  -- ID Akun baru
    v_role_akun VARCHAR2(20) := 'mahasiswa';    -- Role: mahasiswa atau dosen
    v_id_peminjam NUMBER := 22311;              -- NIM atau NIP sesuai role
    v_id_staff NUMBER := 30001;                 -- ID staf yang terkait
BEGIN
    -- Panggil prosedur
    create_akun_aju(
        p_id_akun => v_id_akun,
        p_role_akun => v_role_akun,
        p_id_peminjam => v_id_peminjam,
        p_id_staff => v_id_staff
    );

    DBMS_OUTPUT.PUT_LINE('Prosedur berhasil dijalankan.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
