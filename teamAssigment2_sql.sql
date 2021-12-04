CREATE DATABASE BEN_SEAN_THANY_ASSIG2_DB;
GO

ALTER DATABASE myDB SET RECOVERY FULL;
GO

USE BEN_SEAN_THANY_ASSIG2_DB;
GO
-----------------------------------
-- CANNOT CHANGE THE DATABSE NAME--
-----------------------------------
--ALTER DATABASE BEN_SEAN_THANY_ASSIG2_DB SET OFFLINE;
--GO
--ALTER DATABASE BEN_SEAN_THANY_ASSIG2_DB SET ONLINE;
--GO


-- DROP ALL TABLES
DROP TABLE IF EXISTS 
	HOUSEKEEPING_REPORT,
	AVAILABLE_PARKING_SPACE,
	ROOM_BOOKING_DETAIL,
	ROOM_STATUS,
	CHECKING_STATUS,
	CHARGEBACK,
	ITEM,	
	CAR_PARK_TYPE,
	BOOKING,
	PAYMENT,
	BOOKING_TYPE,
	PAYMENT_TYPE,	
	AGENT,
	GUEST,
	GROUP_TYPE,
	ROOM,
	ROOM_TYPE,
	HOUSEKEEPING_STATUS,
	APP_USER,
	USER_ROLE
;
GO

-- CAP 1
CREATE TABLE PAYMENT_TYPE(
	PaymentTypeID INT PRIMARY KEY IDENTITY(1,1),
	PaymentType VARCHAR(50) NOT NULL
);
GO
INSERT INTO PAYMENT_TYPE 
VALUES
	('CASH'),
	('EFTPOS'),
	('VOUCHER'),
	('CREDIT CARD'),
	('DEBIT CARD')
;
GO

-- CAP 2
CREATE TABLE ROOM_STATUS(
	RoomStatusID INT PRIMARY KEY IDENTITY(1,1),
	RoomStatus VARCHAR(50)
);
GO
INSERT INTO ROOM_STATUS
VALUES
	('VACANT'),
	('BOOKED'),
	('OCCUPIED')	
;
GO

-- CAP3
CREATE TABLE BOOKING_TYPE(
	BookingTypeID INT PRIMARY KEY IDENTITY(1, 1),
	BookingType VARCHAR(50) NOT NULL
);
GO
INSERT INTO BOOKING_TYPE
VALUES
	('ONLINE'),
	('AT THE DESK'),
	('AGENT')
;
GO

-- CAP 4
CREATE TABLE ROOM_TYPE(
	RoomTypeID INT PRIMARY KEY IDENTITY(1,1),
	RoomType VARCHAR(50) NOT NULL
);
GO
INSERT INTO ROOM_TYPE
VALUES
	('SINGLE'),
	('2 SINGLES'),
	('DOUBLE'),
	('2 BEDROOMS'),
	('2 BUNK BEDS'),
	('SUPERIOR')
;
GO

-- CAP 5
CREATE TABLE HOUSEKEEPING_STATUS(
	KeepingStatusID INT PRIMARY KEY IDENTITY(1,1),
	KeepingStatus VARCHAR(25) NOT NULL
);
GO
INSERT INTO HOUSEKEEPING_STATUS
VALUES
	('VACANT CLEAN'),
	('VACANT DIRTY'),
	('OCCUPIED CLEAN'),
	('OCCUPIED SERVICE'),
	('MAINTENANCE')
;
GO

-- CAP 6
CREATE TABLE USER_ROLE(
	RoleID INT PRIMARY KEY IDENTITY(1,1),
	RoleName VARCHAR(50)
);
GO
INSERT INTO USER_ROLE
VALUES
	('MANAGER'),
	('RECEPTIONIST'),
	('HOUSE KEEPER'),
	('CHARGE BACK CLIENT')
;
GO

