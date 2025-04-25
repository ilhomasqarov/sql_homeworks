
select min(price) from products


select max(salary) from Employees

select count(*) from customers

select count(distinct category) from Products

select sum(saleamount) from sales
where SaleID=7

select avg(age) from Employees

select departmentname,count(*) from Employees
group by DepartmentName

select category,min(price),max(price) from products
group by Category

select customerid,sum(saleamount) from sales
group by customerid

select productid,sum(saleamount),avg(saleamount) from sales
group by ProductID


select count(DepartmentName)
from Employees 
where departmentname='hr'

select departmentname, max(salary)as eng_yuqori_oylik,min(salary) as eng_past_oylik from Employees
group by DepartmentName

select DepartmentName, avg(salary)as ortacha_oylik from Employees
group by DepartmentName


  select DepartmentName, avg(salary)as ortacha_oylik,count(*)as nechta_ishchi_bor from Employees
group by DepartmentName

  
select Category, avg(price) from products
group by Category
having avg (Price) < 400;

select saledate,sum(saleamount) from sales as yillik_savdo
group by saledate


select salesman_id,count(customer_id)as most_order_number from orders
group by salesman_id
having count (*) > 2


select departmentname,sum(salary) from Employees
group by departmentname
having count(*) < 500000

select category,avg(stockquantity) from products
group by category
having avg (stockquantity) > 200

select customer_id,sum(purch_amt) from orders
group by customer_id
having sum(purch_amt) > 1500

select departmentname,sum(salary),avg(salary) from Employees
group by departmentname
having avg(salary) > 65000

select salesman_id,max(purch_amt)as eng_yuqori,min(purch_amt) as eng_past from orders
group by salesman_id
having min(purch_amt) > 50








