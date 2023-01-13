create table League
(
    LeagueID      int          not null
        constraint LEAGUE_PK
            primary key,
    LeagueName    varchar2(50) not null,
    LeagueCountry varchar2(50) not null
);

create table Team
(
    TeamID         int          not null
        constraint TEAM_PK
            primary key,
    TeamName       varchar2(50) not null,
    FoundationYear int          not null,
    LeagueID       int          not null
);

ALTER TABLE Team
ADD (CONSTRAINT  team_league_fk
    FOREIGN KEY (LeagueID)
    REFERENCES League(LeagueID));

CREATE TABLE Ranking
(
    RankingID int not null
        constraint RANKING_PK
            primary key,
    Points    int,
    LeagueID  int not null,
    TeamID    int not null
);

ALTER TABLE Ranking
ADD (CONSTRAINT ranking_league_fk
    FOREIGN KEY (LeagueID)
    REFERENCES League(LeagueID),
    CONSTRAINT ranking_team_fk
    FOREIGN KEY (TeamID)
    REFERENCES Team(TeamID));


create table Stadium
(
    StadiumID       int
        constraint STADIUM_PK
            primary key,
    TeamID          int          not null,
    StadiumName     varchar2(50) not null,
    StadiumCapacity int          not null,
    BuildingYear    int          not null,
    UefaStars       int          not null,
    StadiumCity     varchar2(50) not null
);


alter table Stadium
ADD (CONSTRAINT stadium_team_fk
    FOREIGN KEY (TeamID)
    REFERENCES Team(TeamID));

create table Country
(
    CountryID        int          not null
        constraint COUNTRY_PK
            primary key,
    CountryName      varchar2(50) not null,
    CountryContinent varchar2(50) not null
);

create table Job
(
    JobID     int          not null
        constraint JOB_PK
            primary key,
    JobName   varchar2(50) not null,
    JobSalary varchar2(50) not null
);

create table Manager
(
    ManagerID   int          not null
        constraint MANAGER_PK
            primary key,
    CountryID   int          not null,
    TeamID      int          not null,
    ManagerName varchar2(50) not null
);

alter table Manager
ADD (CONSTRAINT manager_country_fk
    FOREIGN KEY (CountryID)
    REFERENCES Country(CountryID),
    CONSTRAINT manager_team_fk
    FOREIGN KEY (TeamID)
    REFERENCES Team(TeamID)
    );

create table Employee
(
    EmployeeID   int          not null
        constraint EMPLOYEE_PK
            primary key,
    JobID        int          not null,
    CountryID    int          not null,
    TeamID       int          not null,
    EmployeeName varchar2(50) not null
);

alter table Employee
ADD (CONSTRAINT employee_job_fk
    FOREIGN KEY (JobID)
    REFERENCES Job(JobID),
    CONSTRAINT employee_country_fk
    FOREIGN KEY (CountryID)
    REFERENCES Country(CountryID),
    CONSTRAINT employee_team_fk
    FOREIGN KEY (TeamID)
    REFERENCES Team(TeamID)
    );

create table Player
(
    PlayerID       int          not null
        constraint PLAYER_PK
            primary key,
    TeamID         int          not null,
    CountryID      int          not null,
    PlayerName     varchar2(50) not null,
    PlayerPosition varchar2(50) not null,
    JerseyNumber   int          not null
);

alter table Player
ADD(CONSTRAINT player_team_fk
    FOREIGN KEY (TeamID)
    REFERENCES Team(TeamID),
    CONSTRAINT player_country_fk
    FOREIGN KEY (CountryID)
    REFERENCES Country(CountryID));

create table Sponsor
(
    SponsorID   int          not null
        constraint SPONSOR_PK
            primary key,
    SponsorName varchar2(50) not null
);

create table Contract
(
    ContractID      int                  not null
        constraint CONTRACT_PK
            primary key,
    ClauzaReziliere int                  not null,
    Years           int                  not null
);

create table Deal
(
    PlayerID   int not null,
    SponsorID  int not null,
    ContractID int not null,
    constraint DEAL_PrimaryKey
        primary key (PlayerID, SponsorID, ContractID)
);

alter table Deal
ADD (CONSTRAINT deal_player_fk
    FOREIGN KEY (PlayerID)
    REFERENCES Player(PlayerID),
    CONSTRAINT deal_sponsor_fk
    FOREIGN KEY (SponsorID)
    REFERENCES Sponsor(SponsorID),
    CONSTRAINT deal_contract_fk
    FOREIGN KEY (ContractID)
    REFERENCES Contract(ContractID)
    );


create table Broadcaster
(
    BroadcasterID   int          not null
        constraint BROADCASTER_PK
            primary key,
    BroadcasterName varchar2(50) not null,
    CommentatorName varchar2(50) not null
);

create table Livestream
(
    LeagueID    int not null,
    BroadcasterID int not null,
    StartDate       date         not null,
    EndDate         date         not null,
    constraint LIVESTREAM_PK
        primary key (LeagueID, BroadcasterID)
);

alter table Livestream
ADD (CONSTRAINT livestream_league_fk
    FOREIGN KEY (LeagueID)
    REFERENCES League(LeagueID),
    CONSTRAINT livestream_broadcast_fk
    FOREIGN KEY (BroadcasterID)
    REFERENCES Broadcaster(BroadcasterID)
    );

CREATE SEQUENCE AUTO_ID
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000
NOCYCLE;

INSERT INTO League(LeagueID, LeagueName, LeagueCountry) VALUES (AUTO_ID.nextval, 'Liga 1 Betano','Romania');
INSERT INTO League(LeagueID, LeagueName, LeagueCountry) VALUES (AUTO_ID.nextval, 'La Liga Santander','Spania');
INSERT INTO League(LeagueID, LeagueName, LeagueCountry) VALUES (AUTO_ID.nextval, 'English Premier League','Anglia');
INSERT INTO League(LeagueID, LeagueName, LeagueCountry) VALUES (AUTO_ID.nextval, 'Ligue 1 UberEats','Franta');
INSERT INTO League(LeagueID, LeagueName, LeagueCountry) VALUES (AUTO_ID.nextval, 'Serie A TIM','Italia');
INSERT INTO League(LeagueID, LeagueName, LeagueCountry) VALUES (AUTO_ID.nextval, 'Bundesliga','Germania');

select * from League;

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

INSERT INTO Team(TeamID, TeamName, FoundationYear, LeagueID)
            VALUES (AUTO_ID.nextval,'CFR Cluj', 1907, 1);
