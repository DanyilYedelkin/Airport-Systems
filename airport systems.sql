drop table if exists ticket;
drop table if exists contain;
drop table if exists serves;
drop table if exists passenger;
drop table if exists flight;
drop table if exists airline;
drop table if exists employee;
drop table if exists airport;
drop table if exists city;


create table city
(
    cityname varchar(15) not null
        primary key,
    country  varchar(30) not null,
    state    varchar(15)
);


create table airport
(
    airportname varchar(100) not null
        primary key,
    country     varchar(30)  not null,
    state       varchar(15),
    cityname    varchar(15)
        references city
            on delete cascade
);


create table airline
(
    airlineid      varchar(3) not null
        primary key,
    airlinename    varchar(50),
    threedigitcode varchar(3)
);


create table flight
(
    flightcode  varchar(10) not null
        primary key,
    destination varchar(3),
    source      varchar(3),
    arrival     varchar(10),
    departure   varchar(10),
    status      varchar(10),
    duration    varchar(30),
    flighttype  varchar(10),
    airlineid   varchar(3)
        references airline
            on delete cascade
);


create table passenger
(
    pid            integer     not null,
    passportnumber varchar(10) not null,
    firstname      varchar(20) not null,
    lastname       varchar(20) not null,
    sex            varchar(1),
    age            integer
        constraint passenger_age_check
            check (age > 0),
    address        varchar(100),
    phone          integer,
    airplanecode   varchar(10)
        references flight
            on delete cascade,
    primary key (passportnumber, pid)
);


create table ticket
(
    ticketnumber     integer     not null
        primary key,
    source           varchar(3)  not null,
    destination      varchar(3)  not null,
    class            varchar(15) not null,
    seatnumber       varchar(5)  not null,
    datetravel       date        not null,
    numberairplane   varchar(10) not null,
    price            integer,
    datebooking      date,
    datecancellation date,
    surcharge        integer,
    passportnumber   varchar(10),
    pid              integer,
    foreign key (passportnumber, pid) references passenger
        on delete cascade
);


create table employee
(
    ssn         integer     not null
        primary key,
    firstname   varchar(20) not null,
    lastname    varchar(20) not null,
    jobtype     varchar(30) not null,
    sex         varchar(1),
    age         integer
        constraint employee_age_check
            check (age > 0),
    address     varchar(100),
    phone       integer,
    salary      integer,
    airportname varchar(100)
        references airport
            on delete cascade
);


create table contain
(
    airportname varchar(100) not null
        references airport
            on delete cascade,
    airlineid   varchar(3)   not null
        references airline
            on delete cascade,
    primary key (airportname, airlineid)
);


create table serves
(
    ssn            integer     not null
        references employee
            on delete cascade,
    pid            integer     not null,
    passportnumber varchar(10) not null,
    primary key (ssn, pid, passportnumber),
    foreign key (passportnumber, pid) references passenger
        on delete cascade
);