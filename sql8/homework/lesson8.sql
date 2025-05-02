
select * from Products
select count(category), count(productname) from Products


select category, avg(Price) from Products
group by category

select * from Customers
where city like 'L%'

select * from Products
where productname like '%er'

select * from Customers
where Country like '%a'

select max(price) from Products

select case 
  when stockquantity<30 then 'low_stock'
  else 'sufficient'
  end

from Products


select country,count(CustomerID)
from customers
group by country

select max(quantity)as eng_kop,min(quantity)as eng_kam from orders

select ProductName from products
union all
select productname  from products_discounted

select ProductName from products
union 
select productname  from products_discounted

select orderdate, avg(totalamount) as yearly from orders
group by orderdate

select productname from Products


select productname,
case 
  when  price<100 then 'low'
  when  price between 100 and 500 then 'mid'
  when  price>500 then 'high'
end as pricegroup
from products;

select sum(saleamount) from sales
group by productid

select * from Products
where productname like '%oo%'

select top 3 customerid, sum(totalamount) as totalspent from invoices
group by customerid
order by totalspent desc

select ProductName from Products
inner join sales 
on products.ProductID=sales.saleid

inner join sales as b
on a.saleid=b.productid






