# Database Application annibal-hotel-db

## Overview
This repository contains scripts for a database application. It includes the schema definition, sample data, stored procedures, functions, triggers, and various utility scripts for managing the database.

## Contents
- **demo_data.sql**: Inserts sample data into the database for testing and demonstration purposes.
- **procedures_functions_create.sql**: Defines stored procedures and functions used in the application.
- **schema_create.sql**: Contains `CREATE TABLE` statements to define the database schema.
- **schema_drop.sql**: Contains `DROP TABLE` statements to remove the database schema.
- **statistics_drop.sql**: Commands to drop database statistics objects.
- **statistics_generate.sql**: Commands to generate or update statistics for query optimization.
- **test.sql**: Includes SQL commands to test the database application.
- **triggers_create.sql**: Defines triggers that automatically execute in response to certain events.
- **views_create.sql**: Contains `CREATE VIEW` statements to define virtual tables.

## Procedures and Functions
### Procedures
- **Example Procedure**
    ```sql
    CREATE PROCEDURE procedure_name (parameters)
    BEGIN
        -- Procedure logic
    END;
    ```

### Functions
- **Example Function**
    ```sql
    CREATE FUNCTION function_name (parameters)
    RETURNS return_type
    BEGIN
        -- Function logic
        RETURN value;
    END;
    ```

## Triggers
- **Example Trigger**
    ```sql
    CREATE TRIGGER trigger_name
    AFTER INSERT ON table_name
    FOR EACH ROW
    BEGIN
        -- Trigger logic
    END;
    ```

## Detailed File Descriptions

### demo_data.sql
This file contains `INSERT` statements to populate the tables with initial data. This is useful for testing and demonstrating the database application.

### procedures_functions_create.sql
This file contains the definitions of various stored procedures and functions.

#### Stored Procedures
Stored procedures are routines that perform operations such as data manipulation or complex calculations.

#### Functions
Functions return a single value and can be used in SQL queries for various purposes like computations or data formatting.

### schema_create.sql
This file includes `CREATE TABLE` statements that describe the structure of the tables, including columns, data types, constraints (like primary keys, foreign keys), and other table properties.

### schema_drop.sql
This file includes `DROP TABLE` statements to remove tables from the database. This is typically used to clean up or reset the database schema.

### statistics_drop.sql
This file contains SQL commands to drop statistics objects used for performance tuning and query optimization in the database.

### statistics_generate.sql
This file includes commands to generate or update statistics for the database, helping the database engine make efficient query plans.

### test.sql
This file includes SQL commands to test various aspects of the database application. It might contain `SELECT` queries, test cases, or validation scripts to ensure the database behaves as expected.

### triggers_create.sql
This file defines database triggers. Triggers are special types of stored procedures that automatically execute in response to certain events on a particular table or view.

### views_create.sql
This file contains `CREATE VIEW` statements. Views are virtual tables that are based on the result-set of a SQL query, providing a way to encapsulate complex queries and present data in a simplified manner.

## How to Use
1. Run `schema_create.sql` to create the database schema.
2. Execute `demo_data.sql` to populate the database with sample data.
3. Use `procedures_functions_create.sql` to create necessary stored procedures and functions.
4. Apply triggers by running `triggers_create.sql`.
5. Create views using `views_create.sql`.
6. Use `statistics_generate.sql` to generate necessary statistics for optimization.
7. Test the setup using `test.sql`.
8. Clean up by running `schema_drop.sql` and `statistics_drop.sql` if needed.

## License
This project is licensed under the MIT License.
