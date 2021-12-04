USE BEN_SEAN_THANY_ASSIG2_DB;
GO

-- STORE PROCEDUREs AND TRIGGERS

-- CAP 1
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_DIRTY_ROOM;
GO
CREATE PROCEDURE SP_SHOW_ALL_DIRTY_ROOM
AS
BEGIN
	SELECT 
		r.RoomNumber, 
		hs.KeepingStatus    
	FROM 
		ROOM r,
		HOUSEKEEPING_STATUS hs
	WHERE 
		HouseKeepingStatusID = 2
	AND r.HouseKeepingStatusID = hs.KeepingStatusID
END;
GO

EXEC SP_SHOW_ALL_DIRTY_ROOM;
GO

-- CAP 2
DROP PROCEDURE IF EXISTS SP_SELECT_ROOM_NUMBER;
GO
CREATE PROCEDURE SP_SELECT_ROOM_NUMBER
	@room_num VARCHAR(25)
AS 
BEGIN
	SELECT 
		RoomNumber 'ROOM NUMBER',
		RoomPrice 'DAILY RATE',
		RoomCapacity 'CAPACITY',
		RoomDescription 'DESCRIPTION',
		rt.RoomType 'ROOM TYPE',	
		hks.KeepingStatus 'CLEANING STATUS',
		au.UserName 'CLEANER NAME',
		CleanedDate 'DATE OF CLEANING'
	FROM ROOM r, ROOM_TYPE rt, HOUSEKEEPING_STATUS hks, APP_USER au
	WHERE RoomNumber = @room_num
	AND r.HouseKeepingStatusID = hks.KeepingStatusID
	AND r.RoomTypeID = rt.RoomTypeID
	AND au.UserID = r.WhoCleanedIT
END;
GO

EXEC SP_SELECT_ROOM_NUMBER @room_num = 'A1-04';
GO

-- CAP 3
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_PARKING_SPACES;
GO
CREATE PROCEDURE SP_SHOW_ALL_PARKING_SPACES
AS
BEGIN
	SELECT  
		ps.ParkingSpaceID 'PARKING SPACE ID',
		cpt.CarParkType 'PAKING SPACE TYPE',
		ps.RBD_ID 'ROOM BOOKING DETAIL ID'
	FROM 
		AVAILABLE_PARKING_SPACE ps,
		CAR_PARK_TYPE cpt
	WHERE cpt.CarParkTypeID = ps.ParkingSpaceTypeID

END;
GO

EXEC SP_SHOW_ALL_PARKING_SPACES;
GO

-- CAP 4
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_AVAILABE_PARKING_SPACES;
GO
CREATE PROCEDURE SP_SHOW_ALL_AVAILABE_PARKING_SPACES
AS
BEGIN
	SELECT  
		ps.ParkingSpaceID 'PARKING SPACE ID',
		cpt.CarParkType 'PAKING SPACE TYPE',
		ps.RBD_ID 'ROOM BOOKING DETAIL ID'
	FROM 
		AVAILABLE_PARKING_SPACE ps,
		CAR_PARK_TYPE cpt
	WHERE RBD_ID IS NULL
	AND	cpt.CarParkTypeID = ps.ParkingSpaceTypeID
	
END;
GO

EXEC SP_SHOW_ALL_AVAILABE_PARKING_SPACES;
GO

-- CAP 5
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_SUPERIOR_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_SUPERIOR_ROOMS
AS
BEGIN
	SELECT 
		r.RoomNumber 'ROOM NUMBER',
		r.RoomPrice 'DAILY RATE',
		r.RoomCapacity 'CAPACITY',
		r.RoomDescription 'DESCRIPTION',
		rt.RoomType 'ROOM TYPE',
		hs.KeepingStatus 'CLEANING STATUS',
		au.UserName 'CLEANER NAME',
		r.CleanedDate 'DATE OF CLEANING'

	FROM ROOM r, ROOM_TYPE rt, HOUSEKEEPING_STATUS hs, APP_USER au
	WHERE r.RoomTypeID = 6
	AND rt.RoomTypeID = r.RoomTypeID
	AND hs.KeepingStatusID = r.HouseKeepingStatusID
	AND au.UserID = r.WhoCleanedIT
END;
GO

EXEC SP_SHOW_ALL_SUPERIOR_ROOMS;
GO

