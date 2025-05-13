--TRIGGER_1
--stage can only hold one event at the same time
DELIMITER //
DROP TRIGGER IF EXISTS check_event_overlap;
CREATE TRIGGER check_event_overlap
BEFORE INSERT ON event
FOR EACH ROW
BEGIN
    
    DECLARE festival_start DATE;
    DECLARE festival_end DATE;
    DECLARE start_time_day DATETIME;
    DECLARE end_time_day DATETIME;
    DECLARE valid_count INT DEFAULT 0;
    DECLARE overlap_count INT;
    
    #event in festival dates#
    SELECT start_date, end_date INTO festival_start, festival_end
    FROM festival
    WHERE festival_id = NEW.festival_id;

    IF NOT (DATE(NEW.start_time) >= festival_start AND DATE(NEW.start_time) <= festival_end
    AND DATE(NEW.end_time) >= festival_start AND DATE(NEW.end_time) <= festival_end) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mismatch event dates with festival dates';
    END IF;
    
    #one event per stage at the same time#
    SELECT COUNT(*) INTO overlap_count
    FROM event
    WHERE stage_id = NEW.stage_id
    AND ( NEW.start_time < end_time AND NEW.end_time > start_time);
    
    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stage is already booked for another event at this time';
    END IF;

    #check festival duration per day#
    SELECT MIN(start_time) INTO start_time_day
    FROM event 
    WHERE festival_id = NEW.festival_id AND DATE(start_time) = DATE(NEW.start_time);

    SELECT MAX(end_time) INTO end_time_day
    FROM event 
    WHERE festival_id = NEW.festival_id AND DATE(start_time) = DATE(NEW.start_time);

    IF start_time_day IS NOT NULL THEN 
        IF NEW.start_time < start_time_day THEN
            SET start_time_day = NEW.start_time;
        END IF;
        IF NEW.end_time > end_time_day THEN
            SET end_time_day = NEW.end_time;
        END IF;
        IF TIMESTAMPDIFF(MINUTE, start_time_day, end_time_day) > 780 THEN 
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Violation of festival duration per day';
        END IF;
    END IF;
END//
DELIMITER ;


--TRIGGER_2
--check for valid assignment of staff
DELIMITER //
DROP TRIGGER IF EXISTS check_staff_assignments;
CREATE TRIGGER check_staff_assignments
BEFORE INSERT ON staff_event
FOR EACH ROW
BEGIN
    DECLARE v_job_type VARCHAR(100);
    DECLARE v_event_start DATETIME;
    DECLARE v_event_end DATETIME;
    DECLARE v_event_date DATE;
    DECLARE v_daily_assignments INT;
    DECLARE v_overlap_count INT;
    
    #We find the employee job type (from the staff table)#
    SELECT job INTO v_job_type 
    FROM staff 
    WHERE staff_id = NEW.staff_id;
    
    #We find the schedule/timings of the new event (from the event table)#
    SELECT start_time, end_time, DATE(start_time)
    INTO v_event_start, v_event_end, v_event_date
    FROM event
    WHERE event_id = NEW.event_id;
    

    #Check for overlapping assignments (for all staff)#
    SELECT COUNT(*) INTO v_overlap_count
    FROM staff_event se
    JOIN event e ON se.event_id = e.event_id
    WHERE se.staff_id = NEW.staff_id
    AND (
        (v_event_start < e.end_time AND v_event_end > e.start_time)
    );

    IF v_overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'One person cannot be in two events at the same time. Overlap assignments';
    END IF;

    #Check for technicians (max 2 daily assignments)#
    IF v_job_type = 'technical' THEN
        SELECT COUNT(*) INTO v_daily_assignments
        FROM staff_event se
        JOIN event e ON se.event_id = e.event_id
        WHERE se.staff_id = NEW.staff_id
        AND DATE(e.start_time) = v_event_date;
        
        IF v_daily_assignments >= 2 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Max of 2 assignments for the same day for technician has been reached.';
        END IF;
    END IF;
END//
DELIMITER ;


