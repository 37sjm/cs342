DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Status_Enum;
DROP TABLE Performer;

-- Create database schema
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL, 
	year decimal(4), 
	score float,
	votes integer,
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);

CREATE TABLE Performer (
	id integer,
	name varchar(35),
	PRIMARY KEY (id)
	);

CREATE TABLE Status_Enum (
	status varchar(6),
	PRIMARY KEY (status)
	);
	
CREATE TABLE Casting (
	movieId integer,
	performerId integer,
	status varchar(6),
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	FOREIGN KEY (status) REFERENCES Status_Enum(status) ON DELETE SET NULL
	);

-- Load sample data
INSERT INTO Movie VALUES (1,'Star Wars',1977,8.9, 2000);
INSERT INTO Movie VALUES (2,'Blade Runner',1982,8.6, 1500);

INSERT INTO Performer VALUES (1,'Harrison Ford');
INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Status_Enum values ('star');
INSERT INTO Status_Enum values ('costar');
INSERT INTO Status_Enum values ('extra');

INSERT INTO Casting VALUES (1,1, 'star');
INSERT INTO Casting VALUES (1,3, 'extra');
INSERT INTO Casting VALUES (2,1, 'star');
INSERT INTO Casting VALUES (2,2, 'costar');
INSERT INTO Casting VALUES (2,4, 'costar');


--What I did: created a Status_Enum table, and then, using 'insert', I created all the possible values in the Status_Enum table.
--Advantages of this: you don't have to use 'check' (although using check isn't necesarily a bad thing).
--Disadvantages: This is more complicated, and you need to use an extra join in order to correctly find the string.
--Another disadvantage would be that there's nothing stopping the user from just entering more 'valid' strings to map to.