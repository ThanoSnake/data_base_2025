#location/10#
INSERT INTO location (address, latitude, longitude, city, country, continent) VALUES
('1600 Amphitheatre Parkway', 37.422, -122.084, 'Mountain View', 'United States', 'North America'),
('10 Downing Street', 51.503, -0.127, 'London', 'United Kingdom', 'Europe'),
('1 Chome-1-2 Oshiage', 35.710, 139.810, 'Tokyo', 'Japan', 'Asia'),
('Plaça de Catalunya', 41.387, 2.170, 'Barcelona', 'Spain', 'Europe'),
('Brandenburg Gate', 52.516, 13.378, 'Berlin', 'Germany', 'Europe'),
('Opera House', -33.857, 151.215, 'Sydney', 'Australia', 'Australia'),
('Zócalo', 19.434, -99.133, 'Mexico City', 'Mexico', 'North America'),
('Union Buildings', -25.746, 28.187, 'Pretoria', 'South Africa', 'Africa'),
('Red Square', 55.755, 37.617, 'Moscow', 'Russia', 'Europe'),
('Christ the Redeemer', -22.952, -43.210, 'Rio de Janeiro', 'Brazil', 'South America');

#festival/10#
INSERT INTO festival (location_id, festival_name, start_date, end_date) VALUES
(1, 'TechWorld Summit', '2016-06-10', '2016-06-12'),
(2, 'London Arts Festival', '2018-07-01', '2018-07-05'),
(3, 'Tokyo Light Festival', '2020-03-15', '2020-03-20'),
(4, 'Barcelona Music Fiesta', '2021-09-10', '2021-09-13'),
(5, 'Berlin Film Festival', '2019-02-10', '2019-02-20'),
(6, 'Sydney Harbour Show', '2022-01-01', '2022-01-03'),
(7, 'Mexico Day Parade', '2017-11-20', '2017-11-21'),
(8, 'Heritage Festival SA', '2023-04-27', '2023-04-30'),
(9, 'Moscow Ice Carnival', '2026-12-10', '2026-12-15'),
(10, 'Rio Carnival Beats', '2027-02-15', '2027-02-20');


#stage/30#
INSERT INTO stage (stage_name, description, max_capacity) VALUES
('Main Stage', 'The central stage for headlining acts.', 100),
('Echo Arena', 'Known for its superb acoustics and lighting.', 135),
('Sunset Pavilion', 'Open-air stage best for evening performances.', 150),
('Bass Yard', 'Heavy bass and EDM-focused performances.', 120),
('Acoustic Garden', 'Intimate setting for acoustic sets.', 130),
('Fire Dome', 'Enclosed stage with pyrotechnic shows.', 140),
('Chill Vibes Tent', 'Relaxed atmosphere with ambient music.', 110),
('Folk Forest', 'Woodland stage dedicated to folk artists.', 100),
('Rock Ridge', 'Dedicated to rock and metal bands.', 170),
('Dance Hall', 'Indoor venue with state-of-the-art lighting.', 130),
('Sky Stage', 'Elevated stage with panoramic views.', 130),
('Neon Grove', 'Colorful, neon-lit stage for electronic music.', 120),
('Roots Corner', 'Showcasing world and cultural music.', 170),
('Jazz Lounge', 'Smooth jazz and blues sessions.', 100),
('Rap Vault', 'Urban-themed venue for hip hop artists.', 110),
('Indie Hill', 'Featuring independent and emerging artists.', 130),
('Global Beats Arena', 'Stage for international music acts.', 110),
('The Circle', '360-degree immersive stage experience.', 150),
('Vibe Stage', 'Multi-genre stage with shifting vibes.', 145),
('Zen Stage', 'Chill-out zone with meditation and soft music.', 115),
('Fusion Point', 'Mix of electronic, jazz, and experimental genres.', 130),
('Underground Hub', 'Dark, gritty stage for alternative styles.', 110),
('Open Mic Grove', 'Stage for new talent and live submissions.', 130),
('Lyrical Lounge', 'Focus on lyrical and spoken word performances.', 120),
('Tempo Tent', 'Fast-paced sets, DJs, and dance battles.', 100),
('Classic Stage', 'Orchestral and classical music features.', 120),
('Electric Forest', 'Psychedelic visuals and synth-heavy music.', 140),
('Pulse Zone', 'High-energy acts with booming sound systems.', 100),
('Sonic Bay', 'Stage surrounded by water and sound installations.', 130),
('Harmony Hall', 'Blends classical with modern crossover genres.', 110);


#event/50#
-- Event inserts grouped by festival, distributed across multiple days, ensuring stage_id is within 1-30
INSERT INTO event (festival_id, stage_id, event_name, start_time, end_time) VALUES

-- Festival 1: TechWorld Summit (June 10, 2016 - June 12, 2016)
-- Day 1
(1, 1, 'Opening Soundwaves: Electronic Beats', '2016-06-10 09:00:00', '2016-06-10 10:40:00'),
(1, 2, 'The Sound of Future Tech: Synthwave Live', '2016-06-10 11:00:00', '2016-06-10 12:40:00'),
-- Day 2
(1, 3, 'Virtual Reality Soundscapes: Interactive Beats', '2016-06-11 09:00:00', '2016-06-11 10:40:00'),
(1, 4, 'Quantum Sound: Music of the Future', '2016-06-11 11:00:00', '2016-06-11 12:40:00'),
-- Day 3
(1, 5, 'Techno-Tronica: A Sonic Experience', '2016-06-12 09:00:00', '2016-06-12 10:40:00'),

-- Festival 2: London Arts Festival (July 1, 2018 - July 5, 2018)
-- Day 1
(2, 6, 'Strings of the Past: Classical Fusion', '2018-07-01 09:00:00', '2018-07-01 10:30:00'),
(2, 7, 'Jazz and Blues Rhythms: A Live Jam Session', '2018-07-01 11:00:00', '2018-07-01 12:30:00'),
-- Day 2
(2, 8, 'Folk Melodies in the Air', '2018-07-02 09:00:00', '2018-07-02 10:30:00'),
(2, 9, 'The Beat of the City: Indie Music Showcase', '2018-07-02 11:00:00', '2018-07-02 12:30:00'),
-- Day 3
(2, 10, 'Ambient Sounds: A Chill-Out Experience', '2018-07-03 09:00:00', '2018-07-03 10:30:00'),

-- Festival 3: Tokyo Light Festival (March 15, 2020 - March 20, 2020)
-- Day 1
(3, 11, 'The Neon Orchestra: Light & Sound', '2020-03-15 09:00:00', '2020-03-15 10:30:00'),
(3, 12, 'Electrosonic Groove: Neon Beats', '2020-03-15 11:00:00', '2020-03-15 12:30:00'),
-- Day 2
(3, 13, 'Techno Dreams: A Digital Soundscape', '2020-03-16 09:00:00', '2020-03-16 10:30:00'),
(3, 14, 'Electro-Light Experiments: VR Music Show', '2020-03-16 11:00:00', '2020-03-16 12:30:00'),
-- Day 3
(3, 15, 'Synthwave Dreams: Retro Future Beats', '2020-03-17 09:00:00', '2020-03-17 10:30:00'),

-- Festival 4: Barcelona Music Fiesta (September 10, 2021 - September 13, 2021)
-- Day 1
(4, 16, 'Rock n Roll Legends Live', '2021-09-10 09:00:00', '2021-09-10 10:30:00'),
(4, 17, 'Classical Melodies: A Grand Symphony', '2021-09-10 11:00:00', '2021-09-10 12:30:00'),
-- Day 2
(4, 18, 'Folk Rhythms: Heartbeat of the Land', '2021-09-11 09:00:00', '2021-09-11 10:30:00'),
(4, 19, 'Indie Grooves: Acoustic Vibes', '2021-09-11 11:00:00', '2021-09-11 12:30:00'),
-- Day 3
(4, 20, 'Electric Pulse: Dance Floor Hits', '2021-09-12 09:00:00', '2021-09-12 10:30:00'),

-- Festival 5: Berlin Film Festival (February 10, 2019 - February 20, 2019)
-- Day 1
(5, 21, 'Cinema Symphony: The Sound of Film', '2019-02-10 09:00:00', '2019-02-10 10:30:00'),
(5, 22, 'Short Films, Big Sounds: A Visual Audio Experience', '2019-02-10 11:00:00', '2019-02-10 12:30:00'),
-- Day 2
(5, 23, 'Documentary Beats: Voices of the World', '2019-02-11 09:00:00', '2019-02-11 10:30:00'),
(5, 24, 'Directors in the Spotlight: Crafting the Soundtrack', '2019-02-11 11:00:00', '2019-02-11 12:30:00'),
-- Day 3
(5, 25, 'Cinematic Strings: Orchestral Music of Film', '2019-02-12 09:00:00', '2019-02-12 10:30:00'),

-- Festival 6: Sydney Harbour Show (January 1, 2022 - January 3, 2022)
-- Day 1
(6, 26, 'Orchestra Under the Stars', '2022-01-01 09:00:00', '2022-01-01 10:30:00'),
(6, 27, 'Harbour Soundscape: New Years Celebration', '2022-01-01 11:00:00', '2022-01-01 12:30:00'),
-- Day 2
(6, 28, 'Global Rhythms: A World Music Extravaganza', '2022-01-02 09:00:00', '2022-01-02 10:30:00'),
(6, 29, 'Jazz by the Water: Live Session', '2022-01-02 11:00:00', '2022-01-02 12:30:00'),
-- Day 3
(6, 30, 'Electro Fireworks: A Sound and Light Spectacle', '2022-01-03 09:00:00', '2022-01-03 10:30:00'),

-- Festival 7: Mexico Day Parade (November 20, 2017 - November 21, 2017)
-- Day 1
(7, 1, 'Mariachi Melody: Live Band Performance', '2017-11-20 09:00:00', '2017-11-20 10:30:00'),
(7, 2, 'Ranchera Rhythms: Mexican Folk Music', '2017-11-20 11:00:00', '2017-11-20 12:30:00'),
-- Day 2
(7, 3, 'Ballet Folklorico: The Dance of Mexico', '2017-11-21 09:00:00', '2017-11-21 10:30:00'),
(7, 4, 'Aztec Drum Circle: Traditional Percussion', '2017-11-21 11:00:00', '2017-11-21 12:30:00'),
(7, 5, 'Viva Mexico: Latin Party Beats', '2017-11-21 13:00:00', '2017-11-21 14:30:00'),
-- Day 3


-- Festival 8: Heritage Festival SA (April 27, 2023 - April 30, 2023)
-- Day 1
(8, 6, 'African Percussion: Rhythms of the Continent', '2023-04-27 09:00:00', '2023-04-27 10:30:00'),
(8, 7, 'Zydeco Blues: The Sound of South Africa', '2023-04-27 11:00:00', '2023-04-27 12:30:00'),
-- Day 2
(8, 8, 'Traditional Sounds of Africa', '2023-04-28 09:00:00', '2023-04-28 10:30:00'),
(8, 9, 'Dance Beats from the South: Afrobeat Party', '2023-04-28 11:00:00', '2023-04-28 12:30:00'),
-- Day 3
(8, 10, 'Soulful Sounds: Gospel and Jazz Fusion', '2023-04-29 09:00:00', '2023-04-29 10:30:00'),