-- CAP 6
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_2BUNKBEDS_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_2BUNKBEDS_ROOMS
AS
BEGIN
	SELECT 
		r.RoomNumber 'ROOM NUMBER',
		r.RoomPrice 'DAILY RATE',
		r.RoomCapacity 'CAPACITY',
		r.RoomDescription 'DESCRIPTION',
		rt.RoomType 'ROOM TYPE',
		hs.KeepingStatus 'CLEANING STATUS',
		au.UserName 'CLEANER NAME',
		r.CleanedDate 'DATE OF CLEANING'

	FROM ROOM r, ROOM_TYPE rt, HOUSEKEEPING_STATUS hs, APP_USER au
	WHERE r.RoomTypeID = 5
	AND rt.RoomTypeID = r.RoomTypeID
	AND hs.KeepingStatusID = r.HouseKeepingStatusID
	AND au.UserID = r.WhoCleanedIT
END;
GO

EXEC SP_SHOW_ALL_2BUNKBEDS_ROOMS;
GO

-- CAP 7
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_2BEDROOMS_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_2BEDROOMS_ROOMS
AS
BEGIN
	SELECT 
		r.RoomNumber 'ROOM NUMBER',
		r.RoomPrice 'DAILY RATE',
		r.RoomCapacity 'CAPACITY',
		r.RoomDescription 'DESCRIPTION',
		rt.RoomType 'ROOM TYPE',
		hs.KeepingStatus 'CLEANING STATUS',
		au.UserName 'CLEANER NAME',
		r.CleanedDate 'DATE OF CLEANING'
	FROM ROOM r, ROOM_TYPE rt, HOUSEKEEPING_STATUS hs, APP_USER au
	WHERE r.RoomTypeID = 4
	AND rt.RoomTypeID = r.RoomTypeID
	AND hs.KeepingStatusID = r.HouseKeepingStatusID
	AND au.UserID = r.WhoCleanedIT
END;
GO

EXEC SP_SHOW_ALL_2BEDROOMS_ROOMS;
GO


-- CAP 8
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_DOUBLE_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_DOUBLE_ROOMS
AS
BEGIN
	SELECT 
		r.RoomNumber 'ROOM NUMBER',
		r.RoomPrice 'DAILY RATE',
		r.RoomCapacity 'CAPACITY',
		r.RoomDescription 'DESCRIPTION',
		rt.RoomType 'ROOM TYPE',
		hs.KeepingStatus 'CLEANING STATUS',
		au.UserName 'CLEANER NAME',
		r.CleanedDate 'DATE OF CLEANING'
	FROM ROOM r, ROOM_TYPE rt, HOUSEKEEPING_STATUS hs, APP_USER au
	WHERE r.RoomTypeID = 3
	AND rt.RoomTypeID = r.RoomTypeID
	AND hs.KeepingStatusID = r.HouseKeepingStatusID
	AND au.UserID = r.WhoCleanedIT
END;
GO

EXEC SP_SHOW_ALL_DOUBLE_ROOMS;
GO

-- CAP 9
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_2SINGLE_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_2SINGLE_ROOMS
AS
BEGIN
	SELECT
		r.RoomNumber 'ROOM NUMBER',
		r.RoomPrice 'DAILY RATE',
		r.RoomCapacity 'CAPACITY',
		r.RoomDescription 'DESCRIPTION',
		rt.RoomType 'ROOM TYPE',
		hs.KeepingStatus 'CLEANING STATUS',
		au.UserName 'CLEANER NAME',
		r.CleanedDate 'DATE OF CLEANING'
	FROM ROOM r, ROOM_TYPE rt, HOUSEKEEPING_STATUS hs, APP_USER au
	WHERE r.RoomTypeID = 2
	AND rt.RoomTypeID = r.RoomTypeID
	AND hs.KeepingStatusID = r.HouseKeepingStatusID
	AND au.UserID = r.WhoCleanedIT
END;
GO

EXEC SP_SHOW_ALL_2SINGLE_ROOMS;
GO

-- CAP 10
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_SINGLE_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_ALL_SINGLE_ROOMS
AS
BEGIN
	SELECT
		r.RoomNumber 'ROOM NUMBER',
		r.RoomPrice 'DAILY RATE',
		r.RoomCapacity 'CAPACITY',
		r.RoomDescription 'DESCRIPTION',
		rt.RoomType 'ROOM TYPE',
		hs.KeepingStatus 'CLEANING STATUS',
		au.UserName 'CLEANER NAME',
		r.CleanedDate 'DATE OF CLEANING'
	FROM ROOM r, ROOM_TYPE rt, HOUSEKEEPING_STATUS hs, APP_USER au
	WHERE r.RoomTypeID = 1
	AND rt.RoomTypeID = r.RoomTypeID
	AND hs.KeepingStatusID = r.HouseKeepingStatusID
	AND au.UserID = r.WhoCleanedIT