INSERT INTO Team(TeamID, TeamName, FoundationYear, LeagueID)
            VALUES (AUTO_ID.nextval,'FC Steaua Bucuresti', 1947, 1);
INSERT INTO Team(TeamID, TeamName, FoundationYear, LeagueID)
            VALUES (AUTO_ID.nextval,'CS Universitatea Craiova', 1948, 1);
INSERT INTO Team(TeamID, TeamName, FoundationYear, LeagueID)
            VALUES (AUTO_ID.nextval,'FC Dinamo Bucuresti', 1948, 1);
INSERT INTO Team(TeamID, TeamName, FoundationYear, LeagueID)
            VALUES (AUTO_ID.nextval,'Rapid Bucuresti', 1923, 1);
INSERT INTO Team(TeamID, TeamName, FoundationYear, LeagueID)
            VALUES (AUTO_ID.nextval,'SC Otelul Galati', 1964, 1);
INSERT INTO Team(TeamID, TeamName, FoundationYear, LeagueID)
            VALUES (AUTO_ID.nextval,'Real Madrid', 1902, 2);
INSERT INTO Team(TeamID, TeamName, FoundationYear, LeagueID)
            VALUES (AUTO_ID.nextval,'Liverpool', 1892, 3);
INSERT INTO Team(TeamID, TeamName, FoundationYear, LeagueID)
            VALUES (AUTO_ID.nextval,'PSG', 1907, 4);
INSERT INTO Team(TeamID, TeamName, FoundationYear, LeagueID)
            VALUES (AUTO_ID.nextval,'AC Milan', 1899, 5);
INSERT INTO Team(TeamID, TeamName, FoundationYear, LeagueID)
            VALUES (AUTO_ID.nextval,'Borussia Dortmund', 1909, 6);

select * from Team;

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

INSERT INTO Ranking(RankingID, Points, LeagueID, TeamID)
            VALUES(AUTO_ID.nextval, 57, 1, 1);
INSERT INTO Ranking(RankingID, Points, LeagueID, TeamID)
            VALUES(AUTO_ID.nextval, 56, 1, 2);
INSERT INTO Ranking(RankingID, Points, LeagueID, TeamID)
            VALUES(AUTO_ID.nextval, 48, 1, 3);
INSERT INTO Ranking(RankingID, Points, LeagueID, TeamID)
            VALUES(AUTO_ID.nextval, 49, 1, 4);
INSERT INTO Ranking(RankingID, Points, LeagueID, TeamID)
            VALUES(AUTO_ID.nextval, 45, 1, 5);
INSERT INTO Ranking(RankingID, Points, LeagueID, TeamID)
            VALUES(AUTO_ID.nextval, 45, 1, 6);

select * from Ranking;


DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;


INSERT INTO Stadium(StadiumID, TeamID, StadiumName, StadiumCapacity, BuildingYear, UefaStars, StadiumCity)
VALUES (AUTO_ID.nextval,4,'Stadionul Stefan cel Mare',15032,1952,2,'Bucuresti');
INSERT INTO Stadium(StadiumID, TeamID, StadiumName, StadiumCapacity, BuildingYear, UefaStars, StadiumCity)
VALUES (AUTO_ID.nextval,2,'Stadionul Ghencea',31254,2021,4,'Bucuresti');
INSERT INTO Stadium(StadiumID, TeamID, StadiumName, StadiumCapacity, BuildingYear, UefaStars, StadiumCity)
VALUES (AUTO_ID.nextval,1,'Stadionul Dr. Constantin Radulescu',22198,1973,3,'Cluj-Napoca');
INSERT INTO Stadium(StadiumID, TeamID, StadiumName, StadiumCapacity, BuildingYear, UefaStars, StadiumCity)
VALUES (AUTO_ID.nextval,5,'Stadionul Giulesti',14047,2022,3,'Bucuresti');
INSERT INTO Stadium(StadiumID, TeamID, StadiumName, StadiumCapacity, BuildingYear, UefaStars, StadiumCity)
VALUES (AUTO_ID.nextval,6,'Stadionul Otelul',13932,1982,2,'Galati');
INSERT INTO Stadium(StadiumID, TeamID, StadiumName, StadiumCapacity, BuildingYear, UefaStars, StadiumCity)
VALUES (AUTO_ID.nextval,11,'Signal Iduna Park',81365,1974,5,'Dortmund');
INSERT INTO Stadium(StadiumID, TeamID, StadiumName, StadiumCapacity, BuildingYear, UefaStars, StadiumCity)
VALUES (AUTO_ID.nextval,9,'Parc des Princes',47929,1972,5,'Paris');
INSERT INTO Stadium(StadiumID, TeamID, StadiumName, StadiumCapacity, BuildingYear, UefaStars, StadiumCity)
VALUES (AUTO_ID.nextval,8,'Anfield Stadium',53594,1884,5,'Liverpool');
INSERT INTO Stadium(StadiumID, TeamID, StadiumName, StadiumCapacity, BuildingYear, UefaStars, StadiumCity)
VALUES (AUTO_ID.nextval,7,'Stadio Bernabeu',81044,1947,5,'Madrid');
INSERT INTO Stadium(StadiumID, TeamID, StadiumName, StadiumCapacity, BuildingYear, UefaStars, StadiumCity)
VALUES (AUTO_ID.nextval,10,'San Siro',80018,1926,5,'Milano');
INSERT INTO Stadium(StadiumID, TeamID, StadiumName, StadiumCapacity, BuildingYear, UefaStars, StadiumCity)
VALUES (AUTO_ID.nextval,3,'Stadionul Ion Oblemenco',30944,2017,4,'Craiova');

select * from Stadium;

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Romania','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Coasta de Fildes','Africa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Italia','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Republica Moldova','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Brazilia','America');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Bosnia si Herzegovina','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Ghana','Africa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Islanda','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Franta','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Croatia','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Muntenegru','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Portugalia','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Argentina','America');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Bulgaria','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Macedonia de Nord','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Nigeria','Africa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Estonia','Europa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Maroc','Africa');
INSERT INTO Country(CountryID, CountryName, CountryContinent) VALUES (AUTO_ID.nextval,'Germania','Europa');

select * from Country;

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

