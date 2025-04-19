basic level tasks
CREATE TABLE Employees (
    empID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);
select * from Employees
insert into Employees values (1,'ilhom',10000.2),
(2,'yusuf',20000);

update Employees
set Salary= 12000
where empID=1;

DELETE from Employees
where empID = 2


--delete is used for deleting the rows, on the other hand the truncate is for columns deletes.
--drop table is for vanishing all inculding the whole table too

alter table employees
add department varchar(100);

create table departments(
departmentID int primary key,
department_name varchar (50));

select * from departments

truncate table employees

intermediate level tasks

insert into departments(departmentID,department_name) 

values

(1,'IT'),
(2,'Support'),
(3,'Finance'),
(4,'Management'),
(5,'Employees');

delete from departments;

advanced level tasks

create table Products(
ProductID int Primary Key,
ProductName VARCHAR (50) ,
Category VARCHAR(50),
Price DECIMAL(10,5),
check (price>=0));

select * from Products

insert into Products values (2,'nestle','dairy',13.5),
                            (3,'chococream','sweets',43.2),
                            (24,'gorilla','drinks',14),
							(16,'chips','snacks',10)

							alter table products
							add StockQuantity varchar (50)

ALTER TABLE products
CHANGE COLUMN category productcategory VARCHAR(255);
				

				select * into products_backup
				from Products ;
			
			alter table Products
			rename to inventory

