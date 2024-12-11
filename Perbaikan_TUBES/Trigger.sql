CREATE OR REPLACE TRIGGER trg_notif_kembali
AFTER UPDATE OR INSERT ON peminjaman
FOR EACH ROW
DECLARE
    v_telat Integer;  -- Hitungan hari keterlambatan
BEGIN
    -- Memeriksa jika status peminjaman adalah 'Sedang Dipinjam'
    IF :NEW.status_pinjam = 'Sedang Dipinjam' THEN
        -- Menghitung selisih hari antara tanggal pengembalian dan tanggal hari ini
        v_telat := TRUNC(SYSDATE - :NEW.tgl_kembali);

        -- Jika pengembalian jatuh tempo hari ini
        IF v_telat = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Pengembalian jatuh tempo hari ini. Harap segera kembalikan barang!');
        
        -- Jika pengembalian terlambat
        ELSIF v_telat > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Anda terlambat mengembalikan barang! Keterlambatan: ' || v_telat || ' hari.');
        END IF;
    END IF;
END;
/

CREATE SEQUENCE log_peminjaman_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE OR REPLACE TRIGGER trg_peminjaman_to_log
AFTER UPDATE OF status_pinjam ON peminjaman
FOR EACH ROW
WHEN (NEW.status_pinjam = 'Sedang Dipinjam')
BEGIN
    INSERT INTO log_peminjaman (
        id_log,
        status_brg,
        tgl_log,
        peminjaman_id_pinjam
    )
    VALUES (
        log_peminjaman_seq.NEXTVAL, -- Anggap ada sequence untuk id_log
        'Dipinjam',
        SYSDATE,
        :NEW.id_pinjam
    );
END;