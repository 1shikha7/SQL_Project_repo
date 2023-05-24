USE MusicStore
CREATE TABLE employee (
    employee_id INT,
    last_name VARCHAR(8),
    first_name VARCHAR(8),
    title VARCHAR(22),
    reports_to INT,
    levels VARCHAR(2),
    birthdate DATETIME,
    hire_date DATETIME,
    address VARCHAR(27),
    city VARCHAR(10),
    state VARCHAR(2),
    country VARCHAR(6),
    postal_code VARCHAR(7),
    phone VARCHAR(17),
    fax VARCHAR(17),
    email VARCHAR(27)
);
INSERT INTO employee VALUES (1,'Adams','Andrew','General Manager',9,'L6','1962-02-18 00:00:00','2016-08-14 00:00:00','11120 Jasper Ave NW','Edmonton','AB','Canada','T5K 2N1','+1 (780) 428-9482','+1 (780) 428-3457','andrew@chinookcorp.com'),
	(2,'Edwards','Nancy','Sales Manager',1,'L4','1958-12-08 00:00:00','2016-05-01 00:00:00','825 8 Ave SW','Calgary','AB','Canada','T2P 2T3','+1 (403) 262-3443','+1 (403) 262-3322','nancy@chinookcorp.com'),
	(3,'Peacock','Jane','Sales Support Agent',2,'L1','1973-08-29 00:00:00','2017-04-01 00:00:00','1111 6 Ave SW','Calgary','AB','Canada','T2P 5M5','+1 (403) 262-3443','+1 (403) 262-6712','jane@chinookcorp.com'),
	(4,'Park','Margaret','Sales Support Agent',2,'L1','1947-09-19 00:00:00','2017-05-03 00:00:00','683 10 Street SW','Calgary','AB','Canada','T2P 5G3','+1 (403) 263-4423','+1 (403) 263-4289','margaret@chinookcorp.com'),
	(5,'Johnson','Steve','Sales Support Agent',2,'L1','1965-03-03 00:00:00','2017-10-17 00:00:00','7727B 41 Ave','Calgary','AB','Canada','T3B 1Y7','1 (780) 836-9987','1 (780) 836-9543','steve@chinookcorp.com'),
	(6,'Mitchell','Michael','IT Manager',1,'L3','1973-07-01 00:00:00','2016-10-17 00:00:00','5827 Bowness Road NW','Calgary','AB','Canada','T3B 0C5','+1 (403) 246-9887','+1 (403) 246-9899','michael@chinookcorp.com'),
	(7,'King','Robert','IT Staff',6,'L2','1970-05-29 00:00:00','2017-01-02 00:00:00','590 Columbia Boulevard West','Lethbridge','AB','Canada','T1K 5N8','+1 (403) 456-9986','+1 (403) 456-8485','robert@chinookcorp.com'),
	(8,'Callahan','Laura','IT Staff',6,'L2','1968-01-09 00:00:00','2017-03-04 00:00:00','923 7 ST NW','Lethbridge','AB','Canada','T1H 1Y8','+1 (403) 467-3351','+1 (403) 467-8772','laura@chinookcorp.com'),
	(9,'Madan','Mohan','Senior General Manager',NULL,'L7','1961-01-26 00:00:00','2016-01-14 00:00:00','1008 Vrinda Ave MT','Edmonton','AB','Canada','T5K 2N1','+1 (780) 428-9482','+1 (780) 428-3457','madan.mohan@chinookcorp.com');
