--Exercitiul 14
--Definiti un pachet care sa includa tipuri de date complexe si obiecte necesare
--unui flux de actiuni integrate, specifice bazei de date definite (minim 2 tipuri de date, minim 2 functii, minim 2 proceduri)

--Pentru fiecare echipa, obtineti numele precum si lista numelor angajatilor care isi desfasoara
--activitatea in cadrul acestora, si calculati salariul mediu pentru fiecare echipa.

CREATE OR REPLACE PACKAGE proiect_sgbd_evs2 AS
    TYPE refcursor is ref cursor;
    TYPE angajat_echipa IS RECORD (
        nume_angajat Employee.EmployeeName%TYPE,
        salariu_angajat Job.JobSalary%TYPE
    );
    TYPE tabloul_angajati IS TABLE OF angajat_echipa;
    CURSOR c_angajati(id_echipa Team.TeamID%TYPE) RETURN angajat_echipa;
    TYPE echipa_record IS RECORD (
        id_echipa Team.TeamID%TYPE,
        nume_echipa Team.TeamName%TYPE,
        --angajati_echipa care e un cursor
        angajati_echipa c_angajati%TYPE
    );
    CURSOR c_echipe RETURN echipa_record;
    FUNCTION salariu_mediu_echipa(nume_echipa Team.TeamName%TYPE) RETURN NUMBER;
    PROCEDURE afisare_detalii_echipe;
END proiect_sgbd_evs2;

CREATE OR REPLACE PACKAGE BODY proiect_sgbd_evs2 AS
    CURSOR c_angajati(id_echipa Team.TeamID%TYPE) RETURN angajat_echipa IS
        SELECT Employee.EmployeeName, Job.JobSalary
        FROM Employee, Job
        WHERE Employee.TeamID = id_echipa AND Employee.JobID = Job.JobID;

    CURSOR c_echipa RETURN echipa_record IS
        SELECT Team.TeamID, Team.TeamName, c_angajati(Team.TeamID) angajati_echipa
        FROM Team;

    FUNCTION salariu_mediu_echipa(nume_echipa Team.TeamName%TYPE)
        RETURN NUMBER IS
        salariu_mediu NUMBER;
        BEGIN
            SELECT AVG(JobSalary)
            INTO salariu_mediu
            FROM Employee, Job, Team
            WHERE Employee.JobID = Job.JobID AND Employee.TeamID = Team.TeamID AND TeamName = nume_echipa;
            RETURN salariu_mediu;
        END salariu_mediu_echipa;

    PROCEDURE afisare_detalii_echipe IS
        v_id_echipa Team.TeamID%TYPE;
        v_nume_echipa Team.TeamName%TYPE;
        v_cursor refcursor;
        v_nume_angajat Employee.EmployeeName%TYPE;
        v_salariu_angajat Job.JobSalary%TYPE;
    BEGIN
        OPEN c_echipa;
        LOOP
            FETCH c_echipa INTO v_id_echipa, v_nume_echipa, v_cursor;
            EXIT WHEN c_echipa%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Echipa ' || v_nume_echipa || ' are salariul mediu de ' || salariu_mediu_echipa(v_nume_echipa));
            LOOP
                FETCH v_cursor INTO v_nume_angajat, v_salariu_angajat;
                EXIT WHEN v_cursor%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('Angajatul ' || v_nume_angajat || ' are salariul ' || v_salariu_angajat);
            end loop;
        end loop;
    END afisare_detalii_echipe;
END proiect_sgbd_evs2;


--VARIANTA 2
--Exercitiul 14
--Definiti un pachet care sa includa tipuri de date complexe si obiecte necesare
--unui flux de actiuni integrate, specifice bazei de date definite (minim 2 tipuri de date, minim 2 functii, minim 2 proceduri)

--Pentru fiecare echipa, obtineti numele precum si lista numelor angajatilor care isi desfasoara
--activitatea in cadrul acestora, si calculati salariul mediu pentru fiecare echipa. Pentru fiecare angajat
--se va afisa si functia acestuia.

