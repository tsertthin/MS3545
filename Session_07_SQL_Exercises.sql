USE AdventureWorks2012; /*Set current database*/

/*1, Display the total amount collected from the orders for each order date. */
/* Table: Sales.SalesOrderHeader*/
SELECT OrderDate, SUM(TotalDue) as Daily_Amount, COUNT(SalesOrderID) as Number_of_Orders
FROM Sales.SalesOrderHeader
GROUP BY OrderDate
ORDER By SUM(TotalDue) DESC;
/*2, Display the total amount collected from selling the products, 774 and 777. */
/* Table: Sales.SalesOrderDetail*/
SELECT ProductID,
SUM(LineTotal) as TotalRevenue,
SUM(OrderQty) as TotalOrders,
MAX(UnitPrice) as MaxUnitPrice
FROM Sales.SalesOrderDetail
WHERE ProductID in (774,777)
GROUP BY ProductID
/*3, Write a query to display the sales person BusinessEntityID, last name and first name of all the sales persons and the name of the territory to which they belong.*/
SELECT sp.BusinessEntityID, pp.FirstName, pp.LastName, st.Name as Territory_Name
FROM Person.Person as pp
JOIN Sales.SalesPerson as sp
ON pp.BusinessEntityID= sp.BusinessEntityID
JOIN Sales.SalesTerritory as st
ON st.TerritoryID= sp.TerritoryID
/*4,  Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/
/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/
SELECT pp.BusinessEntityID, pp.FirstName, pp.LastName, sc.CardType
FROM Person.Person as pp
JOIN Sales.PersonCreditCard as spc
ON pp.BusinessEntityID= spc.BusinessEntityID
JOIN Sales.CreditCard as sc
ON sc.CreditCardID=spc.CreditCardID
WHERE Cardtype= 'Vista';

/*Show the number of customers for each type of credit cards*/
SELECT sc.CardType, COUNT(pp.BusinessEntityID) as Total_Customers
FROM Person.Person as pp
JOIN Sales.PersonCreditCard as spc
ON pp.BusinessEntityID= spc.BusinessEntityID
JOIN Sales.CreditCard as sc
ON sc.CreditCardID=spc.CreditCardID
GROUP BY sc.CardType;

/*5, Write a query to display ALL the country region codes along with their corresponding territory IDs*/
/* tables: Sales.SalesTerritory,  Person.CountryRegion*/
SELECT pc.CountryRegionCode, pc.Name as RegionName, st.TerritoryID 
FROM Person.CountryRegion as pc
LEFT OUTER JOIN Sales.SalesTerritory as st
ON pc.CountryRegionCode=st.CountryRegionCode
WHERE st.TerritoryID is NULL

/*6, Find out the average of the total dues of all the orders.*/
/* tables: Sales.SalesOrderHeader*/
SELECT AVG(TotalDue) as AverageTotalDue
FROM Sales.SalesOrderHeader

/*7, Write a query to report the sales order ID of those orders where the total due is greater than the average of the total dues of all the orders*/
SELECT SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue> 
(SELECT AVG(TotalDue) as AverageTotalDue
FROM Sales.SalesOrderHeader)
ORDER BY TotalDue DESC;