-- Festival 9: Moscow Ice Carnival (December 10, 2026 - December 15, 2026)
-- Day 1
(9, 11, 'Frosty Rhythms: Ice and Music', '2026-12-10 09:00:00', '2026-12-10 10:30:00'),
(9, 12, 'Frozen Beats: A Chill Dance Party', '2026-12-10 11:00:00', '2026-12-10 12:30:00'),
-- Day 2
(9, 13, 'Snow Dance: Winter Groove', '2026-12-11 09:00:00', '2026-12-11 10:30:00'),
(9, 14, 'Ice Orchestra: Classical Meets Cold', '2026-12-11 11:00:00', '2026-12-11 12:30:00'),
-- Day 3
(9, 15, 'Cold Beats: The Freeze Dance Party', '2026-12-12 09:00:00', '2026-12-12 10:30:00'),

-- Festival 10: Rio Carnival Beats (February 15, 2027 - February 20, 2027)
-- Day 1
(10, 16, 'Samba Rhythms: Carnival Kickoff', '2027-02-15 09:00:00', '2027-02-15 10'),
(10, 17, 'Beach Rythms', '2027-02-15 10:30:00', '2027-02-15 11'),
-- Day 2
(10, 18, 'Carnaval Electrónico: Neon Nights', '2027-02-16 09:00:00', '2027-02-16 10'),
(10, 19, 'Football Songs Rhythms', '2027-02-16 10:30:00', '2027-02-16 11'), #same start and time#
-- Day 3
(10, 20, 'Samba Rhythms', '2027-02-17 10:30:00', '2027-02-17 11'); #same event name as Day 1#

#equipment/15#
INSERT INTO equipment (type) VALUES
('Speakers'),
('Lights'),
('Microphones'),
('Mixing Console'),
('Special Effects'),
('Projectors'),
('Cables'),
('Stage Monitors'),
('Fog Machines'),
('Smoke Machines'),
('Strobe Lights'),
('Video Walls'),
('Laser Lights'),
('LED Screens'),
('Stage Risers');

#stage_equipment/41#
INSERT INTO stage_equipment (equipment_id, stage_id, quantity) VALUES
(1, 1, 4),  -- Speakers for stage 1
(2, 1, 8),  -- Lights for stage 1
(3, 1, 5),  -- Microphones for stage 1
(4, 1, 1),  -- Mixing Console for stage 1
(6, 2, 2),  -- Projectors for stage 2
(7, 2, 20), -- Cables for stage 2
(8, 2, 4),  -- Stage Monitors for stage 2
(5, 3, 3),  -- Special Effects for stage 3
(10, 3, 1), -- Smoke Machines for stage 3
(12, 4, 2), -- Strobe Lights for stage 4
(13, 4, 3), -- LED Screens for stage 4
(14, 5, 2), -- Laser Lights for stage 5
(9, 6, 3),  -- Fog Machines for stage 6
(15, 7, 1), -- Stage Risers for stage 7
(1, 8, 6),  -- Speakers for stage 8
(2, 8, 10), -- Lights for stage 8
(3, 9, 7),  -- Microphones for stage 9
(5, 9, 2),  -- Special Effects for stage 9
(4, 10, 1), -- Mixing Console for stage 10
(6, 11, 2), -- Projectors for stage 11
(7, 12, 15),-- Cables for stage 12
(8, 12, 5), -- Stage Monitors for stage 12
(10, 13, 4),-- Smoke Machines for stage 13
(13, 13, 2),-- LED Screens for stage 13
(14, 14, 4),-- Laser Lights for stage 14
(12, 15, 3),-- Strobe Lights for stage 15
(11, 16, 6),-- Video Walls for stage 16
(6, 17, 3), -- Projectors for stage 17
(2, 18, 7), -- Lights for stage 18
(3, 19, 4), -- Microphones for stage 19
(15, 20, 3), -- Stage Risers for stage 20
(8, 21, 6),  -- Stage Monitors for stage 21
(5, 22, 5),  -- Special Effects for stage 22
(1, 23, 10), -- Speakers for stage 23
(13, 24, 2), -- LED Screens for stage 24
(9, 25, 2),  -- Fog Machines for stage 25
(6, 26, 4),  -- Projectors for stage 26
(10, 27, 2), -- Smoke Machines for stage 27
(2, 28, 8),  -- Lights for stage 28
(4, 29, 1),  -- Mixing Console for stage 29
(15, 30, 4); -- Stage Risers for stage 30



#staff/50#
INSERT INTO staff (staff_name, age, role, experience_level, job) VALUES
('Alice Morgan', 29, 'Stage Technician', 'Experienced', 'technical'),
('Ben Carter', 34, 'Lighting Crew', 'Intermediate', 'technical'),
('Chloe Kim', 26, 'Sound Engineer', 'Very Experienced', 'technical'),
('Daniel Reyes', 31, 'Security Supervisor', 'Experienced', 'security'),
('Ella Tran', 22, 'Event Assistant', 'Beginner', 'assistant'),
('Frank Silva', 38, 'Electrician', 'Specialist', 'technical'),
('Grace Liu', 25, 'Stagehand', 'Intermediate', 'technical'),
('Hugo Novak', 41, 'Backstage Manager', 'Very Experienced', 'assistant'),
('Isla Ahmed', 27, 'Volunteer Coordinator', 'Experienced', 'assistant'),
('Jack Nolan', 30, 'Frontline Security', 'Experienced', 'security'),

('Karen Singh', 33, 'First Responder', 'Specialist', 'security'),
('Leo Brooks', 28, 'Rigging Expert', 'Experienced', 'technical'),
('Maya Patel', 24, 'Logistics Assistant', 'Intermediate', 'assistant'),
('Noah Kim', 35, 'Stage Manager', 'Very Experienced', 'technical'),
('Olivia Garcia', 21, 'Entry Gate Assistant', 'Beginner', 'assistant'),
('Paul Zimmer', 43, 'Technical Director', 'Specialist', 'technical'),
('Quinn Harper', 29, 'Security Guard', 'Intermediate', 'security'),
('Riley Thomas', 32, 'LED Display Tech', 'Experienced', 'technical'),
('Sophia Lane', 27, 'Performer Liaison', 'Intermediate', 'assistant'),
('Tariq White', 36, 'Surveillance Officer', 'Very Experienced', 'security'),

('Uma Sanchez', 30, 'Wireless Comms Tech', 'Experienced', 'technical'),
('Victor Li', 39, 'Access Control Lead', 'Very Experienced', 'security'),
('Wendy Zhou', 23, 'Wardrobe Assistant', 'Beginner', 'assistant'),
('Xavier Miles', 40, 'Senior Engineer', 'Specialist', 'technical'),
('Yasmin Omar', 26, 'Crowd Manager', 'Intermediate', 'security'),
('Zane Adler', 28, 'Transport Assistant', 'Intermediate', 'assistant'),
('Amara Bennett', 25, 'Mic Setup Tech', 'Intermediate', 'technical'),
('Brent Owen', 34, 'Emergency Response', 'Experienced', 'security'),
('Carla Dawson', 37, 'Performer Assistant', 'Very Experienced', 'assistant'),
('Derek Lee', 33, 'Truss System Specialist', 'Specialist', 'technical'),

('Eva Brandt', 29, 'Stage Crew', 'Experienced', 'technical'),
('Felix Jones', 31, 'Roving Security', 'Experienced', 'security'),
('Gina Russo', 26, 'Artist Check-in', 'Intermediate', 'assistant'),
('Hank Cooper', 38, 'Electrical Safety Officer', 'Specialist', 'technical'),
('Ines Duarte', 24, 'Registration Desk', 'Beginner', 'assistant'),
('Jonas Meyer', 35, 'Pyro Tech Lead', 'Specialist', 'technical'),
('Kyla Ford', 27, 'Gate Supervisor', 'Experienced', 'security'),
('Lars Becker', 42, 'Audio Systems Lead', 'Very Experienced', 'technical'),
('Marina Costa', 31, 'Artist Runner', 'Experienced', 'assistant'),
('Nico Alvarez', 30, 'Security Rover', 'Intermediate', 'security'),

('Opal Jensen', 29, 'Sound Desk Assistant', 'Intermediate', 'technical'),
('Preston Hale', 33, 'Barrier Control', 'Experienced', 'security'),
('Queenie Sharp', 23, 'Backline Assistant', 'Beginner', 'assistant'),
('Ronan Cook', 36, 'Lighting Director', 'Specialist', 'technical'),
('Sasha Dean', 28, 'Hospitality Host', 'Intermediate', 'assistant'),
('Theo Rojas', 34, 'CCTV Monitor', 'Experienced', 'security'),
('Uma Voss', 27, 'Performer Chaperone', 'Intermediate', 'assistant'),
('Viktor Novak', 39, 'Digital Sound Mixer', 'Specialist', 'technical'),
('Willa Stone', 25, 'Crowd Flow Monitor', 'Beginner', 'security'),
('Xena Li', 22, 'Stage Setup Assistant', 'Beginner', 'technical');