--PROCEDURE 1
--check the percentages of staffs for every event
DELIMITER //
DROP PROCEDURE IF EXISTS validate_event_staffing;
CREATE PROCEDURE validate_event_staffing()
BEGIN
    DECLARE violations_count INT DEFAULT 0;

    SELECT COUNT(*) INTO violations_count
    FROM (
        SELECT 
            e.event_id,
            st.max_capacity AS max_cap,
            COALESCE(SUM(CASE WHEN s.job = 'technical' THEN 1 ELSE 0 END), 0) AS tech_count,
            COALESCE(SUM(CASE WHEN s.job = 'security' THEN 1 ELSE 0 END), 0) AS security_count,
            COALESCE(SUM(CASE WHEN s.job = 'assistant' THEN 1 ELSE 0 END), 0) AS assistant_count
        FROM event e
        JOIN stage st ON e.stage_id = st.stage_id
        LEFT JOIN staff_event se ON e.event_id = se.event_id
        LEFT JOIN staff s ON se.staff_id = s.staff_id
        GROUP BY e.event_id, st.max_capacity
    ) AS sub 
    WHERE 
        tech_count < 1
        OR security_count < CEIL(max_cap * 0.05)
        OR assistant_count < CEIL(max_cap * 0.02);

     IF violations_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Staffing constraints violated for one or more events';
    END IF;
END//
DELIMITER ;


