truncate table contain, ticket, serves, passenger, flight, airline, employee, airport, city;
drop view if exists dddddd;
drop view if exists all_ns_customers;
drop view if exists ns_customers_de;
drop view if exists all_information_p30;
drop view if exists view_massive_1;
drop view if exists view_airport_city;
drop view if exists view_inf_flight;
drop view if exists view_inf_pfs;
drop view if exists view_count;
drop view if exists view_max_min_sum;
drop view if exists show_all_name_surnames;
drop view if exists employee_salary_view;
drop view if exists passenger_age_view;

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
    state    varchar(15) not null
);

--Insering values for Table: city--
insert into city (cityname, country, state)
values ('Louisville', 'United States', 'Kentucky'),
       ('Chandigarh', 'India', 'Chandigarh'),
       ('Fort Worth', 'United States', 'Texas'),
       ('Delhi', 'India', 'Delhi'),
       ('Mumbai', 'India', 'Maharashtra'),
       ('San Francisco', 'United States', 'California'),
       ('Frankfurt','Germany', 'Hesse'),
       ('Houston','United States', 'Texas'),
       ('New York City','United States', 'New York'),
       ('Tampa', 'United States', 'Florida');


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

--Insering values for Table: airport--
insert into airport (airportname, country, state, cityname)
values ('Louisville International Airport','United States', 'Kentucky','Louisville'),
       ('Chandigarh International Airport', 'India', 'Chandigarh','Chandigarh'),
       ('Dallas/Fort Worth International Airport', 'United States', 'Texas','Fort Worth'),
       ('Indira GandhiInternational Airport', 'India', 'Delhi','Delhi'),
       ('Chhatrapati Shivaji International Airport','India', 'Maharashtra','Mumbai'),
       ('San Francisco International Airport', 'United States', 'California','San Francisco'),
       ('Frankfurt Airport', 'Germany', 'Hesse','Frankfurt'),
       ('George Bush Intercontinental Airport', 'United States', 'Texas','Houston'),
       ('John F. Kennedy International Airport', 'United States', 'New York','New York City'),
       ('Tampa International Airport', 'United States', 'Florida','Tampa');



create table airline
(
    airlineid      varchar(3) not null
        primary key,
    airlinename    varchar(50),
    threedigitcode varchar(3)
);

-- Insering values for Table: airline --
insert into airline (airlineid, airlinename, threedigitcode)
values ('AA','American Airlines','001'),
       ('AI','Air India Limited','098'),
       ('LH','Lufthansa', '220'),
       ('BA','British Airways','125'),
       ('QR','Qatar Airways','157'),
       ('9W','Jet Airways','589'),
       ('EK','Emirates','176'),
       ('EY','Ethiad Airways','607');


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
    fairlineid   varchar(3)
        references airline
            on delete cascade
);

-- Insering values for Table: flight --
insert into flight(flightcode, source, destination, arrival, departure, status, duration, flighttype, fairlineid)
values ('AI2014','BOM','DFW','02:10','03:15','On-time','24hr','Connecting', 'AI'),
       ('QR2305','BOM','DFW','13:00','13:55','Delayed','21hr','Non-stop', 'QR'),
       ('EY1234','JFK','TPA','19:20','20:05','On-time','16hrs','Connecting', 'EY'),
       ('LH9876','JFK','BOM','05:50','06:35','On-time','18hrs','Non-stop', 'LH'),
       ('BA1689','FRA','DEL','10:20','10:55','On-time','14hrs','Non-stop', 'BA'),
       ('AA4367','SFO','FRA','18:10','18:55','On-time','21hrs','Non-stop', 'AA'),
       ('QR1902','IXC','IAH','22:00','22:50','Delayed','28hrs','Non-stop', 'QR'),
       ('BA3056','BOM','DFW','02:15','02:55','On-time','29hrs','Connecting', 'BA'),
       ('EK3456','BOM','SFO','18:50','19:40','On-time','30hrs','Non-stop', 'EK'),
       ('9W2334','IAH','DEL','23:00','13:45','On-time','23hrs','Direct', '9W');