INSERT INTO Player(PlayerID, TeamID, CountryID, PlayerName, PlayerPosition, JerseyNumber)
VALUES (AUTO_ID.nextval, 6, 1, 'Dur-Bozoanca','GK',13);
INSERT INTO Player(PlayerID, TeamID, CountryID, PlayerName, PlayerPosition, JerseyNumber)
VALUES (AUTO_ID.nextval, 6, 1, 'Ursu','GK',1);
INSERT INTO Player(PlayerID, TeamID, CountryID, PlayerName, PlayerPosition, JerseyNumber)
VALUES (AUTO_ID.nextval, 6, 2, 'Yabre','DEF',15);
INSERT INTO Player(PlayerID, TeamID, CountryID, PlayerName, PlayerPosition, JerseyNumber)
VALUES (AUTO_ID.nextval, 6, 1, 'Sirghi','DEF',33);
INSERT INTO Player(PlayerID, TeamID, CountryID, PlayerName, PlayerPosition, JerseyNumber)
VALUES (AUTO_ID.nextval, 6, 1, 'Ghiocel','DEF', 16);
INSERT INTO Player(PlayerID, TeamID, CountryID, PlayerName, PlayerPosition, JerseyNumber)
VALUES (AUTO_ID.nextval, 6, 1, 'Neagu','MID', 8);
INSERT INTO Player(PlayerID, TeamID, CountryID, PlayerName, PlayerPosition, JerseyNumber)
VALUES (AUTO_ID.nextval, 6, 4, 'Jardan','MID',23);
INSERT INTO Player(PlayerID, TeamID, CountryID, PlayerName, PlayerPosition, JerseyNumber)
VALUES (AUTO_ID.nextval, 6, 1, 'Nica','MID',11);
INSERT INTO Player(PlayerID, TeamID, CountryID, PlayerName, PlayerPosition, JerseyNumber)
VALUES (AUTO_ID.nextval, 6, 3, 'Cisotti','ATT',30);
INSERT INTO Player(PlayerID, TeamID, CountryID, PlayerName, PlayerPosition, JerseyNumber)
VALUES (AUTO_ID.nextval, 6, 1, 'Cirjan','ATT',7);
INSERT INTO Player(PlayerID, TeamID, CountryID, PlayerName, PlayerPosition, JerseyNumber)
VALUES (AUTO_ID.nextval, 6, 4, 'Cricimari', 'ATT', 9);
insert into Player values (AUTO_ID.nextval, 1, 1,'Hindrich', 'GK', 89);
insert into Player values (AUTO_ID.nextval, 1, 1,'Balgradean', 'GK', 34);
insert into Player values (AUTO_ID.nextval, 1, 1,'Stefan', 'DEF', 78);
insert into Player values (AUTO_ID.nextval, 1, 1,'Camora', 'DEF', 45);
insert into Player values (AUTO_ID.nextval, 1, 5,'Yuri', 'DEF', 44);
insert into Player values (AUTO_ID.nextval, 1, 1,'Burca', 'DEF', 3);
insert into Player values (AUTO_ID.nextval, 1, 6,'Graovac', 'DEF', 6);
insert into Player values (AUTO_ID.nextval, 1, 6,'Susic', 'DEF', 16);
insert into Player values (AUTO_ID.nextval, 1, 1,'Manea', 'DEF', 4);
insert into Player values (AUTO_ID.nextval, 1, 1,'Deac', 'MID', 10);
insert into Player values (AUTO_ID.nextval, 1, 7,'Boateng', 'MID', 21);
insert into Player values (AUTO_ID.nextval, 1, 8,'Sigurjonsson', 'MID', 8);
insert into Player values (AUTO_ID.nextval, 1, 1,'Bordeianu', 'MID', 37);
insert into Player values (AUTO_ID.nextval, 1, 1,'Gidea', 'MID', 98);
insert into Player values (AUTO_ID.nextval, 1, 1,'Paun', 'MID', 7);
insert into Player values (AUTO_ID.nextval, 1, 1,'Costache', 'ATT', 18);
insert into Player values (AUTO_ID.nextval, 1, 1,'Petrila', 'ATT', 27);
insert into Player values (AUTO_ID.nextval, 1, 5,'Roger', 'ATT', 77);
insert into Player values (AUTO_ID.nextval, 1, 9,'Omrani', 'ATT', 9);
insert into Player values (AUTO_ID.nextval, 1, 10,'Dugandzic', 'ATT', 17);
insert into Player values (AUTO_ID.nextval, 1, 10,'Debeljuh', 'ATT', 22);
insert into Player values (AUTO_ID.nextval, 1, 1,'Negut', 'ATT', 75);
insert into Player values (AUTO_ID.nextval, 1, 1,'Birligea', 'ATT', 30);
insert into Player values (AUTO_ID.nextval, 1, 1,'Bus', 'ATT', 99);
insert into Player values (AUTO_ID.nextval, 2, 1,'Vlad', 'GK', 99);
insert into Player values (AUTO_ID.nextval, 2, 1,'Tarnovanu', 'GK', 32);
insert into Player values (AUTO_ID.nextval, 2, 1,'Straton', 'GK', 1);
insert into Player values (AUTO_ID.nextval, 2, 11,'Radunovic', 'DEF', 33);
insert into Player values (AUTO_ID.nextval, 2, 1,'Serban', 'DEF', 77);
insert into Player values (AUTO_ID.nextval, 2, 1,'Pantiru', 'DEF', 3);
insert into Player values (AUTO_ID.nextval, 2, 5,'Vinicius', 'DEF', 55);
insert into Player values (AUTO_ID.nextval, 2, 1,'Cristea', 'DEF', 17);
insert into Player values (AUTO_ID.nextval, 2, 1,'Miron', 'DEF', 4);
insert into Player values (AUTO_ID.nextval, 2, 1,'Cretu', 'DEF', 2);
insert into Player values (AUTO_ID.nextval, 2, 1,'Achim', 'DEF', 21);
insert into Player values (AUTO_ID.nextval, 2, 1,'Popescu', 'MID', 23);
insert into Player values (AUTO_ID.nextval, 2, 1,'Tanase', 'MID', 10);
insert into Player values (AUTO_ID.nextval, 2, 9,'Edjouma', 'MID', 18);
insert into Player values (AUTO_ID.nextval, 2, 1,'Perianu', 'MID', 25);
insert into Player values (AUTO_ID.nextval, 2, 1,'Sut', 'MID', 8);
insert into Player values (AUTO_ID.nextval, 2, 1,'Oaida', 'MID', 26);
insert into Player values (AUTO_ID.nextval, 2, 1,'Olaru', 'MID', 27);
insert into Player values (AUTO_ID.nextval, 2, 1,'Musi', 'MID', 30);
insert into Player values (AUTO_ID.nextval, 2, 1,'Popescu', 'ATT', 9);
insert into Player values (AUTO_ID.nextval, 2, 1,'Burlacu', 'ATT', 20);
insert into Player values (AUTO_ID.nextval, 2, 1,'Coman', 'ATT', 7);
insert into Player values (AUTO_ID.nextval, 2, 1,'Stoica', 'ATT', 19);
insert into Player values (AUTO_ID.nextval, 2, 10,'Mamut', 'ATT', 31);
insert into Player values (AUTO_ID.nextval, 2, 1,'Dumiter', 'ATT', 13);
insert into Player values (AUTO_ID.nextval, 2, 1,'Gheorghe', 'ATT', 22);
insert into Player values (AUTO_ID.nextval, 2, 1,'Cordea', 'ATT', 98);
insert into Player values (AUTO_ID.nextval, 3, 3,'Pigliacelli', 'GK', 13);
insert into Player values (AUTO_ID.nextval, 3, 1,'Lazar', 'GK', 1);
insert into Player values (AUTO_ID.nextval, 3, 1,'Bancu', 'DEF', 11);
insert into Player values (AUTO_ID.nextval, 3, 9,'Conte', 'DEF', 29);
insert into Player values (AUTO_ID.nextval, 3, 1,'Gaman', 'DEF', 25);
insert into Player values (AUTO_ID.nextval, 3, 1,'Papp', 'DEF', 2);
insert into Player values (AUTO_ID.nextval, 3, 1,'Constantin', 'DEF', 23);
insert into Player values (AUTO_ID.nextval, 3, 1,'Screciu', 'DEF', 6);
insert into Player values (AUTO_ID.nextval, 3, 1,'Vladoiu', 'DEF', 18);
insert into Player values (AUTO_ID.nextval, 3, 1,'Vatajelu', 'DEF', 5);
insert into Player values (AUTO_ID.nextval, 3, 1,'Mateiu', 'MID', 8);
insert into Player values (AUTO_ID.nextval, 3, 1,'Capatina', 'MID', 33);
insert into Player values (AUTO_ID.nextval, 3, 10,'Rogulic', 'MID', 24);
insert into Player values (AUTO_ID.nextval, 3, 1,'Bic', 'MID', 27);
insert into Player values (AUTO_ID.nextval, 3, 1,'Cretu', 'MID', 14);
insert into Player values (AUTO_ID.nextval, 3, 1,'Nistor', 'MID', 16);
insert into Player values (AUTO_ID.nextval, 3, 1,'Vina', 'MID', 10);
insert into Player values (AUTO_ID.nextval, 3, 9,'Houri', 'MID', 15);
insert into Player values (AUTO_ID.nextval, 3, 1,'Baiaram', 'ATT', 17);
insert into Player values (AUTO_ID.nextval, 3, 1,'Ivan', 'ATT', 9);
insert into Player values (AUTO_ID.nextval, 3, 1,'Markovic', 'ATT', 20);
insert into Player values (AUTO_ID.nextval, 3, 6,'Koljic', 'ATT', 19);
insert into Player values (AUTO_ID.nextval, 3, 1,'Cimpanu', 'ATT', 7);
insert into Player values (AUTO_ID.nextval, 3, 5,'Gustavo', 'ATT', 22);
insert into Player values (AUTO_ID.nextval, 4, 12,'Figueiredo', 'GK', 13);
insert into Player values (AUTO_ID.nextval, 4, 1,'Esanu', 'GK', 12);
insert into Player values (AUTO_ID.nextval, 4, 1,'Giafer', 'DEF', 24);
insert into Player values (AUTO_ID.nextval, 4, 1,'Ehmann', 'DEF', 6);
insert into Player values (AUTO_ID.nextval, 4, 1,'Carp', 'DEF', 71);
insert into Player values (AUTO_ID.nextval, 4, 10,'Jovanovic', 'DEF', 4);
insert into Player values (AUTO_ID.nextval, 4, 1,'Grigore', 'DEF', 27);
insert into Player values (AUTO_ID.nextval, 4, 1,'Tomozei', 'DEF', 26);
insert into Player values (AUTO_ID.nextval, 4, 1,'Patriche', 'DEF', 23);
insert into Player values (AUTO_ID.nextval, 4, 1,'Radu', 'DEF', 3);
insert into Player values (AUTO_ID.nextval, 4, 1,'Buleica', 'DEF', 77);
insert into Player values (AUTO_ID.nextval, 4, 1,'Rauta', 'MID', 5);
insert into Player values (AUTO_ID.nextval, 4, 13,'Rodriguez', 'MID', 18);
insert into Player values (AUTO_ID.nextval, 4, 1,'Matei', 'MID', 10);
insert into Player values (AUTO_ID.nextval, 4, 1,'Bani', 'MID', 38);
insert into Player values (AUTO_ID.nextval, 4, 14,'Ivanov', 'MID', 99);
insert into Player values (AUTO_ID.nextval, 4, 1,'Cretu', 'MID', 32);
insert into Player values (AUTO_ID.nextval, 4, 5,'deMoura', 'MID', 2);
insert into Player values (AUTO_ID.nextval, 4, 1,'Gradinaru', 'MID', 21);
insert into Player values (AUTO_ID.nextval, 4, 9,'Pierret', 'MID', 8);
insert into Player values (AUTO_ID.nextval, 4, 1,'Borcea', 'MID', 28);
insert into Player values (AUTO_ID.nextval, 4, 1,'Torje', 'ATT', 22);
insert into Player values (AUTO_ID.nextval, 4, 15,'Ivanovski', 'ATT', 44);
insert into Player values (AUTO_ID.nextval, 4, 1,'Bordusanu', 'ATT', 20);
insert into Player values (AUTO_ID.nextval, 4, 1,'Morar', 'ATT', 70);
insert into Player values (AUTO_ID.nextval, 4, 16,'Irobiso', 'ATT', 35);
insert into Player values (AUTO_ID.nextval, 4, 1,'Mihaiu', 'ATT', 98);
insert into Player values (AUTO_ID.nextval, 5, 1,'Moldovan', 'GK', 31);
insert into Player values (AUTO_ID.nextval, 5, 1,'Draghia', 'GK', 90);
insert into Player values (AUTO_ID.nextval, 5, 1,'Belu-Iordache', 'DEF', 77);
insert into Player values (AUTO_ID.nextval, 5, 1,'Sapunaru', 'DEF', 22);
insert into Player values (AUTO_ID.nextval, 5, 1,'Grigore', 'DEF', 27);
insert into Player values (AUTO_ID.nextval, 5, 5,'Junior-Morais', 'DEF', 11);
insert into Player values (AUTO_ID.nextval, 5, 1,'Dandea', 'DEF', 30);
insert into Player values (AUTO_ID.nextval, 5, 1,'Demici', 'DEF', 44);
insert into Player values (AUTO_ID.nextval, 5, 13,'Acuna', 'DEF', 21);
insert into Player values (AUTO_ID.nextval, 5, 1,'Goge', 'DEF', 13);
insert into Player values (AUTO_ID.nextval, 5, 1,'Onea', 'DEF', 19);
insert into Player values (AUTO_ID.nextval, 5, 17, 'Kait', 'MID', 14);
insert into Player values (AUTO_ID.nextval, 5, 1,'Albu', 'MID', 23);
insert into Player values (AUTO_ID.nextval, 5, 1,'Sefer', 'MID', 7);
insert into Player values (AUTO_ID.nextval, 5, 1,'Stahl', 'MID', 29);
insert into Player values (AUTO_ID.nextval, 5, 1,'Ilie', 'MID', 10);
insert into Player values (AUTO_ID.nextval, 5, 1,'Carnat', 'MID', 8);
insert into Player values (AUTO_ID.nextval, 5, 1,'Ionita', 'MID', 80);
insert into Player values (AUTO_ID.nextval, 5, 10,'Crepulja', 'MID', 4);
insert into Player values (AUTO_ID.nextval, 5, 1,'Hlistei', 'MID', 94);
insert into Player values (AUTO_ID.nextval, 5, 1,'Moise', 'MID', 20);
insert into Player values (AUTO_ID.nextval, 5, 1,'Panoiu', 'MID', 17);
insert into Player values (AUTO_ID.nextval, 5, 10,'Vojtus', 'ATT', 71);
insert into Player values (AUTO_ID.nextval, 5, 1,'Balan', 'ATT', 9);
insert into Player values (AUTO_ID.nextval, 5, 18,'Marzouk', 'ATT', 57);

