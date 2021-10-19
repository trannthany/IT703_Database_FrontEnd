USE BEN_SEAN_THANY_ASSIG2_DB;
GO

-- STORE PROCEDUREs AND TRIGGERS
-- CAP 19
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_SUM_TOTAL_STAY_PRICE_BETWEEN_2_DAYS;
GO
CREATE PROCEDURE SP_SUM_TOTAL_STAY_PRICE_BETWEEN_2_DAYS
	@input_date_1 DATE,
	@input_date_2 DATE
AS
BEGIN
	SELECT 
		SUM(b.TotalStayPrice) 'SUM OF ALL TOTAL STAY PRICES'
	FROM ROOM_BOOKING_DETAIL rbd, BOOKING b, GUEST g 
	WHERE rbd.BookingID = b.BookingID
	AND g.GuestDrivingID IN (
		SELECT p.GuestID FROM PAYMENT p
		WHERE b.PaymentID = p.PaymentID
	)
	AND (rbd.CheckInDate >= @input_date_1 OR rbd.CheckInDate <= @input_date_2)
END;
GO
EXEC SP_SUM_TOTAL_STAY_PRICE_BETWEEN_2_DAYS @input_date_1 ='2021-10-11', @input_date_2 = '2021-10-17';
GO

-- CAP 18
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_BOOKING_FORCASTS_BETWEEN_2_DAYS;
GO
CREATE PROCEDURE SP_BOOKING_FORCASTS_BETWEEN_2_DAYS
	@input_date_1 DATE,
	@input_date_2 DATE
AS
BEGIN
	SELECT 
		g.GuestName 'GUEST NAME',
		rbd.RoomNumber 'ROOM NUMBER', 
		rbd.CheckInDate 'CHECK IN DATE', 
		rbd.CheckOutDate 'CHECK OUT DATE', 
		b.TotalStayPrice 'TOTAL STAY PRICE' 
	FROM ROOM_BOOKING_DETAIL rbd, BOOKING b, GUEST g 
	WHERE rbd.BookingID = b.BookingID
	AND g.GuestDrivingID IN (
		SELECT p.GuestID FROM PAYMENT p
		WHERE b.PaymentID = p.PaymentID
	)
	AND (rbd.CheckInDate >= @input_date_1 OR rbd.CheckInDate <= @input_date_2)
END;
GO
EXEC SP_BOOKING_FORCASTS_BETWEEN_2_DAYS @input_date_1 ='2021-10-11', @input_date_2 = '2021-10-17'; 
GO

-- CAP 17
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_SUM_TOTAL_STAY_PRICE_FOR_A_SPECIFIC_DAY;
GO
CREATE PROCEDURE SP_SUM_TOTAL_STAY_PRICE_FOR_A_SPECIFIC_DAY
	@input_date DATE
AS
BEGIN
	SELECT 
		SUM(b.TotalStayPrice) 'SUM OF ALL TOTAL STAY PRICES'
	FROM ROOM_BOOKING_DETAIL rbd, BOOKING b, GUEST g 
	WHERE rbd.BookingID = b.BookingID
	AND g.GuestDrivingID IN (
		SELECT p.GuestID FROM PAYMENT p
		WHERE b.PaymentID = p.PaymentID
	)
	AND rbd.CheckInDate = @input_date
END;
GO
EXEC SP_SUM_TOTAL_STAY_PRICE_FOR_A_SPECIFIC_DAY @input_date = '2021-10-13';
GO

-- CAP 16
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_BOOKING_FORCASTS_FOR_A_SPECIFIC_DAY;
GO
CREATE PROCEDURE SP_BOOKING_FORCASTS_FOR_A_SPECIFIC_DAY
	@input_date DATE
AS
BEGIN
	SELECT 
		g.GuestName 'GUEST NAME',
		rbd.RoomNumber 'ROOM NUMBER', 
		rbd.CheckInDate 'CHECK IN DATE', 
		rbd.CheckOutDate 'CHECK OUT DATE', 
		b.TotalStayPrice 'TOTAL STAY PRICE' 
	FROM ROOM_BOOKING_DETAIL rbd, BOOKING b, GUEST g 
	WHERE rbd.BookingID = b.BookingID
	AND g.GuestDrivingID IN (
		SELECT p.GuestID FROM PAYMENT p
		WHERE b.PaymentID = p.PaymentID
	)
	AND rbd.CheckInDate = @input_date
END;
GO
EXEC SP_BOOKING_FORCASTS_FOR_A_SPECIFIC_DAY @input_date = '2021-10-13';
GO