END;
GO

EXEC SP_SHOW_ALL_SINGLE_ROOMS;
GO

-- CAP 11
-- MANAGER, RECEPTIONIST can use this procedure
-- This procedure insert a new guest or update and existing guest and insert a new payment
DROP PROCEDURE IF EXISTS SP_INSERT_A_NEW_GUEST;
GO
CREATE PROCEDURE SP_INSERT_A_NEW_GUEST
	@guest_driving_id VARCHAR(50),
	@guest_name VARCHAR(50),
	@guest_address VARCHAR(500),
	@guest_vehicle_plate VARCHAR(12),
	@guest_from VARCHAR(50),
	@guest_group_type INT,
	@guest_company_or_travel_agency VARCHAR(50),
	@guest_credit_card VARCHAR(19),
	@guest_credit_holder_name VARCHAR(50),
	@guest_credit_card_CCV VARCHAR(3),
	@is_credit_card_valid BIT,
	@payment_type_id INT
AS
BEGIN
	IF (NOT EXISTS(SELECT * FROM GUEST WHERE GuestDrivingID = @guest_driving_id))
		BEGIN
			INSERT INTO GUEST 
			VALUES (
				@guest_driving_id, 
				@guest_name, 
				@guest_address, 
				@guest_vehicle_plate, 
				@guest_from,
				@guest_group_type,
				@guest_company_or_travel_agency,
				@guest_credit_card,
				@guest_credit_holder_name,
				@guest_credit_card_CCV,
				@is_credit_card_valid
			)
		
		END
	ELSE -- update guest's details
		BEGIN
			UPDATE GUEST
			SET
				GuestName = @guest_name,
				GuestAddress = @guest_address,
				VehiclePlate = @guest_vehicle_plate,
				PlaceTheyAreFrom = @guest_from,
				GroupTypeID = @guest_group_type,
				NameOfCompanyOrTravelAgency = @guest_company_or_travel_agency,
				GuestCreditCard = @guest_credit_card,
				CreditCardHolder = @guest_credit_card,
				CreditCardCCV = @guest_credit_card_CCV,
				IsCreditCardValid = @is_credit_card_valid
			WHERE GuestDrivingID = @guest_driving_id
		END

	-- I cannot pass payment_type_id to the trigger
	IF( @@ROWCOUNT = 1)
		BEGIN
			INSERT INTO PAYMENT
			VALUES (
				@guest_driving_id, 
				@payment_type_id,
				0.0,
				GETDATE(),
				0
			)
		END
END;
GO

-- CAP 12
-- MANAGER & RECEPTIONIST can use this procedure
-- This procedure insert a new booking and a new room booking detail
DROP PROCEDURE IF EXISTS SP_BOOKING;
GO
CREATE PROCEDURE SP_BOOKING
	@guest_id VARCHAR(50),	
	@assigned_room_number VARCHAR(25),
	@number_of_guests INT,
	@leaving_comments VARCHAR(250),
	@number_of_car_parks INT,
	@is_accessible_car_park BIT,
	@agent_id INT,
	@booking_type_id INT,	
	@check_in_date DATE,
	@check_out_date DATE
AS
BEGIN
IF(@check_out_date >= @check_in_date)
	BEGIN
		DECLARE
		@payment_id INT,
		@room_price MONEY	

		SELECT @room_price = RoomPrice FROM ROOM
		WHERE RoomNumber = @assigned_room_number
		
		SELECT TOP 1 @payment_id = PaymentID FROM PAYMENT
		ORDER BY PaymentID DESC

		INSERT INTO BOOKING
		VALUES(
			@payment_id,
			@guest_id,
			@assigned_room_number,
			@number_of_guests,
			@room_price * DATEDIFF(day, @check_in_date, @check_out_date),
			0.0,
			@leaving_comments,
			@number_of_car_parks,
			@is_accessible_car_park,
			@agent_id,
			3,
			0
		)

		IF( @@ROWCOUNT = 1)
		BEGIN
			INSERT INTO ROOM_BOOKING_DETAIL
			VALUES(
				@assigned_room_number,
				2,
				@payment_id,
				@guest_id,
				@check_in_date,
				@check_out_date,
				1
			)
		END
		
		
	END