create table passenger
(
    pid            integer     not null,
    ppassportnumber varchar(10) not null,
    firstname      varchar(20) not null,
    lastname       varchar(20) not null,
    sex            varchar(1),
    age            integer
        constraint passenger_age_check
            check (age > 0),
    address        varchar(100),
    phone          bigint,
    airplanecode   varchar(10)
        references flight
            on delete cascade,
    primary key (ppassportnumber, pid)
);

--iNSERTING VALUES IN TABLE: Passenger--
insert into passenger(pid, ppassportnumber, firstname, lastname, sex, age, address, phone, airplanecode)
values (1,'A1234568','Daniel','Edelman', 'M', 29, '2230 NORTHSIDE, APT 11, ALBANY, NY', 8080367290, 'AI2014'),
       (2,'E3277889','Artur','Pringe', 'M', 43, '7820 MCCALLUM COURTS, APT 234, AKRON, OH',9004568903, 'EY1234'),
       (3,'S1243269','Kevin','Frair', 'M', 35, '9082 ESTAES OF RICHARDSON, RICHARDSON, TX',9004335126, 'AA4367'),
       (4,'K3212322','Erik','Migen', 'M', 21, '5589 CHTHAM REFLECTIONS, APT 349 HOUSTON, TX',9734567800, 'EK3456'),
       (5,'P3452390','John','Fridrich', 'M', 19, '4444 FRANKFORD VILLA, APT 77, GUILDERLAND, NY',4624569986, 'LH9876'),
       (6,'W7543336','Natali','Dolgeban', 'W', 38, '548 MARKET PLACE, SAN Francisco, CA',4724512343, 'QR1902'),
       (7,'J9801235','Violeta','Senfaur', 'W', 44, '1234 BAKER APTS, APT 59, HESSE, GERMANY',8082267280, 'QR1902'),
       (8,'R8990566','Yukina','Saori', 'W', 28, '2230 NORTHSIDE, APT 11, ALBANY, NY', 8080367283, 'AI2014');


