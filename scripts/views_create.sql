-- List of customers including data from associated tables
create view view_customers as
select c.email, c.first_name, c.last_name, r.room_number, r.start_date, r.end_date, p.amount_paid, p.payment_date
from customers c
left join reservations r on c.email = r.email
left join payments p on r.reservation_id = p.reservation_id;

-- List of reservations, including customer data
create view view_reservations as
select c.first_name, c.last_name, c.email, r.room_number, r.start_date, r.end_date
from customers c
join reservations r on c.email = r.email;

-- List of customers who have given a rating of 4 or above
create view view_high_rating_customers as
select c.first_name, c.last_name, c.email, r.rating
from customers c
join reservations res on c.email = res.email
join reviews r on res.reservation_id = r.reservation_id
where r.rating >= 4;

-- List of services and their total revenue
create view view_service_revenue as
select s.service_name, s.price, count(sr.reservation_id) * s.price as total_revenue
from services s
join servicesreservations sr on s.service_name = sr.service_name
group by s.service_name, s.price;

-- List of rooms and their current occupancy status
create view view_room_status as
select rm.room_number, rm.type_name,
case when r.room_number is null then 'Available' else 'Occupied' end as status
from rooms rm
left join reservations r on rm.room_number = r.room_number;

-- List of customers with their total payments
create view view_customers_payments as
select c.email, c.first_name, c.last_name, sum(p.amount_paid) as total_paid
from customers c
join reservations r on c.email = r.email
join payments p on r.reservation_id = p.reservation_id
group by c.email, c.first_name, c.last_name;


-- List of upcoming reservations in the next 7 days
create view view_upcoming_reservations as
select r.reservation_id, c.first_name, c.last_name, r.room_number, r.start_date, r.end_date
from reservations r
join customers c on r.email = c.email
where r.start_date between sysdate and sysdate + 7;