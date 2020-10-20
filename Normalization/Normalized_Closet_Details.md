

# Closet and Clothes Excercise.
    Inicially, we need two tables:
    - Closet
    - Clothes

    At the end, we must be able to find out how many tipes of clothes we have, and list the quantity of clothe per each type.

## Initial Tables.
    
### Closet Tale
    For a Closet basic table, we may want a design like this one:
    - Size
    - Material
    - Builder
    - Capacity
    
    To normalize it, we may specify other details about the Builder or the materials the closet is made of, the size can be specified by its dimensions.

### Clothes table.
    We may decide to design a table for clothes like this one:
    - Size
    - Brand
    - Country
    - Material
    - Gender
    - Description
    - Type
    - Existences
    
    We could say that Brand and Country could go along in a single since a Brand is originally from one; material for clothing can go in another table, like gender and size with other useful information.

## Decomposing tables for reaching normalization.

### Tables derived from Closet.
    
    Closet main table:
    - id
    - id_dimensions
    - id_builder
    - id_material    
    - description

    Size table:
    - id
    - height
    - width
    - depth

    Material table:
    - id
    - name

    Builder Table:
    - id
    - id_country
    - name

### Tables derived from Clothe

    Main clothe table:
    - id
    - id_size
    - id_brand
    - id_material
    - description

    Sizes table:
    - id
    - size
    - gender
    - age
    
    Material table:
    - id
    - name

    Brand table:
    - id
    - name
    - id_country

### Derived table country
    This is a table both closet and clothes will use:
    - id
    - name
    - continent
    