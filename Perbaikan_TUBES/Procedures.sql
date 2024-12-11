-- Prosedure
CREATE OR REPLACE PROCEDURE create_mahasiswa_account (
    p_nim IN INTEGER,
    p_akun_role IN VARCHAR2 DEFAULT 'Mahasiswa'
) AS
    v_status mahasiswa.status%TYPE;
    v_akun_id INTEGER;
BEGIN
    -- Ambil status mahasiswa berdasarkan NIM
    SELECT status
    INTO v_status
    FROM mahasiswa
    WHERE nim = p_nim;

    -- Periksa apakah mahasiswa aktif
    IF v_status = 'Aktif' THEN
        -- Buat ID akun baru
        SELECT NVL(MAX(id_akun), 0) + 1
        INTO v_akun_id
        FROM akun_aju;

        -- Masukkan akun baru ke tabel akun_aju
        INSERT INTO akun_aju (id_akun, akun_role)
        VALUES (v_akun_id, p_akun_role);

        -- Perbarui akun_aju_id_akun di tabel mahasiswa
        UPDATE mahasiswa
        SET akun_aju_id_akun = v_akun_id
        WHERE nim = p_nim;

        DBMS_OUTPUT.PUT_LINE('Akun mahasiswa berhasil dibuat dengan ID: ' || v_akun_id);
    ELSE
        -- Jika mahasiswa tidak aktif, lemparkan kesalahan
        RAISE_APPLICATION_ERROR(-20001, 'Mahasiswa dengan NIM ' || p_nim || ' tidak berstatus Aktif.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Mahasiswa dengan NIM ' || p_nim || ' tidak ditemukan.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Terjadi kesalahan: ' || SQLERRM);
END;
/

BEGIN
    create_mahasiswa_account(p_nim => 2103);
END;
/

-- Prosedure pembuatan akun dosen
CREATE OR REPLACE PROCEDURE create_dosen_account (
    p_nip IN dosen.nip%TYPE
) AS
    v_id_akun   akun_aju.id_akun%TYPE;
    v_exists    INTEGER;
    v_akun_id   INTEGER;
BEGIN
    -- Cek apakah NIP dosen ada
    SELECT COUNT(*)
    INTO v_exists
    FROM dosen
    WHERE nip = p_nip;

    IF v_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'NIP dosen tidak ditemukan.');
    END IF;

    -- Cek apakah dosen sudah memiliki akun
    SELECT akun_aju_id_akun
    INTO v_akun_id
    FROM dosen
    WHERE nip = p_nip;

    IF v_akun_id IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Dosen ini sudah memiliki akun.');
    END IF;

    -- Generate ID Akun baru
    SELECT NVL(MAX(id_akun), 0) + 1
    INTO v_id_akun
    FROM akun_aju;

    -- Tambahkan akun ke tabel akun_aju
    INSERT INTO akun_aju (id_akun, akun_role)
    VALUES (v_id_akun, 'Dosen');

    -- Update dosen untuk menghubungkan akun dengan NIP dosen
    UPDATE dosen
    SET akun_aju_id_akun = v_id_akun
    WHERE nip = p_nip;

    -- Commit perubahan
    COMMIT;

    -- Tampilkan pesan berhasil
    DBMS_OUTPUT.PUT_LINE('Akun untuk dosen dengan NIP ' || p_nip || ' berhasil dibuat.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'NIP dosen tidak valid atau tidak ditemukan.');
    WHEN OTHERS THEN
        -- Tangani kesalahan
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Terjadi kesalahan: ' || SQLERRM);
END create_dosen_account;
/

-- Mengecek
BEGIN
    create_dosen_account(p_nip => 12347); -- NIP dosen yang valid
END;
/

CREATE OR REPLACE PROCEDURE create_staf_account (
    p_id_staff IN INTEGER
) AS
    v_akun_id INTEGER;
    v_exists  INTEGER;
BEGIN
    -- Cek apakah ID staf ada dalam tabel staf
    SELECT COUNT(*)
    INTO v_exists
    FROM staf
    WHERE id_staff = p_id_staff;

    IF v_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'ID staf tidak ditemukan.');
    END IF;

    -- Cek apakah staf sudah memiliki akun
    SELECT akun_aju_id_akun
    INTO v_akun_id
    FROM staf
    WHERE id_staff = p_id_staff;

    IF v_akun_id IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Staf ini sudah memiliki akun.');
    END IF;

    -- Buat ID akun baru
    SELECT NVL(MAX(id_akun), 0) + 1
    INTO v_akun_id
    FROM akun_aju;

    -- Masukkan akun baru ke tabel akun_aju
    INSERT INTO akun_aju (id_akun, akun_role)
    VALUES (v_akun_id, 'Staf');

    -- Perbarui akun_aju_id_akun di tabel staf
    UPDATE staf
    SET akun_aju_id_akun = v_akun_id
    WHERE id_staff = p_id_staff;

    -- Commit transaksi
    COMMIT;

    -- Tampilkan pesan berhasil
    DBMS_OUTPUT.PUT_LINE('Akun staf berhasil dibuat dengan ID: ' || v_akun_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'ID staf tidak valid atau tidak ditemukan.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Terjadi kesalahan: ' || SQLERRM);