select * from Player;


DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;


insert into Broadcaster(BroadcasterID, BroadcasterName, CommentatorName)
VALUES (AUTO_ID.nextval,'Digi Sport','Dan Stefanescu');
insert into Broadcaster(BroadcasterID, BroadcasterName, CommentatorName)
VALUES (AUTO_ID.nextval,'PROTV','Mihai Mironica');
insert into Broadcaster(BroadcasterID, BroadcasterName, CommentatorName)
VALUES (AUTO_ID.nextval,'TVR','Marian Oleianos');
insert into Broadcaster(BroadcasterID, BroadcasterName, CommentatorName)
VALUES (AUTO_ID.nextval,'LookTV','Emil Gradinescu');
insert into Broadcaster(BroadcasterID, BroadcasterName, CommentatorName)
VALUES (AUTO_ID.nextval,'Orange Sport','Bogdan Socol');
insert into Broadcaster(BroadcasterID, BroadcasterName, CommentatorName)
VALUES (AUTO_ID.nextval,'Eurosport','Emanuel Terzian');

select * from Broadcaster;



insert into Livestream(LeagueID, BroadcasterID, StartDate, EndDate)
VALUES (1,1,TO_DATE('2019-06-01','YYYY-MM-DD'), TO_DATE('2023-06-01','YYYY-MM-DD'));
insert into Livestream(LeagueID, BroadcasterID, StartDate, EndDate)
VALUES (1,4,TO_DATE('2020-06-01','YYYY-MM-DD'), TO_DATE('2025-06-01','YYYY-MM-DD'));
insert into Livestream(LeagueID, BroadcasterID, StartDate, EndDate)
VALUES (2,1,TO_DATE('2016-06-01','YYYY-MM-DD'), TO_DATE('2026-06-01','YYYY-MM-DD'));
insert into Livestream(LeagueID, BroadcasterID, StartDate, EndDate)
VALUES (3,6,TO_DATE('2012-06-01','YYYY-MM-DD'), TO_DATE('2022-06-01','YYYY-MM-DD'));
insert into Livestream(LeagueID, BroadcasterID, StartDate, EndDate)
VALUES (3,1,TO_DATE('2022-06-01','YYYY-MM-DD'), TO_DATE('2025-06-01','YYYY-MM-DD'));
insert into Livestream(LeagueID, BroadcasterID, StartDate, EndDate)
VALUES (4,5,TO_DATE('2018-06-01','YYYY-MM-DD'), TO_DATE('2021-06-01','YYYY-MM-DD'));
insert into Livestream(LeagueID, BroadcasterID, StartDate, EndDate)
VALUES (5,3,TO_DATE('2020-06-01','YYYY-MM-DD'), TO_DATE('2025-06-01','YYYY-MM-DD'));
insert into Livestream(LeagueID, BroadcasterID, StartDate, EndDate)
VALUES (6,1,TO_DATE('2016-06-01','YYYY-MM-DD'), TO_DATE('2022-06-01','YYYY-MM-DD'));
insert into Livestream(LeagueID, BroadcasterID, StartDate, EndDate)
VALUES (6,4,TO_DATE('2020-06-01','YYYY-MM-DD'), TO_DATE('2023-06-01','YYYY-MM-DD'));
insert into Livestream(LeagueID, BroadcasterID, StartDate, EndDate)
VALUES (6,5,TO_DATE('2021-06-01','YYYY-MM-DD'), TO_DATE('2025-06-01','YYYY-MM-DD'));