ELSE
	PRINT 'ERROR- Check OUT DATE CANNOT BE LESS THAN CHECK IN DATE'
END;
GO
-- This trigger will update the payment associating with the guest 
DROP TRIGGER IF EXISTS TRG_UPDATE_PAYMENT_WITH_BOOKING;
GO
CREATE TRIGGER TRG_UPDATE_PAYMENT_WITH_BOOKING
ON BOOKING
FOR INSERT
AS
BEGIN
DECLARE 
	@guest_id VARCHAR(50),
	@payment_id INT,
	@total_stay_price MONEY

	SELECT
		@guest_id = GuestID, 
		@total_stay_price = TotalStayPrice,
		@payment_id = PaymentID
	FROM inserted
	
	UPDATE PAYMENT
	SET PaymentAmount = PaymentAmount + @total_stay_price
	WHERE GuestID = @guest_id AND PaymentID = @payment_id
	
END;
GO
EXEC SP_INSERT_A_NEW_GUEST 
	@guest_driving_id = 'DL000125',
	@guest_name = 'Nhi, Nguyen',
	@guest_address = '444 Conyer Street, Georgetown',
	@guest_vehicle_plate = 'GNS487',
	@guest_from = 'Vietnam',
	@guest_group_type = 2,
	@guest_company_or_travel_agency = 'Ho Chi Minh Explorer',
	@guest_credit_card = '123145453647',
	@guest_credit_holder_name = 'Nhi Nguyen',
	@guest_credit_card_CCV = '432',
	@is_credit_card_valid = 1,
	@payment_type_id = 4;
GO
EXEC SP_BOOKING 
	@guest_id = 'DL000125',
	@assigned_room_number = 'E1-03',
	@number_of_guests = 2,
	@leaving_comments = 'Fried rice says to a Shrimp: don yo wok away from me.',
	@number_of_car_parks = 1,
	@is_accessible_car_park = 0,
	@agent_id = null,
	@booking_type_id = 3,
	@check_in_date = '2021-11-15',
	@check_out_date = '2021-11-17';
GO
EXEC SP_INSERT_A_NEW_GUEST 
	@guest_driving_id = 'DL000126',
	@guest_name = 'Mei, Nguyen',
	@guest_address = '74 Conyer Street, Georgetown',
	@guest_vehicle_plate = 'KLK437',
	@guest_from = 'Vietnam',
	@guest_group_type = 2,
	@guest_company_or_travel_agency = 'Good Morning Saigon',
	@guest_credit_card = '1290645453647',
	@guest_credit_holder_name = 'Mei Nguyen',
	@guest_credit_card_CCV = '895',
	@is_credit_card_valid = 1,
	@payment_type_id = 4;
GO
EXEC SP_BOOKING 
	@guest_id = 'DL000126',
	@assigned_room_number = 'E1-03',
	@number_of_guests = 2,
	@leaving_comments = 'Bring us more watermelons',
	@number_of_car_parks = 1,
	@is_accessible_car_park = 0,
	@agent_id = null,
	@booking_type_id = 3,
	@check_in_date = '2021-11-20',
	@check_out_date = '2021-11-22';
GO

-- CAP 13
-- MANAGER, RECEPTIONIST, & GUEST can use this procedure
DROP PROCEDURE IF EXISTS SP_CHECK_BOOKING_DETAIL_BY_BOOKING_ID;
GO
CREATE PROCEDURE SP_CHECK_BOOKING_DETAIL_BY_BOOKING_ID
	@booking_id VARCHAR(50)
AS
BEGIN
	DECLARE
		@b_guest_id VARCHAR(50)
	
	SELECT @b_guest_id = GuestID FROM BOOKING
	WHERE BookingID = @booking_id

	SELECT 
		g.GuestName 'NAME', 
		rbd.RoomNumber 'ROOM NUMBER', 
		rbd.CheckInDate 'CHECK IN DATE', 
		rbd.CheckOutDate 'CHECK OUT DATE'
	FROM 
		ROOM_BOOKING_DETAIL rbd, 
		GUEST g 		
	WHERE 
		@b_guest_id = g.GuestDrivingID
	AND g.GuestDrivingID = rbd.GuestID
	
END;
GO
EXEC SP_CHECK_BOOKING_DETAIL_BY_BOOKING_ID @booking_id = 2;
GO

-- CAP 14
-- MANAGER, RECEPTIONIST, and GUEST can use this procedure
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
		GUEST g
	WHERE 
		rbd.GuestID = g.GuestDrivingID
	AND @guest_id = rbd.GuestID
