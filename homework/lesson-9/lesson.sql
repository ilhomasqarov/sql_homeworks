select Products.ProductName,Suppliers.SupplierName
from Products
cross join Suppliers


select departments.department_name,Employees.EmployeeID 
from departments
cross join Employees


select products.ProductName,suppliers.SupplierName,Products.ProductID,Suppliers.SupplierID 
from Products
join Suppliers 
on Products.ProductID=Suppliers.SupplierID


select Customers.CustomerName,orders.OrderID from Orders
join Customers
on orders.CustomerID=customers.CustomerID


select students.name,courses.coursename,courses.instructor
from courses
cross join students


select Products.productname,products.ProductID,orderss.orderid from Products
join orderss 
on Products.ProductID=orderss.productid



select Employees.departmentid,departments.department_name from departments
inner join Employees
on Employees.departmentid=deparments.departmentid


select students.name,enrollments.courseid from enrollments
join students on enrollments.studentid=students.studentid

select ProductName,Products.price,orderss.orderdate from Products
join orderss 
on products.ProductID=orderss.productid
where products.price > 300;


select Employees.name,Employees.departmentid,departments.departmentID,departments.departmentname
from Employees
cross join departments
where Employees.departmentid <> departments.departmentID


select orderss.totalamount,products.ProductName,Products.StockQuantity from orderss
join products on orderss.productid=products.productid
where orderss.quantity>products.stockquantity

select customers.CustomerName,sales.ProductID,sales.SaleAmount from customers
join sales 
on customers.CustomerID=sales.CustomerID
where sales.SaleAmount>=500


select students.name,students.major from courses
join enrollments 
on courses.courseid=enrollments.courseid
join students 
on enrollments.studentid=students.studentid


select Products.ProductName,Suppliers.SupplierName from Products
join suppliers 
on products.SupplierID=suppliers.SupplierID
where Suppliers.SupplierName like '%tech%'


select * from Employees
join departments
on Employees.departmentid=departments.departmentid

select Employees.name,Departments.DepartmentName from Employees
cross join departments


select products.ProductName,Products.Category from Products
join categories
on Products.supplierid=categories.categoryid
where products.Category in ( 'electronics','furniture')


select * from sales
join customers
on sales.customerid=Customers.CustomerID
where customers.country='USA'

select * from Orderss
join customers
on Orderss.customerid=Customers.CustomerID
where customers.country='germany' and orderss.Quantity>100


select employees.name,departments.DepartmentName from  Employees
cross join Departments


select students.name from Students
left join Enrollments
on students.StudentID=Enrollments.EnrollmentID
where Enrollments.StudentID is null



select * from Employees as a
join Employees as b
on a.EmployeeID=b.ManagerID
where a.Salary>b.Salary
