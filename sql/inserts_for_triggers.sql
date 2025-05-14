--TRIGGER 1/ημερομηνίες event έξω από τις ημερομηνίες κάποιου φεστιβάλ
INSERT INTO event (festival_id, stage_id, event_name, start_time, end_time) VALUES
(1, 30, 'test_event', '2016-06-13 9', '2016-06-13 10');
--TRIGGER 1/ταυτόχρονη χρήση stage από δύο events
INSERT INTO event (festival_id, stage_id, event_name, start_time, end_time) VALUES
(1, 1, 'test_event', '2016-06-10 9:30:00', '2016-06-10 10:40:00');
--TRIGGER 1/υπερβαίνει το ημερήσιο όριο του φεστιβάλ σε διάρκεια
INSERT INTO event (festival_id, stage_id, event_name, start_time, end_time) VALUES
(1, 30, 'test_event', '2016-06-10 23:30:00', '2016-06-10 23:40:00');



--TRIGGER 2/ταυτόχρονη παρουσία προσωπικού
INSERT INTO event (festival_id, stage_id, event_name, start_time, end_time) VALUES      #προσθήκη event την ίδια ωρα#
(1, 30, 'test_event', '2016-06-10 9', '2016-06-10 10');     
INSERT INTO staff_event (staff_id, event_id) VALUES
(1, 51);  #ριξε το 52 σε 51 και γενικα ολα ενα κατω#
--TRIGGER 2/Ένας τεχνικός με παραπάνω από 2 αναθέσεις την ίδια μέρα
INSERT INTO event (festival_id, stage_id, event_name, start_time, end_time) VALUES      #προσθήκη event την ίδια μέρα άλλη ώρα#
(1, 29, 'test_event', '2016-06-10 13', '2016-06-10 14');
INSERT INTO staff_event (staff_id, event_id) VALUES         #2η ανάθεση του τεχνικού 1 για την ίδια ημέρα#
(1, 52);
INSERT INTO staff_event (staff_id, event_id) VALUES         #3η ανάθεση του τεχνικού 1 για την ίδια ημέρα#
(1, 2);


--PROCEDURE 1/Υποστελεχωμένο event


--TRIGGER 3/Το performance εκτός των ωρών του event στο οποίο ανήκει
INSERT INTO performance (event_id, type_of_performance, start_time, end_time) VALUES
(1, 'warm up', '2016-06-10 8:10:00', '2016-06-10 9:20:00');
--TRIGGER 3/Ταυτόχρονα performances
INSERT INTO performance (event_id, type_of_performance, start_time, end_time) VALUES
(1, 'warm up', '2016-06-10 9:10:00', '2016-06-10 9:20:00');
--TRIGGER 3/Break μικρότερο από 5 minutes
INSERT INTO performance (event_id, type_of_performance, start_time, end_time) VALUES
(1, 'warm up', '2016-06-10 9:32:00', '2016-06-10 9:35:00');
--TRIGGER 3/Break μεγαλύτερο από 30 minutes
INSERT INTO performance (event_id, type_of_performance, start_time, end_time) VALUES
(51, 'warm up', '2016-06-10 9:00:00', '2016-06-10 9:20:00');  #52 θα γινει 51# 
INSERT INTO performance (event_id, type_of_performance, start_time, end_time) VALUES
(51, 'warm up', '2016-06-10 10:10:00', '2016-06-10 10:20:00');

--TRIGGER 4/Διαγραφή event
delete from event where event_id = 1;

--TRIGGER 5/Διαγραφή festival
delete from festival where festival_id = 1;


--TRIGGER 6/Artist εμφανίζεται ταυτόχρονα σε δύο σκηνές
INSERT INTO performance_artist(performance_id, artist_id) VALUES (101, 1);
--TRIGGER 6/Artist εμφανίζεται ταυτόχρονα σε δύο σκηνές*****
--αυτό εμφανίζει για όλους τους artists τα χρονια συμμετοχής
SELECT pa.artist_id,
GROUP_CONCAT(DISTINCT YEAR(p.start_time))
FROM performance_artist pa
JOIN performance p ON pa.performance_id = p.performance_id
GROUP BY pa.artist_id;
--αυτο θα σκασει γιατι ξεπερνα τα 3 συνεχομενα χρονια συμμετοχης
INSERT INTO performance_artist(performance_id, artist_id) VALUES (41, 30);

