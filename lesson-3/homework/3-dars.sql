level easy

Bulk insert is used for transferring data or files from computers internal storage into SQL
we can insert excel files, CSV files using Bulk insert in SQL
the difference between Null and not null is that if there is no information on column but a place exists for it, SQL writes Null for this space because not any information was provided. On the other hand, if you dont want any empty column or row we have to write NOT NULL when we creating a table. So that when we execute the table it gives us error, if we enter null value

when we have important notes or some special remindings we use comments on SQL, so it will not effect our codes, to do that we use --

create table products 
  (ProductID int Primary key,
  Product_name varchar(20)unique,
  Price decimal(10,4));

  insert into products values (12,'macbook',400.2),
  (23,'notebook',300),
  (43,'samsung',450.3);

  select * from products
  drop table products

  create table products 
  (ProductID int Primary key,
  Product_name varchar(20)unique,
  Price decimal(10,4));

  --unique constraint has been added there

  create table categories
  (CategoryID int primary key,
Category_name varchar(20)unique
  );

  select * from categories

  bulk insert text_file
  from .......
  with(firstrow 2,
  fieldterminator=','
  rowterminator='\n'
  
  )
  create table products 
  (ProductID int Primary key,
  Product_name varchar(20)unique,
  Price decimal(10,4),
  check (price>0));
  
  select * from products

  alter table products add stock int

select
productid,
Product_name,
price,
isnull(stock,12) as New_Column 
from products;


create table customers(
id int primary key,
name varchar(20),
age int,
check (age>=18));

select * from customers
insert into customers values (12,'ilhom',15);  -- this table gives error because age limit is set for 18+
