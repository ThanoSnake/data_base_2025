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

   
 

 - **equipment:**Equipment types available at the festival

   
  
 - **stage_equipment:** Equipment by stage and quantity

   
   

 - **artist:**Artists with details and social profiles

   

 - **performance:** Artist performances within events

   

 - **performance_artist:** Association of artists with performance.

   

 - **artist_genre:** Music genres and subgenres by artist

   

 - **band:** Bands with formation date and profile

   

 - **band_genre:** Music genres and subgenres by band

   

 - **band_member:** Artists' connection with bands.

   

 - **visitor:**Festival visitor information

   

 - **ticket:** Tickets for events and visitors

   

 - **visitor_contact:** Visitor phone and email

   

 - **resale_queue**: Ticket resale requests

   

 - **buyer_interest_queue:** Buyer interest queue for tickets

   

 - **review:** Performance reviews by visitors

##  Entity Related Diagram

![Alt Text](https://github.com/ThanoSnake/data_base_2025/blob/main/diagrams/er.png)

## Relational Schema

![Alt Text](https://github.com/ThanoSnake/data_base_2025/blob/main/diagrams/relational.png)

##  Contributors

Μιχαήλ Παναγόπουλος
Αθανάσιος Φειδάκης


