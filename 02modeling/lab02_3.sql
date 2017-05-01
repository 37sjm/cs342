DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;
DROP SEQUENCE movie_sequence;

-- Create database schema
create sequence movie_sequence
start with 1
increment by 1;

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
	
CREATE TABLE Casting (
	movieId integer,
	performerId integer,
	status varchar(6),
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	CHECK (status in ('star', 'costar', 'extra'))
	);

-- Load sample data
INSERT INTO Movie VALUES (movie_sequence.nextval, 'Star Wars',1977,8.9, 2000);
INSERT INTO Movie VALUES (movie_sequence.nextval, 'Blade Runner',1982,8.6, 1500);

INSERT INTO Performer VALUES (1,'Harrison Ford');
INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Casting VALUES (1,1, 'star');
INSERT INTO Casting VALUES (1,3, 'extra');
INSERT INTO Casting VALUES (2,1, 'star');
INSERT INTO Casting VALUES (2,2, 'costar');
INSERT INTO Casting VALUES (2,4, 'costar');

--2.4.a
--No, because if you are inserting multiple performers into the performer table that are from the same movie,
--you cannot use a sequence because then it will increment when you do not want it to. Instead, you must either
--know the id of the movie that you'd like to add a performer for, or else use a select statement with the title to
--find it.

--2.4.b
--Yes, my main problem is that I was unable to find a way to remove the ID from the insert statement, in order to only allow values
--of the sequence to be used for id's. So while the sequence is there and SHOULD be used in order to create new movies, there is currently
--no way of mandating this (although I did find documentation for doing this in a later release of Oracle that we do not have in the labs).