--TRIGGER 3
--check for valid performance gaps and overlaps
DELIMITER //
DROP TRIGGER IF EXISTS trg_check_performance_gaps;
CREATE TRIGGER trg_check_performance_gaps
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
    DECLARE conflict_count INT;
    DECLARE small_gap_count INT;
    DECLARE large_gap_count INT;
    DECLARE event_start DATETIME;
    DECLARE event_end DATETIME;

    #Check if the performance time between event time#
    SELECT start_time, end_time INTO event_start, event_end
    FROM event
    WHERE event_id = NEW.event_id;

    IF NOT NEW.start_time >= event_start AND NEW.start_time <= event_end
    AND NEW.end_time >= event_start AND NEW.end_time <= event_end THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mismatch performance time with event time';
    END IF;

    #Check for overlapping performances in the same event.#
    SELECT COUNT(*) INTO conflict_count
    FROM performance
    WHERE event_id = NEW.event_id
      AND (NEW.start_time < end_time AND NEW.end_time > start_time);

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The new performance overlaps in time with another one in the same event.';
    END IF;

    #Check for breaks shorter than 5 minutes between performances.#
    SELECT COUNT(*) INTO small_gap_count
    FROM performance
    WHERE event_id = NEW.event_id
      AND (
          ABS(TIMESTAMPDIFF(MINUTE, end_time, NEW.start_time)) BETWEEN 1 AND 4
          OR ABS(TIMESTAMPDIFF(MINUTE, NEW.end_time, start_time)) BETWEEN 1 AND 4
      );

    IF small_gap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The gap between performances must be at least 5 minutes';
    END IF;

    #Check for breaks > 30 minutes between performances (before or after)#
    SELECT COUNT(*) INTO large_gap_count
    FROM performance
    WHERE event_id = NEW.event_id
      AND (
          (NEW.start_time > end_time AND TIMESTAMPDIFF(MINUTE, end_time, NEW.start_time) > 30)
          OR
          (NEW.end_time < start_time AND TIMESTAMPDIFF(MINUTE, NEW.end_time, start_time) > 30)
      );

    IF (SELECT COUNT(*) FROM performance WHERE event_id = NEW.event_id) > 0 AND large_gap_count = (SELECT COUNT(*) FROM performance WHERE event_id = NEW.event_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The break must not exceed 30 minutes between performances.';
    END IF;
END//
DELIMITER ;

--TRIGGER 4
--event cannot be deleted
DELIMITER //
DROP TRIGGER IF EXISTS trg_prevent_event_deletion;
CREATE TRIGGER trg_prevent_event_deletion
BEFORE DELETE ON event
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Events cannot be deleted';
END//
DELIMITER ;


--TRIGGER 5
--festival cannot be deleted
DELIMITER //
DROP TRIGGER IF EXISTS trg_prevent_festival_deletion;
CREATE TRIGGER trg_prevent_festival_deletion
BEFORE DELETE ON festival
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Festivals cannot be deleted';
END//
DELIMITER ;


--TRIGGER 6
--check for overalp of artists_performance and max consecutive years
DELIMITER //
DROP TRIGGER IF EXISTS trg_check_artist_band_constraints;
CREATE TRIGGER trg_check_artist_band_constraints
BEFORE INSERT ON performance_artist
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;
    DECLARE spec_start_time DATETIME;
    DECLARE spec_end_time DATETIME;
    DECLARE unique_key INT;
    DECLARE current_year INT;
    DECLARE year_exists INT;
    DECLARE consecutive_years INT;

    #first check primary key uniqueness and after that continue to other triggers#
    SELECT COUNT(*) INTO unique_key
    FROM performance_artist
    WHERE performance_id = NEW.performance_id AND artist_id = NEW.artist_id;
    
    IF unique_key > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insert of a duplicate';
    END IF;

    SELECT start_time, end_time, YEAR(start_time) INTO spec_start_time, spec_end_time, current_year
    FROM performance
    WHERE performance_id = NEW.performance_id;

     
    #1.Check for overlap on different stages at the same time#
    SELECT COUNT(*) INTO overlap_count
    FROM performance_artist pa
    JOIN performance p ON pa.performance_id = p.performance_id
    WHERE pa.artist_id = NEW.artist_id
    AND (spec_start_time < p.end_time AND spec_end_time > p.start_time);


    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Artist cannot perform on two stages at the same time';
    END IF;
    

    #2.Check for more than 3 consecutive years of participation#
    -- Βρίσκουμε το έτος του φεστιβάλ για το οποίο γίνεται η ανάθεση
    SELECT f.year INTO current_year
    FROM performance p
    JOIN event e ON p.event_id = e.event_id
    JOIN festival f ON e.festival_id = f.festival_id
    WHERE p.performance_id = NEW.performance_id;

    SELECT COUNT(*) INTO year_exists
    FROM performance_artist pa
    JOIN performance p ON pa.performance_id = p.performance_id
    JOIN event e ON p.event_id = e.event_id
    JOIN festival f ON e.festival_id = f.festival_id
    WHERE pa.artist_id = NEW.artist_id AND f.year = current_year;
    
    -- Ελέγχουμε αν ο καλλιτέχνης έχει συμμετάσχει σε 3 ή περισσότερα συνεχή έτη
    WITH temp AS (
        SELECT DISTINCT f.year
        FROM performance_artist pa
        JOIN performance p ON pa.performance_id = p.performance_id
        JOIN event e ON p.event_id = e.event_id
        JOIN festival f ON e.festival_id = f.festival_id
        WHERE pa.artist_id = NEW.artist_id
    
        UNION
        
        SELECT current_year AS year  -- Προσθέτουμε το νέο έτος στον έλεγχο
        
        ORDER BY year 
    ),
    artist_years as(
        SELECT DISTINCT year
        FROM temp
        ORDER BY year
    ),
    consecutive_groups AS (
        SELECT 
            year,
            year - ROW_NUMBER() OVER (ORDER BY year) AS grp
        FROM artist_years
    )
    SELECT MAX(cnt) INTO consecutive_years
    FROM (
        SELECT COUNT(*) AS cnt
        FROM consecutive_groups
        GROUP BY grp
    ) AS counts;
    
    -- Αν βρεθούν 3 ή περισσότερα συνεχή έτη, απορρίπτουμε την εισαγωγή
    IF consecutive_years > 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Artist cannot participate for more than 3 consecutive years';
    END IF;
END//
DELIMITER ;

--TRIGGER 7
--check not to surpass stage capacity and vip percentage
DELIMITER //
DROP TRIGGER IF EXISTS check_stage_capacity;
CREATE TRIGGER check_stage_capacity
BEFORE INSERT ON ticket
FOR EACH ROW
BEGIN
    DECLARE event_end_time DATETIME;
    DECLARE event_start_time DATETIME;
    DECLARE current_capacity INT;
    DECLARE stage_capacity INT;
    DECLARE vip_count INT;
    DECLARE message varchar(300);
    
    #Purchase time after the end of the event#
    SELECT end_time INTO event_end_time
    FROM event
    WHERE event_id = NEW.event_id;

    IF TIMESTAMPDIFF(MINUTE, NEW.purchase_time, event_end_time) < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The event has ended. You can not buy a ticket';
    END IF;

    SELECT start_time INTO event_start_time
    FROM event
    WHERE event_id = NEW.event_id;

    #inactive before the start of the event#
    IF TIMESTAMPDIFF(MINUTE, NOW(), event_start_time) > 0 AND NOT NEW.active THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A ticket can not be inactive before the start of the event';
    END IF;

    #Find how many tickets already exist for this event#
    SELECT COUNT(*) INTO current_capacity
    FROM ticket
    WHERE event_id = NEW.event_id;

    #Find the stage capacity for the event#
    SELECT s.max_capacity INTO stage_capacity
    FROM event e
    JOIN stage s ON e.stage_id = s.stage_id
    WHERE e.event_id = NEW.event_id;

    #Check if the capacity is exceeded#
    IF current_capacity >= stage_capacity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Max attendance has achieved. It is not possible to sell more tickets';
    END IF;  

    IF NEW.category = 'vip' THEN
        SELECT COUNT(*) INTO vip_count
        FROM ticket
        WHERE event_id = NEW.event_id AND category = 'vip';

        IF vip_count >= FLOOR(stage_capacity * 0.10) THEN
            SET message=CONCAT('Limit for VIP tickets has been reached. Event ID: ', NEW.event_id);
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = message;
        END IF;
    END IF;
END//
DELIMITER ;




--TRIGGER 8
--check if the seller is valid and it is time for resale
DELIMITER //
DROP TRIGGER IF EXISTS new_resale_queue;
CREATE TRIGGER new_resale_queue
BEFORE INSERT ON resale_queue
FOR EACH ROW
BEGIN
    DECLARE ticket_valid INT;
    DECLARE current_event INT;
    DECLARE stage_capacity INT;
    DECLARE current_capacity INT;
    DECLARE valid_comb_ticket_seller INT;
    DECLARE event_end_time DATETIME;
    DECLARE last_purchase_time DATETIME;
    
    #check if the specific ticket belongs to this visitor#
    SELECT COUNT(*) INTO valid_comb_ticket_seller
    FROM ticket
    WHERE ticket_id = NEW.ticket_id AND visitor_id = NEW.visitor_id;

    IF valid_comb_ticket_seller = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Seller does not possess this ticket';
    END IF; 

    #check if the resale queue for this event has opened#
    SELECT event_id INTO current_event
    FROM ticket 
    WHERE ticket_id = NEW.ticket_id;

    SELECT s.max_capacity INTO stage_capacity
    FROM event e
    JOIN stage s ON e.stage_id = s.stage_id
    WHERE e.event_id = current_event;

    SELECT COUNT(*) INTO current_capacity
    FROM ticket
    WHERE event_id = current_event;

    IF current_capacity < stage_capacity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Max attendance has not been achieved. It is not possible to sell tickets';
    END IF; 

    #check if the event has ended before visitor enters resale queue#
    SELECT end_time INTO event_end_time
    FROM event 
    WHERE event_id = current_event;
    
    IF TIMESTAMPDIFF(MINUTE, NEW.request_time, event_end_time) < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Event has ended. Ticket cannot be sold';
    END IF; 

    #check the request_time to be after the purchase_time of the last ticket#
    SELECT purchase_time INTO last_purchase_time
    FROM ticket
    WHERE event_id = current_event
    ORDER BY purchase_time DESC 
    LIMIT 1;

    IF TIMESTAMPDIFF(MINUTE, last_purchase_time, NEW.request_time) < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You cannot sell a ticket yet';
    END IF; 

    #check if the ticket for sale has been used already#
    SELECT COUNT(*) INTO ticket_valid 
    FROM ticket 
    WHERE ticket_id = NEW.ticket_id AND visitor_id = NEW.visitor_id AND active = FALSE;

    IF ticket_valid > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Seller tries to sell an inactive ticket';
    END IF;
END//
DELIMITER ;

-- PROCEDURE 2
-- After entering the seller, we check for an available buyer
DELIMITER //
DROP PROCEDURE IF EXISTS MatchResaler;
CREATE PROCEDURE MatchResaler (
    IN s_resale_id INT,
    IN s_ticket_id INT,          
    IN s_visitor_id INT    
)
BEGIN

    DECLARE b_buyer_id INT;
    DECLARE b_visitor_id INT;
    DECLARE b_ticket_id INT;
    DECLARE b_event_id INT;
    DECLARE b_category VARCHAR(50);
    DECLARE b_new_visitor_id INT;
    DECLARE b_buyer_name VARCHAR(100);
    DECLARE b_age INT;

    SELECT t.event_id, t.category INTO b_event_id, b_category
    FROM ticket t WHERE t.ticket_id = s_ticket_id;

    SELECT buyer_id, visitor_id, buyer_name, age INTO b_buyer_id, b_visitor_id, b_buyer_name, b_age
    FROM buyer_interest_queue
    WHERE is_fulfilled = FALSE
      AND (
           (ticket_id IS NOT NULL AND ticket_id = s_ticket_id)
           OR
           (event_id = b_event_id AND category = b_category)
      )
    ORDER BY request_time ASC
    LIMIT 1;

    IF b_buyer_id IS NOT NULL THEN
        IF b_visitor_id IS NULL THEN 
            INSERT INTO visitor(visitor_name, age) VALUES(b_buyer_name, b_age);
            SELECT LAST_INSERT_ID() INTO b_new_visitor_id;
        ELSE
            SET b_new_visitor_id = b_visitor_id;
        END IF;

        UPDATE ticket
        SET visitor_id = b_new_visitor_id
        WHERE ticket_id = s_ticket_id;

        UPDATE resale_queue SET is_completed = TRUE WHERE resale_id = s_resale_id;
        UPDATE buyer_interest_queue SET is_fulfilled = TRUE WHERE buyer_id = b_buyer_id AND is_fulfilled = FALSE;
    END IF;
END//
DELIMITER ;

--PROCEDURE 3/insert in resale_queue and check for available match with buyer
DELIMITER //
DROP PROCEDURE IF EXISTS my_insert_resaler;
CREATE PROCEDURE my_insert_resaler (
    IN s_ticket_id INT,
    IN s_visitor_id INT,
    IN s_request_time DATETIME
)
BEGIN 
    DECLARE last_id INT;

    INSERT INTO resale_queue (ticket_id, visitor_id, request_time) VALUES (s_ticket_id, s_visitor_id, s_request_time);
    SELECT LAST_INSERT_ID() INTO last_id;
    CALL MatchResaler(last_id, s_ticket_id, s_visitor_id);
END//
DELIMITER ;


--TRIGGER 9
--We check if the buyer is valid / if they belong to the visitors, we verify their ID
DELIMITER //
DROP TRIGGER IF EXISTS new_buyer;
CREATE TRIGGER new_buyer
BEFORE INSERT ON buyer_interest_queue
FOR EACH ROW
BEGIN
    DECLARE buyer_visitor_valid INT;
    DECLARE ticket_for_sale INT;
    DECLARE current_capacity INT;
    DECLARE stage_capacity INT;
    DECLARE last_purchase_time DATETIME;
    DECLARE event_end_time DATETIME;
    DECLARE flag INT;
    DECLARE current_event INT;

    IF NOT (NEW.ticket_id IS NOT NULL OR (NEW.event_id IS NOT NULL AND NEW.category IS NOT NULL)) THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough information to buy a ticket';
    END IF;

    IF NEW.visitor_id IS NOT NULL THEN 
        SELECT COUNT(*) INTO buyer_visitor_valid
        FROM visitor
        WHERE visitor_id = NEW.visitor_id AND visitor_name = NEW.buyer_name;

        IF buyer_visitor_valid = 0 THEN 
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid match between buyer and visitor';
        END IF;
    END IF;


    IF NEW.ticket_id IS NOT NULL THEN 
        IF NEW.visitor_id IS NOT NULL THEN
            SELECT event_id INTO current_event
            FROM ticket 
            WHERE ticket_id = NEW.ticket_id;

            SELECT COUNT(*) INTO flag
            FROM ticket t 
            JOIN event e ON t.event_id = e.event_id
            WHERE t.visitor_id = NEW.visitor_id AND e.event_id = current_event;

            IF flag > 0 THEN 
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Buyer has already a ticket for this event';
            END IF;
        END IF;

        SELECT COUNT(*) INTO ticket_for_sale
        FROM resale_queue
        WHERE ticket_id = NEW.ticket_id;

        IF ticket_for_sale = 0 THEN 
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'This specific ticket is not for sale.';
        END IF;
    END IF;

    IF NEW.event_id IS NOT NULL THEN
        IF NEW.visitor_id IS NOT NULL THEN
            SELECT COUNT(*) INTO FLAG 
            FROM ticket 
            WHERE event_id = NEW.event_id AND visitor_id = NEW.visitor_id;

            IF flag > 0 THEN 
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Buyer has already a ticket for this event';
            END IF;
        END IF;

        SELECT s.max_capacity INTO stage_capacity
        FROM event e
        JOIN stage s ON e.stage_id = s.stage_id
        WHERE e.event_id = NEW.event_id;

        SELECT COUNT(*) INTO current_capacity
        FROM ticket
        WHERE event_id = NEW.event_id;

        IF current_capacity < stage_capacity THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Max attendance has not been achieved. There is no resale queue available for this event';
        END IF;

        #check if the event has ended before buyer enters buyer_interest queue#
        SELECT end_time INTO event_end_time
        FROM event 
        WHERE event_id = NEW.event_id;
        
        IF TIMESTAMPDIFF(MINUTE, NEW.request_time, event_end_time) < 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Event has ended. Buyer cannot buy ticket for this event';
        END IF; 

        #check the request_time to be after the purchase_time of the last ticket#
        SELECT purchase_time INTO last_purchase_time
        FROM ticket
        WHERE event_id = NEW.event_id
        ORDER BY purchase_time DESC 
        LIMIT 1;

        IF TIMESTAMPDIFF(MINUTE, last_purchase_time, NEW.request_time) < 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'You cannot buy a ticket yet';
        END IF; 
    END IF;
END//
DELIMITER ;

-- PROCEDURE 4
-- After entering the buyer, we check for an available seller#
DELIMITER //
DROP PROCEDURE IF EXISTS MatchBuyer;
CREATE PROCEDURE MatchBuyer ( 
    IN b_buyer_id INT,
    IN b_buyer_name VARCHAR(100),
    IN b_age INT,
    IN b_visitor_id INT,
    IN b_ticket_id INT,
    IN b_event_id INT,
    IN b_category VARCHAR(100)
)

BEGIN
    DECLARE r_resale_id INT;
    DECLARE r_visitor_id INT;
    DECLARE r_ticket_id INT;

    IF b_ticket_id IS NOT NULL THEN

        SELECT resale_id, visitor_id, ticket_id INTO r_resale_id, r_visitor_id, r_ticket_id
        FROM resale_queue
        WHERE is_completed = FALSE
        AND b_ticket_id = ticket_id
        LIMIT 1;

    ELSE 

        SELECT rq.resale_id, rq.visitor_id, rq.ticket_id INTO r_resale_id, r_visitor_id, r_ticket_id
        FROM resale_queue rq 
        JOIN ticket t ON rq.ticket_id = t.ticket_id
        WHERE  rq.is_completed = FALSE
        AND (
            b_event_id = t.event_id AND 
            b_category = t.category 
        )
        ORDER BY rq.request_time
        LIMIT 1;

    END IF;

    IF r_resale_id IS NOT NULL THEN 
        IF b_visitor_id IS NULL THEN 
            INSERT INTO visitor(visitor_name, age) VALUES(b_buyer_name, b_age);
            SELECT LAST_INSERT_ID() INTO b_visitor_id;
        END IF;

        UPDATE ticket
        SET visitor_id = b_visitor_id
        WHERE ticket_id = r_ticket_id;

        UPDATE resale_queue SET is_completed = TRUE WHERE resale_id = r_resale_id;
        UPDATE buyer_interest_queue SET is_fulfilled = TRUE WHERE buyer_id = b_buyer_id AND is_fulfilled = FALSE;
    END IF;
END// 
DELIMITER ;

--PROCEDURE 5/insert in buyer_interest_queue and check for available match with seller
DELIMITER //
DROP PROCEDURE IF EXISTS my_insert_buyer_interest_queue;
CREATE PROCEDURE my_insert_buyer_interest_queue (
    IN b_buyer_name VARCHAR(100),
    IN b_age INT,
    IN b_visitor_id INT,
    IN b_ticket_id INT,
    IN b_event_id INT,
    IN b_category VARCHAR(100),
    IN b_request_time DATETIME
)
BEGIN 
    DECLARE last_id INT;

    INSERT INTO buyer_interest_queue (buyer_name, age, visitor_id, ticket_id, event_id, category, request_time) VALUES
    (b_buyer_name, b_age, b_visitor_id, b_ticket_id, b_event_id, b_category, b_request_time);
    SELECT LAST_INSERT_ID() INTO last_id;
    CALL MatchBuyer(last_id, b_buyer_name, b_age, b_visitor_id, b_ticket_id, b_event_id, b_category);
END//
DELIMITER ;


--TRIGGER 10
--check for valid review
DELIMITER //
DROP TRIGGER IF EXISTS valid_review;
CREATE TRIGGER valid_review BEFORE INSERT ON review
FOR EACH ROW
BEGIN
    DECLARE review_for_event INT;
    DECLARE valid_review INT;

    SELECT event_id INTO review_for_event
    FROM performance 
    WHERE performance_id = NEW.performance_id;

    SELECT COUNT(*) INTO valid_review
    FROM ticket 
    WHERE event_id = review_for_event AND visitor_id = NEW.visitor_id AND active = FALSE;

    IF valid_review = 0 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid review';
    END IF;
END//
DELIMITER ;





