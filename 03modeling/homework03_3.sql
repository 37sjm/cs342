drop table Order_Part;
drop table Order_Info;
drop table Part;
drop table Customer;
drop table Employee;

create table Employee (
	id integer primary key,
	first_name varchar(25),
	last_name varchar(25),
	zip integer,
	check (zip <= 99999 and zip >= 0)
	--check that zips are five digits and not negative
	);
	
create table Customer (
	id integer primary key,
	first_name varchar(25),
	last_name varchar(25),
	zip integer,
	check (zip <= 99999 and zip >= 0)
	--check that zips are five digits and not negative
	);
	
create table Part (
	id integer primary key,
	part_name varchar(25),
	price float not null,
	quantity_in_stock integer not null,
	check (quantity_in_stock >= 0)
	);
	
create table Order_Info (
	id integer primary key,
	customer_id integer,
	employee_id integer,
	order_date date,
	expected_ship_date date,
	actual_ship_date date,
	foreign key (customer_id) references customer(id) on delete cascade,
	foreign key (employee_id) references employee(id) on delete set null
	);
	
create table Order_Part (
	order_id integer,
	part_id integer,
	quantity_ordered integer,
	primary key (order_id, part_id),
	foreign key (order_id) references Order_Info(id) on delete set null,
	foreign key (part_id) references Part(id) on delete set null
	);
	
insert into employee values (1, 'Jane', 'Doe', 12345);
insert into employee values (2, 'John', 'Doe', 23456);

insert into customer values (1, 'Mitch', 'Stark', 34567);
insert into customer values (2, 'Cam', 'Richman', 45678);

insert into part values (1, 'keyboard', 20.00, 100);
insert into part values (2, 'mouse', 23.00, 12);

insert into order_info values (1, 1, 1, '20-Jan-2017', '21-Jan-2017', null);
insert into order_info values (2, 1, 2, '12-Jan-2017', '18-Jan-2017', '18-Jan-2017');
insert into order_info values (3, 2, 1, null, null, null);

insert into order_part values (1, 2, 2);
insert into order_part values (1, 1, 1);
insert into order_part values (2, 2, 2);