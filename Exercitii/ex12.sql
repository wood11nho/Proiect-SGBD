--Exercitiul 12
--Definiti un trigger de tip LDD(CREATE, ALTER, DROP) la nivel de baza de date. Declansati trigger-ul
--Definiti un trigger de tip LDD care sa permita modificarea bazei de date doar daca utilizatorul curent este administratorul bazei de date(UTILIZATOR). Salvati modificarile facute intr-o tabela noua.

CREATE TABLE info_admin
(
    username VARCHAR2(30),
    nume_bd VARCHAR2(50),
    data_modificare TIMESTAMP(6),
    comanda VARCHAR2(1000),
    eroare VARCHAR2(1000)
);

CREATE OR REPLACE TRIGGER trigger_admin
    BEFORE CREATE OR ALTER OR DROP ON SCHEMA
DECLARE
    comanda_aux VARCHAR2(1000);
BEGIN
    --in comanda_aux vreau sa am comanda care a declansat trigger-ul
    comanda_aux := 'alter table Player drop column Salary;';
    if USER != 'UTILIZATOR' then
        insert into info_admin values (USER, SYS_CONTEXT('USERENV', 'DB_NAME'), SYSDATE, comanda_aux, 'Nu aveti drepturi de administrator.');
        raise_application_error(-20000, 'Nu aveti drepturi de administrator.');
    end if;

    insert into info_admin values (USER, SYS_CONTEXT('USERENV', 'DB_NAME'), SYSDATE, comanda_aux, 'OK');
end;

--Declansare trigger:
alter table Player add Salary number(10,2);
--Acum vreau sa sterg coloana asta adaugata
alter table Player drop column Salary;
