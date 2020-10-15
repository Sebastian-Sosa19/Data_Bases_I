@author: lyraNoMilo_19.
@date: October 15, 2020.

# College BD: How to normalize this DataBase?
    - First, we can make a new table for PEOPLE, this will include the general data like name, age or sex. This in order to have tables with no duplicated attributes. We see STUDENT and TEACHER tables have some exact attributes. With normalization, we will avoid this redundancy in these two tables.
    - In the Subjects table we see a problem. Every register for some class needs to be inserted over and over again just to specify the name of the student or the name of the teacher. We could create a Table specially for registred students in a specific class, other table to describe each class section with its vital information like hour, vu, or something like that.

## Let's start defining people and its child tables:

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
    -  

    