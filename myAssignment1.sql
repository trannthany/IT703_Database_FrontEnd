USE Thany_Assignment_1;
GO
-- Cap1
 DROP TABLE IF EXISTS 
	ORDER_TABLE,
	ORDER_DETAIL,
	FINISH_PRODUCT, 
	ASSEMBLY_DETAIL,
	ASSEMBLER, 
	INCOMING_SHIPMENT,
	PART,
	SUPPLIER, 
	CUSTOMER;
 GO
-- Cap2 
CREATE TABLE CUSTOMER(
	CusID INT PRIMARY KEY,
	FirstName VARCHAR(25) NOT NULL,
	Lastname VARCHAR(25),
	Phone VARCHAR(15) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	CusAddress VARCHAR(65)
);
GO
-- Cap3
CREATE TABLE ASSEMBLER(
	EmpNum INT PRIMARY KEY,
	FirstName VARCHAR(25) NOT NULL,
	LastName VARCHAR(25),
	Phone VARCHAR(15),
	Eamil VARCHAR(50)
);
GO
-- Cap4
CREATE TABLE SUPPLIER(
	SupID INT PRIMARY KEY,
	SupName VARCHAR(25) NOT NULL,
	SupPhone VARCHAR(25),
	SupAddress VARCHAR(65),
	SupEmail VARCHAR(35)
);
GO
-- Cap5
CREATE TABLE PART(
	PartID INT PRIMARY KEY,
	PartName VARCHAR(65) NOT NULL,
	SupID INT NOT NULL FOREIGN KEY REFERENCES SUPPLIER(SupID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	PartLocation VARCHAR(65),
	Available_Unit INT NOT NULL DEFAULT 0,
	Mini_Unit INT,
	Mini_Ordering_Unit INT	
);
GO
-- Cap6
CREATE TABLE INCOMING_SHIPMENT(
	InShipID INT PRIMARY KEY,	
	PartID INT NOT NULL FOREIGN KEY REFERENCES PART(PartID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,	
	Ordered_Date DATE NOT NULL,
	Expected_Arrival_Date DATE NOT NULL,
	Quantity INT NOT NULL DEFAULT 0
);
GO
-- Cap7
CREATE TABLE ASSEMBLY_DETAIL(
	AssID INT PRIMARY KEY,
	EmpNum INT NOT NULL FOREIGN KEY REFERENCES ASSEMBLER(EmpNum)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	ProName VARCHAR(25) NOT NULL,
	ProDetails VARCHAR(65),
	ProPrice MONEY NOT NULL DEFAULT 0,
	ProLocation VARCHAR(65),
	Part_1 INT,
	Part_2 INT,
	Part_3 INT,
	Part_4 INT,
	Part_5 INT,
	Part_6 INT,
	Part_7 INT,
	Part_8 INT,
	Part_9 INT,
	Part_10 INT,
	Part_11 INT,
	Part_12 INT
);
GO
-- Cap8
CREATE TABLE FINISH_PRODUCT(
	ProID INT IDENTITY(1,1) PRIMARY KEY,	
	AssID INT NOT NULL FOREIGN KEY REFERENCES ASSEMBLY_DETAIL(AssID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	Is_Sold BIT
);
GO
-- Cap 9
CREATE TABLE ORDER_DETAIL(
	OdID INT IDENTITY(1,1) PRIMARY KEY,
	PricePerUnit MONEY NOT NULL DEFAULT 0,
	Quantity INT NOT NULL DEFAULT 1,
	TotalPrice MONEY NOT NULL DEFAULT 0,
	ProID INT NOT NULL FOREIGN KEY REFERENCES FINISH_PRODUCT(ProID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
GO
-- Cap 10
CREATE TABLE ORDER_TABLE(
	OrderID INT IDENTITY(1,1) PRIMARY KEY,
	CusID INT NOT NULL FOREIGN KEY REFERENCES CUSTOMER(CusID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	OrderDate DATE NOT NULL,
	Details VARCHAR(160),
	OdID INT NOT NULL FOREIGN KEY REFERENCES ORDER_DETAIL(OdID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
GO
-- Cap 11
INSERT INTO CUSTOMER 
VALUES
(100100, 'Lisa', 'Petite Woman', '021-126-4291', 'lisa@gmail.com', '69 Some Where, Over The Rainbow, Invercargill'),
(100101, 'Nadia', 'Smart Woman', '021-126-4292', 'Naya@gmail.com', '69 Some Where, In Dreamland, Queentown'),
(100102, 'Chandra', 'Bubbly Woman', '021-126-4293', 'chandra@gmail.com', '69 Some Where, In Imagination, Invercargill'),
(100103, 'Mulan', 'Brave Woman', '021-126-4294', 'mulan@gmail.com', '69 Some Where, In The Sky, Christchurch'),
(100104, 'Carrot', 'Kind Woman', '021-126-4295', 'carrot@gmail.com', '69 Some Where, In The Moon, Auckland')
;
GO
-- Cap13
INSERT INTO SUPPLIER
VALUES 
(200200, 'DELL', '027-555-9999', '678 Conon Street, Appleby, Invercargill', 'dellnz@gmail.co.nz'),
(200201, 'Think Vision','027-888-6666', '876 Conon Street, Appleby, Invercargill', 'thinkvisionnz@gmail.co.nz'),
(200202, 'Lenovo', '027-777-2222', '768 Conon Street, Appleby, Invercargill', 'lenovonz@gmail.co.nz')
;
GO
-- Cap12
INSERT INTO SUPPLIER 
VALUES(200203, 'Asus', '027-444-3333', '687 Conon Street, Appleby, Invercargill', 'asusnz@gmail.co.nz');
GO
INSERT INTO ASSEMBLER
VALUES
(300300, 'John', 'Doe', '09-777-ext-1', 'john@gmail.com'),
(300301, 'Ben', 'Bear', '09-777-ext-2', 'ben@gmail.com')
;
GO
-- Cap14
INSERT INTO PART
VALUES
(400400, 'Hard Drive', 200200, 'Ailse-1', 10, 5, 15 ),
(400401, 'RAM', 200200, 'Ailse-1', 40, 10, 20),
(400402, 'Mother Board', 200203, 'Ailse-2', 60, 10, 15),
(400403, 'Power Supply', 200200, 'Ailse-3', 60, 10, 15),
(400409, 'CPU', 200203, 'Ailse-1', 60, 10, 15),
(400404, 'Grapic Card', 200203, 'Ailse-1', 12, 5, 10),
(400405, 'Mouse', 200200, 'Ailse-3', 60, 10, 15),
(400406, 'Key Board', 200200, 'Ailse-3', 60, 10, 15),
(400407, 'Case', 200200, 'Ailse-3', 60, 10, 15),
(400408, 'Monitor', 200200,'Ailse-3', 60, 10, 15)
;
GO
-- Cap15
INSERT INTO INCOMING_SHIPMENT
VALUES
(500500, 400400, GETDATE(), GETDATE()+14, 30),
(500501, 400401, GETDATE(), GETDATE()+14, 100)
;
GO
-- Cap16
INSERT INTO ASSEMBLY_DETAIL
VALUES
(600600, 300300, 'Dell Computer 11', 'Blah blah 11', 1200.00, 'Ailse-4',
	400408, 400407, 400406, 400405, 400404,400409, 400403, 400402, 400401, 400401, 400400, NULL),
(600601, 300301, 'Dell Computer 12', 'Blah blah 12', 1200.00, 'Ailse-4',
	400408, 400407, 400406, 400405, 400404,400409, 400403, 400402, 400401, 400401, 400400, NULL),
(600602, 300300, 'Dell Computer 13', 'Blah blah 13', 1200.00, 'Ailse-4',
	400408, 400407, 400406, 400405, 400404,400409, 400403, 400402, 400401, 400401, 400400, NULL),
(600603, 300301, 'Dell Computer 14', 'Blah blah 14', 1200.00, 'Ailse-4',
	400408, 400407, 400406, 400405, 400404,400409, 400403, 400402, 400401, 400401, 400400, NULL)
;
GO
-- Cap17
INSERT INTO FINISH_PRODUCT
VALUES
(600600, 1),
(600601, 1),
(600602, 0),
(600603, 0)
;
GO
-- Cap18
INSERT INTO ORDER_DETAIL
VALUES 
(1200, 1, 1200, 1),
(1200, 1, 1200, 2)
;
GO
-- Cap19
INSERT INTO ORDER_TABLE
VALUES
(100100, '6-09-2021', 'Blah Blah', 1),
(100101, '6-6-2021', 'Blah Blah 2', 2)
;
GO


-- Store procedures and triggers
-- Cap20
DROP PROCEDURE IF EXISTS PRC_ADD_CUSTOMER;
GO
CREATe PROCEDURE PRC_ADD_CUSTOMER
	@cust_id INT,
	@fname VARCHAR(25),
	@lname VARCHAR(25),
	@phone VARCHAR(15),
	@email VARCHAR(50),
	@cust_addr VARCHAR(65)
AS
BEGIN
	INSERT INTO CUSTOMER
	VALUES(@cust_id, @fname, @lname, @phone, @email, @cust_addr)
END;
GO
-- 21
EXEC PRC_ADD_CUSTOMER 
@cust_id=100105, @fname='Yunita', @lname='Fun to Talk to Woman', 
@phone='123-456-789', @email='yunita@gmail.com', 
@cust_addr='89 Haha Street, Endless Jokes, Invercargill';
GO
-- 22
CREATe PROCEDURE PRC_ADD_SUPPLIER
	@sup_id INT,
	@sup_name VARCHAR(25),
	@sup_phone VARCHAR(25),
	@sup_addr VARCHAR(65),
	@sup_email VARCHAR(35)	
AS
BEGIN
	INSERT INTO SUPPLIER
	VALUES(@sup_id, @sup_name, @sup_phone, @sup_addr, @sup_email)
END;
GO
-- 23
EXEC PRC_ADD_SUPPLIER
@sup_id=200204, @sup_name='Apple NZ', @sup_phone='123-456-7890', 
@sup_addr='3333 Apple Street, Invercargill', @sup_email='applenz@apple.com'
;
GO
-- 24
CREATE PROCEDURE PRC_ADD_ASSEBLER
	@emp_num VARCHAR(25),
	@fname VARCHAR(25),
	@lname VARCHAR(25),
	@phone VARCHAR(15),
	@email VARCHAR(50)
AS
BEGIN
	INSERT INTO ASSEMBLER
	VALUES(@emp_num, @fname, @lname, @phone, @email)
END;
GO
-- 25
EXEC PRC_ADD_ASSEBLER
@emp_num=300302, @fname='Guy', @lname='New',
@phone='123-456-7890', @email='guynew1@gmail.com'
;
GO

DROP PROCEDURE IF EXISTS PRC_ASSEMBLE_PRODUCT;
GO
-- 26
CREATE PROCEDURE PRC_ASSEMBLE_PRODUCT
	@assem_id INT,	@emp_num INT,
	@prod_name VARCHAR(25), @prod_detail VARCHAR(65),
	@prod_price MONEY, @prod_location VARCHAR(65),
	@part_1 INT, @part_2 INT, @part_3 INT,
	@part_4 INT, @part_5 INT, @part_6 INT,
	@part_7 INT, @part_8 INT, @part_9 INT,
	@part_10 INT, @part_11 INT, @part_12 INT
AS
BEGIN
	DECLARE 
	@temp_avail_1 INT = 1, @temp_avail_2 INT  = 1, @temp_avail_3 INT  = 1,
	@temp_avail_4 INT  = 1, @temp_avail_5 INT  = 1, @temp_avail_6 INT  = 1,
	@temp_avail_7 INT  = 1, @temp_avail_8 INT  = 1, @temp_avail_9 INT  = 1,
	@temp_avail_10 INT  = 1, @temp_avail_11 INT  = 1, @temp_avail_12 INT  = 1

	SELECT @temp_avail_1 = Available_Unit FROM PART WHERE PartID=@part_1	
	IF(0 = @temp_avail_1 )
		PRINT 'THERE IS NO' + @part_1 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_1 = 1
	
	SELECT @temp_avail_2 = Available_Unit FROM PART WHERE PartID=@part_2	
	IF(0 = @temp_avail_2 )
		PRINT 'THERE IS NO' + @part_2 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_2 = 1

	SELECT @temp_avail_3 = Available_Unit FROM PART WHERE PartID=@part_3
	IF(0 = @temp_avail_3 )
		PRINT 'THERE IS NO' + @part_3 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_3 = 1

	SELECT @temp_avail_4 = Available_Unit FROM PART WHERE PartID=@part_4	
	IF(0 = @temp_avail_4 )
		PRINT 'THERE IS NO' + @part_4 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_4 = 1
	
	SELECT @temp_avail_5 = Available_Unit FROM PART WHERE PartID=@part_5	
	IF(0 = @temp_avail_5 )
		PRINT 'THERE IS NO' + @part_5 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_5 = 1
	
	SELECT @temp_avail_6 = Available_Unit FROM PART WHERE PartID=@part_6	
	IF(0 = @temp_avail_6 )
		PRINT 'THERE IS NO' + @part_6 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_6 = 1
	
	SELECT @temp_avail_7 = Available_Unit FROM PART WHERE PartID=@part_7	
	IF(0 = @temp_avail_7 )
		PRINT 'THERE IS NO' + @part_7 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_7 = 1
	
	SELECT @temp_avail_8 = Available_Unit FROM PART WHERE PartID=@part_8	
	IF(0 = @temp_avail_8 )
		PRINT 'THERE IS NO' + @part_8 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_8 = 1
	
	SELECT @temp_avail_9 = Available_Unit FROM PART WHERE PartID=@part_9	
	IF(0 = @temp_avail_9 )
		PRINT 'THERE IS NO' + @part_9 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_9 = 1
	
	SELECT @temp_avail_10 = Available_Unit FROM PART WHERE PartID=@part_10	
	IF(0 = @temp_avail_10 )
		PRINT 'THERE IS NO' + @part_10 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_10 = 1
	
	SELECT @temp_avail_11 = Available_Unit FROM PART WHERE PartID=@part_11	
	IF(0 = @temp_avail_11 )
		PRINT 'THERE IS NO' + @part_11 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_11 = 1
	
	SELECT @temp_avail_12 = Available_Unit FROM PART WHERE PartID=@part_12	
	IF(0 = @temp_avail_12 )
		PRINT 'THERE IS NO' + @part_12 + 'PART AVAILABLE'
	ELSE
		SET @temp_avail_12 = 1

	IF(@temp_avail_1 > 0 AND @temp_avail_2 > 0 AND  @temp_avail_3 > 0 AND  
		@temp_avail_4 > 0 AND @temp_avail_5 > 0 AND @temp_avail_6 > 0 AND
		@temp_avail_7 > 0 AND @temp_avail_8 > 0 AND @temp_avail_9 > 0 AND
		@temp_avail_10 > 0 AND @temp_avail_11 > 0 AND @temp_avail_12 > 0)
		INSERT INTO ASSEMBLY_DETAIL
		VALUES 
		(@assem_id, @emp_num, 
		@prod_name, @prod_detail, @prod_price, @prod_location,
		@part_1, @part_2, @part_3, @part_4, @part_5, @part_6,
		@part_7, @part_8, @part_9, @part_10, @part_11, @part_12)
	ELSE
		PRINT 'THERE ARE PARTS WHICH ARE NOT AVAILABLE'
END;
GO

DROP TRIGGER IF EXISTS TRG_DECREMENT_PART;
GO
-- 27
CREATE TRIGGER TRG_DECREMENT_PART
ON ASSEMBLY_DETAIL
FOR INSERT
AS
DECLARE
	@temp1 INT, @temp2 INT, @temp3 INT,
	@temp4 INT, @temp5 INT, @temp6 INT,
	@temp7 INT, @temp8 INT, @temp9 INT,
	@temp10 INT, @temp11 INT, @temp12 INT
BEGIN
	SELECT @temp1 = Part_1, @temp2 = Part_2, @temp3 = Part_3,
			@temp4 = Part_4, @temp5 = Part_5, @temp6 = Part_6,
			@temp7 = Part_7, @temp8 = Part_8, @temp9 = Part_9,
			@temp10 = Part_10, @temp11 = Part_11, @temp12 = Part_12
	FROM inserted
	UPDATE PART
	SET Available_Unit = Available_Unit - 1
	WHERE PartID 
	IN (@temp1, @temp2, @temp3, @temp4,
		@temp5, @temp6, @temp7, @temp8,
		@temp9, @temp10, @temp11, @temp12)
END;
GO

DROP TRIGGER IF EXISTS TRG_ADD_FINISH_PRODUCT;
GO
-- 28 
CREATE TRIGGER TRG_ADD_FINISH_PRODUCT
ON ASSEMBLY_DETAIL
FOR INSERT
AS
DECLARE
	@temp_assem_id INT
BEGIN
	SELECT @temp_assem_id = AssID FROM inserted
	INSERT INTO FINISH_PRODUCT
	VALUES(@temp_assem_id, 0)
END;
GO
-- 29
EXEC PRC_ASSEMBLE_PRODUCT
	@assem_id = 600604, @emp_num = 300302,
	@prod_name = 'Dell Computer 15', @prod_detail = 'Blah blah 15', @prod_price = 1200.00, @prod_location = 'Ailse-4',
	@part_1 = 400408, @part_2 = 400407, @part_3 = 400406, @part_4 = 400405, @part_5 = 400404, @part_6 = 400409, 
	@part_7 = 400403, @part_8 = 400402, @part_9 = 400401, @part_10 = 400401, @part_11 = 400400, @part_12 = NULL
;
GO

DROP PROCEDURE IF EXISTS PRC_CUST_MAKE_ORDER;
GO
-- 30
CREATE PROCEDURE PRC_CUST_MAKE_ORDER
	@cust_id INT, 
	@prod_id INT, 	
	@detail VARCHAR(160)
AS
BEGIN
	DECLARE 
		@temp_price MONEY,
		@temp_od_id INT

	SELECT @temp_price = ProPrice FROM ASSEMBLY_DETAIL
	WHERE AssID = (
		SELECT AssID FROM FINISH_PRODUCT
		WHERE ProID = @prod_id
	)

	INSERT INTO ORDER_DETAIL
	VALUES (@temp_price, 1, @temp_price, @prod_id)

	SELECT @temp_od_id = ODID FROM ORDER_DETAIL
	WHERE ProID = @prod_id

	INSERT INTO ORDER_TABLE
	VALUES(@cust_id, GETDATE(), @detail, @temp_od_id)
	
END;
GO

DROP TRIGGER IF EXISTS TRG_UPDATE_FINISH_PRODUCT;
GO
-- 31
CREATE TRIGGER TRG_UPDATE_FINISH_PRODUCT
ON ORDER_DETAIL
FOR INSERT
AS
BEGIN
	UPDATE FINISH_PRODUCT
	SET Is_Sold = 1
	WHERE ProID = (
			SELECT ProID FROM inserted
		)
END;
GO

EXEC PRC_CUST_MAKE_ORDER
	@cust_id = 100104, 
	@prod_id = 4, 	
	@detail = 'Blah blah make order number 1'
;
GO

DROP PROCEDURE IF EXISTS PRC_ISSUE_PART_ORDER;
GO
-- 32
ALTER PROCEDURE PRC_ISSUE_PART_ORDER
	@incoming_shipment_id INT,
	@ordered_part_id INT,
	@quantity INT
AS
BEGIN
	INSERT INTO INCOMING_SHIPMENT
	VALUES(@incoming_shipment_id, @ordered_part_id, GETDATE(), GETDATE() +14, @quantity)
END;
GO

EXEC PRC_ISSUE_PART_ORDER
	@incoming_shipment_id=500502, @ordered_part_id=400400, @quantity=24
;
GO

EXEC PRC_ISSUE_PART_ORDER
	@incoming_shipment_id=500503, @ordered_part_id=400404, @quantity=20
;
GO








