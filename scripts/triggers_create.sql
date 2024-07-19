-- High price service is inserted
create or replace trigger trg_before_insert_high_price_service
after insert on services
for each row
declare
  l_high_price_threshold number := 1000;
begin
  if :new.price > l_high_price_threshold then
    dbms_output.put_line('A high-priced service is being added: ' || :new.service_name);
    -- Additional actions or notifications can be added here
  end if;
end trg_before_insert_high_price_service;
/

-- Prevent Overlapping Reservations
create or replace trigger trg_prevent_overlapping_reservations
before insert or update on reservations
for each row
declare
    v_count number;
begin
    select count(*)
    into v_count
    from reservations
    where room_number = :new.room_number
    and (start_date between :new.start_date and :new.end_date
    or end_date between :new.start_date and :new.end_date
    or :new.start_date between start_date and end_date);
    
    if v_count > 0 then
        raise_application_error(-20001, 'The room is already booked for the selected dates.');
    end if;
end;
/
