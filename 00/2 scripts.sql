create or replace trigger trg_val_pnjm
before insert or update on peminjaman
for each row
declare
    v_status_pengaju varchar(10); -- Status pengaju (Aktif/Alumni)
    v_count integer;              -- Jumlah barang yang sedang dipinjam
    v_jenis_pengaju varchar(20); -- Jenis pengaju (Mahasiswa/Dosen)
begin
    -- Ambil jenis pengaju dari akun_aju
    select jenis_pengaju
    into v_jenis_pengaju
    from akun_aju
    where id_akun = :new.akun_aju_id_akun;

    -- Validasi mahasiswa
    if v_jenis_pengaju = 'Mahasiswa' then
        -- Ambil status mahasiswa
        select status
        into v_status_pengaju
        from mahasiswa
        where akun_aju_id_akun = :new.akun_aju_id_akun;

        if v_status_pengaju != 'Aktif' then
            raise_application_error(-20001, 'Mahasiswa alumni tidak dapat melakukan peminjaman.');
        end if;
    end if;

    -- Validasi dosen
    if v_jenis_pengaju = 'Dosen' then
        -- Cek apakah dosen terdaftar
        select count(*)
        into v_count
        from dosen
        where akun_aju_id_akun = :new.akun_aju_id_akun;

        if v_count = 0 then
            raise_application_error(-20002, 'Dosen tidak terdaftar tidak dapat melakukan peminjaman.');
        end if;
    end if;

    -- Cek apakah pengaju sedang meminjam barang
    select count(*)
    into v_count
    from peminjaman
    where akun_aju_id_akun = :new.akun_aju_id_akun
      and status_pinjam = 'Sedang Dipinjam';

    if v_count > 0 then
        raise_application_error(-20003, 'Peminjam belum mengembalikan barang yang sebelumnya dipinjam!');
    end if;
end;

create or replace trigger trg_histori_pnjm
after insert or update on peminjaman
for each row
begin
    if :new.status_pinjam = 'Sedang Dipinjam' then
        -- Log barang dipinjam
        insert into log_peminjaman (id_log, status_brg, tgl_log, peminjaman_id_pinjam)
        values (SYS_GUID(), 'Barang dipinjam', SYSDATE, :new.id_pinjam);
    elsif :new.status_pinjam = 'Peminjaman Selesai' then
        -- Log barang dikembalikan
        insert into log_peminjaman (id_log, status_brg, tgl_log, peminjaman_id_pinjam)
        values (SYS_GUID(), 'Barang dikembalikan', SYSDATE, :new.id_pinjam);
    end if;
end;

create or replace trigger trg_notif_kembali
after update or insert on peminjaman
for each row
declare
    v_telat integer; -- Hitungan hari keterlambatan
begin
    if :new.status_pinjam = 'Sedang Dipinjam' then
        v_telat := trunc(SYSDATE - :new.tgl_kembali);

        if v_telat = 0 then
            dbms_output.put_line('Pengembalian jatuh tempo hari ini. Harap segera kembalikan barang!');
        elsif v_telat > 0 then
            dbms_output.put_line('Anda terlambat mengembalikan barang!');
        end if;
    end if;
end;

create or replace procedure lihat_log(p_id_barang in varchar)
is
begin
    for record in (
        select
            l.id_log, l.status_brg, l.tgl_log,
            p.id_pinjam, p.status_pinjam
        from log_peminjaman l
        join peminjaman p on l.peminjaman_id_pinjam = p.id_pinjam
        where p.barang_id_barang = p_id_barang
        order by l.tgl_log
    ) loop
        dbms_output.put_line(
            'Log ID: ' || record.id_log ||
            ', Status: ' || record.status_brg ||
            ', Tanggal: ' || record.tgl_log ||
            ', ID Peminjaman: ' || record.id_pinjam ||
            ', Status Peminjaman: ' || record.status_pinjam
        );
    end loop;
end;

create or replace function cek_stok_barang(p_id_barang in varchar)
return varchar
is
    v_status_pinjam varchar(20);
begin
    select case
        when count(*) > 0 then 'Tidak Tersedia'
        else 'Tersedia'
    end
    into v_status_pinjam
    from peminjaman
    where barang_id_barang = p_id_barang
      and status_pinjam = 'Sedang Dipinjam';

    return v_status_pinjam;
end;

