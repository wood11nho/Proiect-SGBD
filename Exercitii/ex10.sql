--Exercitiul 10
--Definiti un trigger de tip LMD la nivel de comanda. Declansati trigger-ul
--Creati un trigger de tip LMD la nivel de comanda care sa nu permita inserarea a mai mult de 10 canale de televiziune. Declansati trigger-ul.

CREATE OR REPLACE TRIGGER trig_canale_tv
    BEFORE INSERT ON Broadcaster
DECLARE
    nr NUMBER;
    nr_ligi NUMBER;
BEGIN
    SELECT COUNT(*) INTO nr FROM Broadcaster;
    SELECT COUNT(LeagueID) INTO nr_ligi FROM League;
    nr_ligi := nr_ligi * 2;
    IF nr >= nr_ligi THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nu se pot insera mai mult de ' || nr_ligi || ' canale de televiziune.');
    END IF;
END;

BEGIN
    DELETE FROM Broadcaster WHERE BroadcasterID >= 7 and BROADCASTERID <= 13;
    INSERT INTO Broadcaster VALUES(7, 'GSP TV', 'Teodor Raducanu');
    INSERT INTO Broadcaster VALUES(8, 'Antena 1', 'Mihai Gadea');
    INSERT INTO Broadcaster VALUES(9, 'Dolce Sport', 'Pavel Pascu');
    INSERT INTO Broadcaster VALUES(10, 'Sport.ro', 'Ioana Cozma');
    INSERT INTO Broadcaster VALUES(11, 'DinamoTV', 'Cristian Borcea');
    INSERT INTO Broadcaster VALUES(12, 'LiveStream Online ', 'Hidden Person');
    INSERT INTO Broadcaster VALUES(13, 'Prima Sport ', 'Dragos Borchina');

end;

SELECT * FROM Broadcaster;