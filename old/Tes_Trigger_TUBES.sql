-- validasi peminjaman
create or replace trigger trg_val_pnjm
before insert or update on peminjaman
for each row
declare
    v_stat_mhs varchar(255);
    v_status_pnjm varchar(255);
begin
    select status into v_stat_mhs
    from mahasiswa
    where nim = :new.mahasiswa_nim;
    
    if v_stat_mhs != 'Aktif' then
        RAISE_APPLICATION_ERROR(-20001,
            'Peminjaman tidak bisa dilakukan! Peminjam adalah Alumni.');
    end if;
    
    -- cek jika peminjam sudah meminjam barang lain yang belum dikembalikan
    select status_pnjm into v_status_pnjm
    from peminjaman
    where mahasiswa_nim = :new.mahasiswa_nim
    and status_pnjm = 'Sedang Dipinjam';
    
    if v_status_pnjm = 'Sedang Dipinjam' then
        RAISE_APPLICATION_ERROR(-20002, 'Peminjaman tidak bisa dilakukan! Peminjam masih memiliki barang yang belum dikembalikan.');
    end if;
end;

-- notifikasi jika telat
create or replace trigger trg_notif_kmbl
after update or insert on peminjaman
for each row
declare
    v_telat number;
begin
    v_telat := trunc(:new.tgl_kembali - SYSDATE);
    
    if v_telat = 0 then
        dbms_output.put_line('Pengembalian jatuh tempo hari ini. Harap segera kembalikan!');
    elsif v_telat < 0 then
        dbms_output.put_line('Anda terlambat mengembalikan barang!');
    end if;
end;

-- melihat log
create or replace trigger trg_log
after update on barang
for each row
declare
    v_terakhir_peminjaman varchar(255);
    v_terakhir_peminjam varchar(255);
begin
    if :new.kondisi in ('Rusak', 'Hilang') then
        select id_pnjm
        into v_terakhir_peminjaman
        from peminjaman
        where barang_id_brg = :new.id_brg
        and tgl_kembali = (select max(tgl_kembali) from peminjaman where barang_id_brg = :new.id_brg);
        
        select nama_mhs
        into v_terakhir_peminjam
        from mahasiswa
        where nim = (select mahasiswa_nim from peminjaman where id_pnjm = v_terakhir_peminjaman);
        
        dbms_output.put_line('Barang terakhir dipinjam oleh: ' || v_terakhir_peminjam);
    end if;
end;

-- pinjam satu saja