END;
GO
EXEC SP_CHECK_BOOKING_DETAIL_BY_GUEST_ID @guest_id = 'DL000124';
GO

-- CAP 15
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_ASSIGN_PARKING;
GO
CREATE PROCEDURE SP_ASSIGN_PARKING
	@parking_space_id INT,
	@rbd_id INT
AS
BEGIN
	UPDATE AVAILABLE_PARKING_SPACE
	SET RBD_ID = @rbd_id
	WHERE ParkingSpaceID = @parking_space_id
END;
GO
EXEC SP_ASSIGN_PARKING @parking_space_id = 11, @rbd_id = 3;
GO

-- CAP 16
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_SHOW_ALL_OCCUPIED_PARKING_SPACES;
GO
CREATE PROCEDURE SP_SHOW_ALL_OCCUPIED_PARKING_SPACES
AS
BEGIN
	SELECT  
		ps.ParkingSpaceID 'PARKING SPACE ID',
		cpt.CarParkType 'PAKING SPACE TYPE',
		rbd.GuestID 'GUEST ID'
	FROM 
		AVAILABLE_PARKING_SPACE ps,
		CAR_PARK_TYPE cpt,
		ROOM_BOOKING_DETAIL rbd
	WHERE cpt.CarParkTypeID = ps.ParkingSpaceTypeID
	AND rbd.RBD_ID = ps.RBD_ID
END;
GO

EXEC SP_SHOW_ALL_OCCUPIED_PARKING_SPACES;
GO

-- CAP 17
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_CHECK_IN_GUEST_WITH_BOOKING_ID;
GO
CREATE PROCEDURE SP_CHECK_IN_GUEST_WITH_BOOKING_ID
	@booking_id INT
AS
BEGIN 
	DECLARE
		@b_guest_id VARCHAR(50),
		@room_number VARCHAR(25)
	
	SELECT 
		@b_guest_id = GuestID, 
		@room_number = AssignedRoomNum		
	FROM BOOKING
	WHERE BookingID = @booking_id

	UPDATE ROOM_BOOKING_DETAIL
	SET CheckingIN_OUT_Status = 2
	WHERE 
		GuestID = @b_guest_id
	AND
		RoomNumber = @room_number
END;
GO
EXEC SP_CHECK_IN_GUEST_WITH_BOOKING_ID @booking_id = 2;
GO

-- CAP 18
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_CHECK_IN_GUEST_WITH_GUEST_ID;
GO

CREATE PROCEDURE SP_CHECK_IN_GUEST_WITH_GUEST_ID
	@guest_id VARCHAR(50)
AS
BEGIN

	UPDATE ROOM_BOOKING_DETAIL
	SET CheckingIN_OUT_Status = 2
	WHERE GuestID = @guest_id

END;
GO
EXEC SP_CHECK_IN_GUEST_WITH_GUEST_ID @guest_id = 'DL000123';
GO

-- CAP 19
-- CHARGE BACK CLIENT can use this procedure
DROP PROCEDURE IF EXISTS SP_CHARGE_BACK;
GO
CREATE PROCEDURE SP_CHARGE_BACK
	@guest_id VARCHAR(50),
	@payment_id INT,
	@item_id INT,
	@item_quantity INT
AS
BEGIN
	DECLARE 
		@check_out_date DATE,
		@room_number VARCHAR(25),
		@check_in_out_status INT
	SELECT 
		@room_number = RoomNumber,
		@check_in_out_status = CheckingIN_OUT_status,
		@check_out_date = CheckOutDate
	FROM ROOM_BOOKING_DETAIL
	WHERE GuestID = @guest_id AND PaymentID = @payment_id

	IF (
		@room_number IS NULL 
		OR @room_number = '' 
		OR NOT(
				@check_out_date >= GETDATE() 
				AND @check_in_out_status = 2
			)
		)
		PRINT 'THIS PERSON IS NOT A GUEST WHO DID THE BOOKING'
	ELSE
		BEGIN
			INSERT INTO CHARGEBACK
			VALUES (
				@room_number,
				@payment_id,
				@guest_id,
				@item_id,
				@item_quantity,
				GETDATE()
			)
		END
	
END;
GO