-- Staff Event Assignments
INSERT INTO staff_event (staff_id, event_id) VALUES
(1, 1),
(4, 1),
(11, 1),
(32, 1),
(49, 1),
(28, 1),
(9, 1),
(35, 1),
(2, 2),
(4, 2),
(11, 2),
(32, 2),
(49, 2),
(28, 2),
(25, 2),
(40, 2),
(9, 2),
(35, 2),
(5, 2),
(3, 3),
(4, 3),
(11, 3),
(32, 3),
(49, 3),
(28, 3),
(25, 3),
(40, 3),
(42, 3),
(9, 3),
(35, 3),
(5, 3),
(6, 4),
(4, 4),
(11, 4),
(32, 4),
(49, 4),
(28, 4),
(25, 4),
(9, 4),
(35, 4),
(5, 4),
(7, 5),
(4, 5),
(11, 5),
(32, 5),
(49, 5),
(28, 5),
(25, 5),
(40, 5),
(9, 5),
(35, 5),
(5, 5),
(12, 6),
(4, 6),
(11, 6),
(32, 6),
(49, 6),
(28, 6),
(25, 6),
(40, 6),
(9, 6),
(35, 6),
(5, 6),
(14, 7),
(4, 7),
(11, 7),
(32, 7),
(49, 7),
(28, 7),
(25, 7),
(9, 7),
(35, 7),
(5, 7),
(16, 8),
(4, 8),
(11, 8),
(32, 8),
(49, 8),
(28, 8),
(9, 8),
(35, 8),
(18, 9),
(4, 9),
(11, 9),
(32, 9),
(49, 9),
(28, 9),
(25, 9),
(40, 9),
(42, 9),
(20, 9),
(9, 9),
(35, 9),
(5, 9),
(13, 9),
(21, 10),
(4, 10),
(11, 10),
(32, 10),
(49, 10),
(28, 10),
(25, 10),
(40, 10),
(9, 10),
(35, 10),
(5, 10),
(24, 11),
(4, 11),
(11, 11),
(32, 11),
(49, 11),
(28, 11),
(25, 11),
(40, 11),
(9, 11),
(35, 11),
(5, 11),
(27, 12),
(4, 12),
(11, 12),
(32, 12),
(49, 12),
(28, 12),
(25, 12),
(9, 12),
(35, 12),
(5, 12),
(30, 13),
(4, 13),
(11, 13),
(32, 13),
(49, 13),
(28, 13),
(25, 13),
(40, 13),
(42, 13),
(20, 13),
(9, 13),
(35, 13),
(5, 13),
(13, 13),
(31, 14),
(4, 14),
(11, 14),
(32, 14),
(49, 14),
(28, 14),
(9, 14),
(35, 14),
(34, 15),
(4, 15),
(11, 15),
(32, 15),
(49, 15),
(28, 15),
(25, 15),
(9, 15),
(35, 15),
(5, 15),
(36, 16),
(4, 16),
(11, 16),
(32, 16),
(49, 16),
(28, 16),
(25, 16),
(40, 16),
(9, 16),
(35, 16),
(5, 16),
(38, 17),
(4, 17),
(11, 17),
(32, 17),
(49, 17),
(28, 17),
(25, 17),
(9, 17),
(35, 17),
(5, 17),
(41, 18),
(4, 18),
(11, 18),
(32, 18),
(49, 18),
(28, 18),
(25, 18),
(40, 18),
(42, 18),
(9, 18),
(35, 18),
(5, 18),
(44, 19),
(4, 19),
(11, 19),
(32, 19),
(49, 19),
(28, 19),
(25, 19),
(40, 19),
(42, 19),
(9, 19),
(35, 19),
(5, 19),
(48, 20),
(4, 20),
(11, 20),
(32, 20),
(49, 20),
(28, 20),
(25, 20),
(9, 20),
(35, 20),
(5, 20),
(50, 21),
(4, 21),
(11, 21),
(32, 21),
(49, 21),
(28, 21),
(25, 21),
(40, 21),
(9, 21),
(35, 21),
(5, 21),
(1, 22),
(4, 22),
(11, 22),
(32, 22),
(49, 22),
(28, 22),
(25, 22),
(9, 22),
(35, 22),
(5, 22),
(2, 23),
(4, 23),
(11, 23),
(32, 23),
(49, 23),
(28, 23),
(25, 23),
(40, 23),
(9, 23),
(35, 23),
(5, 23),
(3, 24),
(4, 24),
(11, 24),
(32, 24),
(49, 24),
(28, 24),
(25, 24),
(9, 24),
(35, 24),
(5, 24),
(6, 25),
(4, 25),
(11, 25),
(32, 25),
(49, 25),
(28, 25),
(9, 25),
(35, 25),
(7, 26),
(4, 26),
(11, 26),
(32, 26),
(49, 26),
(28, 26),
(25, 26),
(9, 26),
(35, 26),
(5, 26),
(12, 27),
(4, 27),
(11, 27),
(32, 27),
(49, 27),
(28, 27),
(25, 27),
(40, 27),
(9, 27),
(35, 27),
(5, 27),
(14, 28),
(4, 28),
(11, 28),
(32, 28),
(49, 28),
(28, 28),
(9, 28),
(35, 28),
(16, 29),
(4, 29),
(11, 29),
(32, 29),
(49, 29),
(28, 29),
(25, 29),
(40, 29),
(9, 29),
(35, 29),
(5, 29),
(18, 30),
(4, 30),
(11, 30),
(32, 30),
(49, 30),
(28, 30),
(25, 30),
(9, 30),
(35, 30),
(5, 30),
(21, 31),
(4, 31),
(11, 31),
(32, 31),
(49, 31),
(28, 31),
(9, 31),
(35, 31),
(24, 32),
(4, 32),
(11, 32),
(32, 32),
(49, 32),
(28, 32),
(25, 32),
(40, 32),
(9, 32),
(35, 32),
(5, 32),
(27, 33),
(4, 33),
(11, 33),
(32, 33),
(49, 33),
(28, 33),
(25, 33),
(40, 33),
(42, 33),
(9, 33),
(35, 33),
(5, 33),
(30, 34),
(4, 34),
(11, 34),
(32, 34),
(49, 34),
(28, 34),
(25, 34),
(9, 34),
(35, 34),
(5, 34),
(31, 35),
(4, 35),
(11, 35),
(32, 35),
(49, 35),
(28, 35),
(25, 35),
(40, 35),
(9, 35),
(35, 35),
(5, 35),
(34, 36),
(4, 36),
(11, 36),
(32, 36),
(49, 36),
(28, 36),
(25, 36),
(40, 36),
(9, 36),
(35, 36),
(5, 36),
(36, 37),
(4, 37),
(11, 37),
(32, 37),
(49, 37),
(28, 37),
(25, 37),
(9, 37),
(35, 37),
(5, 37),
(38, 38),
(4, 38),
(11, 38),
(32, 38),
(49, 38),
(28, 38),
(9, 38),
(35, 38),
(41, 39),
(4, 39),
(11, 39),
(32, 39),
(49, 39),
(28, 39),
(25, 39),
(40, 39),
(42, 39),
(20, 39),
(9, 39),
(35, 39),
(5, 39),
(13, 39),
(44, 40),
(4, 40),
(11, 40),
(32, 40),
(49, 40),
(28, 40),
(25, 40),
(40, 40),
(9, 40),
(35, 40),
(5, 40),
(48, 41),
(4, 41),
(11, 41),
(32, 41),
(49, 41),
(28, 41),
(25, 41),
(40, 41),
(9, 41),
(35, 41),
(5, 41),
(50, 42),
(4, 42),
(11, 42),
(32, 42),
(49, 42),
(28, 42),
(25, 42),
(9, 42),
(35, 42),
(5, 42),
(1, 43),
(4, 43),
(11, 43),
(32, 43),
(49, 43),
(28, 43),
(25, 43),
(40, 43),
(42, 43),
(20, 43),
(9, 43),
(35, 43),
(5, 43),
(13, 43),
(2, 44),
(4, 44),
(11, 44),
(32, 44),
(49, 44),
(28, 44),
(9, 44),
(35, 44),
(3, 45),
(4, 45),
(11, 45),
(32, 45),
(49, 45),
(28, 45),
(25, 45),
(9, 45),
(35, 45),
(5, 45),
(6, 46),
(4, 46),
(11, 46),
(32, 46),
(49, 46),
(28, 46),
(25, 46),
(40, 46),
(9, 46),
(35, 46),
(5, 46),
(7, 47),
(4, 47),
(11, 47),
(32, 47),
(49, 47),
(28, 47),
(25, 47),
(9, 47),
(35, 47),
(5, 47),
(12, 48),
(4, 48),
(11, 48),
(32, 48),
(49, 48),
(28, 48),
(25, 48),
(40, 48),
(42, 48),
(9, 48),
(35, 48),
(5, 48),
(14, 49),
(4, 49),
(11, 49),
(32, 49),
(49, 49),
(28, 49),
(25, 49),
(40, 49),
(42, 49),
(9, 49),
(35, 49),
(5, 49),
(16, 50),
(4, 50),
(11, 50),
(32, 50),
(49, 50),
(28, 50),
(25, 50),
(9, 50),
(35, 50),
(5, 50);


#artist/50#
INSERT INTO artist (artist_name, pseudonym, birth_date, website, instagram) VALUES
('Alice Monroe', 'AliMo', '1992-06-15', 'https://alicemonroe.com', 'https://instagram.com/ali_mo'),
('Benjamin Clark', NULL, '1987-03-22', 'https://benjaminclarkmusic.com', 'https://instagram.com/ben.clark'),
('Chloe Rivera', 'ChloRiv', '1995-12-01', 'https://chloeriv.com', 'https://instagram.com/chloeriv'),
('Daniel Wu', NULL, '1990-07-09', 'https://danielwumusic.com', 'https://instagram.com/danwu_music'),
('Elena Petrova', 'ElenP', '1989-11-30', 'https://elenapetrova.net', 'https://instagram.com/elenp_music'),
('Felix Turner', NULL, '1993-08-17', 'https://felixtunes.com', 'https://instagram.com/felix_turner'),
('Gabriella Stone', 'GabiS', '1991-05-10', 'https://gabriellastone.com', 'https://instagram.com/gabisofficial'),
('Hiro Tanaka', NULL, '1986-04-26', 'https://hirotanaka.jp', 'https://instagram.com/hiro_music'),
('Isabelle Moreau', 'IsaM', '1994-09-03', 'https://isamoreau.fr', 'https://instagram.com/isabelle.music'),
('Jack Thompson', 'JT', '1988-02-14', 'https://jacktunes.com', 'https://instagram.com/jt_official'),
('Kira Novak', 'KNovak', '1990-01-25', 'https://kiranovak.com', 'https://instagram.com/kira_novak'),
('Liam Berg', NULL, '1985-10-12', 'https://liambergmusic.com', 'https://instagram.com/liam.berg'),
('Maya Delgado', 'MayDel', '1993-07-19', 'https://mayadelgado.com', 'https://instagram.com/maya.del'),
('Noah Schmidt', NULL, '1991-11-07', 'https://noahschmidt.de', 'https://instagram.com/noah.schmidt'),
('Olivia Hayes', 'LivH', '1996-03-30', 'https://oliviahayes.com', 'https://instagram.com/livhayes'),
('Pedro Silva', NULL, '1988-09-14', 'https://pedrosilva.pt', 'https://instagram.com/pedros_music'),
('Quinn Avery', 'QAv', '1992-02-20', 'https://quinnavery.com', 'https://instagram.com/quinn.avery'),
('Rina Kapoor', NULL, '1994-06-05', 'https://rinakapoor.in', 'https://instagram.com/rinakapoor_music'),
('Samuel Ortega', 'SamO', '1990-12-11', 'https://samortega.mx', 'https://instagram.com/sam.ortega'),
('Tessa Bloom', NULL, '1995-05-18', 'https://tessabloom.com', 'https://instagram.com/tessa.bloom'),
('Uriel Cohen', 'UC', '1987-08-29', 'https://urielcohen.com', 'https://instagram.com/uriel.cohen'),
('Valeria Rossi', NULL, '1989-04-04', 'https://valeriarossi.it', 'https://instagram.com/val.rossi'),
('William Tan', 'WillT', '1992-01-09', 'https://williamtan.sg', 'https://instagram.com/willtan.music'),
('Xenia Lopez', NULL, '1996-10-21', 'https://xenialopez.com', 'https://instagram.com/xenia.lopez'),
('Yusuf El-Amin', 'YEAMusic', '1986-07-13', 'https://yusufelamin.com', 'https://instagram.com/yusuf.amin'),
('Zara Khalid', NULL, '1993-11-02', 'https://zarakhalid.com', 'https://instagram.com/zara.khalid'),
('Aiden Brooks', 'AidoB', '1991-09-27', 'https://aidenbrooks.com', 'https://instagram.com/aiden.brooks'),
('Beatriz Santos', NULL, '1989-12-16', 'https://beatrizsantos.com', 'https://instagram.com/beas.music'),
('Elias Romero', 'ERo', '1987-04-15', 'https://eliasromero.com', 'https://instagram.com/elias.romero'),
('Freya Lund', NULL, '1993-12-03', 'https://freyalund.se', 'https://instagram.com/freya.lund'),
('Gabriel Costa', 'GC', '1991-08-19', 'https://gabrielcosta.com', 'https://instagram.com/gabriel.costa'),
('Hana Sato', NULL, '1995-02-27', 'https://hanasato.jp', 'https://instagram.com/hana.sato'),
('Ivan Petrov', 'I.P.', '1986-11-11', 'https://ivanpetrov.ru', 'https://instagram.com/ivan.petrov'),
('Jade Lin', NULL, '1994-06-07', 'https://jadelin.tw', 'https://instagram.com/jade.lin'),
('Karl Meier', 'KMeier', '1988-09-25', 'https://karlmeier.de', 'https://instagram.com/karl.meier'),
('Leila Haddad', NULL, '1990-05-30', 'https://leilahaddad.com', 'https://instagram.com/leila.music'),
('Matteo Bianchi', 'MattB', '1989-03-14', 'https://matteobianchi.it', 'https://instagram.com/matteo.bianchi'),
('Nora Jensen', NULL, '1996-10-09', 'https://norajensen.dk', 'https://instagram.com/nora.jensen'),
('Oscar Alvarez', 'OAlva', '1992-01-18', 'https://oscaralvarez.es', 'https://instagram.com/oscar.alvarez'),
('Priya Nair', NULL, '1993-07-24', 'https://priyanair.in', 'https://instagram.com/priya.nair'),
('Rafael Mendes', 'RM', '1987-12-29', 'https://rafaelmendes.com', 'https://instagram.com/rafael.mendes'),
('Selina Wu', NULL, '1995-04-22', 'https://selinawu.cn', 'https://instagram.com/selina.wu'),
('Tobias Nielsen', 'TobiN', '1988-08-03', 'https://tobiasnielsen.se', 'https://instagram.com/tobias.nielsen'),
('Usha Patel', NULL, '1991-11-06', 'https://ushapatel.com', 'https://instagram.com/usha.patel'),
('Victor Hugo', 'VHugo', '1985-06-20', 'https://victorhugo.com', 'https://instagram.com/victor.hugo'),
('Wen Li', NULL, '1994-03-10', 'https://wenli.cn', 'https://instagram.com/wenli.music'),
('Xavier Rojas', 'XR', '1990-02-17', 'https://xavierrojas.com', 'https://instagram.com/xavier.rojas'),
('Yara Mendes', NULL, '1992-09-01', 'https://yaramendes.com', 'https://instagram.com/yara.mendes'),
('Zane Walker', 'Z-Walk', '1986-12-05', 'https://zanewalker.com', 'https://instagram.com/zane.walker'),
('Alice Edwards', 'AEd', '1991-09-13', 'https://aliceedwards.com', 'https://instagram.com/alice.edwards');