-- CAP 15
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_END_OF_DAY_REPORT;
GO
CREATE PROCEDURE SP_END_OF_DAY_REPORT
	@today_date DATE
AS
BEGIN
	SELECT
		g.GuestName 'GUEST NAME', 
		b.AssignedRoomNum 'ROOM NUMBER',
		CONVERT(VARCHAR, rbd.CheckInDate, 103) 'CHECK IN',
		CONVERT(VARCHAR, rbd.CheckOutDate, 103) 'CHECK OUT',
		rbd.ParkingSpaceID 'PARKING SPACE',
		p.PaymentAmount 'PAYMENT UP TO DATE',
		p.IsPaid 'IS PAID?',
		p.PaymentTypeID 'PAYMENT TYPE'
	FROM
		GUEST g,
		BOOKING b,
		ROOM_BOOKING_DETAIL rbd,
		PAYMENT p
	WHERE
		rbd.BookingID = b.BookingID
	AND
		g.GuestDrivingID IN (
			SELECT p.GuestID FROM PAYMENT p
			WHERE b.PaymentID = p.PaymentID
		)
	AND
		p.GuestID = g.GuestDrivingID
	AND 
		rbd.CheckInDate <= @today_date
	AND 
		rbd.CheckOutDate > @today_date
END;
GO
EXEC SP_END_OF_DAY_REPORT @today_date = '2021-10-14';
GO
-- Test 
-- '2021-10-12' & '2021-10-15', there shouldn't be any result.
-- '2021-10-13' & '2021-10-14', there should be results.

-- CAP 14
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_CHECK_OUT_GUEST_WITH_BOOKING_ID;
GO
CREATE PROCEDURE SP_CHECK_OUT_GUEST_WITH_BOOKING_ID
	@booking_id INT
AS
BEGIN
	UPDATE ROOM_BOOKING_DETAIL
	SET CheckingIN_OUT_Status = 3
	WHERE BookingID = @booking_id
END;
GO
EXEC SP_CHECK_OUT_GUEST_WITH_BOOKING_ID @booking_id = 2;
GO

-- CAP 13
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_CHECK_OUT_GUEST_WITH_GUEST_ID;
GO
CREATE PROCEDURE SP_CHECK_OUT_GUEST_WITH_GUEST_ID
	@guest_id VARCHAR(50)
AS
BEGIN
	DECLARE 
		@payment_id INT,
		@booking_id INT

	SELECT @payment_id = PaymentID FROM PAYMENT
	WHERE GuestID = @guest_id

	SELECT @booking_id = BookingID FROM BOOKING
	WHERE PaymentID = @payment_id

	UPDATE ROOM_BOOKING_DETAIL
	SET CheckingIN_OUT_Status = 3
	WHERE BookingID = @booking_id

END;
GO
EXEC SP_CHECK_OUT_GUEST_WITH_GUEST_ID @guest_id = 'DL000123';
GO

-- CAP 12
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_CHECK_IN_GUEST_WITH_BOOKING_ID;
GO
CREATE PROCEDURE SP_CHECK_IN_GUEST_WITH_BOOKING_ID
	@booking_id INT
AS
BEGIN 
	UPDATE ROOM_BOOKING_DETAIL
	SET CheckingIN_OUT_Status = 2
	WHERE BookingID = @booking_id
END;
GO
EXEC SP_CHECK_IN_GUEST_WITH_BOOKING_ID @booking_id = 2;
GO

-- CAP 11
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_CHECK_IN_GUEST_WITH_GUEST_ID;
GO

CREATE PROCEDURE SP_CHECK_IN_GUEST_WITH_GUEST_ID
	@guest_id VARCHAR(50)
AS
BEGIN
	DECLARE 
		@payment_id INT,
		@booking_id INT

	SELECT @payment_id = PaymentID FROM PAYMENT
	WHERE GuestID = @guest_id

	SELECT @booking_id = BookingID FROM BOOKING
	WHERE PaymentID = @payment_id

	UPDATE ROOM_BOOKING_DETAIL
	SET CheckingIN_OUT_Status = 2
	WHERE BookingID = @booking_id

END;
GO
EXEC SP_CHECK_IN_GUEST_WITH_GUEST_ID @guest_id = 'DL000123';
GO

-- CAP 10
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_CHECK_BOOKING_DETAIL_BY_BOOKING_ID;
GO
CREATE PROCEDURE SP_CHECK_BOOKING_DETAIL_BY_BOOKING_ID
	@booking_id VARCHAR(50)