DROP TRIGGER IF EXISTS TRG_UPDATE_PAYMENT_AND_BOOKING_ON_CHARGEBACK;
GO
CREATE TRIGGER TRG_UPDATE_PAYMENT_AND_BOOKING_ON_CHARGEBACK
ON CHARGEBACK
FOR INSERT
AS
BEGIN
	DECLARE 
		@item_id INT,
		@item_quantity INT,
		@item_price MONEY

	SELECT @item_id = ItemID, @item_quantity = ItemQuantity
	FROM inserted

	UPDATE BOOKING
	SET TotalChargeBack = TotalChargeBack + @item_quantity *
	(
		SELECT ItemPrice FROM ITEM
		WHERE ItemID = (
			SELECT ItemID FROM inserted
		)
	)
	WHERE GuestID = (
		SELECT GuestID FROM inserted
	)
	AND PaymentID = (
		SELECT PaymentID FROM inserted
	)

	UPDATE PAYMENT
	SET PaymentAmount = 
		 
		(SELECT TotalChargeBack + TotalStayPrice FROM BOOKING
		WHERE GuestID = (
							SELECT GuestID FROM inserted
						)
		AND PaymentID = (
							SELECT PaymentID FROM inserted
						)
		)
	WHERE GuestID = (
		SELECT GuestID FROM inserted
	)
	AND PaymentID = (
		SELECT PaymentID FROM inserted
	)
END;
GO

EXEC SP_CHECK_IN_GUEST_WITH_GUEST_ID @guest_id = 'DL000126';
GO

EXEC SP_CHARGE_BACK
	@guest_id = 'DL000126',
	@payment_id = 4,
	@item_id = 5,
	@item_quantity = 2;
GO

-- CAP 20
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_CHECK_OUT_GUEST_WITH_BOOKING_ID;
GO
CREATE PROCEDURE SP_CHECK_OUT_GUEST_WITH_BOOKING_ID
	@booking_id INT
AS
BEGIN
	DECLARE 
		@guest_id_from_booking_tbl VARCHAR(50),
		@room_number VARCHAR(50),
		@rbd_id INT

	SELECT @guest_id_from_booking_tbl = GuestID, @room_number = AssignedRoomNum 
	FROM BOOKING
	WHERE BookingID = @booking_id

	UPDATE ROOM_BOOKING_DETAIL
	SET CheckingIN_OUT_Status = 3
	WHERE 
		@guest_id_from_booking_tbl = GuestID
	AND
		@room_number = RoomNumber
	AND 
		CheckingIN_OUT_status != 3
	
	SELECT @rbd_id = RBD_ID 
	FROM ROOM_BOOKING_DETAIL
	WHERE 
		@guest_id_from_booking_tbl = GuestID
	AND
		@room_number = RoomNumber
	AND 
		CheckingIN_OUT_status != 3
	
	UPDATE AVAILABLE_PARKING_SPACE
	SET RBD_ID = null
	WHERE RBD_ID = @rbd_id
END;
GO
EXEC SP_CHECK_OUT_GUEST_WITH_BOOKING_ID @booking_id = 2;
GO

-- CAP 21
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_CHECK_OUT_GUEST_WITH_GUEST_ID;
GO
CREATE PROCEDURE SP_CHECK_OUT_GUEST_WITH_GUEST_ID
	@guest_id VARCHAR(50)
AS
BEGIN
	DECLARE 
		@rbd_id INT

	SELECT @rbd_id = RBD_ID 
	FROM ROOM_BOOKING_DETAIL
	WHERE GuestID = @guest_id

	UPDATE ROOM_BOOKING_DETAIL
	SET CheckingIN_OUT_Status = 3
	WHERE GuestID = @guest_id

	UPDATE AVAILABLE_PARKING_SPACE
	SET RBD_ID = null
	WHERE RBD_ID = @rbd_id
END;
GO
EXEC SP_CHECK_OUT_GUEST_WITH_GUEST_ID @guest_id = 'DL000123';
GO

-- CAP 22
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
	WHERE rbd.GuestID = b.GuestID
	AND g.GuestDrivingID IN (
		SELECT p.GuestID FROM PAYMENT p
		WHERE b.GuestID = p.GuestID
	)
	AND (rbd.CheckInDate >= @input_date_1 OR rbd.CheckInDate <= @input_date_2)
END;
GO
EXEC SP_SUM_TOTAL_STAY_PRICE_BETWEEN_2_DAYS @input_date_1 ='2021-10-11', @input_date_2 = '2021-10-17';
GO

