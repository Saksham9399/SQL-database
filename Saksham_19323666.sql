-- Created by Saksham Agarwal
-- 19323666

DROP database Flight_Reservation;
-- A database for Airlines reservation system
CREATE database Flight_Reservation;
USE Flight_Reservation;

-- Table to store user details
CREATE table User_Details(
Social_Security_Number int(16) NOT NULL UNIQUE, 
username varchar(50) PRIMARY KEY NOT NULL,
first_name varchar(50) NOT NULL,
last_name varchar(50),
dob DATE,
mobile int(12), email varchar(50), address varchar(255)
);

-- Table for airplanes
CREATE table Airplanes(
plane_id varchar(10) PRIMARY KEY NOT NULL,
Max_seats int(3) NOT NULL,
Name_of_Airline varchar(20) NOT NULL
);
-- Table for weekly schedule of flights
CREATE table flight_schedule(
flight_id varchar(10) PRIMARY KEY NOT NULL,
day_of_week int,
arrival varchar(10) NOT NULL,
departure varchar(10) NOT NULL,
Source varchar(5),
Destination varchar(5)
 );
 
-- Mapping table between flight_id and plane_id
 CREATE table flight_map(
flight_id varchar(10) UNIQUE NOT NULL,
plane_id varchar(10) NOT NULL
);

ALTER TABLE flight_map
ADD CONSTRAINT fk_planeid
FOREIGN KEY (plane_id) REFERENCES Airplanes (plane_id); 

ALTER TABLE flight_map
ADD CONSTRAINT fk_flightid
FOREIGN KEY (flight_id) REFERENCES flight_schedule (flight_id);

-- contains past records of tickets of last 90 days of date_of_journey 
CREATE table transactions(
pnr int (6) UNIQUE NOT NULL, 
booking_date TIMESTAMP,
username varchar(50),
flight_id varchar(10),
fare int(10),
no_of_seats_booked int(3),
reservation_status varchar(15) check (reservation_status IN ('CANCELLED','BOOKED')),
date_of_journey DATE NOT NULL
 );
 
-- flight_id should be present in flight_schedule
ALTER TABLE transactions
ADD CONSTRAINT fk_flightid2 FOREIGN KEY (flight_id) REFERENCES flight_schedule(flight_id);

ALTER TABLE transactions
ADD CONSTRAINT fk_uname FOREIGN KEY (username) REFERENCES User_Details(username);

-- list of all the cities
CREATE table cities(
city_code varchar(5) PRIMARY KEY NOT NULL,
city_name varchar(15) NOT NULL
);

-- table to store distance between 2 cities
CREATE table distances (
Source varchar(5) NOT NULL,
Destination varchar(5) NOT NULL,
distance int (7) NOT NULL
);
-- any source code should be from cities table
ALTER TABLE distances
ADD CONSTRAINT fk_source FOREIGN KEY (Source) REFERENCES cities(city_code);

-- any destination code should be from cities table 
ALTER TABLE distances
ADD CONSTRAINT fk_dest FOREIGN KEY (Destination) REFERENCES cities (city_code);

DELIMITER $$

CREATE procedure insert_user(
IN SSN  int(16),
IN un varchar(50),
IN fn varchar(50),
IN ln varchar(50), 
IN db DATE,
IN mob int(15),
IN eml varchar(50),
IN adre varchar(255)
)
BEGIN
	INSERT INTO User_Details values(SSN,un,fn,ln,db,mob,eml,adre);
END $$

-- procedural call to insert values in User_Details
call insert_user('943543123','SakshamAg','Saksham','Agarwal','1999-03-09','0923142746','saagarwa@tcd.ie','Dublin');
call insert_user('821675487','John92','John','Parker','1997-04-03','0843322142','jparker@gmail.com','Paris');
call insert_user('771424862','Sean123','Sean','Porter','1998-12-3','0724565132','sean@gmail.com','London');
call insert_user('891487912','Meadbh_M','Meadbh','Morgan','1993-10-21','0851387621','medbh@gmail.com','Dublin');
call insert_user('788845321','Ravi_k21','Ravi','Kumar','1991-06-24','0965324181','ravikumar@gmail.com','Dublin');

-- Table of all the cities supported by our application
INSERT INTO cities VALUES ('PAR','Paris');
INSERT INTO cities VALUES ('DUB','Dublin');
INSERT INTO cities VALUES ('LHR','London');
INSERT INTO cities VALUES ('AMS','Amsterdam');
INSERT INTO cities VALUES ('ROM','Rome');

