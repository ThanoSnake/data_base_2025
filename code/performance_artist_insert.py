import random

performance_years = {
    1: 2016, 2: 2016, 3: 2016, 4: 2016, 5: 2016, 6: 2016, 7: 2016, 8: 2016, 9: 2016, 10: 2016,
    11: 2018, 12: 2018, 13: 2018, 14: 2018, 15: 2018, 16: 2018, 17: 2018, 18: 2018, 19: 2018, 20: 2018,
    21: 2020, 22: 2020, 23: 2020, 24: 2020, 25: 2020, 26: 2020, 27: 2020, 28: 2020, 29: 2020, 30: 2020,
    31: 2021, 32: 2021, 33: 2021, 34: 2021, 35: 2021, 36: 2021, 37: 2021, 38: 2021, 39: 2021, 40: 2021,
    41: 2019, 42: 2019, 43: 2019, 44: 2019, 45: 2019, 46: 2019, 47: 2019, 48: 2019, 49: 2019, 50: 2019,
    51: 2022, 52: 2022, 53: 2022, 54: 2022, 55: 2022, 56: 2022, 57: 2022, 58: 2022, 59: 2022, 60: 2022,
    61: 2017, 62: 2017, 63: 2017, 64: 2017, 65: 2017, 66: 2017, 67: 2017, 68: 2017, 69: 2017, 70: 2017,
    71: 2023, 72: 2023, 73: 2023, 74: 2023, 75: 2023, 76: 2023, 77: 2023, 78: 2023, 79: 2023, 80: 2023,
    81: 2026, 82: 2026, 83: 2026, 84: 2026, 85: 2026, 86: 2026, 87: 2026, 88: 2026, 89: 2026, 90: 2026,
    91: 2027, 92: 2027, 93: 2027, 94: 2027, 95: 2027, 96: 2027, 97: 2027, 98: 2027, 99: 2027, 100: 2027
}

### Δομή bands (band_id: [artist_ids]) ###
bands = {
    1: [25, 26, 27, 28],
    2: [29, 30, 31, 32, 33],
    3: [34, 35, 36],
    4: [37, 38, 39, 40],
    5: [41, 42, 43, 44, 45],
    6: [46, 47, 48],
    7: [49, 50, 25, 26],
    8: [27, 28, 29, 30, 31],
    9: [32, 33, 34],
    10: [35, 36, 37, 38]
}

### Solo artists (artist_id 1-25) ###
solo_artists = list(range(1, 26))

### Λεξικό για παρακολούθηση συμμετοχών όλων των καλλιτεχνών ###
artist_participations = {}

# Αρχικοποίηση για όλους τους solo καλλιτέχνες
for artist_id in solo_artists:
    artist_participations[artist_id] = []

# Αρχικοποίηση για όλα τα μέλη συγκροτημάτων
for band_members in bands.values():
    for artist_id in band_members:
        if artist_id not in artist_participations:
            artist_participations[artist_id] = []

### Συνάρτηση ελέγχου συνεχόμενων ετών ###
def check_consecutive_years(years_list, new_year, max_consecutive=3):
    if not years_list:
        return True
        
    # Δημιουργία λίστας μοναδικών ετών με το νέο έτος
    unique_years = sorted(list(set(years_list + [new_year])))
    
    max_consec = 1
    current_consec = 1
    
    for i in range(1, len(unique_years)):
        if unique_years[i] == unique_years[i-1] + 1:
            current_consec += 1
            max_consec = max(max_consec, current_consec)
        else:
            current_consec = 1
            
    return max_consec <= max_consecutive

### Δημιουργία INSERT statements ###
inserts = []
for performance_id, year in performance_years.items():
    max_attempts = 20  # Μέγιστες προσπάθειες αναζήτησης
    assigned = False
    
    for attempt in range(max_attempts):
        # 50% πιθανότητα για band ή solo
        use_band = random.random() < 0.5
        
        if use_band:
            # Επιλογή τυχαίου band και έλεγχος όλων των μελών
            band_id = random.choice(list(bands.keys()))
            band_members = bands[band_id]
            
            # Έλεγχος αν όλα τα μέλη ικανοποιούν τον περιορισμό
            all_valid = True
            for artist_id in band_members:
                if not check_consecutive_years(artist_participations[artist_id], year):
                    all_valid = False
                    break
            
            if all_valid:
                for artist_id in band_members:
                    inserts.append(
                        f"INSERT INTO performance_artist(performance_id, artist_id) "
                        f"VALUES ({performance_id}, {artist_id});"
                    )
                    artist_participations[artist_id].append(year)
                assigned = True
                break
        
        else:
            # Επιλογή τυχαίου solo artist που ικανοποιεί τον περιορισμό
            valid_artists = [a for a in solo_artists 
                           if check_consecutive_years(artist_participations[a], year)]
            
            if valid_artists:
                artist_id = random.choice(valid_artists)
                inserts.append(
                    f"INSERT INTO performance_artist(performance_id, artist_id) "
                    f"VALUES ({performance_id}, {artist_id});"
                )
                artist_participations[artist_id].append(year)
                assigned = True
                break
    
    if not assigned:
        print(f"Δεν βρέθηκε διαθέσιμος καλλιτέχνης/συγκρότημα για performance {performance_id} (έτος {year})")

### Εκτύπωση όλων των INSERT statements ###
for insert in inserts:
    print(insert)