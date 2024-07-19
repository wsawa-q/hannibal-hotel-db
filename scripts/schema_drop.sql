-- Drop triggers
begin
  execute immediate 'drop trigger trg_before_insert_high_price_service';
  execute immediate 'drop trigger trg_prevent_overlapping_reservations';
exception
  when others then
    dbms_output.put_line('Error dropping triggers.');
end;
/

-- Drop packages
begin
  execute immediate 'drop package customers_pkg';
  execute immediate 'drop package reservations_pkg';
  execute immediate 'drop package analytics_pkg';
  execute immediate 'drop package services_pkg';
  execute immediate 'drop package payments_pkg';
  execute immediate 'drop package reservationservices_pkg';
  execute immediate 'drop package reviews_pkg';
exception
  when others then
    dbms_output.put_line('Error dropping packages.');
end;
/

-- Drop views
begin
  execute immediate 'drop view view_customers';
  execute immediate 'drop view view_reservations';
  execute immediate 'drop view view_high_rating_customers';
  execute immediate 'drop view view_service_revenue';
  execute immediate 'drop view view_room_status';
  execute immediate 'drop view view_customers_payments';
  execute immediate 'drop view view_upcoming_reservations';
exception
  when others then
    dbms_output.put_line('Error dropping views.');
end;
/

-- Drop tables
begin
  execute immediate 'drop table reviews cascade constraints';
  execute immediate 'drop table services cascade constraints';
  execute immediate 'drop table payments cascade constraints';
  execute immediate 'drop table reservations cascade constraints';
  execute immediate 'drop table roomtypes cascade constraints';
  execute immediate 'drop table customers cascade constraints';
  execute immediate 'drop table rooms cascade constraints';
  execute immediate 'drop table servicesreservations cascade constraints';
exception
  when others then
    dbms_output.put_line('Error dropping tables.');
end;
/

commit;