AS
BEGIN
	SELECT 
		g.GuestName 'NAME', 
		rbd.RoomNumber 'ROOM NUMBER', 
		rbd.CheckInDate 'CHECK IN DATE', 
		rbd.CheckOutDate 'CHECK OUT DATE'
	FROM 
		ROOM_BOOKING_DETAIL rbd, 
		BOOKING b, GUEST g, 
		PAYMENT p
	WHERE 
		rbd.BookingID = b.BookingID
	AND p.GuestID = g.GuestDrivingID
	AND b.BookingID = p.PaymentID
	AND rbd.RBD_ID = @booking_id
END;
GO
EXEC SP_CHECK_BOOKING_DETAIL_BY_BOOKING_ID @booking_id = 2;
GO

-- CAP 9
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_CHECK_BOOKING_DETAIL_BY_GUEST_ID;
GO
CREATE PROCEDURE SP_CHECK_BOOKING_DETAIL_BY_GUEST_ID
	@guest_id VARCHAR(50)
AS
BEGIN
	SELECT 
		g.GuestName 'NAME', 
		rbd.RoomNumber 'ROOM NUMBER', 
		rbd.CheckInDate 'CHECK IN DATE', 
		rbd.CheckOutDate 'CHECK OUT DATE'
	FROM 
		ROOM_BOOKING_DETAIL rbd, 
		BOOKING b, GUEST g, 
		PAYMENT p
	WHERE 
		rbd.BookingID = b.BookingID
	AND @guest_id = g.GuestDrivingID
	AND p.GuestID = @guest_id
	AND b.BookingID = p.PaymentID
END;
GO
EXEC SP_CHECK_BOOKING_DETAIL_BY_GUEST_ID @guest_id = 'DL000124';
GO

-- CAP 8
-- Only MANAGER can use this procedure
DROP PROCEDURE IF EXISTS SP_UPDATE_APP_USER_PRIVILEDGE;
GO
CREATE PROCEDURE SP_UPDATE_APP_USER_PRIVILEDGE
	@user_name VARCHAR(50),
	@email VARCHAR(50),
	@current_role INT,
	@new_role INT
AS
BEGIN
	UPDATE APP_USER
	SET RoleID = @new_role
	WHERE UserName = @user_name 
	AND Email = @email
	AND RoleID = @current_role
END;
GO
EXEC SP_UPDATE_APP_USER_PRIVILEDGE
	@user_name = 'Bob',
	@email = 'bobdoe@pelocanhotel.com',
	@current_role = 3,
	@new_role = 2;
GO

-- CAP 7
-- Only MANAGER can use this procedure
DROP PROCEDURE IF EXISTS SP_ADD_NEW_APP_USER;
GO
CREATE PROCEDURE SP_ADD_NEW_APP_USER
	@role_id INT,
	@user_name VARCHAR(50),
	@email VARCHAR(50),
	@user_password VARCHAR(50),
	@contact_number VARCHAR(50)
AS
BEGIN
	INSERT INTO APP_USER
	VALUES 
	(@role_id, @user_name, @email, @user_password, @contact_number)
END;
GO
EXEC SP_ADD_NEW_APP_USER 
	@role_id = 3, @user_name = 'Bob', 
	@email = 'bobdoe@pelocanhotel.com', 
	@user_password = 'bob123',
	@contact_number = '123 456 7890';
GO

-- CAP 6
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_BILL_TO_DATE_OF_A_GUEST;
GO
CREATE PROCEDURE SP_BILL_TO_DATE_OF_A_GUEST
	@guest_id VARCHAR(25)
AS
BEGIN
	SELECT p.PaymentID,g.GuestName,b.TotalStayPrice,b.TotalChargeBack 
	FROM BOOKING b left join  PAYMENT p ON b.PaymentID = p.PaymentID left join GUEST g 
	ON g.GuestDrivingID = p.GuestID 
	WHERE p.GuestID = @guest_id
END;
GO
EXEC SP_BILL_TO_DATE_OF_A_GUEST @guest_id = 'DL000123';
GO

-- CAP 5
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_BILL_TO_DATE_OF_EVERY_GUEST;
GO
CREATE PROCEDURE SP_BILL_TO_DATE_OF_EVERY_GUEST
AS
BEGIN
	SELECT p.PaymentID,g.GuestName,b.TotalStayPrice,b.TotalChargeBack 
	FROM BOOKING b left join  PAYMENT p ON b.PaymentID = p.PaymentID left join GUEST g 
	ON g.GuestDrivingID = p.GuestID  
END;
GO

EXEC SP_BILL_TO_DATE_OF_EVERY_GUEST;
GO

