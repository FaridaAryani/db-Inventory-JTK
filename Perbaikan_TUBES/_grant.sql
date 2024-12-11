GRANT CREATE VIEW TO TUBESPATH;

GRANT SELECT ON log_peminjaman TO tubespath;

SELECT * FROM USER_SYS_PRIVS WHERE PRIVILEGE = 'CREATE VIEW';

grant all on tubespath.log_peminjaman to tubespath;

grant create any view to TUBESPATH;

conn tubespath as sysdba;

grant create any view to tubespath;

sqlplus tubespath as sysdba;