-- CAP 23
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
	WHERE rbd.GuestID = b.GuestID
	AND g.GuestDrivingID IN (
		SELECT p.GuestID FROM PAYMENT p
		WHERE b.GuestID = p.GuestID
	)
	AND (rbd.CheckInDate >= @input_date_1 OR rbd.CheckInDate <= @input_date_2)
END;
GO
EXEC SP_BOOKING_FORCASTS_BETWEEN_2_DAYS @input_date_1 ='2021-10-11', @input_date_2 = '2021-10-17'; 
GO

-- CAP 24
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
	WHERE rbd.GuestID = b.GuestID
	AND g.GuestDrivingID IN (
		SELECT p.GuestID FROM PAYMENT p
		WHERE b.GuestID = p.GuestID
	)
	AND rbd.CheckInDate = @input_date
END;
GO
EXEC SP_SUM_TOTAL_STAY_PRICE_FOR_A_SPECIFIC_DAY @input_date = '2021-10-13';
GO

-- CAP 25
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
	WHERE rbd.GuestID = b.GuestID
	AND g.GuestDrivingID IN (
		SELECT p.GuestID FROM PAYMENT p
		WHERE b.GuestID = p.GuestID
	)
	AND rbd.CheckInDate = @input_date
END;
GO
EXEC SP_BOOKING_FORCASTS_FOR_A_SPECIFIC_DAY @input_date = '2021-10-13';
GO


-- CAP 26
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_END_OF_DAY_REPORT;
GO
CREATE PROCEDURE SP_END_OF_DAY_REPORT
	@today_date DATE
AS
BEGIN
	SELECT
		g.GuestName 'GUEST NAME', 
		rbd.RoomNumber 'ROOM NUMBER',
		CONVERT(VARCHAR, rbd.CheckInDate, 103) 'CHECK IN',
		CONVERT(VARCHAR, rbd.CheckOutDate, 103) 'CHECK OUT',
		p.PaymentAmount 'PAYMENT UP TO DATE',
		CASE WHEN p.IsPaid = 1 THEN 'YES' ELSE 'NO' END AS 'IS PAID?',
		p.PaymentTypeID 'PAYMENT TYPE'
	FROM
		GUEST g,		
		ROOM_BOOKING_DETAIL rbd,
		PAYMENT p
	WHERE	
		p.GuestID = g.GuestDrivingID
	AND 
		rbd.CheckInDate <= @today_date
	AND 
		rbd.CheckOutDate > @today_date
	AND 
		rbd.GuestID = g.GuestDrivingID
END;
GO
-- Test 
-- '2021-10-12' & '2021-10-15', there shouldn't be any result.
-- '2021-10-13' & '2021-10-14', there should be results.
EXEC SP_END_OF_DAY_REPORT @today_date = '2021-10-14';
GO

-- CAP 27
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

-- CAP 28
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

-- CAP 29
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_BILL_TO_DATE_OF_A_GUEST;
GO
CREATE PROCEDURE SP_BILL_TO_DATE_OF_A_GUEST
	@guest_id VARCHAR(25)
AS
BEGIN
	SELECT 
		p.PaymentID 'PAYMENT ID',
		g.GuestName 'GUEST NAME',
		b.TotalStayPrice 'TOTAL ROOM PRICE',
		b.TotalChargeBack 'TOTAL CHARGE BACK',
		p.PaymentAmount 'TOTAL PAYMENT'
	FROM 
		BOOKING b left join  PAYMENT p 
	ON b.GuestID = p.GuestID left join GUEST g 
	ON g.GuestDrivingID = p.GuestID 
	WHERE p.GuestID = @guest_id
END;
GO
EXEC SP_BILL_TO_DATE_OF_A_GUEST @guest_id = 'DL000123';
GO

-- CAP 30
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_BILL_TO_DATE_OF_EVERY_GUEST;
GO
CREATE PROCEDURE SP_BILL_TO_DATE_OF_EVERY_GUEST
AS
BEGIN
	SELECT 
		p.PaymentID 'PAYMENT ID',
		g.GuestName 'GUEST NAME',
		b.TotalStayPrice 'TOTAL ROOM PRICE',
		b.TotalChargeBack 'TOTAL CHARGE BACK',
		p.PaymentAmount 'TOTAL PAYMENT'
	FROM 
		BOOKING b left join  PAYMENT p 
	ON b.GuestID = p.GuestID left join GUEST g 
	ON g.GuestDrivingID = p.GuestID  
END;
GO

EXEC SP_BILL_TO_DATE_OF_EVERY_GUEST;
GO