-- CAP 4
-- MANAGER, RECEPTIONIST, & HOUSEKEEPER can use this procedure
DROP PROCEDURE IF EXISTS SP_CHANGE_ROOM_STATUS;
GO
CREATE PROCEDURE SP_CHANGE_ROOM_STATUS
	@room_number VARCHAR(25),
	@house_keeping_status_id INT
AS
BEGIN
	UPDATE ROOM
	SET HouseKeepingStatusID = @house_keeping_status_id
	WHERE RoomNumber = @room_number
END;
GO
EXEC SP_CHANGE_ROOM_STATUS @room_number= 'A1-04', @house_keeping_status_id = 2;
GO

-- CAP 3
-- MANAGER, RECEPTIONIST, & HOUSEKEEPER can use this procedure
DROP PROCEDURE IF EXISTS SP_MAINTENANCE;
GO
CREATE PROCEDURE SP_MAINTENANCE
	@room_num VARCHAR(25)
	
AS
BEGIN
	UPDATE ROOM
	SET HouseKeepingStatusID = 5
	WHERE RoomNumber = @room_num
END;
GO
EXEC SP_MAINTENANCE @room_num = 'E1-04';
GO

-- CAP 2
-- MANAGER, RECEPTIONIST, & HOUSEKEEPER can use this procedure
DROP PROCEDURE IF EXISTS SP_HOUSEKEEPING_REPORT;
GO
CREATE PROCEDURE SP_HOUSEKEEPING_REPORT
AS
BEGIN

	SELECT 
		r.RoomNumber 'ROOM NUMBER',
		app.UserName 'CLEANER',
		r.CleanedDate 'CLEANED DATE',
		r.HouseKeepingStatusID 'HOUSEKEEPING STATUS'		
	FROM ROOM r, APP_USER app
	WHERE r.WhoCleanedIT = app.UserID

END;
GO
EXEC SP_HOUSEKEEPING_REPORT;
GO

-- CAP 1
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_SHOW_AVAILABLE_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_AVAILABLE_ROOMS
	@room_type INT,
	@checkin_date DATE,
	@checkout_date DATE
AS	
BEGIN
	SELECT RoomNumber AS 'Room Number',RoomPrice 'Price', HouseKeepingStatusID 'Clean Status', 'AVAILABLE' AS 'Room Availability' 
	FROM ROOM
	WHERE RoomNumber NOT IN (
		SELECT RoomNumber FROM ROOM_BOOKING_DETAIL
		WHERE CheckOutDate >= @checkin_date 

	) AND RoomTypeID = @room_type
END;
GO
EXEC SP_SHOW_AVAILABLE_ROOMS @room_type = 3, @checkin_date = '2021-10-14', @checkout_date = '2021-10-14';
GO




--- Old and may be useless procedures
-- CAP 2
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_SINGLE_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_SINGLE_ROOMS
AS
BEGIN
	SELECT * FROM ROOM
	WHERE RoomTypeID = 1
END;
GO

EXEC SP_SHOW_ALL_SINGLE_ROOMS;
GO

-- CAP 3
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_2SINGLE_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_2SINGLE_ROOMS
AS
BEGIN
	SELECT * FROM ROOM
	WHERE RoomTypeID = 2
END;
GO

EXEC SP_SHOW_ALL_2SINGLE_ROOMS;
GO

-- CAP 4
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_DOUBLE_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_DOUBLE_ROOMS
AS
BEGIN
	SELECT * FROM ROOM
	WHERE RoomTypeID = 3
END;
GO

EXEC SP_SHOW_ALL_DOUBLE_ROOMS;
GO

-- CAP 5
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_2BEDROOMS_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_2BEDROOMS_ROOMS
AS
BEGIN
	SELECT * FROM ROOM
	WHERE RoomTypeID = 4
END;
GO

EXEC SP_SHOW_ALL_2BEDROOMS_ROOMS;
GO

-- CAP 6
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_2BUNKBEDS_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_2BUNKBEDS_ROOMS
AS
BEGIN
	SELECT * FROM ROOM
	WHERE RoomTypeID = 5
END;
GO

EXEC SP_SHOW_ALL_2BUNKBEDS_ROOMS;
GO

-- CAP 7
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_SUPERIOR_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_SUPERIOR_ROOMS
AS
BEGIN
	SELECT * FROM ROOM
	WHERE RoomTypeID = 6
END;
GO

EXEC SP_SHOW_ALL_SUPERIOR_ROOMS;
GO

-- CAP 8
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_AVAILABE_PARKING_SPACES;
GO
CREATE PROCEDURE SP_SHOW_ALL_AVAILABE_PARKING_SPACES
AS
BEGIN
	SELECT * FROM AVAILABLE_PARKING_SPACE
	
