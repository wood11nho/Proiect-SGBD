--Exercitiul 13
--Definiti un pachet care sa contina toate obiectele definite in cadrul proiectului.


CREATE OR REPLACE PACKAGE proiect_sgbd_evs AS
    PROCEDURE afisare_coechipieri(id_jucator_tast Player.PlayerID%TYPE);
    FUNCTION filtrare_jucatori_dupa_numar(numar_echipa Player.TeamID%TYPE, numar_tricou Player.JerseyNumber%TYPE) RETURN NUMBER;
    PROCEDURE afisare_detalii_echipe;
    FUNCTION stadion_jucator(nume_jucator Player.PlayerName%TYPE) RETURN Stadium.StadiumName%TYPE;
    PROCEDURE afisare_jucator_exc(nume_jucator Player.PlayerName%TYPE);
END proiect_sgbd_evs;

CREATE OR REPLACE PACKAGE BODY proiect_sgbd_evs AS
--Exercitiul 6
--Pentru un jucator de fotbal, caruia i se va da ID-ul de la tastatura, salvati si afisati
--numele tuturor coechipierilor sai, iar pentru fiecare coechipier sa se salveze si sponsorul acestuia.

procedure afisare_coechipieri
    (id_jucator_tast Player.PlayerID%type)
AS
    TYPE tablou_indexat is TABLE OF Player.PlayerName%type INDEX BY PLS_INTEGER;
    nume_coechipieri tablou_indexat;
    TYPE tablou_imbricat is TABLE OF Sponsor.SponsorName%type;
    sponsor_jucatori tablou_imbricat := tablou_imbricat();
    i NUMBER;
    id_echipa_jucator Player.TeamID%type;
    id_echipa_coechiper Player.TeamID%type;
    nume_jucator Player.PlayerName%type;
    id_coechipier Player.PlayerID%type;
    nume_coechipier Player.PlayerName%type;
    nume_sponsor Sponsor.SponsorName%type;
    numar_jucatori NUMBER;
    id_jucator Player.PlayerID%type;
BEGIN
    i := 0;
    select TeamID, PlayerName into id_echipa_jucator, nume_jucator from Player where PlayerID = id_jucator_tast;
    select count(*) into numar_jucatori from Player;
    id_jucator := 1;
    while id_jucator <= numar_jucatori
    loop
        select TeamID into id_echipa_coechiper from Player where PlayerID = id_jucator;
        if id_echipa_coechiper = id_echipa_jucator and id_jucator_tast <> id_jucator then
            i := i + 1;
            select PlayerName, PlayerID into nume_coechipier, id_coechipier from Player where PlayerID = id_jucator;
            nume_coechipieri(i) := nume_coechipier;
            sponsor_jucatori.extend;
            select SponsorName into nume_sponsor from Sponsor where SponsorID = (select SponsorID from Deal where PlayerID = id_coechipier);
            sponsor_jucatori(i) := nume_sponsor;
        end if;
        id_jucator := id_jucator + 1;
    end loop;
    DBMS_OUTPUT.PUT_LINE('Jucatorul ' || nume_jucator || ' are urmatorii coechipieri:');
    FOR j IN 1..nume_coechipieri.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(nume_coechipieri(j) || ' - ' || sponsor_jucatori(j));
    END LOOP;
END;

--Exercitiul 7
--Sa se afiseze pentru fiecare echipa numarul de jucatori. In cazul in
--care echipa nu are jucatori inscrisi, se va afisa un mesaj corespunzator.
--Pentru fiecare jucator cu numarul de pe tricou mai mare decat un parametru dat,
--sa se afiseze pozitia, numarul de pe tricou si tara de provenienta.

FUNCTION filtrare_jucatori_dupa_numar
    (numar_echipa Player.TeamID%TYPE, numar_tricou Player.JerseyNumber%TYPE)
RETURN NUMBER is
    nr_jucatori_filtrati NUMBER;
BEGIN
    select count(*) into nr_jucatori_filtrati
    from Player
    where JerseyNumber > numar_tricou and TeamID = numar_echipa;
    return nr_jucatori_filtrati;
end;


PROCEDURE afisare_detalii_echipe AS
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
    numar_jucator_tastatura NUMBER := &numar_tricou;
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

--Exercitiul 8
--Scrie o functie care va afisa stadionul pe care evolueaza echipa unui jucator, al carui nume va fi dat de la tastatura.
FUNCTION stadion_jucator
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

--Exercitiul 9
--Sa se afiseze numele, echipa, numarul de pe tricou si sponsorul unui jucator dat ca parametru, doar daca
--acesta a terminat pe locul 1 in campionatul din Romania si daca are o clauza de reziliere activa in contractul cu sponsorii sai.

PROCEDURE afisare_jucator_exc
    (nume_jucator Player.PlayerName%TYPE)
