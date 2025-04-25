select productname from Products
union
select productname from OutOfStock
EXEC sp_rename 'customers', 'client';

select productname from Products
union
select productname from Products_Discounted

select * from Products
instersect
select * from Products_Discounted

select distinct firstname,country
from client

select *, case 
  when price>=1000 then 'high'
  when price<=1000 then 'low'
  end as rate_level

from Products

select productname from Products
union
select productname from OutOfStock

select * from Productss
except
select * from Products_Discounted

select *, case
   when price>=1000 then 'expensive'
    when price<=1000 then 'affordable'
	end as rate_name

from Products

select * from Employees
where age<25 or salary>60000

select ProductName from Products
except
select ProductName from Products_Discounted

select *,case 
  when saleamount>500 then 'toptier'
  when saleamount between 200 and 500 then 'midtier'
   else 'lowtier'
   end

from sales



select *,case 

  when Quantity=1 then '3%'
  when Quantity between 1 and 3 then '5%'
  else '7%'
  end

from Orders