INSERT INTO artist_genre (artist_id, genre, subgenre) VALUES
-- 1 είδος για κάθε καλλιτέχνη:
(1, 'Pop', 'Synthpop'),
(2, 'Rock', 'Indie Rock'),
(3, 'Hip Hop', 'Rap'),
(4, 'R&B', 'Neo Soul'),
(5, 'Jazz', 'Smooth Jazz'),
(6, 'Rock', 'Punk'),
(7, 'Pop', 'Indie Pop'),
(8, 'R&B', 'Funk Soul'),
(9, 'Hip Hop', 'Trap'),
(10, 'Classical', 'Orchestral'),
(11, 'Rock', 'Classic Rock'),
(12, 'Pop', 'Dance Pop'),
(13, 'Folk', 'Indie Folk'),
(14, 'Country', 'Americana'),
(15, 'Pop', 'Funk Pop'),
(16, 'Electronic', 'House'),
(17, 'Jazz', 'Bebop'),
(18, 'Folk', 'Indie Folk'),
(19, 'Pop', 'Teen Pop'),
(20, 'Electronic', 'Trance'),
(21, 'R&B', 'Contemporary R&B'),
(22, 'Pop', 'Bubblegum Pop'),
(23, 'Country', 'Country Pop'),
(24, 'Pop', 'Electropop'),
(25, 'Pop', 'Funk Pop'),
(26, 'Electronic', 'Techno'),
(27, 'Rock', 'Garage Rock'),
(28, 'Jazz', 'Smooth Jazz'),
(29, 'Pop', 'Alternative Pop'),
(30, 'Classical', 'Symphonic'),
-- 2 είδη για κάθε καλλιτέχνη:
(31, 'Pop', 'Indie Pop'),
(31, 'Jazz', 'Bebop'),
(32, 'R&B', 'Neo Soul'),
(32, 'Pop', 'Funk Pop'),
(33, 'Hip Hop', 'Rap'),
(33, 'Jazz', 'Vocal Jazz'),
(34, 'Electronic', 'Trance'),
(34, 'Pop', 'Tropical House'),
(35, 'Rock', 'Indie Rock'),
(35, 'Pop', 'Indie Pop'),
(36, 'Jazz', 'Smooth Jazz'),
(36, 'Pop', 'Electropop'),
(37, 'Rock', 'Psychedelic Rock'),
(37, 'Electronic', 'Dubstep'),
(38, 'Classical', 'Chamber Music'),
(38, 'Pop', 'Indie Pop'),
(39, 'Electronic', 'Minimal Techno'),
(39, 'Pop', 'Dance Pop'),
(40, 'Jazz', 'Vocal Jazz'),
(40, 'Electronic', 'Ambient'),
(41, 'Pop', 'Tropical House'),
(41, 'Jazz', 'Bebop'),
-- 3 είδη για 3 καλλιτέχνες:
(42, 'Pop', 'Alternative Pop'),
(42, 'Rock', 'Indie Rock'),
(42, 'Electronic', 'Trance'),
(43, 'Hip Hop', 'Old School'),
(43, 'Pop', 'Electropop'),
(43, 'Jazz', 'Vocal Jazz'),
(44, 'Electronic', 'House'),
(44, 'Rock', 'Post Rock'),
(44, 'Pop', 'Indie Pop'),
-- 1 είδος για κάθε καλλιτέχνη:
(45, 'Electronic', 'Synthwave'),
(46, 'Pop', 'Acoustic Pop'),
(47, 'R&B', 'Soul'),
(48, 'Rock', 'Alternative Rock'),
(49, 'Jazz', 'Smooth Jazz'),
(50, 'Hip-Hop', 'Trap');


#band/10#
INSERT INTO band (band_name, formation_date, website, instagram) VALUES
('The Rolling Stones', '1962-07-12', 'https://www.rollingstones.com', 'https://www.instagram.com/therollingstones'),
('Imagine Dragons', '2008-09-01', 'https://www.imaginedragonsmusic.com', 'https://www.instagram.com/imagine_dragons'),
('Coldplay', '1996-01-01', 'https://www.coldplay.com', 'https://www.instagram.com/coldplay'),
('Red Hot Chili Peppers', '1983-08-01', 'https://www.rhcp.com', 'https://www.instagram.com/chilipeppers'),
('Metallica', '1981-10-28', 'https://www.metallica.com', 'https://www.instagram.com/metallica'),
('Queen', '1970-07-01', 'https://www.queenonline.com', 'https://www.instagram.com/queenwillrock'),
('Nirvana', '1987-01-01', 'https://www.nirvana.com', 'https://www.instagram.com/nirvana'),
('The Beatles', '1960-08-01', 'https://www.thebeatles.com', 'https://www.instagram.com/thebeatles'),
('Foo Fighters', '1994-01-01', 'https://www.foofighters.com', 'https://www.instagram.com/foofighters'),
('Linkin Park', '1996-10-24', 'https://www.linkinpark.com', 'https://www.instagram.com/linkinpark');



INSERT INTO band_genre (band_id, genre, subgenre) VALUES
(1, 'Rock', 'Classic Rock'),
(1, 'Blues', 'Blues Rock'),
(2, 'Pop', 'Indie Pop'),
(2, 'Rock', 'Pop Rock'),
(3, 'Rock', 'Alternative Rock'),
(3, 'Pop', 'Pop Rock'),
(4, 'Alternative', 'Alternative Rock'),
(4, 'Rock', 'Funk Rock'),
(5, 'Metal', 'Thrash Metal'),
(5, 'Rock', 'Heavy Metal'),
(6, 'Rock', 'Progressive Rock'),
(7, 'Grunge', 'Alternative Rock'),
(8, 'Rock', 'Classic Rock'),
(9, 'Rock', 'Alternative Rock'),
(10, 'Nu Metal', 'Alternative Metal');


INSERT INTO band_member (artist_id, band_id) VALUES
(25, 1), (26, 1), (27, 1), (28, 1),  -- Band 1 members
(29, 2), (30, 2), (31, 2), (32, 2), (33, 2),  -- Band 2 members
(34, 3), (35, 3), (36, 3),  -- Band 3 members
(37, 4), (38, 4), (39, 4), (40, 4),  -- Band 4 members
(41, 5), (42, 5), (43, 5), (44, 5), (45, 5),  -- Band 5 members
(46, 6), (47, 6), (48, 6),  -- Band 6 members
(49, 7), (50, 7), (25, 7), (26, 7),  -- Band 7 members (with some artists in multiple bands)
(27, 8), (28, 8), (29, 8), (30, 8), (31, 8),  -- Band 8 members
(32, 9), (33, 9), (34, 9),  -- Band 9 members
(35, 10), (36, 10), (37, 10), (38, 10);  -- Band 10 members


INSERT INTO performance (event_id, type_of_performance, start_time, end_time) VALUES
-- Festival 1: TechWorld Summit performances
(1, 'warm up', '2016-06-10 09:00:00', '2016-06-10 09:30:00'),
(1, 'headline', '2016-06-10 09:35:00', '2016-06-10 10:20:00'),
(2, 'warm up', '2016-06-10 11:00:00', '2016-06-10 11:45:00'),
(2, 'headline', '2016-06-10 11:50:00', '2016-06-10 12:40:00'),
(3, 'warm up', '2016-06-11 09:00:00', '2016-06-11 09:30:00'),
(3, 'headline', '2016-06-11 09:35:00', '2016-06-11 10:20:00'),
(4, 'Special guest', '2016-06-11 11:00:00', '2016-06-11 11:45:00'),
(4, 'headline', '2016-06-11 11:50:00', '2016-06-11 12:40:00'),
(5, 'headline', '2016-06-12 9:00:00', '2016-06-12 9:45:00'),
(5, 'warm up', '2016-06-12 9:50:00', '2016-06-12 10:30:00'),

-- Festival 2: London Arts Festival performances
(6, 'warm up', '2018-07-01 09:00:00', '2018-07-01 09:30:00'),
(6, 'headline', '2018-07-01 09:35:00', '2018-07-01 10:20:00'),
(7, 'Special guest', '2018-07-01 11:00:00', '2018-07-01 11:45:00'),
(7, 'headline', '2018-07-01 11:50:00', '2018-07-01 12:30:00'),
(8, 'warm up', '2018-07-02 09:00:00', '2018-07-02 09:30:00'),
(8, 'headline', '2018-07-02 09:35:00', '2018-07-02 10:20:00'),
(9, 'Special guest', '2018-07-02 11:00:00', '2018-07-02 11:45:00'),
(9, 'headline', '2018-07-02 11:50:00', '2018-07-02 12:30:00'),
(10, 'headline', '2018-07-03 9:00:00', '2018-07-03 9:45:00'),
(10, 'Special guest', '2018-07-03 9:50:00', '2018-07-03 10:30:00'),

-- Festival 3: Tokyo Light Festival performances
(11, 'warm up', '2020-03-15 09:00:00', '2020-03-15 09:30:00'),
(11, 'headline', '2020-03-15 09:35:00', '2020-03-15 10:20:00'),
(12, 'Special guest', '2020-03-15 11:00:00', '2020-03-15 11:45:00'),
(12, 'headline', '2020-03-15 11:50:00', '2020-03-15 12:30:00'),
(13, 'warm up', '2020-03-16 09:00:00', '2020-03-16 09:30:00'),
(13, 'headline', '2020-03-16 09:35:00', '2020-03-16 10:20:00'),
(14, 'Special guest', '2020-03-16 11:00:00', '2020-03-16 11:45:00'),
(14, 'headline', '2020-03-16 11:50:00', '2020-03-16 12:30:00'),
(15, 'headline', '2020-03-17 9:00:00', '2020-03-17 9:40:00'),
(15, 'warm up', '2020-03-17 9:50:00', '2020-03-17 10:30:00'),

