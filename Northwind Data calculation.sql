--Creating a new column for sales
Alter Table "ordeorderdetailss"
Add Column "sales" Numeric;


--Adding Values to my new column " sales" by multiplying Quantity and Unitprice

Update orderdetailss
SET sales = ( unitprice * quantity);

--Creating a new column for the amount_paid_after_discount
Alter Table orderdetailss
Add Column amount_paid_after_discount Numeric;


--Adding values to the new column (amount_paid_after_discount) by calculating (1-discount)*sales
Update orderdetailss
Set amount_paid_after_discount = (1-discount)*sales;

--Rounding up the decimal to whole numbers in the amount_paid_after_discount column
Select ceiling (amount_paid_after_discount) As amount_paid_after_discount$
From
orderdetailss;

 update orderdetailss
 Set amount_paid_after_discount = ceiling (amount_paid_after_discount);
 
 
--Add profit column to order details table
Alter Table orderdetailss
Add Column profits numeric;


--Left Joining Order details, product table and  order table to get the profit.

Create view combined as (

Select
od.orderid,
od.unitprice,
od.quantity,
od.discount,
od.detailsid,
od.sales,
od.amount_paid_after_discount,
od.profits,
p.productid,
p.productname,
p.prodquantity,
p.discontinued,
p.categoryid,
o.*
From
products as p
Left join
orderdetailss as od
on p.productid = od.productid
Left Join
orders as o
on o."orderID" = od.orderid
);

Update orderdetailss
Set profits = (od.amount_paid_after_discount) - (p.unitprice * od.quantity)
From orderdetailss as od
Left Join 
products as p
on p.productid = od.productid

;



Select
sum ( amount_paid_after_discount)
from
orderdetailss;


Select
*
from
combined