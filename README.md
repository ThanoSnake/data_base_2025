# Pulse Festival Database

Welcome to the Pulse Festival Database! This project provides a structured and scalable schema for managing all aspects of a multi-day music and arts festival. From venues and events to artists, performances, and ticketing, this system is designed to handle the complex logistics and data relationships involved in organizing large-scale festival experiences.


## Directory Features

**Database Management:** Built with MySQL to ensure reliable and consistent relational data handling.

**Schema Design:** A normalized [schema](https://github.com/ThanoSnake/data_base_2025/blob/main/sql/install.sql) featuring keys, constraints, [triggers](https://github.com/ThanoSnake/data_base_2025/blob/main/sql/triggers_procedures.sql), and checks for robust data integrity.

**Performance Support:** Designed for [querying](https://github.com/ThanoSnake/data_base_2025/blob/main/sql/all_queries.sql) across a variety of use cases, including performance reviews, ticket sales, and equipment logistics.

**Scalable Design:** Supports multiple festivals, locations, and years with minimal redundancy.


## Database Features



 - **location:** Πληροφορίες τοποθεσίας για φεστιβάλ (διεύθυνση, συντεταγμένες, πόλη, χώρα).
 
 - **festival:** Στοιχεία φεστιβάλ ανά έτος και τοποθεσία.
   
   
 - **stage:** Δεδομένα για σκηνές (όνομα, περιγραφή, χωρητικότητα).
   
   
 - **event:** Εκδηλώσεις που λαμβάνουν χώρα σε φεστιβάλ και σκηνές.
   
   
 - **staff:** Προσωπικό με ρόλους, εμπειρία και ειδικότητα.

   
  

 - **technical_staff:** Τεχνικό προσωπικό με εξειδίκευση.

   
   

 - **staff_event:** Συσχέτιση προσωπικού με εκδηλώσεις.

   
 

 - **equipment:** Τύποι εξοπλισμού διαθέσιμοι στο φεστιβάλ.

   
  
 - **stage_equipment:** Εξοπλισμός ανά σκηνή και ποσότητα.

   
   

 - **artist:** Καλλιτέχνες με στοιχεία και κοινωνικά προφίλ.

   

 - **performance:** Εμφανίσεις καλλιτεχνών εντός εκδηλώσεων.

   

 - **performance_artist:** Συσχέτιση καλλιτεχνών με εμφανίσεις.

   

 - **artist_genre:** Μουσικά είδη και υποείδη ανά καλλιτέχνη.

   

 - **band:** Μπάντες με ημερομηνία ίδρυσης και προφίλ.

   

 - **band_genre:** Μουσικά είδη και υποείδη ανά μπάντα.

   

 - **band_member:** Σύνδεση καλλιτεχνών με μπάντες.

   

 - **visitor:** Πληροφορίες επισκεπτών φεστιβάλ.

   

 - **ticket:** Εισιτήρια για εκδηλώσεις και επισκέπτες.

   

 - **visitor_contact:** Τηλέφωνο και email επισκεπτών.

   

 - **resale_queue**: Αιτήματα μεταπώλησης εισιτηρίων.

   

 - **buyer_interest_queue:** Αναμονή αγοραστών για εισιτήρια.

   

 - **review:** Αξιολογήσεις εμφανίσεων από επισκέπτες

##  Entity Related Diagram

![Alt Text](https://github.com/ThanoSnake/data_base_2025/blob/main/diagrams/er.png)

## Relational Schema

![Alt Text](https://github.com/ThanoSnake/data_base_2025/blob/main/diagrams/relational.png)

##  Contributors

Μιχαήλ Παναγόπουλος
Αθανάσιος Φειδάκης


