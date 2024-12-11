CREATE OR REPLACE PROCEDURE create_akun_aju (
    p_id_akun   IN akun_aju.id_akun%TYPE,
    p_role_akun IN akun_aju.akun_role%TYPE,
    p_id_peminjam IN NUMBER,
    p_id_staff IN staf.id_staff%TYPE
) IS
    v_status_mahasiswa mahasiswa.status%TYPE;
BEGIN
    -- Insert ke tabel akun_aju
    INSERT INTO akun_aju (id_akun, akun_role)
    VALUES (p_id_akun, p_role_akun);

    -- Cek role_akun
    IF p_role_akun = 'mahasiswa' THEN
        -- Pastikan mahasiswa memiliki status "aktif"
        SELECT status INTO v_status_mahasiswa
        FROM mahasiswa
        WHERE nim = p_id_peminjam;

        IF v_status_mahasiswa = 'aktif' THEN
            -- Update Foreign Key mahasiswa ke akun_aju
            UPDATE mahasiswa
            SET akun_aju_id_akun = p_id_akun
            WHERE nim = p_id_peminjam;
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Mahasiswa tidak aktif, tidak dapat membuat akun aju.');
        END IF;

    ELSIF p_role_akun = 'dosen' THEN
        -- Update Foreign Key dosen ke akun_aju
        UPDATE dosen
        SET akun_aju_id_akun = p_id_akun
        WHERE nip = p_id_peminjam;

    ELSE
        RAISE_APPLICATION_ERROR(-20002, 'Role akun tidak valid. Hanya "mahasiswa" atau "dosen" yang diperbolehkan.');
    END IF;

    -- Update Foreign Key staf ke akun_aju
    UPDATE staf
    SET akun_aju_id_akun = p_id_akun
    WHERE id_staff = p_id_staff;

    -- Commit perubahan
    COMMIT;
END;
/