--TRIGGER 7/Αγορά εισιτηρίου μετά την λήξη του event 
INSERT INTO ticket (EAN13, event_id, visitor_id, purchase_time, cost, purchase_method, category, active) VALUES
('1234567890098', 1, 24, '2017-10-20 10:30:00', 55.00, 'credit_card', 'general_admission', FALSE);
--TRIGGER 7/Επικύρωση εισιτηρίου πριν την έναρξη του event 
INSERT INTO ticket (EAN13, event_id, visitor_id, purchase_time, cost, purchase_method, category, active) VALUES
('1234567890097', 50, 24, '2027-02-03 14:20:00', 110.00, 'bank_account', 'backstage', FALSE);
--TRIGGER 7/Τα εισιτήρια δεν υπερβαίνουν το max capaxity του stage
INSERT INTO stage (stage_name, description, max_capacity) VALUES  #εισαγωγή stage(31) με χωρητικότητα 1#
('test_stage', 'beautifull', 1);
INSERT INTO event (festival_id, stage_id, event_name, start_time, end_time) VALUES  #εισαγωγή event στο stage 31#
(1, 31, 'test_event', '2016-06-10 9', '2016-06-10 10');
INSERT INTO ticket (EAN13, event_id, visitor_id, purchase_time, cost, purchase_method, category, active) VALUES   #1o εισιτήριο/περνάει#
('1234567890096', 53, 1, '2015-10-20 10:30:00', 30, 'non_cash', 'general_admission', FALSE);  
INSERT INTO ticket (EAN13, event_id, visitor_id, purchase_time, cost, purchase_method, category, active) VALUES    #2o εισιτήριο/ δεν περνάει#
('1234567890095', 53, 2, '2015-10-20 10:30:00', 30, 'non_cash', 'general_admission', FALSE);
--TRIGGER 7/Τα vip εισιτήρια δεν υπερβαίνουν το 10% του max capaxity του stage
INSERT INTO event (festival_id, stage_id, event_name, start_time, end_time) VALUES  #εισαγωγή event στο stage 31#
(1, 31, 'test_event', '2016-06-10 10:30:00', '2016-06-10 11');
INSERT INTO ticket (EAN13, event_id, visitor_id, purchase_time, cost, purchase_method, category, active) VALUES  #εισιτήριο vip που ξεπερνάει το 10%#
('1234567890094', 54, 1, '2015-10-20 10:30:00', 30, 'non_cash', 'vip', FALSE); 

--TRIGGER 8/ο seller δεν έχει το συγκεκριμένο εισιτήριο
call my_insert_resaler(1, 2, '2015-06-06 9');
--TRIGGER 8/Η ουρά δεν έχει ανοίξει ακόμα/δεν έχουν πωληθεί όλα τα εισιτήρια
call my_insert_resaler(1, 1, '2015-06-06 9');
--TRIGGER 8/Η ουρά δεν έχει ανοίξει ακόμα/seller διαθέτει εισιτήριο πριν πωληθεί το τελευταίο
call my_insert_resaler(225, 1, '2014-06-06 9');
--TRIGGER 8/Seller διαθέτει εισιτήριο για event το οποίο έχει τελειώσει
call my_insert_resaler(225, 1, '2017-06-06 9');
--TRIGGER 8/Seller διαθέτει εισιτήριο το οποίο είναι inactive
call my_insert_resaler(225, 1, '2016-06-07 9');

