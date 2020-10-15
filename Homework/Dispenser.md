

Dispenser, Product, Sale, Receipt.
====

    - Can I add a condition to an auto calculated column?
    - 

Things to have in mind:
---
    - Do we need a Money Bill table?
    - Dispensers type will be Drinks, Snacks, Warm Drinks.
    - We need a change operation in the receipt table, so it returns the money difference.
    - With each product added to a recepit, that product's existence must decrease in the product table.

## Dispenser

    - id
    - type
    - company

## Product

    - id
    - dispenser id (refers to Dispenser.id)
    - name
    - price
    - type
    - existences (auto changeable)

## Sale

    - id
    - dispenser id (refers to Dispenser.id)
    - header
    - date

## Recepit

    - id
    - id sale (refers to Sale.id)
    - id product (refers to Product.id)
    - price (must be extracted from product)
    - tax
    - bill
    - change (auto generated)
    - total

## Things left.
    - Trigger for eliminating an existence once a receipt is proccesed. When a new receipt is inserted in the table, the existence of the product the receipt is making a reference must decrease one number. (DONE)
    - Calculate change when bill is greater than price. (DONE)
    - Extract price from product table in receipt. (DONE)
    - Calculate total fee in receipt. (DONE)

