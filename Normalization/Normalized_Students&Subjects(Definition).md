@author: lyraNoMilo_19.
@date: October 15, 2020.

# College BD: How to normalize this DataBase?
    - First, we can make a new table for PEOPLE, this will include the general data like name, age or sex. This in order to have tables with no duplicated attributes. We see STUDENT and TEACHER tables have some exact attributes. With normalization, we will avoid this redundancy in these two tables.
    - In the Subjects table we see a problem. Every register for some class needs to be inserted over and over again just to specify the name of the student or the name of the teacher. We could create a Table specially for registred students in a specific class, other table to describe each class section with its vital information like hour, vu, or something like that.

## Let's start defining people and its child tables.

### PEOPLE table. 
    This one will be a generic person table, with specific data that a person would have:
    - id
    - first name
    - second name
    - first last name
    - second last name
    - birth date
    - age
    - sex
    
    As we can see, this would be the general attributes for any person in this basic college Data Base.
    Now we'll make the tables that will make a reference to this table.

### STUDENT Table
    This will contain specific attributes of a student in the College, making a reference to someone in the PEOPLE table.
    - id
    - person's id
    - semester
    - year
    
    These are enough attributes to set a Student.

### TEACHER Table
    As in the previous section, this table will have specific attributes for someone who's a teacher.
    - id
    - person's id
    - start year
    - mail
    
    Not too much to add.

## Now, let's organize the Subjects.
    First of all, we need to what are the subjects available. For each of those subjects, we need a table of registered students. Also, we need other tables to know wich teachers are imparting the class. In the previous version of the database, we had a single table for all of the subjects. The name in those registers was redundant since we had to repeat a record with the only difference in the teacher or the student.
    Now, we need a table for each subject that has a record of all registered students, we need a table to define each subject as well.

### Main SUBJECT table.
    We'll create the table for each subject in the college, specifying general data in each record. A subject has:
    - id 
    - name
    - vu
    - section
    - hour
    
    This would make it up for a general Subjects table.
    Now, in the previous version of the database we had these signatures:
    - General History
    - Biology
    - Math
    - Physics
    - Music Appreciation
    - Spanish
    - Science
    - Physic Education
    
### All of the RegisteredStudents table.
    
    Registered Students in General History.
    - list id
    - student id
    - main class id
    - section
    - hour
    
    Registered Students in Biology.
    - list id
    - student id
    - main class id
    - section
    - hour
    
    Registered Students in Math.
    - list id
    - student id
    - main class id
    - section
    - hour
    
    Registered Students in Physics.
    - list id
    - student id
    - main class id
    - section
    - hour
    
    Registered Students in Music Appreciation.
    - list id
    - student id
    - main class id
    - section
    - hour
    
    Registered Students in Spanish.
    - list id
    - student id
    - main class id
    - section
    - hour
    
    Registered Students in Science.
    - list id
    - student id
    - main class id
    - section
    - hour
    
    Registered Students in Physic Education.
    - list id
    - student id
    - main class id
    - section
    - hour
    
    
### All of the RegisteredTeachers table.

    Registered Teachers in General History.
    - list id
    - teacher id
    - main class id
    - section
    - hour
    
    Registered Teachers in Biology.
    - list id
    - teacher id
    - main class id
    - section
    - hour
    
    Registered Teachers in Math.
    - list id
    - teacher id
    - main class id
    - section
    - hour
    
    Registered Teachers in Physics.
    - list id
    - teacher id
    - main class id
    - section
    - hour
    
    Registered Teachers in Music Appreciation.
    - list id
    - teacher id
    - main class id
    - section
    - hour
    
    Registered Teachers in Spanish.
    - list id
    - teacher id
    - main class id
    - section
    - hour
    
    Registered Teachers in Science.
    - list id
    - teacher id
    - main class id
    - section
    - hour
    
    Registered Teachers in Physic Education.
    - list id
    - teacher id
    - main class id
    - section
    - hour

## Is this well done?
    We'll see when all of this is implemented in a SQL Script.
    
    