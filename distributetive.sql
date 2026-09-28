--1
--SELECT * FROM airplanes;

--2
--SELECT * FROM airports LIMIT 5;

--3
--SELECT * FROM airports 
--ORDER BY coordinates[0] DESC 
--LIMIT 3;

--4
--SELECT * FROM airplanes 
--WHERE model LIKE '%Airbus%';

--5
--SELECT * FROM airports 
--WHERE LENGTH(airport_name) = 2 
 -- AND city = airport_name;

 --6
 --SELECT * FROM airplanes 
--WHERE "range" BETWEEN 3000 AND 6000;

 --7
 --SELECT DISTINCT timezone 
--FROM airports;

--8
-- Предполагаем наличие таблицы seats, связанной с самолетами
--SELECT s.* 
--FROM seats s
--JOIN airplanes a ON s.airplane_code = a.airplane_code
--WHERE a.model = 'Boeing 737 MAX 7';

--9
--SELECT city 
--FROM airports 
--GROUP BY city 
--HAVING COUNT(*) > 5;

--10
--SELECT MAX("range") 
--FROM airplanes 
--WHERE model NOT LIKE '%Airbus%';

--11
--SELECT COUNT(*) 
--FROM bookings 
--WHERE total_amount > (SELECT AVG(total_amount) FROM bookings);

--12
-- Синтаксис PostgreSQL (регулярные выражения)
--SELECT COUNT(*) 
--FROM tickets 
--WHERE passenger_id ~ '^(RU|US)[0-9]{10,}$';

--13
--SELECT model, COUNT(seat_no) AS total_seats
--FROM airplanes 
--JOIN seats s ON airplanes = airplanes
--GROUP BY model, range
--ORDER BY range;

--14
-- Синтаксис PostgreSQL
--SELECT * FROM airports 
--WHERE airport_name ~ '[A-Z]{3}';

--15
--SELECT ROUND(AVG(b.total_amount), 2) AS avg_cost
--FROM bookings b
--JOIN tickets t ON b.book_ref = t.book_ref
--JOIN segments s ON t.ticket_no = s.ticket_no
--JOIN flights f ON s.flight_id = f.flight_id
--JOIN routes r ON f.route_no = r.route_no          -- Связь рейса с маршрутом
--JOIN airports a ON r.arrival_airport = a.airport_code -- Связь маршрута с аэропортом
--WHERE f.status = 'Departed' 
  --AND a.city = 'Saint Petersburg';

--16
--SELECT a.airport_name, COUNT(bp.seat_no) AS total_seats
--FROM airports a
--JOIN routes r ON a.airport_code = r.arrival_airport
--JOIN flights f ON r.route_no = f.route_no
--JOIN segments s ON f.flight_id = s.flight_id
--JOIN tickets t ON s.ticket_no = t.ticket_no
--JOIN boarding_passes bp ON t.ticket_no = bp.ticket_no 
                       --AND s.flight_id = bp.flight_id
--WHERE a.airport_name LIKE '%vo'
--GROUP BY a.airport_name
--ORDER BY total_seats DESC;

--17
--SELECT a.airport_name, COUNT(bp.seat_no) AS total_passes
--FROM airports a
--JOIN routes r ON a.airport_code = r.arrival_airport
--JOIN flights f ON r.route_no = f.route_no
--JOIN segments s ON f.flight_id = s.flight_id
--JOIN tickets t ON s.ticket_no = t.ticket_no
--JOIN boarding_passes bp ON t.ticket_no = bp.ticket_no
--WHERE a.country LIKE '%Russia%'   -- или '%Россия%', если страна на русском
--GROUP BY a.airport_name
--HAVING COUNT(bp.seat_no) > 10;

--18
--SELECT a.airplane_code AS model, a.model, ROUND(AVG(s.price), 2) AS avg_cost
--FROM airplanes a
--JOIN routes r ON a.airplane_code = r.airplane_code
--JOIN flights f ON r.route_no = f.route_no
--JOIN segments s ON f.flight_id = s.flight_id
--WHERE a.airplane_code ~ '^[0-9]+$'
--GROUP BY a.airplane_code, a.model
--HAVING AVG(s.price) > 6000;

--19
--SELECT a.model, COUNT(DISTINCT r.route_no) AS route_count
--FROM airplanes a
--JOIN routes r ON a.airplane_code = r.airplane_code
--GROUP BY a.model;

--20
--SELECT COUNT(*) * (COUNT(*) - 1) / 2 AS total_routes
--FROM airports;