create table ticket
(
    ticketnumber     bigint      not null
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

--INSERTING INTO TABLE: Ticket--
insert into ticket(ticketnumber, source, destination, datebooking, datecancellation, datetravel, seatnumber, class, pid, passportnumber, price, numberairplane, surcharge)
values (0011234111122,'BOM','DFW','11-MAY-16', NULL,'15-DEC-16','32A','ECONOMY',1,'A1234568', 80,'AI2014', DEFAULT),
       (0984567222299,'JFK','BOM','11-JUN-16','10-DEC-16','20-DEC-16','45D','ECONOMY',2,'E3277889', 70,'EY1234', 70),
       (1768901333273,'IAH','DEL','21-AUG-16',NULL,'25-DEC-16','1A','BUSINESS',3,'S1243269', 260,'AA4367', DEFAULT),
       (5890987441464,'IXC','IAH','10-AUG-16',NULL,'12-JAN-17','20C','FIRST-CLASS',4,'K3212322', 300,'EK3456', DEFAULT),
       (1577654664266,'JFK','TPA','13-JUN-16',NULL,'10-DEC-16','54E','ECONOMY',5,'P3452390', 75,'LH9876', DEFAULT),
       (2206543545545,'BOM','DFW','11-NOV-16',NULL,'12-FEB-17','43B','ECONOMY',6,'W7543336', 90,'QR1902', DEFAULT),
       (7064321779737,'IAH','DEL','15-NOV-16',NULL,'25-DEC-16','27B','FIRST-CLASS',7,'J9801235', 280,'QR1902', DEFAULT),
       (1571357215116,'SFO','FRA','15-OCT-16',NULL,'18-DEC-16','34E','ECONOMY',8,'R8990566', 43,'AI2014', DEFAULT);


create table employee
(
    ssn         bigint      not null
        primary key,
    firstname   varchar(20) not null,
    lastname    varchar(20) not null,
    jobtype     varchar(30) not null,
    position    varchar(30) not null,
    sex         varchar(1),
    age         integer
        constraint employee_age_check
            check (age > 0),
    address     varchar(100),
    phone       bigint,
    salary      integer,
    airportname varchar(100)
        references airport
            on delete cascade
);

-- Insering values for Table: employee --
insert into employee(ssn, firstname, salary, lastname, address, phone, age, sex, jobtype, position, airportname)
values (123456789,'LINDA', 1500,'GOODMAN','731 Fondren, Houston, TX',4356789345, 35, 'F','ADMINISTRATIVE SUPPORT','RECEPTIONIST', 'Louisville International Airport'),
       (333445555,'JOHNY', 4000,'PAUL','638 Voss, Houston, TX',9834561995, 40, 'M','PILOT','FIRST PILOT','Louisville International Airport'),
       (999887777,'JAMES', 1700,'BOND','3321 Castle, Spring, TX',9834666995, 50, 'M','ENGINEER','RADIO ENGINEER','Louisville International Airport'),
       (987654321,'SHERLOCK', 1800,'HOLMES','123 TOP HILL, SAN Francisco,CA',8089654321, 47, 'M','TRAFFIC MONITOR','DAY', 'San Francisco International Airport'),
       (666884444,'SHELDON', 1900,'COOPER','345 CHERRY PARK, HESSE,GERMANY',1254678903, 55, 'M','TRAFFIC MONITOR','NIGHT','Frankfurt Airport'),
       (453453453,'RAJ', 2000,'SHARMA','345 FLOYDS, MUMBAI,INDIA',4326789031, 35, 'M','AIRPORT AUTHORITY','MANAGER','Chhatrapati Shivaji International Airport'),
       (987987987,'NIKITA', 2100,'PAUL','110 SYNERGY PARK, DALLAS,TX',5678904325, 33, 'F','ENGINEER','AIRPORT CIVIL ENGINEER','Dallas/Fort Worth International Airport'),
       (888665555,'SHUBHAM', 2200,'GUPTA','567 CHANDANI CHOWK, DELHI, INDIA',8566778890, 39, 'M','ADMINISTRATIVE SUPPORT','DATA ENTRY WORKER','Indira GandhiInternational Airport'),
       (125478909,'PRATIK', 2300,'GOMES','334 VITRUVIAN PARK, ALBANY, NY',4444678903, 56, 'M','TRAFFIC MONITOR', 'DAY','John F. Kennedy International Airport'),
       (324567897,'ADIT', 2400,'DESAI','987 SOMNATH, CHANDIGARH, INDIA',2244658909, 35, 'M','TRAFFIC MONITOR','DAY', 'Chandigarh International Airport');


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

-- Insering values into Table: Contain --
insert into contain (airlineid, airportname)
values  ('AA','Louisville International Airport'),
        ('AA','John F. Kennedy International Airport'),
        ('AA','George Bush Intercontinental Airport'),
        ('AA','San Francisco International Airport'),
        ('AA','Tampa International Airport'),

        ('AI','Chandigarh International Airport'),
        ('AI','Dallas/Fort Worth International Airport'),
        ('AI','Indira GandhiInternational Airport'),
        ('AI','Chhatrapati Shivaji International Airport'),
        ('AI','George Bush Intercontinental Airport'),

        ('LH','Chhatrapati Shivaji International Airport'),
        ('LH','Frankfurt Airport'),
        ('LH','John F. Kennedy International Airport'),
        ('LH','San Francisco International Airport'),
        ('LH','Dallas/Fort Worth International Airport'),

        ('BA','John F. Kennedy International Airport'),
        ('BA','Chhatrapati Shivaji International Airport'),
        ('BA','Chandigarh International Airport'),
        ('BA','Frankfurt Airport'),
        ('BA','San Francisco International Airport'),

        ('QR','Chhatrapati Shivaji International Airport'),
        ('QR','Dallas/Fort Worth International Airport'),
        ('QR','John F. Kennedy International Airport'),
        ('QR','Tampa International Airport'),
        ('QR','Louisville International Airport');


create table serves
(
    ssn            bigint      not null
        references employee
            on delete cascade,
    pid            integer     not null,
    passportnumber varchar(10) not null,
    primary key (ssn, pid, passportnumber),
    foreign key (passportnumber, pid) references passenger
        on delete cascade
);

-- INSERTING VALUES INTO TABLE: SERVES--
insert into serves(ssn, pid, passportnumber)
values (123456789,1,'A1234568'),
       (123456789,2,'E3277889'),
       (123456789,3,'S1243269'),
       (888665555,4,'K3212322'),
       (888665555,5,'P3452390'),
       (333445555,6,'W7543336'),
       (333445555,7,'J9801235'),
       (888665555,8,'R8990566');


-- 1
--all names and surnames from customer table
create view all_ns_customers as
select FirstName, LastName from Passenger;
--names and surnames from customer table where names equals Daniel and Erik
create view ns_customers_de as
select FirstName, LastName from Passenger where FirstName IN ('Daniel', 'Erik') ;
--select passenger who has >30 years old
create view all_information_p30 as
select * from Passenger where Age > 30;
--take information about AirlineName, FlightCode, passenger's name, surname and passportNumber, ticket's class, date of travel
--destination, etc. where some parameters are equals
create view view_massive_1 as
select al.AirlineName, fl.FlightCode, p1.FirstName, p1.LastName, p1.ppassportnumber, t.Class, t.DateTravel,
       t.Destination, t.Source, t.SeatNumber, t.TicketNumber from Airline al, Flight fl, Passenger p1, Ticket t
where al.AirlineID = fl.fairlineid
and t.PassportNumber = p1.ppassportnumber
and t.Class = 'ECONOMY' and t.Destination = 'DFW';


--2
--Information about airport and city
create view view_airport_city as
select AirportName, c.CityName, c.Country, c.State from Airport
    full join City c on Airport.CityName = c.CityName;

--Information about flight, passenger and airline
create view view_inf_flight as
select FlightCode, alr.AirlineID, Flight.fairlineid, p.AirplaneCode from Flight
    full join Passenger p on Flight.FlightCode = p.AirplaneCode
    full join Airline alr on Flight.fairlineid = alr.AirlineID;

--Information about passenger, flight and his seat (from the ticket)
create view view_inf_pfs as
select FirstName, LastName, Passenger.ppassportnumber, t.PassportNumber, SeatNumber, Class, DateTravel, FlightCode from Passenger
    full outer join Ticket t on Passenger.ppassportnumber = t.PassportNumber and Passenger.PID = t.PID
    full outer join Flight fl on Passenger.AirplaneCode = fl.FlightCode;


--3
--Counting how employees
create view view_count as
select count(SSN), SSN from Employee group by SSN;

--Calculating the difference between employee's salary and how much the company gain them money (salary)
create view view_max_min_sum as
select max(Salary) - min(Salary), sum(Salary) from Employee;


-- gives random surcharge (function generating random win surcharge)
DO $$
    DECLARE
        win_pid INT := random() * 10 + 1;
    BEGIN
        FOR counter IN 1..100 LOOP
            UPDATE Ticket
            SET Surcharge = random() * Price + 0
            WHERE PID = win_pid AND Price < counter AND Surcharge = 0;
        END LOOP;
    END;
$$;


-- gives random class (function generating
DO $$
    DECLARE
        win_pid INT := random() * 10 + 1;
        win_class VARCHAR(15);
        randomizer INT := random() * 3 + 1;
    BEGIN
        IF randomizer = 1 THEN
            win_class = 'BUSINESS';
        END IF;
        IF randomizer = 2 THEN
            win_class = 'FIRST-CLASS';
        ELSE
            win_class = 'ECONOMY';
        END IF;


        FOR counter IN 250..310 LOOP
            UPDATE Ticket
            SET Class = win_class
            WHERE PID = win_pid AND Price < counter AND Class != win_class;
        END LOOP;
    END;
$$;


create or replace view show_all_name_surnames as
select firstname, lastname, age from passenger
union
select firstname, lastname, age from employee
order by lastname ASC;

create or replace view passenger_age_view as
select * from passenger
where age > (select age from passenger where passenger.age = 37);

create or replace view employee_salary_view as
select * from employee
where salary > (select salary from employee where employee.salary = 3700);


-- Trigger, which checks passenger's id
create or replace function check_passenger_id()
returns trigger as
$$
    declare
        id int;
    begin
        select max(pid) from passenger into id;
        if id is not null then
            id = id+1;
        else
            id = 1;
        end if;

        NEW.pid = id;
        return NEW;
    end;
$$ language plpgsql;

create trigger check_passenger_id_tg
     before insert on passenger
     for row execute function check_passenger_id();

--insert into passenger(pid, ppassportnumber, firstname, lastname, sex, age, address, phone, airplanecode)
--values (9,'A9934568','Dan','Eman', 'M', 19, '2230 NORTHSIDE, APT 12, ALBANY, NY', 5580367290, 'AI2014'),
--       (9,'A2211568','Dantre','Emanuele', 'M', 20, '2230 NORTHSIDE, APT 13, ALBANY, NY', 1111367290, 'AI2014');

drop trigger check_passenger_id_tg on passenger;


-- Trigger which checks the information about employee's age
create or replace function check_employees_age()
returns trigger as $$
begin
    if(age < 18 and age >= 16) then
        raise exception 'The employee is young for this position';
    elseif(age <= 15) then
        raise exception  'The employee is very young for this job';
    end if;
end;
$$ language plpgsql;

create constraint trigger check_employees_age_tg
    after insert on employee
    for EACH row execute procedure check_employees_age();

--insert into employee(ssn, firstname, salary, lastname, address, phone, age, sex, jobtype, position, airportname)
--values (123456411,'Erik', 1600,'Munchen','771 Serhiot, Houston, TX',4386789345, 13, 'M','ADMINISTRATIVE SUPPORT','RECEPTIONIST', 'Louisville International Airport');
drop trigger check_employees_age_tg on employee;


-- Trigger which checks the information about employee's age
create or replace function update_salary()
returns trigger as $$
declare
    new_salary int;
begin
    new_salary = new.salary;

    --new_salary = new_salary + new_salary*.2;

    if (new.jobtype = 'ADMINISTRATIVE SUPPORT') then
        new_salary = new_salary + new_salary*.2;
    elseif (new.jobtype = 'ENGINEER') then
        new_salary = new_salary + new_salary*.4;
    elseif (new.jobtype = 'TRAFFIC MONITOR') then
        new_salary = new_salary + new_salary*.3;
    end if;

    set NEW.salary = new_salary;
    return NEW;
end;
$$ language plpgsql;

create trigger update_salary_tg
    after insert on employee
    for each row execute function update_salary();

drop trigger if exists update_salary_tg on employee;



create or replace procedure change_salary (percent int, direction varchar(10)) as
$$
    begin
        if (direction = 'increase') then
            update employee set salary = salary + percent*salary/100;
        elseif (direction = 'decrease') then
            update employee set salary = salary - percent*salary/100;
        end if;
    end;
$$ language plpgsql;

call change_salary(6, 'increase');
call change_salary(7, 'decrease');

drop procedure change_salary(percent int, direction varchar(10));


drop function if exists get_passengers_from_airplane(airplane_code varchar);

create or replace function get_passengers_from_airplane (airplane_code varchar)
returns table(
                first_name varchar,
                last_name varchar,
                passport_number varchar,
                class varchar
             ) as
$$
    begin
        return query
        select firstname, lastname, ppassportnumber, t.class from passenger
        join ticket t on passenger.ppassportnumber = t.passportnumber and passenger.pid = t.pid
        where airplanecode in (airplane_code)
        order by passportnumber desc;
    end;
$$ language plpgsql;

select get_passengers_from_airplane('AI2014');
select get_passengers_from_airplane('AA4367');
