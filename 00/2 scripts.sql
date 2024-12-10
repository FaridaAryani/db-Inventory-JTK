/*
    Author    : Dzaka
    Deskripsi :
    Prosedur pengecheckan dan pembuatan akun_aju
*/
CREATE OR REPLACE PROCEDURE insert_akun_aju (
    p_id_akun       IN INTEGER,
    p_akun_role     OUT VARCHAR2,
    p_staff_id_staf IN VARCHAR2,
    p_mahasiswa_nim IN INTEGER,
    p_dosen_nip     IN INTEGER
) AS
    v_status VARCHAR2(100);
BEGIN
    IF p_mahasiswa_nim IS NOT NULL AND p_dosen_nip IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Hanya salah satu dari mahasiswa_nim atau dosen_nip yang boleh diisi.');
    END IF;

    IF p_mahasiswa_nim IS NOT NULL THEN
        SELECT status INTO v_status
        FROM mahasiswa
        WHERE nim = p_mahasiswa_nim;

        IF v_status != 'aktif' THEN
            RAISE_APPLICATION_ERROR(-20002, 'Mahasiswa tidak memiliki status aktif.');
        END IF;

        p_akun_role := 'mahasiswa';

    ELSIF p_dosen_nip IS NOT NULL THEN
        p_akun_role := 'dosen';
    ELSE
        RAISE_APPLICATION_ERROR(-20003, 'Salah satu dari mahasiswa_nim atau dosen_nip harus diisi.');
    END IF;

    -- Insert data ke tabel akun_aju
    INSERT INTO akun_aju (id_akun, akun_role, staf_id_staf, mahasiswa_nim, dosen_nip)
    VALUES (p_id_akun, p_akun_role, p_staff_id_staf, p_mahasiswa_nim, p_dosen_nip);
    
    COMMIT;
END;
/

/*
    Author    : Dzaka
    Deskripsi :
    Trigger pendistribusian id_akun untuk peminjam
*/
CREATE OR REPLACE TRIGGER trg_update_akun_aju
AFTER INSERT ON akun_aju
FOR EACH ROW
BEGIN
    IF :NEW.mahasiswa_nim IS NOT NULL THEN
        UPDATE mahasiswa
        SET akun_aju_id_akun = :NEW.id_akun
        WHERE nim = :NEW.mahasiswa_nim;

    ELSIF :NEW.dosen_nip IS NOT NULL THEN
        UPDATE dosen
        SET akun_aju_id_akun = :NEW.id_akun
        WHERE nip = :NEW.dosen_nip;
    END IF;
END;
/