select * from Livestream;

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

insert into Sponsor(SponsorID, SponsorName) VALUES (AUTO_ID.nextval,'Nike');
insert into Sponsor(SponsorID, SponsorName) VALUES (AUTO_ID.nextval,'Adidas');
insert into Sponsor(SponsorID, SponsorName) VALUES (AUTO_ID.nextval,'Puma');
insert into Sponsor(SponsorID, SponsorName) VALUES (AUTO_ID.nextval,'Under Armour');
insert into Sponsor(SponsorID, SponsorName) VALUES (AUTO_ID.nextval,'Joma');
insert into Sponsor(SponsorID, SponsorName) VALUES (AUTO_ID.nextval,'Umbro');

select * from Sponsor;


DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

insert into Contract(ContractID, ClauzaReziliere, Years) VALUES (AUTO_ID.nextval, 1, 1);
insert into Contract(ContractID, ClauzaReziliere, Years) VALUES (AUTO_ID.nextval, 1, 2);
insert into Contract(ContractID, ClauzaReziliere, Years) VALUES (AUTO_ID.nextval, 1, 3);
insert into Contract(ContractID, ClauzaReziliere, Years) VALUES (AUTO_ID.nextval, 1, 4);
insert into Contract(ContractID, ClauzaReziliere, Years) VALUES (AUTO_ID.nextval, 1, 5);
insert into Contract(ContractID, ClauzaReziliere, Years) VALUES (AUTO_ID.nextval, 0, 1);
insert into Contract(ContractID, ClauzaReziliere, Years) VALUES (AUTO_ID.nextval, 0, 2);
insert into Contract(ContractID, ClauzaReziliere, Years) VALUES (AUTO_ID.nextval, 0, 3);
insert into Contract(ContractID, ClauzaReziliere, Years) VALUES (AUTO_ID.nextval, 0, 4);
insert into Contract(ContractID, ClauzaReziliere, Years) VALUES (AUTO_ID.nextval, 0, 5);