-- Festival 4: Barcelona Music Fiesta performances
(16, 'headline', '2021-09-10 09:35:00', '2021-09-10 10:20:00'),
(16, 'other', '2021-09-10 10:25:00', '2021-09-10 10:30:00'),
(17, 'Special guest', '2021-09-10 11:00:00', '2021-09-10 11:45:00'),
(17, 'headline', '2021-09-10 11:50:00', '2021-09-10 12:30:00'),
(18, 'headline', '2021-09-11 09:35:00', '2021-09-11 10:20:00'),
(18, 'other', '2021-09-11 10:25:00', '2021-09-11 10:30:00'),
(19, 'Special guest', '2021-09-11 11:00:00', '2021-09-11 11:45:00'),
(19, 'headline', '2021-09-11 11:50:00', '2021-09-11 12:30:00'),
(20, 'headline', '2021-09-12 9:00:00', '2021-09-12 9:40:00'),
(20, 'warm up', '2021-09-12 9:50:00', '2021-09-12 10:30:00'),

-- Festival 5: Berlin Film Festival performances
(21, 'warm up', '2019-02-10 09:00:00', '2019-02-10 09:30:00'),
(21, 'headline', '2019-02-10 09:35:00', '2019-02-10 10:20:00'),
(22, 'Special guest', '2019-02-10 11:00:00', '2019-02-10 11:45:00'),
(22, 'headline', '2019-02-10 11:50:00', '2019-02-10 12:30:00'),
(23, 'warm up', '2019-02-11 09:00:00', '2019-02-11 09:30:00'),
(23, 'headline', '2019-02-11 09:35:00', '2019-02-11 10:20:00'),
(24, 'Special guest', '2019-02-11 11:00:00', '2019-02-11 11:45:00'),
(24, 'headline', '2019-02-11 11:50:00', '2019-02-11 12:30:00'),
(25, 'headline', '2019-02-12 9:00:00', '2019-02-12 9:40:00'),
(25, 'warm up', '2019-02-12 9:50:00', '2019-02-12 10:30:00'),

-- Festival 6: Sydney Harbour Show performances
(26, 'warm up', '2022-01-01 09:00:00', '2022-01-01 09:30:00'),
(26, 'headline', '2022-01-01 09:35:00', '2022-01-01 10:20:00'),
(27, 'Special guest', '2022-01-01 11:00:00', '2022-01-01 11:45:00'),
(27, 'headline', '2022-01-01 11:50:00', '2022-01-01 12:30:00'),
(28, 'warm up', '2022-01-02 09:00:00', '2022-01-02 09:30:00'),
(28, 'headline', '2022-01-02 09:35:00', '2022-01-02 10:20:00'),
(29, 'Special guest', '2022-01-02 11:00:00', '2022-01-02 11:45:00'),
(29, 'headline', '2022-01-02 11:50:00', '2022-01-02 12:30:00'),
(30, 'headline', '2022-01-03 9:00:00', '2022-01-03 9:40:00'),
(30, 'warm up', '2022-01-03 9:50:00', '2022-01-03 10:30:00'),

-- Festival 7: Mexico Day Parade performances
(31, 'warm up', '2017-11-20 09:00:00', '2017-11-20 09:30:00'),
(31, 'headline', '2017-11-20 09:35:00', '2017-11-20 10:20:00'),
(32, 'Special guest', '2017-11-20 11:00:00', '2017-11-20 11:45:00'),
(32, 'headline', '2017-11-20 11:50:00', '2017-11-20 12:30:00'),
(33, 'warm up', '2017-11-21 09:00:00', '2017-11-21 09:30:00'),
(33, 'headline', '2017-11-21 09:35:00', '2017-11-21 10:20:00'),
(34, 'Special guest', '2017-11-21 11:00:00', '2017-11-21 11:45:00'),
(34, 'headline', '2017-11-21 11:50:00', '2017-11-21 12:30:00'),
(35, 'headline', '2017-11-21 13:00:00', '2017-11-21 13:30:00'),
(35, 'warm up', '2017-11-21 13:40:00', '2017-11-21 14:25:00'),

-- Festival 8: Heritage Festival SA performances
(36, 'warm up', '2023-04-27 09:00:00', '2023-04-27 09:30:00'),
(36, 'headline', '2023-04-27 09:35:00', '2023-04-27 10:20:00'),
(37, 'Special guest', '2023-04-27 11:00:00', '2023-04-27 11:45:00'),
(37, 'headline', '2023-04-27 11:50:00', '2023-04-27 12:30:00'),
(38, 'warm up', '2023-04-28 09:00:00', '2023-04-28 09:30:00'),
(38, 'headline', '2023-04-28 09:35:00', '2023-04-28 10:20:00'),
(39, 'Special guest', '2023-04-28 11:00:00', '2023-04-28 11:45:00'),
(39, 'headline', '2023-04-28 11:50:00', '2023-04-28 12:30:00'),
(40, 'headline', '2023-04-29 9:00:00', '2023-04-29 9:40:00'),
(40, 'warm up', '2023-04-29 9:50:00', '2023-04-29 10:30:00'),

-- Festival 9: Moscow Ice Carnival performances
(41, 'warm up', '2026-12-10 09:00:00', '2026-12-10 09:30:00'),
(41, 'headline', '2026-12-10 09:35:00', '2026-12-10 10:20:00'),
(42, 'Special guest', '2026-12-10 11:00:00', '2026-12-10 11:45:00'),
(42, 'headline', '2026-12-10 11:50:00', '2026-12-10 12:30:00'),
(43, 'warm up', '2026-12-11 09:00:00', '2026-12-11 09:30:00'),
(43, 'headline', '2026-12-11 09:35:00', '2026-12-11 10:20:00'),
(44, 'Special guest', '2026-12-11 11:00:00', '2026-12-11 11:45:00'),
(44, 'headline', '2026-12-11 11:50:00', '2026-12-11 12:30:00'),
(45, 'headline', '2026-12-12 9:00:00', '2026-12-12 9:40:00'),
(45, 'warm up', '2026-12-12 9:50:00', '2026-12-12 10:30:00'),

-- Festival 10: Rio Carnival Beats performances
(46, 'warm up', '2027-02-15 09:00:00', '2027-02-15 9:20:00'),
(46, 'headline', '2027-02-15 9:30:00', '2027-02-15 10:00:00'),
(47, 'Special guest', '2027-02-15 10:30:00', '2027-02-15 10:40:00'),
(47, 'headline', '2027-02-15 10:50:00', '2027-02-15 11'),
(48, 'warm up', '2027-02-16 9:00:00', '2027-02-16 9:20:00'),
(48, 'headline', '2027-02-16 9:30:00', '2027-02-16 10'),
(49, 'Special guest', '2027-02-16 10:30:00', '2027-02-16 10:40:00'),
(49, 'headline', '2027-02-16 10:50:00', '2027-02-16 11'),
(50, 'headline', '2027-02-17 10:30:00', '2027-02-17 10:40:00'),
(50, 'warm up', '2027-02-17 10:50:00', '2027-02-17 11');