END create_staf_account;
/

-- Contoh penggunaan prosedur
BEGIN
    create_staf_account(p_id_staff => 302); -- Ganti dengan ID staf yang valid
END;
/

CREATE OR REPLACE PROCEDURE validate_peminjaman (
    p_id_pinjam          IN peminjaman.id_pinjam%TYPE,
    p_akun_validator_id  IN akun_aju.id_akun%TYPE,
    p_validation_status  IN VARCHAR2
) AS
    v_exists INTEGER;
    v_role   VARCHAR2(100);
    v_barang_id INTEGER;  -- Menyimpan ID barang yang dipinjam
BEGIN
    -- Cek apakah peminjaman ada
    SELECT COUNT(*)
    INTO v_exists
    FROM peminjaman
    WHERE id_pinjam = p_id_pinjam;

    IF v_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'ID peminjaman tidak ditemukan.');
    END IF;

    -- Cek apakah akun_validator_id adalah milik staf
    SELECT akun_role
    INTO v_role
    FROM akun_aju
    WHERE id_akun = p_akun_validator_id;

    IF v_role != 'Staf' THEN
        RAISE_APPLICATION_ERROR(-20002, 'ID akun bukan milik staf.');
    END IF;

    -- Ambil ID barang yang dipinjam
    SELECT barang_id_brg
    INTO v_barang_id
    FROM peminjaman
    WHERE id_pinjam = p_id_pinjam;

    -- Update status validasi dan akun yang memvalidasi
    UPDATE peminjaman
    SET akun_validator_id = p_akun_validator_id,
        validation_status = p_validation_status
    WHERE id_pinjam = p_id_pinjam;

    -- Update status barang menjadi 'Sedang Dipinjam'
    UPDATE barang
    SET status_brg = 'Dipinjam'
    WHERE id_brg = v_barang_id; -- Pastikan id_brg adalah nama kolom yang benar

    -- Mengoutputkan hasil
    DBMS_OUTPUT.PUT_LINE('Peminjaman dengan ID ' || p_id_pinjam || ' telah divalidasi oleh akun dengan ID ' || p_akun_validator_id);
    
    -- Update status peminjaman menjadi 'Sedang Dipinjam'
    UPDATE peminjaman
    SET status_pinjam = 'Sedang Dipinjam'
    WHERE id_pinjam = p_id_pinjam; -- Pastikan id_brg adalah nama kolom yang benar

    -- Mengoutputkan hasil
    DBMS_OUTPUT.PUT_LINE('Peminjaman dengan ID ' || p_id_pinjam || ' telah divalidasi oleh akun dengan ID ' || p_akun_validator_id);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Data tidak ditemukan.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Terjadi kesalahan: ' || SQLERRM);
END validate_peminjaman;
/

-- Mengecek prosedur
BEGIN
    validate_peminjaman(p_id_pinjam => 1002, p_akun_validator_id => 7, p_validation_status => 'Diverifikasi');
END;
/

CREATE OR REPLACE PROCEDURE update_status_peminjaman (
    p_id_pinjam       IN peminjaman.id_pinjam%TYPE, -- ID peminjaman yang akan diperbarui statusnya
    p_new_status      IN VARCHAR2                    -- Status baru yang akan diupdate
) AS
    v_exists INTEGER;
BEGIN
    -- Cek apakah peminjaman dengan ID tertentu ada
    SELECT COUNT(*)
    INTO v_exists
    FROM peminjaman
    WHERE id_pinjam = p_id_pinjam;

    IF v_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'ID peminjaman tidak ditemukan.');
    END IF;

    -- Memperbarui status peminjaman
    UPDATE peminjaman
    SET validation_status = p_new_status
    WHERE id_pinjam = p_id_pinjam;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Status peminjaman dengan ID ' || p_id_pinjam || ' berhasil diperbarui menjadi ' || p_new_status);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Data peminjaman tidak ditemukan.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Terjadi kesalahan: ' || SQLERRM);
END update_status_peminjaman;
/

BEGIN
    update_status_peminjaman(p_id_pinjam => 1002, p_new_status => 'Diverifikasi');
END;
/

CREATE OR REPLACE PROCEDURE get_list_pengaju_by_role(
    p_role IN VARCHAR2
) AS
BEGIN
    -- Menampilkan data pengaju sesuai role yang dimasukkan
    FOR rec IN (
        SELECT 
            id_akun AS id_pengaju,
            akun_role AS role_pengaju
        FROM 
            akun_aju
        WHERE 
            akun_role = p_role
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Pengaju: ' || rec.id_pengaju ||  
                             ', Role: ' || rec.role_pengaju);
    END LOOP;
END;
/

BEGIN
    get_list_pengaju_by_role('Dosen');
END;
/
