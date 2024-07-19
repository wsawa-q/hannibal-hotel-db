insert into Customers values ('will.graham@example.com', 'Will', 'Graham');
insert into Customers values ('hannibal.lecter@example.com', 'Hannibal', 'Lecter');
insert into Customers values ('jack.crawford@example.com', 'Jack', 'Crawford');
insert into Customers values ('alana.bloom@example.com', 'Alana', 'Bloom');

insert into RoomTypes values ('Ravens Suite', 'Luxurious suite with a view of the woods', 300.00);
insert into RoomTypes values ('Chesapeake Standard', 'Comfortable room with art pieces', 200.00);
insert into RoomTypes values ('Verger Deluxe', 'Spacious room with a balcony', 250.00);

insert into Rooms values (101, 'Ravens Suite');
insert into Rooms values (402, 'Chesapeake Standard');
insert into Rooms values (911, 'Verger Deluxe');

insert into Services values ('Therapy Session', 'One-on-one session with Dr. Lecter', 150.00);
insert into Services values ('Forensic Analysis', 'Detailed analysis of crime scenes', 200.00);

declare
  l_id number; 
begin
  insert into Reservations 
  values (null, 'will.graham@example.com', 101, date '2023-08-10', date '2023-08-15')
  returning reservation_id into l_id;
  
  insert into Reviews 
  values (l_id, 4.5, 'Intriguing stay. The therapy session was... enlightening.');
  
  insert into servicesreservations
  values (l_id, 'Therapy Session');
  
  insert into Reservations 
  values (null, 'hannibal.lecter@example.com', 402, date '2023-07-12', date '2023-07-14')
  returning reservation_id into l_id;
  
  insert into Reviews 
  values (l_id, 5.0, 'A culinary delight. The room was impeccable.');
  
  insert into Reservations 
  values (null, 'jack.crawford@example.com', 911, date '2023-06-16', date '2023-06-20')
  returning reservation_id into l_id;
  
  insert into Reviews 
  values (l_id, 3.5, 'The forensic analysis was detailed but the room lacked certain amenities.');
  
  insert into servicesreservations
  values (l_id, 'Forensic Analysis');
  
  insert into Reservations 
  values (null, 'alana.bloom@example.com', 402, date '2023-08-10', date '2023-08-12')
  returning reservation_id into l_id;
  
  insert into Reviews 
  values (l_id, 4.0, 'Comfortable stay. The art pieces were a nice touch.');
end;
/