INSERT INTO performance_artist(performance_id, artist_id) VALUES (1, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (1, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (1, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (1, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (1, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (2, 12);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (3, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (3, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (3, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (3, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (3, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (4, 19);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (5, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (5, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (5, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (5, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (5, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (6, 34);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (6, 35);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (6, 36);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (7, 49);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (7, 50);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (7, 25);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (7, 26);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (8, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (8, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (8, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (8, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (8, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (9, 25);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (9, 26);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (9, 27);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (9, 28);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (10, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (10, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (10, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (10, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (10, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (11, 16);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (12, 37);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (12, 38);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (12, 39);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (12, 40);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (13, 19);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (14, 2);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (15, 35);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (15, 36);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (15, 37);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (15, 38);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (16, 18);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (17, 20);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (18, 20);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (19, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (19, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (19, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (19, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (19, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (20, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (20, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (20, 34);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (21, 15);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (22, 27);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (22, 28);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (22, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (22, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (22, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (23, 16);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (24, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (24, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (24, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (24, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (24, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (25, 15);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (26, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (26, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (26, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (26, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (26, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (27, 27);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (27, 28);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (27, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (27, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (27, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (28, 46);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (28, 47);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (28, 48);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (29, 13);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (30, 15);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (31, 23);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (32, 21);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (33, 46);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (33, 47);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (33, 48);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (34, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (34, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (34, 34);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (35, 4);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (36, 20);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (37, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (37, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (37, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (37, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (37, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (38, 46);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (38, 47);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (38, 48);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (39, 24);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (40, 14);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (41, 41);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (41, 42);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (41, 43);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (41, 44);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (41, 45);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (42, 6);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (43, 4);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (44, 7);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (45, 8);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (46, 12);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (47, 46);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (47, 47);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (47, 48);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (48, 34);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (48, 35);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (48, 36);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (49, 21);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (50, 19);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (51, 4);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (52, 35);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (52, 36);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (52, 37);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (52, 38);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (53, 17);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (54, 37);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (54, 38);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (54, 39);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (54, 40);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (55, 37);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (55, 38);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (55, 39);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (55, 40);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (56, 37);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (56, 38);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (56, 39);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (56, 40);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (57, 4);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (58, 13);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (59, 6);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (60, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (60, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (60, 34);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (61, 41);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (61, 42);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (61, 43);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (61, 44);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (61, 45);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (62, 20);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (63, 27);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (63, 28);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (63, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (63, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (63, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (64, 46);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (64, 47);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (64, 48);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (65, 18);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (66, 4);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (67, 24);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (68, 13);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (69, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (69, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (69, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (69, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (69, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (70, 20);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (71, 17);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (72, 49);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (72, 50);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (72, 25);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (72, 26);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (73, 3);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (74, 49);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (74, 50);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (74, 25);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (74, 26);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (75, 18);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (76, 7);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (77, 3);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (78, 9);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (79, 13);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (80, 25);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (80, 26);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (80, 27);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (80, 28);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (81, 23);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (82, 17);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (83, 22);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (84, 49);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (84, 50);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (84, 25);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (84, 26);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (85, 37);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (85, 38);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (85, 39);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (85, 40);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (86, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (86, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (86, 34);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (87, 46);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (87, 47);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (87, 48);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (88, 25);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (88, 26);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (88, 27);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (88, 28);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (89, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (89, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (89, 34);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (90, 21);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (91, 16);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (92, 12);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (93, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (93, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (93, 34);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (94, 4);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (95, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (95, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (95, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (95, 32);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (95, 33);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (96, 19);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (97, 13);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (98, 25);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (99, 27);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (99, 28);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (99, 29);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (99, 30);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (99, 31);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (100, 34);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (100, 35);
INSERT INTO performance_artist(performance_id, artist_id) VALUES (100, 36);




#visitor 100#
INSERT INTO visitor (visitor_name, age) VALUES 
('Alice Johnson', 28),
('Ben Carter', 35),
('Chloe Kim', 24),
('Daniel Reyes', 30),
('Ella Tran', 22),
('Frank Silva', 39),
('Grace Liu', 26),
('Hugo Novak', 41),
('Isla Ahmed', 27),
('Jack Nolan', 31),
('Karen Singh', 33),
('Leo Brooks', 29),
('Maya Patel', 24),
('Noah Kim', 36),
('Olivia Garcia', 21),
('Paul Zimmer', 44),
('Quinn Harper', 28),
('Riley Thomas', 32),
('Sophia Lane', 27),
('Tariq White', 37),
('Uma Sanchez', 30),
('Victor Li', 40),
('Wendy Zhou', 23),
('Xavier Miles', 42),
('Yasmin Omar', 25),
('Zane Adler', 29),
('Amara Bennett', 26),
('Brent Owen', 34),
('Carla Dawson', 38),
('Derek Lee', 33),
('Eva Brandt', 28),
('Felix Jones', 32),
('Gina Russo', 25),
('Hank Cooper', 39),
('Ines Duarte', 23),
('Jonas Meyer', 35),
('Kyla Ford', 26),
('Lars Becker', 43),
('Marina Costa', 30),
('Nico Alvarez', 31),
('Opal Jensen', 29),
('Preston Hale', 34),
('Queenie Sharp', 22),
('Ronan Cook', 36),
('Sasha Dean', 27),
('Theo Rojas', 33),
('Uma Voss', 26),
('Viktor Novak', 40),
('Willa Stone', 24),
('Xena Li', 21),
('Yuki Tanaka', 29),
('Liam Smith', 32),
('Emma Brown', 25),
('Noah Wilson', 34),
('Olivia Lee', 23),
('James Harris', 37),
('Ava White', 22),
('Lucas Martin', 31),
('Mia Thompson', 27),
('Elijah Garcia', 36),
('Harper Martinez', 24),
('Ethan Robinson', 35),
('Amelia Clark', 29),
('Logan Rodriguez', 33),
('Charlotte Lewis', 26),
('Mason Walker', 30),
('Aria Hall', 28),
('Jacob Allen', 41),
('Scarlett Young', 25),
('Michael King', 38),
('Luna Wright', 23),
('Alexander Scott', 34),
('Emily Green', 27),
('William Adams', 39),
('Ella Baker', 26),
('Daniel Nelson', 36),
('Grace Hill', 24),
('Matthew Rivera', 33),
('Chloe Campbell', 22),
('Aiden Mitchell', 35),
('Zoe Perez', 28),
('David Roberts', 31),
('Lily Turner', 25),
('Joseph Phillips', 37),
('Hannah Parker', 23),
('Samuel Evans', 32),
('Victoria Edwards', 26),
('Andrew Collins', 40),
('Natalie Stewart', 29),
('Joshua Morris', 34),
('Penelope Rogers', 21),
('Christopher Reed', 36),
('Samantha Cook', 28),
('Anthony Morgan', 39),
('Brooklyn Bell', 24),
('Ryan Murphy', 33),
('Savannah Bailey', 27),
('Thomas Rivera', 30),
('Bella Cooper', 26),
('Jonathan Howard', 42);


#visitor_contact#
INSERT INTO visitor_contact (visitor_id, phone, email) VALUES
(1, '6912345872', 'alice.johnson@example.com'),
(2, '6987623104', 'ben.carter@example.com'),
(3, '6978452398', 'chloe.kim@example.com'),
(5, '6961348790', 'ella.tran@example.com'),
(6, '6998217346', 'frank.silva@example.com'),
(8, '6956732019', 'hugo.novak@example.com'),
(10, '6945327198', 'jack.nolan@example.com'),
(11, '6990132845', 'karen.singh@example.com'),
(13, '6937289456', 'maya.patel@example.com'),
(14, '6984203791', 'noah.kim@example.com'),
(16, '6918765432', 'paul.zimmer@example.com'),
(18, '6973124056', 'riley.thomas@example.com'),
(20, '6950248719', 'tariq.white@example.com'),
(22, '6941236987', 'victor.li@example.com'),
(25, '6927854103', 'yasmin.omar@example.com'),
(27, '6993248675', 'amara.bennett@example.com'),
(30, '6967543981', 'derek.lee@example.com'),
(32, '6934019872', 'felix.jones@example.com'),
(35, '6957681340', 'ines.duarte@example.com'),
(37, '6910234567', 'kyla.ford@example.com'),
(40, '6987392016', 'nico.alvarez@example.com'),
(42, '6949283710', 'preston.hale@example.com'),
(44, '6937842051', 'sasha.dean@example.com'),
(47, '6978913042', 'uma.voss@example.com'),
(49, '6965748392', 'willa.stone@example.com'),
(52, '6913579246', 'liam.smith@example.com'),
(54, '6940137852', 'noah.wilson@example.com'),
(57, '6973421809', 'mia.thompson@example.com'),
(60, '6982047319', 'ethan.robinson@example.com'),
(63, '6928413702', 'charlotte.lewis@example.com');


INSERT INTO ticket (EAN13, event_id, visitor_id, purchase_time, cost, purchase_method, category, active) VALUES
-- Festival 1: TechWorld Summit (Events 1-5) - 20 tickets (4 per event)
('1234567890123', 1, 1, '2016-05-15 10:30:00', 50.00, 'credit_card', 'general_admission', FALSE),
('1234567890124', 1, 2, '2016-05-16 11:15:00', 75.00, 'debit_card', 'general_admission', FALSE),
('1234567890125', 1, 3, '2016-05-17 09:45:00', 50.00, 'cash', 'general_admission', TRUE),
('1234567890126', 1, 4, '2016-05-18 14:20:00', 75.00, 'bank_account', 'general_admission', FALSE),

('1234567890127', 2, 5, '2016-05-19 16:10:00', 60.00, 'credit_card', 'general_admission', FALSE),
('1234567890128', 2, 6, '2016-05-20 10:00:00', 85.00, 'debit_card', 'backstage', TRUE),
('1234567890129', 2, 7, '2016-05-21 13:45:00', 60.00, 'cash', 'general_admission', FALSE),
('1234567890130', 2, 8, '2016-05-22 15:30:00', 85.00, 'bank_account', 'vip', FALSE),

('1234567890131', 3, 9, '2016-05-23 11:20:00', 55.00, 'credit_card', 'general_admission', FALSE),
('1234567890132', 3, 10, '2016-05-24 09:15:00', 80.00, 'debit_card', 'backstage', TRUE),
('1234567890133', 3, 11, '2016-05-25 12:45:00', 55.00, 'cash', 'general_admission', FALSE),
('1234567890134', 3, 12, '2016-05-26 14:30:00', 80.00, 'bank_account', 'vip', FALSE),

('1234567890135', 4, 13, '2016-05-27 16:20:00', 65.00, 'credit_card', 'general_admission', FALSE),
('1234567890136', 4, 14, '2016-05-28 10:45:00', 90.00, 'debit_card', 'vip', TRUE),
('1234567890137', 4, 15, '2016-05-29 13:15:00', 65.00, 'cash', 'general_admission', FALSE),
('1234567890138', 4, 16, '2016-05-30 10:30:00', 90.00, 'bank_account', 'backstage', FALSE),

('1234567890139', 5, 17, '2016-05-31 11:15:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890140', 5, 18, '2016-06-01 09:45:00', 95.00, 'debit_card', 'vip', TRUE),
('1234567890141', 5, 19, '2016-06-02 14:20:00', 70.00, 'cash', 'general_admission', FALSE),
('1234567890142', 5, 20, '2016-06-03 16:10:00', 95.00, 'bank_account', 'backstage', FALSE),

-- Festival 2: London Arts Festival (Events 6-10) - 20 tickets (4 per event)
('1234567890143', 6, 21, '2018-06-04 10:30:00', 60.00, 'credit_card', 'general_admission', FALSE),
('1234567890144', 6, 22, '2018-06-05 11:15:00', 85.00, 'debit_card', 'backstage', TRUE),
('1234567890145', 6, 23, '2018-06-06 09:45:00', 60.00, 'cash', 'general_admission', FALSE),
('1234567890146', 6, 24, '2018-06-07 14:20:00', 85.00, 'bank_account', 'vip', FALSE),

('1234567890147', 7, 25, '2018-06-08 16:10:00', 65.00, 'credit_card', 'general_admission', FALSE),
('1234567890148', 7, 26, '2018-06-09 10:00:00', 90.00, 'debit_card', 'vip', TRUE),
('1234567890149', 7, 27, '2018-06-10 13:45:00', 65.00, 'cash', 'general_admission', FALSE),
('1234567890150', 7, 28, '2018-06-11 15:30:00', 90.00, 'bank_account', 'backstage', FALSE),

('1234567890151', 8, 29, '2018-06-12 11:20:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890152', 8, 30, '2018-06-13 09:15:00', 95.00, 'debit_card', 'vip', TRUE),
('1234567890153', 8, 31, '2018-06-14 12:45:00', 70.00, 'cash', 'general_admission', FALSE),
('1234567890154', 8, 32, '2018-06-15 14:30:00', 95.00, 'bank_account', 'backstage', FALSE),

('1234567890155', 9, 33, '2018-06-16 16:20:00', 75.00, 'credit_card', 'general_admission', FALSE),
('1234567890156', 9, 34, '2018-06-17 10:45:00', 100.00, 'debit_card', 'vip', TRUE),
('1234567890157', 9, 35, '2018-06-18 13:15:00', 75.00, 'cash', 'general_admission', FALSE),
('1234567890158', 9, 36, '2018-06-19 16:10:00', 100.00, 'bank_account', 'vip', FALSE),

('1234567890159', 10, 37, '2018-06-20 10:30:00', 80.00, 'credit_card', 'general_admission', FALSE),
('1234567890160', 10, 38, '2018-06-21 11:15:00', 105.00, 'debit_card', 'backstage', TRUE),
('1234567890161', 10, 39, '2018-06-22 09:45:00', 80.00, 'cash', 'general_admission', FALSE),
('1234567890162', 10, 40, '2018-06-23 14:20:00', 105.00, 'bank_account', 'vip', FALSE),

-- Festival 3: Tokyo Light Festival (Events 11-15) - 20 tickets (4 per event)
('1234567890163', 11, 41, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890164', 11, 42, '2020-02-16 11:15:00', 95.00, 'debit_card', 'backstage', FALSE),
('1234567890165', 11, 43, '2020-02-17 09:45:00', 70.00, 'cash', 'general_admission', TRUE),
('1234567890166', 11, 44, '2020-02-18 14:20:00', 95.00, 'bank_account', 'vip', FALSE),

('1234567890167', 12, 45, '2020-02-19 16:10:00', 75.00, 'credit_card', 'general_admission', FALSE),
('1234567890168', 12, 46, '2020-02-20 10:00:00', 100.00, 'debit_card', 'backstage', FALSE),
('1234567890169', 12, 47, '2020-02-21 13:45:00', 75.00, 'cash', 'general_admission', FALSE),
('1234567890170', 12, 48, '2020-02-22 15:30:00', 100.00, 'bank_account', 'vip', TRUE),

('1234567890171', 13, 49, '2020-02-23 11:20:00', 80.00, 'credit_card', 'general_admission', FALSE),
('1234567890172', 13, 50, '2020-02-24 09:15:00', 105.00, 'debit_card', 'vip', FALSE),
('1234567890173', 13, 51, '2020-02-25 12:45:00', 80.00, 'cash', 'general_admission', FALSE),
('1234567890174', 13, 52, '2020-02-26 14:30:00', 105.00, 'bank_account', 'backstage', TRUE),

('1234567890175', 14, 53, '2020-02-27 16:20:00', 85.00, 'credit_card', 'general_admission', FALSE),
('1234567890176', 14, 54, '2020-02-28 10:45:00', 110.00, 'debit_card', 'backstage', FALSE),
('1234567890177', 14, 55, '2020-02-29 13:15:00', 85.00, 'cash', 'general_admission', TRUE),
('1234567890178', 14, 56, '2020-03-01 16:10:00', 110.00, 'bank_account', 'vip', FALSE),

('1234567890179', 15, 57, '2020-03-02 10:30:00', 90.00, 'credit_card', 'general_admission', FALSE),
('1234567890180', 15, 58, '2020-03-03 11:15:00', 115.00, 'debit_card', 'vip', FALSE),
('1234567890181', 15, 59, '2020-03-04 09:45:00', 90.00, 'cash', 'general_admission', TRUE),
('1234567890182', 15, 60, '2020-03-05 14:20:00', 115.00, 'bank_account', 'backstage', FALSE),

-- Festival 4: Bracelona Music Fiesta (Events 16-20) - 20 tickets (4 per event)
('1234567890183', 16, 61, '2021-08-10 10:30:00', 80.00, 'credit_card', 'general_admission', FALSE),
('1234567890184', 16, 62, '2021-08-11 11:15:00', 105.00, 'debit_card', 'vip', FALSE),
('1234567890185', 16, 63, '2021-08-12 09:45:00', 80.00, 'cash', 'general_admission', FALSE),
('1234567890186', 16, 64, '2021-08-13 14:20:00', 105.00, 'bank_account', 'general_admission', TRUE),

('1234567890187', 17, 65, '2021-08-14 16:10:00', 85.00, 'credit_card', 'general_admission', FALSE),
('1234567890188', 17, 66, '2021-08-15 10:00:00', 110.00, 'debit_card', 'backstage', FALSE),
('1234567890189', 17, 67, '2021-08-16 13:45:00', 85.00, 'cash', 'general_admission', TRUE),
('1234567890190', 17, 68, '2021-08-17 15:30:00', 110.00, 'bank_account', 'vip', FALSE),

('1234567890191', 18, 69, '2021-08-18 11:20:00', 90.00, 'credit_card', 'general_admission', FALSE),
('1234567890192', 18, 70, '2021-08-19 09:15:00', 115.00, 'debit_card', 'vip', FALSE),
('1234567890193', 18, 71, '2021-08-20 12:45:00', 90.00, 'cash', 'general_admission', TRUE),
('1234567890194', 18, 72, '2021-08-21 14:30:00', 115.00, 'bank_account', 'backstage', FALSE),

('1234567890195', 19, 73, '2021-08-22 16:20:00', 95.00, 'credit_card', 'general_admission', FALSE),
('1234567890196', 19, 74, '2021-08-23 10:45:00', 120.00, 'debit_card', 'vip', TRUE),
('1234567890197', 19, 75, '2021-08-24 13:15:00', 95.00, 'cash', 'general_admission', FALSE),
('1234567890198', 19, 76, '2021-08-25 16:10:00', 120.00, 'bank_account', 'backstage', FALSE),

('1234567890199', 20, 77, '2021-08-26 10:30:00', 100.00, 'credit_card', 'general_admission', TRUE),
('1234567890200', 20, 78, '2021-08-27 11:15:00', 125.00, 'debit_card', 'vip', FALSE),
('1234567890201', 20, 79, '2021-08-28 09:45:00', 100.00, 'cash', 'general_admission', FALSE),
('1234567890202', 20, 80, '2021-08-29 14:20:00', 125.00, 'bank_account', 'backstage', TRUE),

-- Festival 5: Berlin Film Festival (Events 21-25) - Modified
('1234567890203', 21, 81, '2019-01-10 10:30:00', 90.00, 'credit_card', 'general_admission', FALSE),
('1234567890204', 21, 82, '2019-01-11 11:15:00', 115.00, 'debit_card', 'backstage', FALSE),
('1234567890205', 21, 83, '2019-01-12 09:45:00', 90.00, 'cash', 'general_admission', TRUE),
('1234567890206', 21, 84, '2019-01-13 14:20:00', 115.00, 'bank_account', 'vip', FALSE),

('1234567890207', 22, 85, '2019-01-14 16:10:00', 95.00, 'credit_card', 'general_admission', FALSE),
('1234567890208', 22, 86, '2019-01-15 10:00:00', 120.00, 'debit_card', 'vip', FALSE),
('1234567890209', 22, 87, '2019-01-16 13:45:00', 95.00, 'cash', 'general_admission', TRUE),
('1234567890210', 22, 88, '2019-01-17 15:30:00', 120.00, 'bank_account', 'backstage', FALSE),

('1234567890211', 23, 89, '2019-01-18 11:20:00', 100.00, 'credit_card', 'general_admission', FALSE),
('1234567890212', 23, 90, '2019-01-19 09:15:00', 125.00, 'debit_card', 'backstage', FALSE),
('1234567890213', 23, 91, '2019-01-20 12:45:00', 100.00, 'cash', 'general_admission', FALSE),
('1234567890214', 23, 92, '2019-01-21 14:30:00', 125.00, 'bank_account', 'vip', TRUE),

('1234567890215', 24, 93, '2019-01-22 16:20:00', 105.00, 'credit_card', 'general_admission', TRUE),
('1234567890216', 24, 94, '2019-01-23 10:45:00', 130.00, 'debit_card', 'vip', FALSE),
('1234567890217', 24, 95, '2019-01-24 13:15:00', 105.00, 'cash', 'general_admission', FALSE),
('1234567890218', 24, 96, '2019-01-25 16:10:00', 130.00, 'bank_account', 'backstage', FALSE),

('1234567890219', 25, 97, '2019-01-26 10:30:00', 110.00, 'credit_card', 'general_admission', FALSE),
('1234567890220', 25, 98, '2019-01-27 11:15:00', 135.00, 'debit_card', 'vip', TRUE),
('1234567890221', 25, 99, '2019-01-28 09:45:00', 110.00, 'cash', 'general_admission', FALSE),
('1234567890222', 25, 100, '2019-01-29 14:20:00', 135.00, 'bank_account', 'backstage', FALSE),

-- Festival 6: Sydney Harbour Show (Events 26-30) - Modified
('1234567890223', 26, 1, '2021-12-01 10:30:00', 100.00, 'credit_card', 'general_admission', FALSE),
('1234567890224', 26, 2, '2021-12-02 11:15:00', 125.00, 'debit_card', 'vip', FALSE),
('1234567890225', 26, 3, '2021-12-03 09:45:00', 100.00, 'cash', 'general_admission', TRUE),
('1234567890226', 26, 4, '2021-12-04 14:20:00', 125.00, 'bank_account', 'backstage', FALSE),

('1234567890227', 27, 5, '2021-12-05 16:10:00', 105.00, 'credit_card', 'general_admission', FALSE),
('1234567890228', 27, 6, '2021-12-06 10:00:00', 130.00, 'debit_card', 'backstage', FALSE),
('1234567890229', 27, 7, '2021-12-07 13:45:00', 105.00, 'cash', 'general_admission', FALSE),
('1234567890230', 27, 8, '2021-12-08 15:30:00', 130.00, 'bank_account', 'vip', TRUE),

('1234567890231', 28, 9, '2021-12-09 11:20:00', 110.00, 'credit_card', 'general_admission', TRUE),
('1234567890232', 28, 10, '2021-12-10 09:15:00', 135.00, 'debit_card', 'vip', FALSE),
('1234567890233', 28, 11, '2021-12-11 12:45:00', 110.00, 'cash', 'general_admission', FALSE),
('1234567890234', 28, 12, '2021-12-12 14:30:00', 135.00, 'bank_account', 'backstage', FALSE),

('1234567890235', 29, 13, '2021-12-13 16:20:00', 115.00, 'credit_card', 'general_admission', FALSE),
('1234567890236', 29, 14, '2021-12-14 10:45:00', 140.00, 'debit_card', 'vip', FALSE),
('1234567890237', 29, 15, '2021-12-15 13:15:00', 115.00, 'cash', 'general_admission', TRUE),
('1234567890238', 29, 16, '2021-12-16 16:10:00', 140.00, 'bank_account', 'backstage', FALSE),

('1234567890239', 30, 17, '2021-12-17 10:30:00', 120.00, 'credit_card', 'general_admission', FALSE),
('1234567890240', 30, 18, '2021-12-18 11:15:00', 145.00, 'debit_card', 'vip', TRUE),
('1234567890241', 30, 19, '2021-12-19 09:45:00', 120.00, 'cash', 'general_admission', FALSE),
('1234567890242', 30, 20, '2021-12-20 14:20:00', 145.00, 'bank_account', 'backstage', FALSE),

-- Festival 7: Mexico Day Parade (Events 31-35) - 20 tickets (4 per event)
('1234567890243', 31, 21, '2017-10-20 10:30:00', 55.00, 'credit_card', 'general_admission', FALSE),
('1234567890244', 31, 22, '2017-10-21 11:15:00', 80.00, 'debit_card', 'backstage', FALSE),
('1234567890245', 31, 23, '2017-10-22 09:45:00', 55.00, 'cash', 'general_admission', FALSE),
('1234567890246', 31, 24, '2017-10-23 14:20:00', 80.00, 'bank_account', 'vip', TRUE),

('1234567890247', 32, 25, '2017-10-24 16:10:00', 60.00, 'credit_card', 'general_admission', FALSE),
('1234567890248', 32, 26, '2017-10-25 10:00:00', 85.00, 'debit_card', 'backstage', FALSE),
('1234567890249', 32, 27, '2017-10-26 13:45:00', 60.00, 'cash', 'general_admission', FALSE),
('1234567890250', 32, 28, '2017-10-27 15:30:00', 85.00, 'bank_account', 'vip', TRUE),

('1234567890251', 33, 29, '2017-10-28 11:20:00', 65.00, 'credit_card', 'general_admission', FALSE),
('1234567890252', 33, 30, '2017-10-29 09:15:00', 90.00, 'debit_card', 'vip', FALSE),
('1234567890253', 33, 31, '2017-10-30 12:45:00', 65.00, 'cash', 'general_admission', FALSE),
('1234567890254', 33, 32, '2017-10-31 14:30:00', 90.00, 'bank_account', 'backstage', TRUE),

('1234567890255', 34, 33, '2017-11-01 16:20:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890256', 34, 34, '2017-11-02 10:45:00', 95.00, 'debit_card', 'vip', FALSE),
('1234567890257', 34, 35, '2017-11-03 13:15:00', 70.00, 'cash', 'general_admission', FALSE),
('1234567890258', 34, 36, '2017-11-04 16:10:00', 95.00, 'bank_account', 'backstage', TRUE),

('1234567890259', 35, 37, '2017-11-05 10:30:00', 75.00, 'credit_card', 'general_admission', FALSE),
('1234567890260', 35, 38, '2017-11-06 11:15:00', 100.00, 'debit_card', 'vip', FALSE),
('1234567890261', 35, 39, '2017-11-07 09:45:00', 75.00, 'cash', 'general_admission', FALSE),
('1234567890262', 35, 40, '2017-11-08 14:20:00', 100.00, 'bank_account', 'vip', TRUE),

-- Festival 8: Heritage Festival SA (Events 36-40) - 20 tickets (4 per event)
('1234567890263', 36, 41, '2023-03-27 10:30:00', 65.00, 'credit_card', 'general_admission', FALSE),
('1234567890264', 36, 42, '2023-03-28 11:15:00', 90.00, 'debit_card', 'backstage', FALSE),
('1234567890265', 36, 43, '2023-03-29 09:45:00', 65.00, 'cash', 'general_admission', FALSE),
('1234567890266', 36, 44, '2023-03-30 14:20:00', 90.00, 'bank_account', 'vip', TRUE),

('1234567890267', 37, 45, '2023-03-31 16:10:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890268', 37, 46, '2023-04-01 10:00:00', 95.00, 'debit_card', 'vip', FALSE),
('1234567890269', 37, 47, '2023-04-02 13:45:00', 70.00, 'cash', 'general_admission', FALSE),
('1234567890270', 37, 48, '2023-04-03 15:30:00', 95.00, 'bank_account', 'backstage', TRUE),

('1234567890271', 38, 49, '2023-04-04 11:20:00', 75.00, 'credit_card', 'general_admission', FALSE),
('1234567890272', 38, 50, '2023-04-05 09:15:00', 100.00, 'debit_card', 'vip', FALSE),
('1234567890273', 38, 51, '2023-04-06 12:45:00', 75.00, 'cash', 'general_admission', FALSE),
('1234567890274', 38, 52, '2023-04-07 14:30:00', 100.00, 'bank_account', 'vip', TRUE),

('1234567890275', 39, 53, '2023-04-08 16:20:00', 80.00, 'credit_card', 'general_admission', FALSE),
('1234567890276', 39, 54, '2023-04-09 10:45:00', 105.00, 'debit_card', 'backstage', FALSE),
('1234567890277', 39, 55, '2023-04-10 13:15:00', 80.00, 'cash', 'general_admission', FALSE),
('1234567890278', 39, 56, '2023-04-11 16:10:00', 105.00, 'bank_account', 'vip', TRUE),

('1234567890279', 40, 57, '2023-04-12 10:30:00', 85.00, 'credit_card', 'general_admission', FALSE),
('1234567890280', 40, 58, '2023-04-13 11:15:00', 110.00, 'debit_card', 'vip', FALSE),
('1234567890281', 40, 59, '2023-04-14 09:45:00', 85.00, 'cash', 'general_admission', FALSE),
('1234567890282', 40, 60, '2023-04-15 14:20:00', 110.00, 'bank_account', 'backstage', TRUE),

-- Festival 9: Moscow Ice Carnival (Events 41-45) - 20 tickets (4 per event)
('1234567890283', 41, 61, '2026-11-10 10:30:00', 75.00, 'credit_card', 'general_admission', TRUE),
('1234567890284', 41, 62, '2026-11-11 11:15:00', 100.00, 'debit_card', 'vip', TRUE),
('1234567890285', 41, 63, '2026-11-12 09:45:00', 75.00, 'cash', 'general_admission', TRUE),
('1234567890286', 41, 64, '2026-11-13 14:20:00', 100.00, 'bank_account', 'vip', TRUE),

('1234567890287', 42, 65, '2026-11-14 16:10:00', 80.00, 'credit_card', 'general_admission', TRUE),
('1234567890288', 42, 66, '2026-11-15 10:00:00', 105.00, 'debit_card', 'vip', TRUE),
('1234567890289', 42, 67, '2026-11-16 13:45:00', 80.00, 'cash', 'general_admission', TRUE),
('1234567890290', 42, 68, '2026-11-17 15:30:00', 105.00, 'bank_account', 'vip', TRUE),

('1234567890291', 43, 69, '2026-11-18 11:20:00', 85.00, 'credit_card', 'general_admission', TRUE),
('1234567890292', 43, 70, '2026-11-19 09:15:00', 110.00, 'debit_card', 'vip', TRUE),
('1234567890293', 43, 71, '2026-11-20 12:45:00', 85.00, 'cash', 'general_admission', TRUE),
('1234567890294', 43, 72, '2026-11-21 14:30:00', 110.00, 'bank_account', 'vip', TRUE),

('1234567890295', 44, 73, '2026-11-22 16:20:00', 90.00, 'credit_card', 'general_admission', TRUE),
('1234567890296', 44, 74, '2026-11-23 10:45:00', 115.00, 'debit_card', 'vip', TRUE),
('1234567890297', 44, 75, '2026-11-24 13:15:00', 90.00, 'cash', 'general_admission', TRUE),
('1234567890298', 44, 76, '2026-11-25 16:10:00', 115.00, 'bank_account', 'vip', TRUE),

('1234567890299', 45, 77, '2026-11-26 10:30:00', 95.00, 'credit_card', 'general_admission', TRUE),
('1234567890300', 45, 78, '2026-11-27 11:15:00', 120.00, 'debit_card', 'vip', TRUE),
('1234567890301', 45, 79, '2026-11-28 09:45:00', 95.00, 'cash', 'general_admission', TRUE),
('1234567890302', 45, 80, '2026-11-29 14:20:00', 120.00, 'bank_account', 'vip', TRUE),

-- Festival 10: Rio Carnival Beats (Event 46 ONLY) - 20 tickets
('1234567890303', 46, 81, '2027-01-15 10:30:00', 85.00, 'credit_card', 'general_admission', TRUE),
('1234567890304', 46, 82, '2027-01-16 11:15:00', 110.00, 'debit_card', 'general_admission', TRUE),
('1234567890305', 46, 83, '2027-01-17 09:45:00', 85.00, 'cash', 'general_admission', TRUE),
('1234567890306', 46, 84, '2027-01-18 14:20:00', 110.00, 'bank_account', 'backstage', TRUE),

('1234567890307', 47, 85, '2027-01-19 16:10:00', 85.00, 'credit_card', 'general_admission', TRUE),
('1234567890308', 47, 86, '2027-01-20 10:00:00', 110.00, 'debit_card', 'backstage', TRUE),
('1234567890309', 47, 87, '2027-01-21 13:45:00', 85.00, 'cash', 'general_admission', TRUE),
('1234567890310', 47, 88, '2027-01-22 15:30:00', 110.00, 'bank_account', 'backstage', TRUE),

('1234567890311', 48, 89, '2027-01-23 11:20:00', 85.00, 'credit_card', 'general_admission', TRUE),
('1234567890312', 48, 90, '2027-01-24 09:15:00', 110.00, 'debit_card', 'backstage', TRUE),
('1234567890313', 48, 91, '2027-01-25 12:45:00', 85.00, 'cash', 'general_admission', TRUE),
('1234567890314', 48, 92, '2027-01-26 14:30:00', 110.00, 'bank_account', 'backstage', TRUE),

('1234567890315', 49, 93, '2027-01-27 16:20:00', 85.00, 'credit_card', 'general_admission', TRUE),
('1234567890316', 49, 94, '2027-01-28 10:45:00', 110.00, 'debit_card', 'backstage', TRUE),
('1234567890317', 49, 95, '2027-01-29 13:15:00', 85.00, 'cash', 'general_admission', TRUE),
('1234567890318', 49, 96, '2027-01-30 16:10:00', 110.00, 'bank_account', 'backstage', TRUE),

('1234567890319', 50, 97, '2027-01-31 10:30:00', 85.00, 'credit_card', 'general_admission', TRUE),
('1234567890320', 50, 98, '2027-02-01 11:15:00', 110.00, 'debit_card', 'backstage', TRUE),
('1234567890321', 50, 99, '2027-02-02 09:45:00', 85.00, 'cash', 'general_admission', TRUE),
('1234567890322', 50, 100, '2027-02-03 14:20:00', 110.00, 'bank_account', 'backstage', TRUE);





--ενας visitor περισσοτερες απο 3 παρακολουθησεις στο ιδιο ετος
INSERT INTO ticket (EAN13, event_id, visitor_id, purchase_time, cost, purchase_method, category, active) VALUES
('1234567890122', 4, 1, '2016-05-15 10:30:00', 50.00, 'credit_card', 'general_admission', FALSE),
('1234567890121', 2, 1, '2016-05-15 10:30:00', 50.00, 'credit_card', 'general_admission', FALSE),
('1234567890120', 3, 1, '2016-05-15 10:30:00', 50.00, 'credit_card', 'general_admission', FALSE),

('1234567890119', 2, 2, '2016-05-16 11:15:00', 75.00, 'debit_card', 'general_admission', FALSE),
('1234567890118', 3, 2, '2016-05-16 11:15:00', 75.00, 'debit_card', 'general_admission', FALSE),
('1234567890117', 4, 2, '2016-05-16 11:15:00', 75.00, 'debit_card', 'general_admission', FALSE),

('1234567890116', 12, 41, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890115', 13, 41, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890114', 14, 41, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890113', 15, 41, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),

('1234567890112', 12, 42, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890111', 13, 42, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890110', 14, 42, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890109', 15, 42, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),

('1234567890108', 12, 43, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890107', 13, 43, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890106', 14, 43, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),
('1234567890105', 15, 43, '2020-02-15 10:30:00', 70.00, 'credit_card', 'general_admission', FALSE),

('1234567890104', 32, 21, '2017-10-20 10:30:00', 55.00, 'credit_card', 'general_admission', FALSE),
('1234567890103', 33, 21, '2017-10-20 10:30:00', 55.00, 'credit_card', 'general_admission', FALSE),
('1234567890102', 34, 21, '2017-10-20 10:30:00', 55.00, 'credit_card', 'general_admission', FALSE),

('1234567890101', 32, 22, '2017-10-20 10:30:00', 55.00, 'credit_card', 'general_admission', FALSE),
('1234567890100', 33, 22, '2017-10-20 10:30:00', 55.00, 'credit_card', 'general_admission', FALSE),
('1234567890099', 34, 22, '2017-10-20 10:30:00', 55.00, 'credit_card', 'general_admission', FALSE);



#review/24#
INSERT INTO review (visitor_id, performance_id, artist_performance, sound_lighting, stage_presence, organization, overall_impression) VALUES
-- Visitor 1 (Event 1 - Performance 1)
(1, 1, 4, 3, 4, 3, 4),
-- Visitor 1 (Event 1 - Performance 2)
(1, 2, 1, 2, 3, 4, 5),
-- Visitor 1 (Event 2) - Performance 3)
(1, 3, 2, 4, 3, 1, 5),
-- Visitor 2 (Event 1 - Performance 2)
(2, 2, 5, 3, 5, 4, 5),
-- Visitor 4 (Event 1 - Performance 2)
(4, 2, 4, 4, 5, 3, 4),
-- Visitor 5 (Event 2 - Performance 3)
(5, 3, 1, 5, 2, 4, 5),
-- Visitor 7 (Event 2 - Performance 3)
(7, 3, 3, 4, 3, 3, 3),
-- Visitor 8 (Event 2 - Performance 4)
(8, 4, 2, 3, 5, 4, 5),
-- Visitor 9 (Event 3 - Performance 5)
(9, 5, 1, 3, 4, 2, 4),
-- Visitor 11 (Event 3 - Performance 5)
(11, 5, 5, 3, 3, 4, 3),
-- Visitor 12 (Event 3 - Performance 6)
(12, 6, 4, 1, 4, 3, 4),
-- Visitor 13 (Event 4 - Performance 7)
(13, 7, 1, 5, 2, 4, 5),
-- Visitor 15 (Event 4 - Performance 7)
(15, 7, 3, 4, 3, 3, 3),
-- Visitor 16 (Event 4 - Performance 8)
(16, 8, 1, 1, 2, 4, 2),
-- Visitor 17 (Event 5 - Performance 9)
(17, 9, 5, 3, 4, 2, 4),
-- Visitor 19 (Event 5 - Performance 9)
(19, 9, 3, 3, 3, 4, 3),
-- Visitor 20 (Event 5 - Performance 10)
(20, 10, 4, 3, 1, 3, 4),
-- Visitor 21 (Event 6 - Performance 11)
(21, 11, 5, 2, 5, 4, 1),
-- Visitor 23 (Event 6 - Performance 11)
(23, 11, 5, 4, 3, 1, 3),
-- Visitor 24 (Event 6 - Performance 12)
(24, 12, 1, 3, 5, 4, 5),
-- Visitor 25 (Event 7 - Performance 13)
(25, 13, 2, 3, 4, 1, 4),
-- Visitor 27 (Event 7 - Performance 13)
(27, 13, 5, 1, 3, 4, 3),
-- Visitor 28 (Event 7 - Performance 14)
(28, 14, 4, 1, 4, 3, 2),
-- Visitor 29 (Event 8 - Performance 15)
(29, 15, 1, 4, 2, 4, 3);