-- Distance between all the above cities stored in a table
INSERT INTO distances VALUES('DUB','LHR','577');
INSERT INTO distances VALUES('DUB','PAR','1052');
INSERT INTO distances VALUES('DUB','ROM','2461');
INSERT INTO distances VALUES('DUB','AMS','955');
INSERT INTO distances VALUES('LHR','AMS','574');
INSERT INTO distances VALUES('LHR','ROM','1906');

-- list of airplanes
INSERT INTO Airplanes VALUES('pid001','200','RyanAir');
INSERT INTO Airplanes VALUES('pid002','150','AerLingus');
INSERT INTO Airplanes VALUES('pid003','300','VirginAtlantic');
INSERT INTO Airplanes VALUES('pid004','250','BritishAirways');
INSERT INTO Airplanes VALUES('pid005','300','AirFrance');
INSERT INTO Airplanes VALUES('pid006','250','Vistara');

-- Schedule of Flights in a week between 2 cities
INSERT INTO flight_schedule VALUES('6E-905','1','0900','0810','DUB','LHR');
INSERT INTO flight_schedule VALUES('6E-906','1','1100','1010','LHR','DUB');
INSERT INTO flight_schedule VALUES('6E-907','1','1200','1020','DUB','ROM');
INSERT INTO flight_schedule VALUES('6E-908','1','1600','1340','DUB','PAR');
INSERT INTO flight_schedule VALUES('6E-909','1','1720','1600','DUB','AMS');
INSERT INTO flight_schedule VALUES('6E-910','1','2000','1850','LHR','AMS');
INSERT INTO flight_schedule VALUES('6E-911','2','0900','0810','DUB','LHR');
INSERT INTO flight_schedule VALUES('6E-912','2','1100','1010','LHR','DUB');
INSERT INTO flight_schedule VALUES('6E-913','2','1200','1020','DUB','ROM');
INSERT INTO flight_schedule VALUES('6E-914','2','1600','1340','DUB','PAR');
INSERT INTO flight_schedule VALUES('6E-915','2','1720','1600','DUB','AMS');
INSERT INTO flight_schedule VALUES('6E-916','2','2000','1850','LHR','AMS');
INSERT INTO flight_schedule VALUES('6E-917','3','0900','0810','DUB','LHR');
INSERT INTO flight_schedule VALUES('6E-918','3','1100','1010','LHR','DUB');
INSERT INTO flight_schedule VALUES('6E-919','3','1200','1020','DUB','ROM');
INSERT INTO flight_schedule VALUES('6E-920','3','1600','1340','DUB','PAR');
INSERT INTO flight_schedule VALUES('6E-921','3','1720','1600','DUB','AMS');
INSERT INTO flight_schedule VALUES('6E-922','3','2000','1850','LHR','AMS');
INSERT INTO flight_schedule VALUES('6E-923','4','0900','0810','DUB','LHR');
INSERT INTO flight_schedule VALUES('6E-924','4','1100','1010','LHR','DUB');
INSERT INTO flight_schedule VALUES('6E-925','4','1200','1020','DUB','ROM');
INSERT INTO flight_schedule VALUES('6E-926','4','1600','1340','DUB','PAR');
INSERT INTO flight_schedule VALUES('6E-927','4','1720','1600','DUB','AMS');
INSERT INTO flight_schedule VALUES('6E-928','4','2000','1850','LHR','AMS');
INSERT INTO flight_schedule VALUES('6E-929','5','0900','0810','DUB','LHR');
INSERT INTO flight_schedule VALUES('6E-930','5','1100','1010','LHR','DUB');
INSERT INTO flight_schedule VALUES('6E-931','5','1200','1020','DUB','ROM');
INSERT INTO flight_schedule VALUES('6E-932','5','1600','1340','DUB','PAR');
INSERT INTO flight_schedule VALUES('6E-933','5','1720','1600','DUB','AMS');
INSERT INTO flight_schedule VALUES('6E-934','5','2000','1850','LHR','AMS');
INSERT INTO flight_schedule VALUES('6E-935','6','0900','0810','DUB','LHR');
INSERT INTO flight_schedule VALUES('6E-936','6','1100','1010','LHR','DUB');
INSERT INTO flight_schedule VALUES('6E-937','6','1200','1020','DUB','ROM');
INSERT INTO flight_schedule VALUES('6E-938','6','1600','1340','DUB','PAR');
INSERT INTO flight_schedule VALUES('6E-939','6','1720','1600','DUB','AMS');
INSERT INTO flight_schedule VALUES('6E-940','6','2000','1850','LHR','AMS');
INSERT INTO flight_schedule VALUES('6E-941','7','0900','0810','DUB','LHR');
INSERT INTO flight_schedule VALUES('6E-942','7','1100','1010','LHR','DUB');
INSERT INTO flight_schedule VALUES('6E-943','7','1200','1020','DUB','ROM');
INSERT INTO flight_schedule VALUES('6E-944','7','1600','1340','DUB','PAR');
INSERT INTO flight_schedule VALUES('6E-945','7','1720','1600','DUB','AMS');
INSERT INTO flight_schedule VALUES('6E-946','7','2000','1850','LHR','AMS');