IS
    CURSOR c1 is
        select t.TeamID id_echipa, t.TeamName nume_echipa, Points puncte
        from Team t, Ranking r
        where t.TeamID = r.TeamID;

    TYPE tip_detalii_echipa IS RECORD (
        id_echipa Team.TeamID%TYPE,
        nume_echipa Team.TeamName%TYPE,
        puncte_echipa Ranking.Points%TYPE );

    TYPE tip_detalii_jucator IS RECORD(
        id_jucator Player.PlayerID%TYPE,
        nume_jucator Player.PlayerName%TYPE,
        echipa_jucator Team.TeamName%TYPE,
        numar_jucator Player.JerseyNumber%TYPE,
        sponsor_jucator Sponsor.SponsorName%TYPE,
        clauza_reziliere Contract.ClauzaReziliere%TYPE);

    jucator_par tip_detalii_jucator;
    echipa_castigatoare tip_detalii_echipa;
    nr_maxim_puncte Ranking.Points%TYPE;
    exceptie_clauza EXCEPTION;
    exceptie_echipa EXCEPTION;
BEGIN
    select MAX(Points)
    into nr_maxim_puncte
    from Ranking;

    open c1;
    LOOP
        FETCH c1 into echipa_castigatoare;
        EXIT WHEN echipa_castigatoare.puncte_echipa = nr_maxim_puncte;
    end loop;

    select p.PlayerID, p.PlayerName, t.TeamName, p.JerseyNumber, s.SponsorName, c.ClauzaReziliere
    into jucator_par
    from Player p
    join Team t on (t.TeamID = p.TeamID)
    join Deal d on (d.PlayerID = p.PlayerID)
    join Contract c on (c.ContractID = d.ContractID)
    join Sponsor s on (s.SponsorID = d.SponsorID)
    where p.PlayerName = nume_jucator;

    if jucator_par.clauza_reziliere = 0 then
        raise exceptie_clauza;
    end if;
    if jucator_par.echipa_jucator <> echipa_castigatoare.nume_echipa then
        raise exceptie_echipa;
    end if;

    DBMS_OUTPUT.PUT_LINE('Jucatorul ' || jucator_par.nume_jucator || ' evolueaza pentru echipa ' || jucator_par.echipa_jucator || ', campioana Romaniei, poarta numarul ' || jucator_par.numar_jucator || ' si este sponsorizat de ' || jucator_par.sponsor_jucator);

    EXCEPTION
            WHEN exceptie_clauza THEN
                RAISE_APPLICATION_ERROR(-20003, 'Jucatorul ' || nume_jucator || ' nu are o clauza activa.');
            WHEN exceptie_echipa THEN
                RAISE_APPLICATION_ERROR(-20003, 'Jucatorul ' || nume_jucator || ' nu joaca pentru echipa castigatoare din Romania.');
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20000, 'Nu exista jucator cu numele ' || nume_jucator);
            WHEN TOO_MANY_ROWS THEN
                RAISE_APPLICATION_ERROR(-20001, 'Sunt mai multi jucatori cu numele ' || nume_jucator);
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002, 'Alta eroare');
end;
END proiect_sgbd_evs;

--Testare pachet

begin
    --Exercitiul 6
    proiect_sgbd_evs.afisare_coechipieri(1);
    --Exercitiul 7
    proiect_sgbd_evs.afisare_detalii_echipe();
    --Exercitiul 8
    DBMS_OUTPUT.PUT_LINE('Jucatorul cu numele Sefer evolueaza pe ' || proiect_sgbd_evs.stadion_jucator('Sefer'));
    --[2023-01-10 03:17:42] completed in 15 ms
    --Jucatorul cu numele Sefer evolueaza pe stadionul Stadionul Giulesti
    DBMS_OUTPUT.PUT_LINE('Jucatorul cu numele Elias evolueaza pe ' || proiect_sgbd_evs.stadion_jucator('Elias'));
    --[2023-01-10 03:18:44]    ORA-20000: Nu exista jucator cu numele Elias
    --[2023-01-10 03:18:44]    ORA-06512: la "UTILIZATOR.STADION_JUCATOR", linia 23
    --Exercitiul 9
    proiect_sgbd_evs.AFISARE_JUCATOR_EXC('Susic');
    --[2023-01-10 04:37:24]    ORA-20003: Jucatorul Susic nu are o clauza activa.
    --[2023-01-10 04:37:24]    ORA-06512: la "UTILIZATOR.AFISARE_JUCATOR_EXC", linia 58
    proiect_sgbd_evs.AFISARE_JUCATOR_EXC('Manea');
    --Jucatorul Manea evolueaza pentru echipa CFR Cluj, campioana Romaniei, poarta numarul 4 si este sponsorizat de Umbro
    proiect_sgbd_evs.AFISARE_JUCATOR_EXC('Elias');
    --[2023-01-10 04:37:54]    ORA-20000: Nu exista jucator cu numele Elias
    --[2023-01-10 04:37:54]    ORA-06512: la "UTILIZATOR.AFISARE_JUCATOR_EXC", linia 62
    proiect_sgbd_evs.AFISARE_JUCATOR_EXC('Carnat');
    --[2023-01-10 04:40:01]    ORA-20003: Jucatorul Carnat nu joaca pentru echipa castigatoare din Romania.
    --[2023-01-10 04:40:01]    ORA-06512: la "UTILIZATOR.AFISARE_JUCATOR_EXC", linia 60
end;