--Exercitiul 11
--A inceput perioada de transferuri. Creati un trigger de tip LMD la nivel de linie care
--sa verifice si sa actualizeze detaliile jucatorilor care au fost transferati, tinand cont
--de toate cazurile posibile (insert, update, delete). Declansati trigger-ul.
--Pentru a evita erori de tip Mutating Table, creati o vizualizare unde veti face toate modificarile

CREATE OR REPLACE VIEW view_jucatori AS
    select p.PlayerID, p.TeamID, p.CountryID, p.PlayerName, p.PlayerPosition, p.JerseyNumber, d.SponsorID, d.ContractID
    from Player p, Deal d
    where p.PlayerID = d.PlayerID;

CREATE OR REPLACE TRIGGER transfer_jucator
    INSTEAD OF INSERT OR UPDATE OR DELETE ON view_jucatori
    FOR EACH ROW
DECLARE
    exista_deja_numar NUMBER;
    exceptie_numar EXCEPTION;
    exceptie_numar_invalid EXCEPTION;
    exceptie_prea_multi_jucatori EXCEPTION;
    exceptie_nu_exista EXCEPTION;
    nr_jucatori NUMBER;
    nume_echipa_noua Team.TeamName%TYPE;
    exista_jucator NUMBER;
BEGIN
    IF INSERTING or UPDATING THEN
        if :NEW.JerseyNumber > 99 or :NEW.JerseyNumber < 1 then
            raise exceptie_numar_invalid;
        end if;
        --verificare numar jucatori echipa noua
        select count(*) into nr_jucatori from view_jucatori where TeamID = :NEW.TeamID;
        select TeamName into nume_echipa_noua from Team where TeamID = :NEW.TeamID;

        if nr_jucatori >= 27 then
            raise exceptie_prea_multi_jucatori;
        end if;

        exista_deja_numar := 0;
        select count(*) into exista_deja_numar
        from view_jucatori where TeamID = :NEW.TeamID and JerseyNumber = :NEW.JerseyNumber;
        if exista_deja_numar > 0 then
            raise exceptie_numar;
        end if;
        if INSERTING THEN
            INSERT INTO Player VALUES(:NEW.PlayerID, :NEW.TeamID, :NEW.CountryID, :NEW.PlayerName, :NEW.PlayerPosition, :NEW.JerseyNumber);
            INSERT INTO Deal VALUES(:NEW.PlayerID, :NEW.SponsorID, :NEW.ContractID);
        elsif UPDATING THEN
            UPDATE Player SET TeamID = :NEW.TeamID
            where PlayerID = :NEW.PlayerID;
        end if;
    elsif DELETING then
        select count(*) into exista_jucator from view_jucatori where PlayerID = :OLD.PlayerID;
        if exista_jucator = 0 then
            raise exceptie_nu_exista;
        end if;
        DELETE FROM Deal WHERE PlayerID = :OLD.PlayerID;
        DELETE FROM Player WHERE PlayerID = :OLD.PlayerID;
    end if;
    EXCEPTION
        WHEN exceptie_numar THEN
            RAISE_APPLICATION_ERROR(-20003, 'Jucatorul ' || :NEW.PlayerName || ' nu poate purta numarul ' || :NEW.JerseyNumber || ' pentru ca echipa ' || nume_echipa_noua || ' are deja un jucator cu acest numar.');
        WHEN exceptie_numar_invalid THEN
            RAISE_APPLICATION_ERROR(-20003, 'Jucatorul ' || :NEW.PlayerName || ' nu are un numar de tricou valid.');
        WHEN exceptie_prea_multi_jucatori THEN
            RAISE_APPLICATION_ERROR(-20003, 'Echipa ' || nume_echipa_noua || ' are deja 27 de jucatori.');
        WHEN exceptie_nu_exista THEN
            RAISE_APPLICATION_ERROR(-20003, 'Jucatorul cu ID-ul ' || :OLD.PlayerID || ' nu exista.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;

--Declansare trigger:
--Se transfera un jucator care vrea sa poarte un numar deja existent la CFR CLUJ.
insert into view_jucatori values (139, 1, 20, 'Jefte', 'ATT', 9, 1, 1);
--[2023-01-10 16:32:30] 	ORA-20003: Jucatorul Jefte nu poate purta numarul 9 pentru ca echipa CFR Cluj are deja un jucator cu acest numar.
--Se transfera un jucator cu un numar invalid
insert into view_jucatori values (139, 1, 20, 'Jefte', 'ATT', 122, 1, 1);
--[2023-01-10 16:33:11] 	ORA-20003: Jucatorul Jefte nu are un numar de tricou valid.
--Se transfera un jucator, dar echipa are deja 27 de jucatori
insert into view_jucatori values (139, 4, 20, 'Iglesias', 'MID', 88, 1, 1);
--[2023-01-10 16:37:21] 	ORA-20003: Echipa FC Dinamo Bucuresti are deja 27 de jucatori.
--Se transfera un jucator nou
insert into view_jucatori values (139, 3, 20, 'Iglesias', 'MID', 88, 1, 1);
--Stergere jucator
delete from view_jucatori where PlayerID = 139;
--UTILIZATOR> delete from view_jucatori where PlayerID = 139
--[2023-01-11 17:50:56] 1 row affected in 12 ms
--Un jucator deja existent se transfera la alta echipa
update view_jucatori set TeamID = 1 where PlayerID = 139;
--UTILIZATOR> update view_jucatori set TeamID = 1 where PlayerID = 139
--[2023-01-11 18:02:26] 1 row affected in 18 ms