-- In this table we map flight_od with plane_id to link the flight scheduled to fly out out to the destination

INSERT INTO flight_map VALUES('6E-905','pid004');
INSERT INTO flight_map VALUES('6E-906','pid003');
INSERT INTO flight_map VALUES('6E-907','pid001');
INSERT INTO flight_map VALUES('6E-908','pid005');
INSERT INTO flight_map VALUES('6E-909','pid002');
INSERT INTO flight_map VALUES('6E-910','pid006');
INSERT INTO flight_map VALUES('6E-911','pid004');
INSERT INTO flight_map VALUES('6E-912','pid003');
INSERT INTO flight_map VALUES('6E-913','pid001');
INSERT INTO flight_map VALUES('6E-914','pid005');
INSERT INTO flight_map VALUES('6E-915','pid002');
INSERT INTO flight_map VALUES('6E-916','pid006');
INSERT INTO flight_map VALUES('6E-917','pid004');
INSERT INTO flight_map VALUES('6E-918','pid003');
INSERT INTO flight_map VALUES('6E-919','pid001');
INSERT INTO flight_map VALUES('6E-920','pid005');
INSERT INTO flight_map VALUES('6E-921','pid002');
INSERT INTO flight_map VALUES('6E-922','pid006');
INSERT INTO flight_map VALUES('6E-923','pid004');
INSERT INTO flight_map VALUES('6E-924','pid003');
INSERT INTO flight_map VALUES('6E-925','pid001');
INSERT INTO flight_map VALUES('6E-926','pid005');
INSERT INTO flight_map VALUES('6E-927','pid002');
INSERT INTO flight_map VALUES('6E-928','pid006');
INSERT INTO flight_map VALUES('6E-929','pid004');
INSERT INTO flight_map VALUES('6E-930','pid003');
INSERT INTO flight_map VALUES('6E-931','pid001');
INSERT INTO flight_map VALUES('6E-932','pid005');
INSERT INTO flight_map VALUES('6E-933','pid002');
INSERT INTO flight_map VALUES('6E-934','pid006');
INSERT INTO flight_map VALUES('6E-935','pid004');
INSERT INTO flight_map VALUES('6E-936','pid003');
INSERT INTO flight_map VALUES('6E-937','pid001');
INSERT INTO flight_map VALUES('6E-938','pid005');
INSERT INTO flight_map VALUES('6E-939','pid002');
INSERT INTO flight_map VALUES('6E-940','pid006');
INSERT INTO flight_map VALUES('6E-941','pid004');
INSERT INTO flight_map VALUES('6E-942','pid003');
INSERT INTO flight_map VALUES('6E-943','pid001');
INSERT INTO flight_map VALUES('6E-944','pid005');
INSERT INTO flight_map VALUES('6E-945','pid002');
INSERT INTO flight_map VALUES('6E-946','pid006');

-- Table for transactions
INSERT INTO  transactions VALUES('939921','2020-08-03 19:50;42','SakshamAg','6E-905','30','1','BOOKED','2020-12-14');
INSERT INTO  transactions VALUES('942366','2020-09-01 09:32:11','John92','6E-914','18','1','BOOKED','2020-12-21');
INSERT INTO  transactions VALUES('947862','2020-12-03 21:41:07','SakshamAg','6E-918','22','1','BOOKED','2020-12-22');
INSERT INTO  transactions VALUES('911111','2020-07-01 12:18:32','SakshamAg','6E-939','20','1','BOOKED','2020-08-01');

-- this trigger deletes all the entries from transactions table, whose date of journey was 90 days before current date 
DELIMITER $$
CREATE TRIGGER delete_transactions AFTER INSERT ON transactions FOR EACH ROW
BEGIN
DELETE from transactions where date_of_journey < (select sysdate-90 from dual);
END $$

-- View to display user details

CREATE VIEW usr_details AS
SELECT
	t.booking_date,
    u.username,
    t.flight_id,
    t.reservation_status,
    u.mobile
FROM
	User_Details AS u
INNER JOIN
	transactions AS t
ON u.username = t.username;