-- CAP 31
-- MANAGER, RECEPTIONIST, & HOUSEKEEPER can use this procedure
DROP PROCEDURE IF EXISTS SP_UPDATE_HOUSEKEEPING_STATUS;
GO
CREATE PROCEDURE SP_UPDATE_HOUSEKEEPING_STATUS
	@room_number VARCHAR(25),
	@user_id INT,
	@house_keeping_status_id INT,	
	@cleaning_date DATE

AS
BEGIN
	UPDATE ROOM
	SET 
		HouseKeepingStatusID = @house_keeping_status_id,
		WhoCleanedIT = @user_id,
		CleanedDate = @cleaning_date
	WHERE RoomNumber = @room_number
END;
GO
EXEC SP_UPDATE_HOUSEKEEPING_STATUS @room_number= 'A1-04', @user_id = 3, @house_keeping_status_id = 2, @cleaning_date = '2021-10-24';
GO

-- CAP 32
-- MANAGER, RECEPTIONIST, & HOUSEKEEPER can use this procedure
DROP PROCEDURE IF EXISTS SP_MAINTENANCE;
GO
CREATE PROCEDURE SP_MAINTENANCE
	@room_num VARCHAR(25),
	@user_id INT,
	@maintenance_date DATE
	
AS
BEGIN
	UPDATE ROOM
	SET	
		HouseKeepingStatusID = 5,
		WhoCleanedIT = @user_id
	WHERE RoomNumber = @room_num
END;
GO
EXEC SP_MAINTENANCE @room_num = 'E1-04', @user_id = 3, @maintenance_date = '2021-10-29';
GO


-- CAP 33
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
		hs.KeepingStatus 'HOUSEKEEPING STATUS'		
	FROM ROOM r, APP_USER app, HOUSEKEEPING_STATUS hs
	WHERE r.WhoCleanedIT = app.UserID
	AND r.HouseKeepingStatusID = hs.KeepingStatusID

END;
GO
EXEC SP_HOUSEKEEPING_REPORT;
GO

-- CAP 34
-- MANAGER & RECEPTIONIST can use this procedure
DROP PROCEDURE IF EXISTS SP_SHOW_AVAILABLE_ROOMS;
GO
CREATE PROCEDURE SP_SHOW_AVAILABLE_ROOMS
	@room_type INT,
	@checkin_date DATE,
	@checkout_date DATE
AS	
BEGIN
	SELECT 
		RoomNumber AS 'Room Number',
		RoomPrice 'Price', 
		hs.KeepingStatus 'Clean Status', 
		'AVAILABLE' AS 'Room Availability' 
	FROM 
		ROOM r, 
		HOUSEKEEPING_STATUS hs
	WHERE RoomNumber NOT IN (
		SELECT RoomNumber FROM ROOM_BOOKING_DETAIL
		WHERE CheckOutDate >= @checkin_date 

	) 
	AND RoomTypeID = @room_type
	AND hs.KeepingStatusID = r.HouseKeepingStatusID
END;
GO
EXEC SP_SHOW_AVAILABLE_ROOMS @room_type = 3, @checkin_date = '2021-10-14', @checkout_date = '2021-10-14';
GO


-- CAP 35 (don't execute this procedure, if you don't have to)
-- MANAGER can use this procedure
DROP PROCEDURE IF EXISTS SP_RESTORE_FULL_BACKUP;
GO
CREATE PROCEDURE SP_RESTORE_FULL_BACKUP
AS
BEGIN
	RESTORE DATABASE BEN_SEAN_THANY_ASSIG2_DB 
	FROM DISK = 'C:\myDatabase_backup\assig2_full.bak'
	WITH NORECOVERY

END;
GO


-- CAP 36 (don't execute this procedure, if you don't have to)
-- MANAGER can use this procedure
DROP PROCEDURE IF EXISTS SP_FULL_BACKUP;
GO
CREATE PROCEDURE SP_FULL_BACKUP
AS
BEGIN
	BACKUP DATABASE BEN_SEAN_THANY_ASSIG2_DB
	TO DISK = 'C:\myDatabase_backup\assig2_full.bak'
	WITH INIT
END;
GO

EXEC SP_FULL_BACKUP;

ALTER DATABASE BEN_SEAN_THANY_ASSIG2_DB SET OFFLINE;
GO 


ALTER DATABASE BEN_SEAN_THANY_ASSIG2_DB SET ONLINE;
GO 




EXEC SP_RESTORE_FULL_BACKUP;
Go

SELECT * FROM ROOM;
GO