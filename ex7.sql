--Exercitiul 7
--Sa se afiseze pentru fiecare echipa numarul de jucatori. In cazul in 
--care echipa nu are jucatori inscrisi, se va afisa un mesaj corespunzator.
--Pentru fiecare jucator cu numarul de pe tricou mai mare decat un parametru dat,
--sa se afiseze pozitia, numarul de pe tricou si tara de provenienta.
CREATE OR REPLACE FUNCTION filtrare_jucatori_dupa_numar
    (numar_echipa Player.TeamID%TYPE, numar_tricou Player.JerseyNumber%TYPE)
RETURN NUMBER is
    nr_jucatori_filtrati NUMBER;
BEGIN
    select count(*) into nr_jucatori_filtrati
    from Player
    where JerseyNumber > numar_tricou and TeamID = numar_echipa;
    return nr_jucatori_filtrati;
end;

CREATE OR REPLACE PROCEDURE afisare_detalii_echipe AS
    CURSOR c1 is
        SELECT t.TeamID id_echipa, TeamName nume_echipa, COUNT(PlayerID) numar_jucatori
        FROM Team t, Player p
        WHERE t.TeamID = p.TeamID(+)
        GROUP BY t.TeamID, TeamName;

    CURSOR c2(parametru NUMBER, echipa_id Team.TeamID%TYPE) is
        SELECT PlayerName nume_jucator, PlayerPosition pozitie_jucator, CountryName tara_jucator, JerseyNumber numar_jucator
        FROM Player p, Country c
        WHERE p.CountryID = c.CountryID(+) and JerseyNumber > parametru and TeamID = echipa_id;

    TYPE tip_detalii_echipa IS RECORD(
        id_echipa Team.TeamID%TYPE,
        nume_echipa Team.TeamName%TYPE,
        numar_jucatori NUMBER
                                 );
    detalii_echipa tip_detalii_echipa;
    count_echipe NUMBER;
    count_jucatori NUMBER;
    numar_jucator_tastatura NUMBER := &numar_tast;
    nr_jucatori_filtrati NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Echipe si jucatori: ');
    count_echipe := 0;
    OPEN c1;
    LOOP
        FETCH c1 INTO detalii_echipa;
        count_echipe := count_echipe + 1;
        EXIT WHEN c1%NOTFOUND;
        IF detalii_echipa.numar_jucatori = 0 THEN
            DBMS_OUTPUT.PUT_LINE(count_echipe || '. ' || detalii_echipa.nume_echipa || ' nu are niciun jucator semnat.');
        ELSE
            nr_jucatori_filtrati := filtrare_jucatori_dupa_numar(detalii_echipa.id_echipa, numar_jucator_tastatura);
            DBMS_OUTPUT.PUT_LINE(count_echipe || '. ' || detalii_echipa.nume_echipa || ' are ' || detalii_echipa.numar_jucatori || ' jucatori semnati iar cei ' || nr_jucatori_filtrati || ' cu numarul mai mare decat ' || numar_jucator_tastatura || ' sunt: ');
            count_jucatori := 0;
            FOR i in c2(numar_jucator_tastatura, detalii_echipa.id_echipa) LOOP
                count_jucatori := count_jucatori + 1;
                DBMS_OUTPUT.PUT_LINE(count_jucatori || '. ' || i.nume_jucator || ', numarul ' || i.numar_jucator || ', joaca pe pozitia ' || i.pozitie_jucator || ' si este din ' || i.tara_jucator);
            end loop;
        END IF;
    end loop;
end;

BEGIN
    afisare_detalii_echipe();
end;