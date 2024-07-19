-- TEST SCRIPT

-- 1. Testing the unique email constraint for Customers
-- This should fail because 'will.graham@example.com' already exists
insert into Customers values ('will.graham@example.com', 'Bedelia', 'Du Maurier');

-- 2. Testing the email format constraint for Customers
-- This should fail because the email format is incorrect
insert into Customers values ('bedelia_du_maurier', 'Bedelia', 'Du Maurier');

-- 3. Testing the rating constraint for Reviews
-- This should fail because rating is out of bounds
insert into Reviews values (2, 6.0, 'Exceptional stay.');

-- 4. Testing the procedures and functions
-- Adding a new customer using the procedure
begin
  customers_pkg.add_new_customer('bedelia.du_maurier@example.com', 'Bedelia', 'Du Maurier');
end;
/

-- show customers table
select * from customers;

-- Checking if any room with type 'Ravens Suite' is available between '2023-08-10' and '2023-08-15'
begin
  reservations_pkg.check_availability('Ravens Suite', date '2023-08-10', date '2023-08-15');
end;
/

-- Check the truthfullness of the check_availability procedure
select * from rooms rm
join reservations r on rm.room_number=r.room_number;

-- Making a new reservation for Bedelia using the procedure
begin
  reservations_pkg.new_reservation('bedelia.du_maurier@example.com', 911, date '2023-08-21', date '2023-08-25');
end;
/

-- Show reservations table
select * from reservations;

-- Calculating the payment for the new reservation and insert the payment
declare
  l_payment_amount number;
  l_id number;
begin
  select reservation_id 
  into l_id 
  from reservations 
  order by reservation_id desc
  fetch first 1 row only;

  l_payment_amount := reservations_pkg.calculate_payment(l_id);
  dbms_output.put_line(l_payment_amount);
  
  payments_pkg.add_new_payment(l_id, l_payment_amount, SYSDATE);
end;
/

-- 5. Testing the trigger functionality
-- Check if adding high priced service triggers dmbs log
insert into Services values ('Private Culinary Experience', 'An exquisite and exclusive dining experience with Chef Hannibal. Enjoy a menu curated just for you.', 1200.00);

-- 6. Testing the views
-- Displaying the list of customers in detail
select * from view_customers;

-- Displaying the list of reservations
select * from view_reservations;

-- Displaying the list of services and their total revenue
select * from view_service_revenue;

-- Displaying the list of customers who have given a rating of 4 or above
select * from view_high_rating_customers;

-- 7. Testing the analytics function
-- Getting the total number of reservations for Hannibal
declare
  l_total_reservations number;
begin
  l_total_reservations := analytics_pkg.get_total_reservations('hannibal.lecter@example.com');
  dbms_output.put_line('Total reservations for Hannibal: ' || l_total_reservations);
end;
/

-- 8. Testing the services package
-- Adding a new service
begin
  services_pkg.add_new_service('Crime Scene Investigation', 'Detailed crime scene analysis with Will Graham', 250.00);
end;
/

-- Show services table
select * from services;

-- 9. Testing the deletion of a customer who has a review
-- This should fail due to the foreign key constraint with the Reservation table
delete from customers where email = 'hannibal.lecter@example.com';

-- Making a new reservation for Jack Crawford
insert into Reservations values (null, 'jack.crawford@example.com', 402, date '2023-09-05', date '2023-09-10');

-- Show reservations table
select * from reservations;

-- END OF TEST SCRIPT