--TRIGGER 9/ο buyer δεν παρέχει πληροφορία αρκετή
call my_insert_buyer_interest_queue('MIKE', 89, NULL, NULL, NULL, NULL, '2016-06-07 9');
--TRIGGER 9/ο buyer δεν είναι ακόμα visitor/ο buyer είναι visitor και έχει λάθος id
call my_insert_buyer_interest_queue('MIKE', 89, 1, 1, NULL, NULL, '2016-06-07 9');
call my_insert_buyer_interest_queue('Alice Johnson', 28, 20, 20, NULL, NULL, '2016-06-07 9');
--TRIGGER 9/ο buyer ζητάει συγκεκριμένο εισιτήριο που δεν είναι προς πώληση
call my_insert_buyer_interest_queue('MIKE', 89, NULL, 225, NULL, NULL, '2016-06-07 9');
--TRIGGER 9/Ο buyer ψάχνει ticket για ένα event που δεν έχει ανοίξει το queue του
call my_insert_buyer_interest_queue('MIKE', 89, NULL, NULL, 1, 'vip', '2016-06-07 9');
--TRIGGER 9/Ο buyer ζητάει εισιτήριο για event που έχει λήξει
call my_insert_buyer_interest_queue('MIKE', 89, NULL, NULL, 53, 'vip', '2017-06-07 9');
--TRIGGER 9/Ο buyer ζητάει εισιτήριο για ένα event πριν από την πώληση του τελευταίου εισιτηρίου για το event
call my_insert_buyer_interest_queue('MIKE', 89, NULL, NULL, 53, 'vip', '2015-10-20 10:29:00');
--TRIGGER 9/Ο buyer πάει να αγοράσει εισιτήριο για event που ήδη έχει εισιτήριο
call my_insert_buyer_interest_queue('Alice Johnson', 28, 1, NULL, 1, 'general_admission', '2016-6-9 10:29:00');

--Σύστημα αγοραπωλησίας
--Δύο sellers για το ίδιο event με άλλη ώρα διάθεσης εισιτηρίου και ένας αγοραστής
UPDATE stage  SET max_capacity = 2 WHERE stage_id = 31; #max_capacity = 2 για stage_id = 31#
UPDATE ticket SET active = TRUE WHERE ticket_id = 225;      #active=TRUE για το 1ο εισιτήριο σε event=53 στο stage 31#
INSERT INTO ticket (EAN13, event_id, visitor_id, purchase_time, cost, purchase_method, category, active) VALUES #εισαγωγή 2ο εισιτήριο σε event=53 στο stage 31#  
('1234567890095', 53, 2, '2015-10-20 10:30:00', 30, 'non_cash', 'general_admission', TRUE);
call my_insert_resaler(225, 1, '2016-06-07 9');
call my_insert_resaler(226, 2, '2016-06-08 9');
call my_insert_buyer_interest_queue('MIKE', 89, NULL, NULL, 53, 'general_admission', '2016-6-9 10:29:00');


--Δύο buyers για το ίδιο event με άλλη ώρα εκδήλωσης ενδιαφέροντος και ένας seller
TRUNCATE resale_queue;
TRUNCATE buyer_interest_queue;
call my_insert_buyer_interest_queue('MIKE_JANA', 90, NULL, NULL, 53, 'general_admission', '2016-6-9 10:29:00');
call my_insert_buyer_interest_queue('THANOS', 95, NULL, NULL, 53, 'general_admission', '2016-6-9 10:27:00');
call my_insert_resaler(225, 101, '2016-06-07 9');

--TRIGGER 10/Review από visitor που δεν έχει εισιτήριο για το συγκεκριμένο performance
INSERT INTO review (visitor_id, performance_id, artist_performance, sound_lighting, stage_presence, organization, overall_impression) VALUES
(1, 20, 1, 1, 1, 1, 1);
--TRIGGER 10/Review από visitor που έχει εισιτήριο για το συγκεκριμένο performance αλλά δεν το έχει επικυρώσει 
INSERT INTO review (visitor_id, performance_id, artist_performance, sound_lighting, stage_presence, organization, overall_impression) VALUES
(3, 1, 1, 1, 1, 1, 1);








