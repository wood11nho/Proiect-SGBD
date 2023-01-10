--Exercitiul 11
--A inceput perioada de transferuri. Creati un trigger de tip LMD la nivel de linie care
--sa verifice si sa actualizeze detaliile jucatorilor care au fost transferati, tinand cont
--de toate cazurile posibile (insert, update, delete). Declansati trigger-ul.

CREATE OR REPLACE TRIGGER transfer_jucator
    BEFORE INSERT OR UPDATE OR DELETE ON Player
    FOR EACH ROW
DECLARE
    exista_deja_numar NUMBER;
    exceptie_numar EXCEPTION;
    exceptie_numar_invalid EXCEPTION;
    exceptie_prea_multi_jucatori EXCEPTION;
    nr_jucatori NUMBER;
    nume_echipa_noua Team.TeamName%TYPE;
    exista_jucator NUMBER;
BEGIN
    IF INSERTING or UPDATING THEN
        if :NEW.JerseyNumber > 99 or :NEW.JerseyNumber < 1 then
            raise exceptie_numar_invalid;
        end if;
        --verificare numar jucatori echipa noua
        select count(*) into nr_jucatori from Player where TeamID = :NEW.TeamID;
        select TeamName into nume_echipa_noua from Team where TeamID = :NEW.TeamID;
        if nr_jucatori >= 27 then
            raise exceptie_prea_multi_jucatori;
        end if;

        exista_deja_numar := 0;
        select count(*) into exista_deja_numar
        from Player where TeamID = :NEW.TeamID and JerseyNumber = :NEW.JerseyNumber;
        if exista_deja_numar > 0 then
            raise exceptie_numar;
        end if;
    end if;
    if DELETING then
        delete from Deal where Deal.PlayerID = :OLD.PlayerID;
        DBMS_OUTPUT.PUT_LINE('DELETE');
        select count(*) into exista_jucator from Player where PlayerID = :OLD.PlayerID;
        if exista_jucator = 0 then
            raise_application_error(-20001, 'Jucatorul nu exista');
        end if;
    end if;
    EXCEPTION
        WHEN NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(-20000, 'Jucatorul cu ID-ul ' || :OLD.PlayerID || ' nu exista.');
        WHEN exceptie_numar THEN
            RAISE_APPLICATION_ERROR(-20003, 'Jucatorul ' || :NEW.PlayerName || ' nu poate purta numarul ' || :NEW.JerseyNumber || ' pentru ca echipa ' || nume_echipa_noua || ' are deja un jucator cu acest numar.');
        WHEN exceptie_numar_invalid THEN
            RAISE_APPLICATION_ERROR(-20003, 'Jucatorul ' || :NEW.PlayerName || ' nu are un numar de tricou valid.');
        WHEN exceptie_prea_multi_jucatori THEN
            RAISE_APPLICATION_ERROR(-20003, 'Echipa ' || nume_echipa_noua || ' are deja 27 de jucatori.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;

--Declansare trigger:
--Se transfera un jucator care vrea sa poarte un numar deja existent la CFR CLUJ.
insert into Player values (139, 1, 20, 'Jefte', 'ATT', 9);
--[2023-01-10 16:32:30] 	ORA-20003: Jucatorul Jefte nu poate purta numarul 9 pentru ca echipa CFR Cluj are deja un jucator cu acest numar.
--Se transfera un jucator cu un numar invalid
insert into Player values (139, 1, 20, 'Jefte', 'ATT', 122);
--[2023-01-10 16:33:11] 	ORA-20003: Jucatorul Jefte nu are un numar de tricou valid.
--Se transfera un jucator, dar echipa are deja 27 de jucatori
insert into Player values (139, 3, 20, 'Iglesias', 'MID', 88);
--[2023-01-10 16:37:21] 	ORA-20003: Echipa FC Dinamo Bucuresti are deja 27 de jucatori.
--Stergere jucator care nu exista
delete from Player where PlayerID = 1000;
--[2023-01-10 16:38:05] 	ORA-20000: Jucatorul cu ID-ul 1000 nu exista.