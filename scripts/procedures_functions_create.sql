create or replace package customers_pkg as
  -- Adds a new customer to the customers table
  procedure add_new_customer(p_email varchar2, p_first_name varchar2, p_last_name varchar2);
end customers_pkg;
/

create or replace package body customers_pkg as
  procedure add_new_customer(
    p_email in varchar2,
    p_first_name in varchar2,
    p_last_name in varchar2
  ) as 
  begin
    insert into customers(email, first_name, last_name)
    values(p_email, p_first_name, p_last_name);
  exception
    when others then
      raise_application_error(-20001, 'Error adding customer: ' || sqlerrm);
  end add_new_customer;
end customers_pkg;
/

create or replace package reservations_pkg as
  -- Adds a new reservation to the reservations table
  procedure new_reservation(p_email in varchar2, p_room_number in number, p_start_date in date, p_end_date in date);
  
  -- Calculates the total payment for a reservation
  function calculate_payment(p_reservation_id in number) return number;
  
  -- Checks if a room is available for a given date range
  function is_room_available(p_room_number in number, p_start_date in date, p_end_date in date) return boolean;
  
  -- Checks if the given room type is available on given date
  procedure check_availability(p_roomtype varchar2, p_start_date date, p_end_date date);
end reservations_pkg;
/

create or replace package body reservations_pkg as
  procedure new_reservation(
    p_email in varchar2,
    p_room_number in number,
    p_start_date in date,
    p_end_date in date
  ) as 
  begin
    insert into reservations(email, room_number, start_date, end_date)
    values(p_email, p_room_number, p_start_date, p_end_date);
  exception
    when others then
      raise_application_error(-20002, 'Error adding reservation: ' || sqlerrm);
  end new_reservation;


  function calculate_payment(p_reservation_id in number) 
  return number as 
    l_total_payment number;
  begin
    select sum(price_per_night * (end_date - start_date))
    into l_total_payment
    from reservations r 
    join rooms rm on r.room_number = rm.room_number
    join roomtypes rt on rm.type_name = rt.type_name
    where r.reservation_id = p_reservation_id;

    return l_total_payment;
  exception
    when others then
      raise_application_error(-20003, 'Error calculating payment: ' || sqlerrm);
      return null;
  end calculate_payment;

  function is_room_available(
    p_room_number in number, 
    p_start_date in date, 
    p_end_date in date
  ) return boolean as 
    l_count number;
  begin
    select count(*)
    into l_count
    from reservations
    where room_number = p_room_number 
    and (p_start_date between start_date and end_date 
    or p_end_date between start_date and end_date 
    or (p_start_date <= start_date and p_end_date >= end_date));

    return (l_count = 0);
  
  exception
    when others then
      raise_application_error(-20004, 'Error checking room availability: ' || sqlerrm);
      return false;
  end is_room_available;
  
  procedure check_availability(
    p_roomtype in varchar2, 
    p_start_date in date, 
    p_end_date in date
  ) as
    v_room_number number;
    v_available boolean := false;
    cursor c_rooms is
      select r.room_number
      from rooms r
      where r.type_name = p_roomtype;
  begin
    -- Loop through all rooms of the given type
    for room in c_rooms loop
      v_available := is_room_available(room.room_number, p_start_date, p_end_date);
      if v_available then
        v_room_number := room.room_number;
        exit;
      end if;
    end loop;
    
    if v_available then
      dbms_output.put_line('Room ' || v_room_number || ' of type ' || p_roomtype || ' is available.');
    else
      dbms_output.put_line('No rooms of type ' || p_roomtype || ' are available.');
    end if;
    
  exception
    when others then
      dbms_output.put_line('Error occurred when checking availability for type ' || p_roomtype || '.');
  end check_availability;
end reservations_pkg;
/

create or replace package analytics_pkg as
  -- Gets the total number of reservations for a specific customer
  function get_total_reservations(p_email in varchar2) return number;
end analytics_pkg;
/

create or replace package body analytics_pkg as
  function get_total_reservations(p_email in varchar2) 
  return number as 
    l_count number;
  begin
    select count(*)
    into l_count
    from reservations
    where email = p_email;

    return l_count;
  exception
    when others then
      raise_application_error(-20006, 'Error getting total reservations: ' || sqlerrm);
      return null;
  end get_total_reservations;
end analytics_pkg;
/

create or replace package services_pkg as
  -- Adds a new service to the services table
  procedure add_new_service(p_service_name varchar2, p_description varchar2, p_price number);
end services_pkg;
/

create or replace package body services_pkg as
  procedure add_new_service(
    p_service_name in varchar2,
    p_description in varchar2,
    p_price in number
  ) as 
  begin
    insert into services(service_name, description, price)
    values(p_service_name, p_description, p_price);
  exception
    when others then
      raise_application_error(-20007, 'Error adding new service: ' || sqlerrm);
  end add_new_service;

end services_pkg;
/

create or replace package payments_pkg as
  -- Adds a new payment for a specific reservation
  procedure add_new_payment(p_reservation_id in number, p_amount_paid in number, p_payment_date in date);
end payments_pkg;
/

create or replace package body payments_pkg as
  procedure add_new_payment(
    p_reservation_id in number,
    p_amount_paid in number,
    p_payment_date in date
  ) as 
  begin
    insert into payments(reservation_id, amount_paid, payment_date)
    values(p_reservation_id, p_amount_paid, p_payment_date);
  exception
    when others then
      raise_application_error(-20008, 'Error adding new payment: ' || sqlerrm);
  end add_new_payment;
end payments_pkg;
/


create or replace package reservationservices_pkg as
  -- Adds a service to a specific reservation
  procedure add_service_to_reservation(p_reservation_id in number, p_service_name varchar2);
end reservationservices_pkg;
/

create or replace package body reservationservices_pkg as
  procedure add_service_to_reservation(
    p_reservation_id in number,
    p_service_name varchar2
  ) as 
  begin
    insert into servicesreservations(reservation_id, service_name)
    values(p_reservation_id, p_service_name);
  exception
    when others then
      raise_application_error(-20009, 'Error adding service to reservation: ' || sqlerrm);
  end add_service_to_reservation;
end reservationservices_pkg;
/

create or replace package reviews_pkg as
  -- Adds a new review for a specific reservation
  procedure add_new_review(p_reservation_id in number, p_rating in number, p_comments varchar2);
end reviews_pkg;
/

create or replace package body reviews_pkg as
  procedure add_new_review(
    p_reservation_id in number,
    p_rating in number,
    p_comments varchar2
  ) as 
  begin
    -- Check if reservation already has a review
    declare 
      v_count number;
    begin
      select count(*) into v_count from reviews where reservation_id = p_reservation_id;
      if v_count > 0 then
        raise_application_error(-20010, 'A review for this reservation already exists.');
        return;
      end if;
    end;

    -- Insert the new review
    insert into reviews(reservation_id, rating, comments)
    values(p_reservation_id, p_rating, p_comments);
  exception
    when others then
      raise_application_error(-20010, 'Error adding new review: ' || sqlerrm);
  end add_new_review;
end reviews_pkg;
/

