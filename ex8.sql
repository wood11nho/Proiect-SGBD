--Exercitiul 8
--Scrie o functie care va afisa stadionul pe care evolueaza echipa unui jucator, al carui nume va fi dat de la tastatura.
CREATE OR REPLACE FUNCTION stadion_jucator
    (nume_jucator Player.PlayerName%TYPE)
RETURN Stadium.StadiumName%TYPE IS
    id_jucator Player.PlayerID%TYPE;
    nume_stadion Stadium.StadiumName%TYPE;
    BEGIN
        select PlayerID
        into id_jucator
        from Player
        where PlayerName = nume_jucator;

        select StadiumName
        into nume_stadion
        from Stadium s
        join Team t on t.TeamID = s.TeamID
        join Player p on p.TeamID = t.TeamID
        where p.PlayerID = id_jucator;

        return nume_stadion;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20000, 'Nu exista jucator cu numele ' || nume_jucator);
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002, 'Alta eroare');
    end;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Jucatorul cu numele Sefer evolueaza pe ' || stadion_jucator('Sefer'));
    --Raspuns:
    --[2023-01-10 03:17:42] completed in 15 ms
    --Jucatorul cu numele Sefer evolueaza pe stadionul Stadionul Giulesti
    DBMS_OUTPUT.PUT_LINE('Jucatorul cu numele Elias evolueaza pe ' || stadion_jucator('Elias'));
    --Raspuns:
    --[2023-01-10 03:18:44] 	ORA-20000: Nu exista jucator cu numele Elias
    --[2023-01-10 03:18:44] 	ORA-06512: la "UTILIZATOR.STADION_JUCATOR", linia 23
    --[2023-01-10 03:18:44] 	ORA-06512: la linia 6
end;