CREATE OR REPLACE PACKAGE proiect_sgbd_evs2 AS
    TYPE echipa_record IS RECORD (
        id_echipa Team.TeamID%TYPE,
        nume_echipa Team.TeamName%TYPE
    );
    CURSOR c_echipa RETURN echipa_record;
    FUNCTION salariu_mediu_echipa(nume_echipa Team.TeamName%TYPE) RETURN NUMBER;
    PROCEDURE afisare_detalii_echipe;
    TYPE tablou_imbricat is TABLE OF VARCHAR2(100);
    FUNCTION functii_angajati RETURN tablou_imbricat;
    FUNCTION get_salariu(id_angajat Employee.EmployeeID%TYPE) RETURN NUMBER;
END proiect_sgbd_evs2;

CREATE OR REPLACE PACKAGE BODY proiect_sgbd_evs2 AS
    CURSOR c_echipa RETURN echipa_record IS
        SELECT Team.TeamID, Team.TeamName
        FROM Team;
    FUNCTION get_salariu(id_angajat Employee.EmployeeID%TYPE) RETURN NUMBER IS
        salariu NUMBER;
    BEGIN
        select JobSalary
        into salariu
        from Job
        where JobID = (select JobID
                       from Employee
                       where EmployeeID = id_angajat);
        RETURN salariu;
    END get_salariu;

    FUNCTION functii_angajati RETURN tablou_imbricat IS
        v_tablou tablou_imbricat := tablou_imbricat();
        nr_angajati NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO nr_angajati
        FROM Employee;
        FOR id_angajat IN 1..nr_angajati
        LOOP
            v_tablou.extend;
            SELECT Job.JobName
            INTO v_tablou(id_angajat)
            FROM Employee, Job
            WHERE Employee.JobID = Job.JobID AND Employee.EmployeeID = id_angajat;
        END LOOP;
        RETURN v_tablou;
    END functii_angajati;

    FUNCTION salariu_mediu_echipa(nume_echipa Team.TeamName%TYPE)
        RETURN NUMBER IS
        salariu_mediu NUMBER;
        BEGIN
            SELECT Round(AVG(JobSalary), 2)
            INTO salariu_mediu
            FROM Employee, Job, Team
            WHERE Employee.JobID = Job.JobID AND Employee.TeamID = Team.TeamID AND TeamName = nume_echipa;
            RETURN salariu_mediu;
        END salariu_mediu_echipa;

    PROCEDURE afisare_detalii_echipe IS
        nr_angajati NUMBER;
        i NUMBER;
        j NUMBER;
        vector_functii_angajati tablou_imbricat := tablou_imbricat();
        record_echipa echipa_record;
    BEGIN
        vector_functii_angajati := functii_angajati;
        OPEN c_echipa;
        i := 0;
        LOOP
            i := i + 1;
            FETCH c_echipa INTO record_echipa;
            EXIT WHEN c_echipa%NOTFOUND;
            SELECT COUNT(*) INTO nr_angajati FROM Employee WHERE TeamID = record_echipa.id_echipa;
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
            if nr_angajati > 0 then
                DBMS_OUTPUT.PUT_LINE(i || '. Echipa ' || record_echipa.nume_echipa || ' are ' || nr_angajati || ' angajati si salariul mediu este ' || salariu_mediu_echipa(record_echipa.nume_echipa));
                --AFISARE ANGAJATI
                j := 0;
                FOR angajat in (SELECT EmployeeID, EmployeeName FROM Employee WHERE TeamID = record_echipa.id_echipa)
                LOOP
                    j := j + 1;
                    DBMS_OUTPUT.PUT_LINE(j || '. Angajatul ' || angajat.EmployeeName || ' are functia ' || vector_functii_angajati(angajat.EmployeeID) || ' si are un salariu de ' || get_salariu(angajat.EmployeeID));
                END LOOP;
            else
                DBMS_OUTPUT.PUT_LINE(i || '. Echipa ' || record_echipa.nume_echipa || ' nu are angajati');
            end if;
        end loop;
    END afisare_detalii_echipe;
END proiect_sgbd_evs2;

--Testare pachet

BEGIN
    proiect_sgbd_evs2.afisare_detalii_echipe();
end;
