exec dbms_stats.delete_table_stats(ownname => USER, tabname => 'Customers');
exec dbms_stats.delete_table_stats(ownname => USER, tabname => 'RoomTypes');
exec dbms_stats.delete_table_stats(ownname => USER, tabname => 'Rooms');
exec dbms_stats.delete_table_stats(ownname => USER, tabname => 'Reservations');
exec dbms_stats.delete_table_stats(ownname => USER, tabname => 'Payments');
exec dbms_stats.delete_table_stats(ownname => USER, tabname => 'ServicesReservations');
exec dbms_stats.delete_table_stats(ownname => USER, tabname => 'Services');
exec dbms_stats.delete_table_stats(ownname => USER, tabname => 'Reviews');