-- CAP 7
CREATE TABLE APP_USER(
	UserID INT PRIMARY KEY IDENTITY(1,1),
	RoleID INT NOT NULL FOREIGN KEY REFERENCES USER_ROLE(RoleID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	UserName VARCHAR(50) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	UserPassword VARCHAR(50) NOT NULL,
	ContactNumber VARCHAR(50) NOT NULL
);
GO
INSERT INTO APP_USER
VALUES
	(1, 'Ben', 'ben@pelocanhotel.com' , 'ben123', '028-444-5555'),
	(2, 'Sean', 'sean@pelocanhotel.com', 'sean123', '028-555-4444'),
	(3, 'Thany', 'thany@pelocanhotel.com', 'thany123', '028-666-9999'),
	(4, 'David', 'david@pelocanhotel.com', 'david123', '028-333-8888')
;
GO

-- CAP 8
CREATE TABLE ROOM(
	RoomNumber VARCHAR(25) PRIMARY KEY,	
	RoomImage NVARCHAR(550) NOT NULL,
	RoomPrice MONEY NOT NULL,	
	RoomTypeID INT NOT NULL FOREIGN KEY REFERENCES ROOM_TYPE(RoomTypeID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	RoomCapacity INT NOT NULL,
	RoomDescription VARCHAR(500) NOT NULL,
	HouseKeepingStatusID INT NOT NULL FOREIGN KEY REFERENCES HOUSEKEEPING_STATUS(KeepingStatusID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	WhoCleanedIT INT NOT NULL,
	CleanedDate DATE NOT NULL,
	IsActive BIT DEFAULT 1 NOT NULL
);
GO
INSERT INTO ROOM
VALUES
	('A1-01', 'null', 14.88, 1, 1, 'For a person who does not want to be with anyone else.', 1, 3, '2021-10-12', 1),
	('A1-02', 'null', 14.88, 1, 1, 'For a person who does not want to be with anyone else.', 1, 3, '2021-10-12', 1),
	('A1-03', 'null', 14.88, 1, 1, 'For a person who does not want to be with anyone else.', 1, 3, '2021-10-12', 1),
	('A1-04', 'null', 14.88, 1, 1, 'For a person who does not want to be with anyone else.', 1, 3, '2021-10-12', 1),
	('A1-05', 'null', 14.88, 1, 1, 'For a person who does not want to be with anyone else.', 2, 3, '2021-10-12', 1),
	('A1-06', 'null', 14.88, 1, 1, 'For a person who does not want to be with anyone else.', 2, 3, '2021-10-12', 1),
	('B1-01', 'null', 29.96, 2, 2, 'For two people who do not want to touch each other.', 1, 3, '2021-10-12', 1),
	('B1-02', 'null', 29.96, 2, 2, 'For two people who do not want to touch each other.', 1, 3, '2021-10-12', 1),
	('B1-03', 'null', 29.96, 2, 2, 'For two people who do not want to touch each other.', 1, 3, '2021-10-12', 1),
	('B1-04', 'null', 29.96, 2, 2, 'For two people who do not want to touch each other.', 2, 3, '2021-10-12', 1),
	('B1-05', 'null', 29.96, 2, 2, 'For two people who do not want to touch each other.', 2, 3, '2021-10-12', 1),
	('B1-06', 'null', 29.96, 2, 2, 'For two people who do not want to touch each other.', 1, 3, '2021-10-12', 1),
	('C1-01', 'null', 32.00, 3, 2, 'For two people who love to hug each other when they are sleeping :D.', 1, 3, '2021-10-12', 1),
	('C1-02', 'null', 32.00, 3, 2, 'For two people who love to hug each other when they are sleeping :D.', 1, 3, '2021-10-12', 1),
	('C1-03', 'null', 32.00, 3, 2, 'For two people who love to hug each other when they are sleeping :D.', 1, 3, '2021-10-12', 1),
	('C1-04', 'null', 32.00, 3, 2, 'For two people who love to hug each other when they are sleeping :D.', 1, 3, '2021-10-12', 1),
	('C1-05', 'null', 64.00, 4, 4, 'For two people who love to hug each other when they are sleeping :D.', 2, 3, '2021-10-12', 1),
	('C1-06', 'null', 64.00, 4, 4, 'For two people who love to hug each other when they are sleeping :D.', 2, 3, '2021-10-12', 1),
	('C1-07', 'null', 64.00, 4, 4, 'For two people who love to hug each other when they are sleeping :D.', 1, 3, '2021-10-12', 1),
	('C1-08', 'null', 64.00, 4, 4, 'For two people who love to hug each other when they are sleeping :D.', 1, 3, '2021-10-12', 1),
	('D1-01', 'null', 64.00, 5, 4, 'For a tour group, team or a family of 4.', 1, 3, '2021-10-12', 1),
	('D1-02', 'null', 64.00, 5, 4, 'For a tour group, team or a family of 4.', 1, 3, '2021-10-12', 1),
	('D1-03', 'null', 64.00, 5, 4, 'For a tour group, team or a family of 4.', 1, 3, '2021-10-12', 1),
	('D1-04', 'null', 64.00, 5, 4, 'For a tour group, team or a family of 4.', 1, 3, '2021-10-12', 1),
	('D1-05', 'null', 64.00, 5, 4, 'For a tour group, team or a family of 4.', 2, 3, '2021-10-12', 1),
	('D1-06', 'null', 64.00, 5, 4, 'For a tour group, team or a family of 4.', 2, 3, '2021-10-12', 1),
	('D1-07', 'null', 64.00, 5, 4, 'For a tour group, team or a family of 4.', 1, 3, '2021-10-12', 1),
	('D1-08', 'null', 64.00, 5, 4, 'For a tour group, team or a family of 4.', 1, 3, '2021-10-12', 1),
	('E1-01', 'null', 96.00, 6, 2, 'For 2 people who want plenty of space to play.', 1, 3, '2021-10-12', 1),
	('E1-02', 'null', 96.00, 6, 2, 'For 2 people who want plenty of space to play.', 2, 3, '2021-10-12', 1),
	('E1-03', 'null', 96.00, 6, 2, 'For 2 people who want plenty of space to play.', 1, 3, '2021-10-12', 1),
	('E1-04', 'null', 96.00, 6, 2, 'For 2 people who want plenty of space to play.', 1, 3, '2021-10-12', 1)
;
GO

-- CAP 9
CREATE TABLE GROUP_TYPE(
	GroupTypeID INT PRIMARY KEY IDENTITY(1, 1),
	GroupTypeName VARCHAR(50) NOT NULL
);
GO
INSERT INTO GROUP_TYPE
VALUES
	('COMPANY'),
	('TRAVEL AGENCY'),
	('SPORT TEAM'),
	('FAMILY & FRIENDS')
;
GO

-- CAP 10
CREATE TABLE GUEST(
	GuestDrivingID VARCHAR(50) PRIMARY KEY,
	GuestName VARCHAR(50) NOT NULL,	
	GuestAddress VARCHAR(500),
	VehiclePlate VARCHAR(12),
	PlaceTheyAreFrom VARCHAR(50), 
	GroupTypeID INT FOREIGN KEY REFERENCES GROUP_TYPE(GroupTypeID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	NameOfCompanyOrTravelAgency VARCHAR(50),
	GuestCreditCard VARCHAR(19),
	CreditCardHolder VARCHAR(50),
	CreditCardCCV VARCHAR(3),
	IsCreditCardValid BIT DEFAULT 0
);
GO

INSERT INTO GUEST
	VALUES
		('DL000123', 'Thany, Rigby', '123 Conon Street, Appleby', 'NAA622', 'Invercargill', 4, 'N/A', '1234567788', 'THANY RIGBY', '111', 1), 
		('DL000124', 'Rigby, Thany', '321 Nonoc Street, Ybelppa', '622NAA', 'Lligracrevni', 4, 'N/A', '8899911234', 'RIGBY THANY', '111', 1)
;
GO

-- CAP 11
CREATE TABLE AGENT(
	AgentID INT PRIMARY KEY IDENTITY(1, 1),
	AgentName VARCHAR(50) NOT NULL
);
GO
INSERT INTO AGENT
VALUES
	('BOOKING.COM'),
	('TRIVAGO'),
	('TRIP ADVISOR'),
	('PANDA EXPRESS'),
	('EXPLOR')
;
GO

-- CAP 12
CREATE TABLE PAYMENT(
	PaymentID INT NOT NULL IDENTITY(1,1),
	GuestID VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES GUEST(GuestDrivingID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	PaymentTypeID INT NOT NULL FOREIGN KEY REFERENCES PAYMENT_TYPE(PaymentTypeID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	PaymentAmount MONEY NOT NULL,
	PaymentDate DATE NOT NULL,
	IsPaid BIT NOT NULL DEFAULT 0,
	PRIMARY KEY (PaymentID, GuestID)
);
GO

INSERT INTO PAYMENT
	VALUES
		('DL000123', 2, 0.0, '2021-10-15', 0),
		('DL000124', 1, 0.0, '2021-10-15', 0)
;
GO

-- CAP 13
CREATE TABLE BOOKING(
	BookingID INT PRIMARY KEY IDENTITY(1,1),
	PaymentID INT NOT NULL,
	GuestID VARCHAR(50) NOT NULL, 
	AssignedRoomNum VARCHAR(25) NOT NULL FOREIGN KEY REFERENCES ROOM(RoomNumber)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	NumberOfGuests INT NOT NULL,
	TotalStayPrice MONEY NOT NULL,
	TotalChargeBack MONEY NOT NULL,		
	LeavingComments VARCHAR(250),
	NumberOfCarParks INT DEFAULT 0,
	IsAccessibleCarPark BIT DEFAULT 0,
	AgentID INT FOREIGN KEY REFERENCES AGENT(AgentID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	BookingTypeID INT FOREIGN KEY REFERENCES BOOKING_TYPE(BookingTypeID)
	ON DELETE CASCADE
	ON UPDATE CASCADE, 
	IsCancelled BIT DEFAULT 0,
	CONSTRAINT FK_Guest_Booking FOREIGN KEY(PaymentID, GuestID) 
	REFERENCES PAYMENT(PaymentID, GuestID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
GO

INSERT INTO BOOKING
	VALUES
	(1, 'DL000123', 'A1-01', 1, 150.25, 0.0, 'No Comment', 0, 0, 1, 1, 0),
	(2, 'DL000124', 'C1-05', 2,  300.75, 0.0, 'No Comment', 1, 0, 4, 1, 0)
;
GO

-- CAP 14
CREATE TABLE CAR_PARK_TYPE(
	CarParkTypeID INT PRIMARY KEY IDENTITY(1,1),
	CarParkType VARCHAR(35) NOT NULL,
);
GO
INSERT INTO CAR_PARK_TYPE
VALUES
	('ACCESSIBLE'),
	('REGULAR')
;
GO

-- CAP 15
CREATE TABLE ITEM(
	ItemID INT PRIMARY KEY IDENTITY(1,1),
	ItemName VARCHAR(50) NOT NULL,
	ItemPrice MONEY NOT NULL
);
GO

INSERT INTO ITEM
VALUES
	('BEER', 9.00),
	('SODA', 3.50),
	('BURGER', 14.50),
	('STEAK', 29.00),
	('SALAD', 0.50)
;
GO

-- CAP 16
CREATE TABLE CHARGEBACK(
	ChargeBackID INT IDENTITY(1,1),
	RoomNumber VARCHAR(5) NOT NULL,	
	PaymentID INT NOT NULL,
	GuestID VARCHAR(50) NOT NULL, 	
	ItemID INT NOT NULL FOREIGN KEY REFERENCES ITEM(ItemID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	ItemQuantity INT,
	DateOfPurchased DATE NOT NULL,
	CONSTRAINT PK_Guest_CB FOREIGN KEY(PaymentID, GuestID) 
	REFERENCES PAYMENT(PaymentID, GuestID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
GO

-- CAP 17 
CREATE TABLE CHECKING_STATUS(
	CheckingID INT PRIMARY KEY IDENTITY(1, 1),
	CheckingStatus VARCHAR(55) NOT NULL
);
GO

INSERT INTO CHECKING_STATUS
	VALUES
		('PENDING'),
		('HAS CHECKED IN'),
		('HAS CHECKED OUT')
;
GO

-- CAP 18
CREATE TABLE ROOM_BOOKING_DETAIL(
	RBD_ID INT PRIMARY KEY IDENTITY(1, 1),
	RoomNumber VARCHAR(25) NOT NULL FOREIGN KEY REFERENCES ROOM(RoomNumber)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	RoomStatusID INT NOT NULL FOREIGN KEY REFERENCES ROOM_STATUS(RoomStatusID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	PaymentID INT NOT NULL,
	GuestID VARCHAR(50) NOT NULL,
	CheckInDate DATE NOT NULL,
	CheckOutDate DATE NOT NULL,	
	CheckingIN_OUT_status INT NOT NULL FOREIGN KEY REFERENCES CHECKING_STATUS(CheckingID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Guest_Booking_Details FOREIGN KEY(PaymentID, GuestID) 
	REFERENCES PAYMENT(PaymentID, GuestID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
GO

INSERT INTO ROOM_BOOKING_DETAIL
	VALUES
		('A1-01', 2, 1, 'DL000123', '2021-10-13', '2021-10-15', 1),
		('C1-05', 2, 2, 'DL000124', '2021-10-13', '2021-10-15', 1)
;
GO

-- CAP 19
CREATE TABLE AVAILABLE_PARKING_SPACE(
	ParkingSpaceID INT PRIMARY KEY IDENTITY(1, 1),
	ParkingSpaceTypeID INT NOT NULL FOREIGN KEY REFERENCES CAR_PARK_TYPE(CarParkTypeID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	RBD_ID INT FOREIGN KEY REFERENCES ROOM_BOOKING_DETAIL(RBD_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
GO

INSERT INTO AVAILABLE_PARKING_SPACE
VALUES
	(1, null),
	(1, null),
	(1, null),
	(1, null),
	(1, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null),
	(2, null)
;
GO

-- CAP 20
CREATE TABLE HOUSEKEEPING_REPORT(
	HousekeepingReportID INT PRIMARY KEY IDENTITY(1,1),
	RoomNumber VARCHAR(25) NOT NULL,
	WhoCleanedIT INT NOT NULL,
	CleanedDate DATE NOT NULL
);
GO

INSERT INTO HOUSEKEEPING_REPORT
	VALUES 
		('C1-05', 3, '2021-10-12')
;
GO

-- Execute this command when things are ready
-- Change the save path
BACKUP DATABASE BEN_SEAN_THANY_ASSIG2_DB
TO DISK = 'C:\myDatabase_backup\assig2_full.bak'
WITH INIT;
GO