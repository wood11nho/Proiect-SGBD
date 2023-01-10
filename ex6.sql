--Exercitiul 6
--Pentru un jucator de fotbal, caruia i se va da ID-ul de la tastatura, salvati si afisati
--numele tuturor coechipierilor sai, iar pentru fiecare coechipier sa se salveze si sponsorul acestuia.

create or replace procedure afisare_coechipieri
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
BEGIN
    i := 0;
    select TeamID, PlayerName into id_echipa_jucator, nume_jucator from Player where PlayerID = id_jucator_tast;
    select count(*) into numar_jucatori from Player;
    for id_jucator in 1..numar_jucatori
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
    end loop;
    DBMS_OUTPUT.PUT_LINE('Jucatorul ' || nume_jucator || ' are urmatorii coechipieri:');
    FOR j IN 1..nume_coechipieri.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(nume_coechipieri(j) || ' - ' || sponsor_jucatori(j));
    END LOOP;
END;

BEGIN
    AFISARE_COECHIPIERI(1);
end;