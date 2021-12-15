--1. Create a database named EmploymentManagement.
create database EmploymentManagement
--2. Create 2 tables as the following figure:
use EmploymentManagement
create table Department(DepartmentID char(5) primary key,
Name nvarchar(50))
create table Employee(EmployeeID char(5) primary key,
Name varchar(50), DepartmentFK char(5),
BirthDate datetime)
alter table Employee
add foreign key (DepartmentFK) references Department(DepartmentID)
alter table Employee
add constraint df_birthdate default '10/12/1970' for BirthDate
--3. Input at least some records for each table. 
--Department table
insert into Department values(1, 'IT')
insert into Department values(2, 'Human resource')
insert into Department values(3, 'Research')
insert into Department values(4, 'Business')
--Employee table
insert into Employee values(1, 'Micheal John', 1, convert(datetime, '21/04/1970', 103))
insert into Employee values(2, 'Anna Lombard', 2, convert(datetime, '02/01/1972', 103))
insert into Employee values(3, 'Peter Dawson', 3, convert(datetime, '12/07/1990', 103))
insert into Employee values(4, 'Leonard', 4, convert(datetime, '25/05/1981', 103))
insert into Employee values(5, 'Elizabeth', 3, convert(datetime, '14/03/1970', 103))
--4. Create a select statement to show EmployeeID, 
--Name and Age of all employees that were borned after 1975. 
select EmployeeID, Name, year(getdate())-year(BirthDate) as 'Tuổi'
from Employee
--5. Create a select statement to show details of employee that are working for “Research” department. 
select e.*, d.Name
from Department d, Employee e
where d.DepartmentID=e.DepartmentFK and d.Name='Research'
--6. Create a  statement to show total of employees who are working for “Research” department. 
select count(*) as 'Total'
from Employee e join Department d on e.DepartmentFK=d.DepartmentID
where d.Name = 'Research'
group by DepartmentFK
--7. Create a update statement to update the employees who are working in “Business” 
--department to “Research” department.
declare @DepartmentFK char(5)
select @DepartmentFK = (select DepartmentID from Department where Name='Research')
update Employee set DepartmentFK = @DepartmentFK 
where DepartmentFK = (select DepartmentID from Department where Name='Business')
--8. Create a delete statement to delete all the employees that are working in 
--“IT” department and year of BirthDate in 1970. 
delete from Employee
where EmployeeID =
(select EmployeeID from Employee e join Department d on e.DepartmentFK=d.DepartmentID
where d.Name='IT' and year(Birthdate)=1970)
--9. Create a view named ViewEmployees to show all information of employees, 
--such as EmployeeID, Name, BirthDate and DepartmentName 
--(DepartmentName is the name of a department which an employee belongs to). 
--Then, display data of this view with a column DepartmentName is sorted ascending.
Create view ViewEmployees as
select EmployeeID, e.Name, BirthDate, d.Name as 'DepartmentName' from Employee e join Department d on e.DepartmentFK=d.DepartmentID
go
select * from ViewEmployees
go
--10. Create a stored procedure named ProcDeleteDepartment with input parameter named 
--@departmentId. This stored procedure deleted a department which 
--DepartmentID is equal to an input value for @departmentId. 
--Then, execute this stored procedure to delete a department which values are ‘3’. 
create procedure ProDeleteDepartment
@departmentId char(5)
as
	delete from Employee where DepartmentFK=@departmentId
	delete from Department where DepartmentID=@departmentId
go
exec ProDeleteDepartment 3;
go
--11. Create a trigger named TriggerInsertEmp for Employee table to ensure that when 
--user executes an insert statement on this table, age of the inserted employee is more than 30 years
--old.
create trigger TriggerInsertEmp on Employee
after insert
as
	declare @birthdate datetime, @age int
	select @birthdate = BirthDate from inserted
	select @age = year(getdate()) - year(@birthdate)
	if @age > 30
	begin 
		print 'The age is more than 30 years old'
		rollback transaction
	end
go