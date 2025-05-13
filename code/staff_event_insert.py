import random
import math
from collections import defaultdict

event_capacities = {1:100, 2:135, 3:150, 4:120, 5:130, 6:140, 7:110, 8:100, 9:170, 10:130, 11:130, 12:120, 13:170, 14:100, 15:110, 16:130, 17:110, 18:150, 19:145, 20:115, 21:130, 22:110, 23:130, 24:120, 25:100, 26:120, 27:140, 28:100, 29:130, 30:110, 31:100, 32:135, 33:150, 34:120, 35:130, 36:140, 37:110, 38:100, 39:170, 40:130, 41:130, 42:120, 43:170, 44:100, 45:110, 46:130, 47:110, 48:150, 49:145, 50:115}
staff_jobs = {1:'technical', 2:'technical', 3:'technical', 4:'security', 5:'assistant', 6:'technical', 7:'technical', 8:'assistant', 9:'assistant', 10:'security', 11:'security', 12:'technical', 13:'assistant', 14:'technical', 15:'assistant', 16:'technical', 17:'security', 18:'technical', 19:'assistant', 20:'security', 21:'technical', 22:'security', 23:'assistant', 24:'technical', 25:'security', 26:'assistant', 27:'technical', 28:'security', 29:'assistant', 30:'technical', 31:'technical', 32:'security', 33:'assistant', 34:'technical', 35:'assistant', 36:'technical', 37:'security', 38:'technical', 39:'assistant', 40:'security', 41:'technical', 42:'security', 43:'assistant', 44:'technical', 45:'assistant', 46:'security', 47:'assistant', 48:'technical', 49:'security', 50:'technical'}


def generate_staff_event_inserts(staff_jobs, event_capacities):
    # Separate staff by their job types
    technical_staff = [s for s, job in staff_jobs.items() if job == 'technical']
    security_staff = [s for s, job in staff_jobs.items() if job == 'security']
    assistant_staff = [s for s, job in staff_jobs.items() if job == 'assistant']
    
    # Shuffle security and assistant staff for random assignment
    random.shuffle(security_staff)
    random.shuffle(assistant_staff)
    
    # Initialize pointer for round-robin technical staff assignment
    tech_pointer = 0
    
    # Generate INSERT statements
    inserts = []
    inserts.append("-- Staff Event Assignments")
    inserts.append("INSERT INTO staff_event (staff_id, event_id) VALUES")
    
    # Process each event in order
    for event_id, capacity in sorted(event_capacities.items()):
        # Calculate required staff using ceil
        security_needed = max(1, math.ceil(capacity * 0.05))  # At least 5% for security
        assistants_needed = max(1, math.ceil(capacity * 0.02))  # At least 2% for assistants
        
        # Assign exactly one technical staff in round-robin order
        staff_id = technical_staff[tech_pointer]
        inserts.append(f"({staff_id}, {event_id}),")
        tech_pointer = (tech_pointer + 1) % len(technical_staff)
        
        # Assign security staff
        for staff_id in security_staff[:security_needed]:
            inserts.append(f"({staff_id}, {event_id}),")
        
        # Assign assistant staff
        for staff_id in assistant_staff[:assistants_needed]:
            inserts.append(f"({staff_id}, {event_id}),")
    
    # Remove the last comma and add semicolon
    if len(inserts) > 2:
        inserts[-1] = inserts[-1].rstrip(',') + ";"
    else:
        inserts.append("(1, 1);")  # Fallback if no assignments were added
    
    return "\n".join(inserts)


# Generate and print the INSERT statements
print(generate_staff_event_inserts(staff_jobs, event_capacities))