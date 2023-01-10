--Exercitiul 9
--Sa se afiseze numele, echipa, numarul de pe tricou si sponsorul unui jucator dat ca parametru, doar daca
--acesta a terminat pe locul 1 in campionatul din Romania si daca are o clauza de reziliere activa in contractul cu sponsorii sai.

CREATE OR REPLACE PROCEDURE afisare_jucator_exc
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

BEGIN
    AFISARE_JUCATOR_EXC('Susic');
    --[2023-01-10 04:37:24] 	ORA-20003: Jucatorul Susic nu are o clauza activa.
    --[2023-01-10 04:37:24] 	ORA-06512: la "UTILIZATOR.AFISARE_JUCATOR_EXC", linia 58
    AFISARE_JUCATOR_EXC('Manea');
    --Jucatorul Manea evolueaza pentru echipa CFR Cluj, campioana Romaniei, poarta numarul 4 si este sponsorizat de Umbro
    AFISARE_JUCATOR_EXC('Elias');
    --[2023-01-10 04:37:54] 	ORA-20000: Nu exista jucator cu numele Elias
    --[2023-01-10 04:37:54] 	ORA-06512: la "UTILIZATOR.AFISARE_JUCATOR_EXC", linia 62
    AFISARE_JUCATOR_EXC('Carnat');
    --[2023-01-10 04:40:01] 	ORA-20003: Jucatorul Carnat nu joaca pentru echipa castigatoare din Romania.
    --[2023-01-10 04:40:01] 	ORA-06512: la "UTILIZATOR.AFISARE_JUCATOR_EXC", linia 60
end;