select * from Contract;


insert into Deal(PlayerID, SponsorID, ContractID) VALUES(1, 5, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(2, 1, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(3, 3, 9);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(4, 1, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(5, 6, 3);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(6, 3, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(7, 1, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(8, 4, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(9, 1, 7);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(10, 1, 7);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(11, 5, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(12, 4, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(13, 1, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(14, 2, 9);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(15, 2, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(16, 1, 7);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(17, 3, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(18, 1, 9);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(19, 2, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(20, 6, 3);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(21, 3, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(22, 3, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(23, 1, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(24, 5, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(25, 5, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(26, 3, 9);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(27, 2, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(28, 4, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(29, 1, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(30, 1, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(31, 1, 3);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(32, 4, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(33, 4, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(34, 4, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(35, 6, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(36, 5, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(37, 6, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(38, 3, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(39, 6, 9);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(40, 3, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(41, 4, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(42, 4, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(43, 5, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(44, 1, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(45, 4, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(46, 5, 9);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(47, 5, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(48, 2, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(49, 2, 3);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(50, 2, 9);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(51, 5, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(52, 2, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(53, 5, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(54, 2, 7);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(55, 3, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(56, 3, 3);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(57, 5, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(58, 1, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(59, 1, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(60, 5, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(61, 2, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(62, 3, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(63, 3, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(64, 6, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(65, 4, 9);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(66, 1, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(67, 2, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(68, 5, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(69, 1, 3);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(70, 4, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(71, 2, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(72, 1, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(73, 2, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(74, 3, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(75, 2, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(76, 4, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(77, 6, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(78, 1, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(79, 2, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(80, 4, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(81, 5, 3);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(82, 5, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(83, 6, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(84, 3, 9);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(85, 5, 7);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(86, 4, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(87, 1, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(88, 3, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(89, 3, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(90, 3, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(91, 2, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(92, 2, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(93, 6, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(94, 4, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(95, 3, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(96, 3, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(97, 5, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(98, 3, 3);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(99, 4, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(100, 5, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(101, 3, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(102, 2, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(103, 5, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(104, 1, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(105, 5, 7);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(106, 2, 3);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(107, 5, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(108, 5, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(109, 5, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(110, 4, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(111, 2, 3);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(112, 3, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(113, 2, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(114, 3, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(115, 5, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(116, 3, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(117, 1, 9);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(118, 4, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(119, 2, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(120, 1, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(121, 1, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(122, 4, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(123, 1, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(124, 3, 1);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(125, 6, 7);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(126, 1, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(127, 2, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(128, 4, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(129, 3, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(130, 5, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(131, 5, 8);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(132, 2, 4);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(133, 5, 6);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(134, 6, 5);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(135, 2, 2);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(136, 5, 7);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(137, 1, 10);
insert into Deal(PlayerID, SponsorID, ContractID) VALUES(138, 4, 10);

select * from Deal;

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

insert into Manager(ManagerID, CountryID, TeamID, ManagerName) VALUES (AUTO_ID.nextval,1,1,'Dan Petrescu');
insert into Manager(ManagerID, CountryID, TeamID, ManagerName) VALUES (AUTO_ID.nextval,1,2,'Anton Petrea');
insert into Manager(ManagerID, CountryID, TeamID, ManagerName) VALUES (AUTO_ID.nextval,1,3,'Laszlo Balint');
insert into Manager(ManagerID, CountryID, TeamID, ManagerName) VALUES (AUTO_ID.nextval,1,5,'Adrian Mutu');
insert into Manager(ManagerID, CountryID, TeamID, ManagerName) VALUES (AUTO_ID.nextval,1,6,'Dorinel Munteanu');
insert into Manager(ManagerID, CountryID, TeamID, ManagerName) VALUES (AUTO_ID.nextval,3,7,'Carlo Ancelotti');
insert into Manager(ManagerID, CountryID, TeamID, ManagerName) VALUES (AUTO_ID.nextval,19,8,'Jurgen Klopp');
insert into Manager(ManagerID, CountryID, TeamID, ManagerName) VALUES (AUTO_ID.nextval,9,9,'Zinedine Zidane');
insert into Manager(ManagerID, CountryID, TeamID, ManagerName) VALUES (AUTO_ID.nextval,3,10,'Stefano Pioli');
insert into Manager(ManagerID, CountryID, TeamID, ManagerName) VALUES (AUTO_ID.nextval,10,11,'Edin Terzic');

select * from Manager;

DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

insert into Job(JobID, JobName, JobSalary) VALUES (AUTO_ID.nextval,'Preparator fizic',1500);
insert into Job(JobID, JobName, JobSalary) VALUES (AUTO_ID.nextval,'Medic',2500);
insert into Job(JobID, JobName, JobSalary) VALUES (AUTO_ID.nextval,'Copil de mingi',500);
insert into Job(JobID, JobName, JobSalary) VALUES (AUTO_ID.nextval,'Director tehnic',2500);
insert into Job(JobID, JobName, JobSalary) VALUES (AUTO_ID.nextval,'Administrator social media',1200);
insert into Job(JobID, JobName, JobSalary) VALUES (AUTO_ID.nextval,'Finantator',500);

select * from Job;


DROP SEQUENCE AUTO_ID;

CREATE SEQUENCE AUTO_ID
START WITH 1;

insert into Employee VALUES(AUTO_ID.nextval,3, 7, 9, 'Steven');
insert into Employee VALUES(AUTO_ID.nextval,5, 4, 9, 'Neena');
insert into Employee VALUES(AUTO_ID.nextval,5, 4, 5, 'Lex');
insert into Employee VALUES(AUTO_ID.nextval,3, 5, 5, 'Alexander');
insert into Employee VALUES(AUTO_ID.nextval,3, 6, 4, 'Bruce');
insert into Employee VALUES(AUTO_ID.nextval,5, 1, 3, 'David');
insert into Employee VALUES(AUTO_ID.nextval,1, 7, 1, 'Valli');
insert into Employee VALUES(AUTO_ID.nextval,4, 8, 2, 'Diana');
insert into Employee VALUES(AUTO_ID.nextval,5, 17, 10, 'Nancy');
insert into Employee VALUES(AUTO_ID.nextval,2, 7, 1, 'Daniel');
insert into Employee VALUES(AUTO_ID.nextval,4, 3, 2, 'John');
insert into Employee VALUES(AUTO_ID.nextval,3, 15, 4, 'Ismael');
insert into Employee VALUES(AUTO_ID.nextval,6, 12, 8, 'Jose Manuel');
insert into Employee VALUES(AUTO_ID.nextval,2, 5, 7, 'Luis');
insert into Employee VALUES(AUTO_ID.nextval,1, 12, 6, 'Den');
insert into Employee VALUES(AUTO_ID.nextval,1, 15, 6, 'Alexander');
insert into Employee VALUES(AUTO_ID.nextval,1, 1, 9, 'Shelli');
insert into Employee VALUES(AUTO_ID.nextval,2, 15, 10, 'Sigal');
insert into Employee VALUES(AUTO_ID.nextval,4, 17, 8, 'Guy');
insert into Employee VALUES(AUTO_ID.nextval,5, 4, 5, 'Karen');
insert into Employee VALUES(AUTO_ID.nextval,5, 3, 5, 'Matthew');
insert into Employee VALUES(AUTO_ID.nextval,4, 15, 10, 'Adam');
insert into Employee VALUES(AUTO_ID.nextval,1, 11, 5, 'Payam');
insert into Employee VALUES(AUTO_ID.nextval,3, 1, 2, 'Shanta');
insert into Employee VALUES(AUTO_ID.nextval,3, 11, 5, 'Kevin');
insert into Employee VALUES(AUTO_ID.nextval,6, 7, 8, 'Julia');
insert into Employee VALUES(AUTO_ID.nextval,5, 10, 2, 'Irene');
insert into Employee VALUES(AUTO_ID.nextval,6, 10, 2, 'James');
insert into Employee VALUES(AUTO_ID.nextval,5, 15, 9, 'Steven');
insert into Employee VALUES(AUTO_ID.nextval,2, 4, 7, 'Laura');
insert into Employee VALUES(AUTO_ID.nextval,4, 8, 10, 'Mozhe');
insert into Employee VALUES(AUTO_ID.nextval,2, 11, 3, 'James');
insert into Employee VALUES(AUTO_ID.nextval,1, 11, 10, 'TJ');
insert into Employee VALUES(AUTO_ID.nextval,2, 5, 6, 'Jason');
insert into Employee VALUES(AUTO_ID.nextval,6, 11, 2, 'Michael');
insert into Employee VALUES(AUTO_ID.nextval,1, 17, 5, 'Ki');
insert into Employee VALUES(AUTO_ID.nextval,3, 12, 9, 'Hazel');
insert into Employee VALUES(AUTO_ID.nextval,3, 12, 1, 'Renske');
insert into Employee VALUES(AUTO_ID.nextval,1, 1, 1, 'Stephen');
insert into Employee VALUES(AUTO_ID.nextval,4, 1, 6, 'John');
insert into Employee VALUES(AUTO_ID.nextval,4, 12, 6, 'Joshua');
insert into Employee VALUES(AUTO_ID.nextval,2, 10, 1, 'Trenna');
insert into Employee VALUES(AUTO_ID.nextval,1, 14, 6, 'Curtis');
insert into Employee VALUES(AUTO_ID.nextval,3, 13, 10, 'Randall');
insert into Employee VALUES(AUTO_ID.nextval,5, 15, 9, 'Peter');
insert into Employee VALUES(AUTO_ID.nextval,4, 11, 4, 'John');
insert into Employee VALUES(AUTO_ID.nextval,4, 16, 3, 'Karen');
insert into Employee VALUES(AUTO_ID.nextval,3, 11, 1, 'Alberto');
insert into Employee VALUES(AUTO_ID.nextval,1, 3, 7, 'Gerald');
insert into Employee VALUES(AUTO_ID.nextval,5, 3, 8, 'Eleni');
insert into Employee VALUES(AUTO_ID.nextval,5, 16, 10, 'Peter');
insert into Employee VALUES(AUTO_ID.nextval,6, 13, 6, 'David');
insert into Employee VALUES(AUTO_ID.nextval,6, 13, 1, 'Peter');
insert into Employee VALUES(AUTO_ID.nextval,5, 6, 8, 'Christopher');
insert into Employee VALUES(AUTO_ID.nextval,3, 8, 1, 'Nanette');
insert into Employee VALUES(AUTO_ID.nextval,4, 5, 7, 'Oliver');
insert into Employee VALUES(AUTO_ID.nextval,6, 14, 5, 'Janette');
insert into Employee VALUES(AUTO_ID.nextval,4, 16, 3, 'Patrick');
insert into Employee VALUES(AUTO_ID.nextval,2, 17, 4, 'Allan');
insert into Employee VALUES(AUTO_ID.nextval,1, 12, 2, 'Lindsey');
insert into Employee VALUES(AUTO_ID.nextval,4, 12, 4, 'Louise');
insert into Employee VALUES(AUTO_ID.nextval,6, 2, 4, 'Sarath');
insert into Employee VALUES(AUTO_ID.nextval,5, 8, 8, 'Clara');
insert into Employee VALUES(AUTO_ID.nextval,6, 6, 10, 'Danielle');
insert into Employee VALUES(AUTO_ID.nextval,3, 8, 5, 'Mattea');
insert into Employee VALUES(AUTO_ID.nextval,4, 10, 9, 'David');
insert into Employee VALUES(AUTO_ID.nextval,5, 4, 5, 'Sundar');
insert into Employee VALUES(AUTO_ID.nextval,2, 12, 9, 'Amit');
insert into Employee VALUES(AUTO_ID.nextval,6, 4, 7, 'Lisa');
insert into Employee VALUES(AUTO_ID.nextval,6, 16, 10, 'Harrison');
insert into Employee VALUES(AUTO_ID.nextval,5, 8, 8, 'Tayler');
insert into Employee VALUES(AUTO_ID.nextval,6, 10, 8, 'William');
insert into Employee VALUES(AUTO_ID.nextval,2, 10, 5, 'Elizabeth');
insert into Employee VALUES(AUTO_ID.nextval,6, 8, 7, 'Sundita');
insert into Employee VALUES(AUTO_ID.nextval,2, 10, 3, 'Ellen');
insert into Employee VALUES(AUTO_ID.nextval,5, 6, 7, 'Alyssa');
insert into Employee VALUES(AUTO_ID.nextval,4, 13, 9, 'Jonathon');
insert into Employee VALUES(AUTO_ID.nextval,1, 10, 2, 'Jack');
insert into Employee VALUES(AUTO_ID.nextval,4, 8, 7, 'Kimberely');
insert into Employee VALUES(AUTO_ID.nextval,2, 5, 4, 'Charles');
insert into Employee VALUES(AUTO_ID.nextval,6, 3, 4, 'Winston');
insert into Employee VALUES(AUTO_ID.nextval,1, 4, 2, 'Jean');
insert into Employee VALUES(AUTO_ID.nextval,5, 17, 6, 'Martha');
insert into Employee VALUES(AUTO_ID.nextval,5, 10, 3, 'Girard');
insert into Employee VALUES(AUTO_ID.nextval,2, 7, 2, 'Nandita');
insert into Employee VALUES(AUTO_ID.nextval,5, 4, 2, 'Alexis');
insert into Employee VALUES(AUTO_ID.nextval,1, 16, 7, 'Julia');
insert into Employee VALUES(AUTO_ID.nextval,2, 14, 5, 'Anthony');
insert into Employee VALUES(AUTO_ID.nextval,6, 17, 4, 'Kelly');
insert into Employee VALUES(AUTO_ID.nextval,5, 12, 5, 'Jennifer');
insert into Employee VALUES(AUTO_ID.nextval,2, 9, 9, 'Timothy');
insert into Employee VALUES(AUTO_ID.nextval,3, 6, 9, 'Randall');
insert into Employee VALUES(AUTO_ID.nextval,4, 9, 3, 'Sarah');
insert into Employee VALUES(AUTO_ID.nextval,1, 15, 6, 'Britney');
insert into Employee VALUES(AUTO_ID.nextval,1, 8, 1, 'Samuel');
insert into Employee VALUES(AUTO_ID.nextval,3, 14, 3, 'Vance');
insert into Employee VALUES(AUTO_ID.nextval,1, 4, 7, 'Alana');
insert into Employee VALUES(AUTO_ID.nextval,1, 9, 10, 'Kevin');
insert into Employee VALUES(AUTO_ID.nextval,6, 4, 4, 'Donald');
insert into Employee VALUES(AUTO_ID.nextval,5, 13, 10, 'Douglas');

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

BEGIN
    afisare_coechipieri(1);
END;

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

--Exercitiul 10
--Definiti un trigger de tip LMD la nivel de comanda. Declansati trigger-ul
--Presupunem ca fiecare ligă poate fi transmisă pe 2 canale de televiziune diferite(concurente).
--Creati un trigger de tip LMD la nivel de comanda care sa nu permita inserarea a mai multe canale de
--televiziune decât aceasta limita permisă. Declansati trigger-ul.

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

select count(*) from Player;
select count(*) from view_jucatori;
select * from view_jucatori;
select * from player;

insert into Player VALUES (200, 1, 20, 'Test', 'GK', 48);
insert into Deal VALUES(200, 1, 1);
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

--Exercitiul 14
--Definiti un pachet care sa includa tipuri de date complexe si obiecte necesare
--unui flux de actiuni integrate, specifice bazei de date definite (minim 2 tipuri de date, minim 2 functii, minim 2 proceduri)

--Pentru fiecare echipa, obtineti numele precum si lista numelor angajatilor care isi desfasoara
--activitatea in cadrul acestora, si calculati salariul mediu pentru fiecare echipa. Pentru fiecare angajat
--se va afisa si functia acestuia si cati colegi din acelasi departament are si la aceeasi echipa are.

CREATE OR REPLACE PACKAGE proiect_sgbd_evs2 AS
    TYPE tablou_imbricat is TABLE OF VARCHAR2(100);
    TYPE echipa_record IS RECORD (
        id_echipa Team.TeamID%TYPE,
        nume_echipa Team.TeamName%TYPE
    );
    CURSOR c_echipa RETURN echipa_record;
    FUNCTION get_salariu(id_angajat Employee.EmployeeID%TYPE) RETURN NUMBER;
    FUNCTION functii_angajati RETURN tablou_imbricat;
    FUNCTION salariu_mediu_echipa(nume_echipa Team.TeamName%TYPE) RETURN NUMBER;
    FUNCTION afisare_nr_colegi_angajat(id_angajat Employee.EmployeeID%TYPE) RETURN NUMBER;
    PROCEDURE afisare_detalii_echipe;
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

    FUNCTION afisare_nr_colegi_angajat(id_angajat Employee.EmployeeID%TYPE)
        RETURN NUMBER IS
        nr_colegi NUMBER;
        TYPE angajat_record is RECORD(
            id_angajat Employee.EmployeeName%TYPE,
            id_job_angajat Job.JobID%TYPE,
            id_echipa_angajat Team.TeamID%TYPE
        );
        angajatul_nostru angajat_record;
        BEGIN
            SELECT Employee.EmployeeName, Employee.JobID, Employee.TeamID
            INTO angajatul_nostru
            FROM Employee
            WHERE Employee.EmployeeID = id_angajat;

            SELECT COUNT(*)
            INTO nr_colegi
            FROM Employee
            WHERE Employee.JobID = angajatul_nostru.id_job_angajat AND Employee.TeamID = angajatul_nostru.id_echipa_angajat;

            RETURN nr_colegi;
        END afisare_nr_colegi_angajat;

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
                    DBMS_OUTPUT.PUT_LINE(j || '. ' || angajat.EmployeeName || ' este ' || vector_functii_angajati(angajat.EmployeeID) || ', castiga ' || get_salariu(angajat.EmployeeID) || ' si are ' || afisare_nr_colegi_angajat(angajat.EmployeeID) || ' colegi din acelasi departament.');
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