END;
GO

EXEC SP_SHOW_ALL_AVAILABE_PARKING_SPACES;
GO

-- CAP 9
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_PARKING_SPACES;
GO
CREATE PROCEDURE SP_SHOW_ALL_PARKING_SPACES
AS
BEGIN
	SELECT * FROM AVAILABLE_PARKING_SPACE	
END;
GO

EXEC SP_SHOW_ALL_PARKING_SPACES;
GO

-- CAP 10
DROP PROCEDURE IF EXISTS SP_SELECT_ROOM_NUMBER;
GO
CREATE PROCEDURE SP_SELECT_ROOM_NUMBER
	@room_num VARCHAR(25)
AS 
BEGIN
	SELECT * FROM ROOM
	WHERE RoomNumber = @room_num
END;
GO

EXEC SP_SELECT_ROOM_NUMBER @room_num = 'A1-04';
GO



-- CAP 12
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_DIRTY_ROOM;
GO
CREATE PROCEDURE SP_SHOW_ALL_DIRTY_ROOM
AS
BEGIN
	SELECT RoomNumber, HouseKeepingStatusID FROM ROOM
	WHERE HouseKeepingStatusID = 2
END;
GO

EXEC SP_SHOW_ALL_DIRTY_ROOM;
GO






-- CAP 13
DROP PROCEDURE IF EXISTS SP_BOOKING;
GO
CREATE PROCEDURE SP_BOOKING
	@guest_name VARCHAR(50),
	@guest_driving_id VARCHAR(50),
	@guest_address VARCHAR(500),
	@vehicle_plate VARCHAR(12),
	@place_they_are_from VARCHAR(50),
	@group_type_id INT,
	@name_of_company_or_agent VARCHAR(50),
	@guest_credit_card VARCHAR(19),
	@credit_card_holder VARCHAR(50),
	@credit_card_ccv VARCHAR(3),
	@assigned_room_num VARCHAR(25),
	@check_in_date DATE,
	@check_out_date DATE,
	@number_of_guests INT,
	@number_of_car_parks INT,
	@is_mobility_park BIT,
	@agent_id INT,
	@booking_type_id INT
AS
BEGIN
DECLARE 
	@room_price MONEY	

	SELECT @room_price = RoomPrice FROM ROOM 
	WHERE RoomNumber = @assigned_room_num
	
	INSERT INTO GUEST
		VALUES(@guest_driving_id, @guest_name, @guest_address, @vehicle_plate, 
				@place_they_are_from, @group_type_id, @name_of_company_or_agent, 
				@guest_credit_card, @credit_card_holder, @credit_card_ccv, 1)	
	
	INSERT INTO ROOM_BOOKING
		VALUES(@assigned_room_num, @guest_driving_id, @check_in_date, 
				@check_out_date, @number_of_guests, (DATEDIFF(day, @check_in_date, @check_out_date)) * @room_price, 0.00, 
				@booking_type_id, @agent_id, 'Comment???', @number_of_car_parks, @is_mobility_park,   1)
END;
GO

EXEC SP_BOOKING
	@guest_name = 'Mrs A', @guest_driving_id = 'DL12345678', @guest_address = '123 Apple Street',
	@vehicle_plate = 'ABC123', @place_they_are_from = 'INVERCARGILL', @group_type_id = 4, @name_of_company_or_agent = 'N/A',
	@guest_credit_card = '1234123412341234', @credit_card_holder = 'Mrs A', @credit_card_ccv = '123',
	@assigned_room_num = 'A1-05', @check_in_date = '2021-10-14', @check_out_date = '2021-10-16', @number_of_guests = 1,
	@number_of_car_parks = 1, @is_mobility_park = 0, @agent_id = 4,  @booking_type_id = 2;
GO









-- CAP xx
--DROP TRIGGER IF EXISTS

CREATE TRIGGER TRG_UPDATE_ROOM_STATUS_AUTO
ON ROOM_BOOKING
FOR INSERT
AS
DECLARE
	@check_in_date DATE,
	@check_out_date DATE,
	@assigned_room_num VARCHAR(25)
BEGIN
	SELECT 
		@check_in_date = CheckInDate, 
		@check_out_date = CheckOutDate,
		@assigned_room_num = AssignedRoomNum
	FROM INSERTED

	IF(GETDATE() >= @check_in_date OR GETDATE() <= @check_out_date )
	BEGIN
		UPDATE ROOM
		SET BookingStatusID = 
	END
END;
GO