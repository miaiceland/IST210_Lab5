/* 1. Write a query that JOINS two tables and returns all physicians as well as their respective
departments. Sort the results by physician id in ascending order. */

select p.id, p.name, d.name as 'department'
from physician as p 
join department as d
on p.department_id = d.id;

/* 2. Write a query that JOINS two tables to list all of the rooms and the number of hospital records
that took place in each. The results should include the room number, room type, and the number
of records. The query should select all rows in the room table so rooms that were unused
(Unmatched rows) are listed in the output as well. Sort the results by room number. */

select r.number, r.roomType, r.floor, r.block, count(h.room_num)
from hospital_record as h
right join room as r
on r.number = h.room_num
group by r.number
order by r.number;

/* 3. Modify the query in question 2 to return the same results; however, only include rooms that
have been used. (Only select matching rows) */

select r.number, r.roomType, r.floor, r.block, count(h.room_num)
from hospital_record as h
right join room as r
on r.number = h.room_num
group by r.number
having count(h.room_num) > 0
order by r.number;

/* 4. Write a query that JOINS all tables created in the previous lab to display the data in a similar
format to hospital_basic. When you are joining your tables ensure that you are showing all
records from the hospital_record table including unmatched rows!
NOTE: You are not using the hospital_basic table, but rather JOINing the physician,
procedures, nurse, room, patient, and hospital_record tables to output a table in the same
format. Modify your column headers to match hospital_basic. */

select h.record_id as 'RecordID', pa.name as 'PatientName', pa.address as 'Addr', pa.phone as 'Phone',
pr.name as 'Procedure', pr.cost as 'Cost', r.number as 'Room', r.roomType as 'RoomType', ph.name as 
'Physician', n.name as 'Nurse', h.date_undergoes as 'Date of Procedure', h.stayStart as 'Stay Arrival',
h.stayEnd as 'Stay Departure'
from hospital_record as h
	left join patient as pa
    on pa.snn = h.patient_snn
    left join physician as ph
    on ph.id = h.physician_id
    left join room as r
    on r.number = h.room_num
    left join procedures as pr
    on pr.code = h.procedure_code
    left join nurse as n
    on n.id = h.assistingNurse_id
group by h.record_id
order by h.record_id;

/* 5. Modify your query from Question 4 to only show rows with a valid physician, procedures,
nurse, room, patient, and hospital_record. (Only matching rows) */

select h.record_id as 'RecordID', pa.name as 'PatientName', pa.address as 'Addr', pa.phone as 'Phone',
pr.name as 'Procedure', pr.cost as 'Cost', r.number as 'Room', r.roomType as 'RoomType', ph.name as 
'Physician', n.name as 'Nurse', h.date_undergoes as 'Date of Procedure', h.stayStart as 'Stay Arrival',
h.stayEnd as 'Stay Departure'
from hospital_record as h
	join patient as pa
    on pa.snn = h.patient_snn
    join physician as ph
    on ph.id = h.physician_id
    join room as r
    on r.number = h.room_num
    join procedures as pr
    on pr.code = h.procedure_code
    join nurse as n
    on n.id = h.assistingNurse_id
group by h.record_id
order by h.record_id;

/* 6. You will notice for some records in your hospital_record table there is a NULL value for the
Assisting Nurse. The NULL value represents Nurse Thomas Jones: A Nurse who was mistakenly
deleted from the database. INSERT a new nurse to the Nurse table for Thomas Jones and
UPDATE the hospital_records with a NULL AssistingNurse id to represent this newly added
Nurse */

insert into nurse (name, position, registered, SNN)
values ('Thomas Jones', 'Trainee', 0, 10567233);

select * from nurse;

update hospital_record
set assistingNurse_id = 113
where assistingNurse_id is null;

/* 7. Rerun your query from Question 5 order by AssistingNurse in descending order! */

select h.record_id as 'RecordID', pa.name as 'PatientName', pa.address as 'Addr', pa.phone as 'Phone',
pr.name as 'Procedure', pr.cost as 'Cost', r.number as 'Room', r.roomType as 'RoomType', ph.name as 
'Physician', n.name as 'Nurse', h.date_undergoes as 'Date of Procedure', h.stayStart as 'Stay Arrival',
h.stayEnd as 'Stay Departure'
from hospital_record as h
	join patient as pa
    on pa.snn = h.patient_snn
    join physician as ph
    on ph.id = h.physician_id
    join room as r
    on r.number = h.room_num
    join procedures as pr
    on pr.code = h.procedure_code
    join nurse as n
    on n.id = h.assistingNurse_id
group by h.record_id
order by n.id desc;
