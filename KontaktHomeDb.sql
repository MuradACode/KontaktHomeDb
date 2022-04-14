Create Database KontaktHomeDb

Use KontaktHomeDb

CREATE TABLE Category (
	Id int Primary Key Identity,
	Name varchar(20)
)

CREATE TABLE Product (
	Id int Primary Key Identity,
	Brand varchar(30),
	Model varchar(100),
	CostPrice int,
	SellPrice int,
	CategoryId int Foreign Key References Category (Id)
)

CREATE TABLE Cart (
	Id int Primary Key Identity,
	ProductId int Foreign Key References Product (Id)
)

CREATE VIEW SumOfCart 
AS
Select SUM(p.SellPrice) as 'Total Price'from Product p
join Cart c on p.Id = c.ProductId

CREATE VIEW ShowCartInfo
AS
Select  p.Id,
		p.Brand,
		p.Model,
		p.SellPrice as 'Price'
	from Cart c
join Product p on c.ProductId = p.Id

CREATE VIEW ShowInfo
AS
Select  c.Name as 'Category',
		p.Id,
		p.Brand,
		p.Model,
		P.CostPrice,
		p.SellPrice
	from Category c
join Product p on p.CategoryId = c.Id

CREATE procedure AddingProductToCart @Id int 
As
Insert into Cart
Values (@Id)

CREATE procedure DeletingProductFromCart @Id int 
As
Delete from Cart where ProductId = @Id

Create trigger ShowProductsTrigger
On Cart
After Insert, Delete
As
Select * from ShowCartInfo

Insert into Category
Values  ('Smartphones'), ('Tablets'), ('Headphones')

Insert into Product
Values  ('Apple', 'iPhone 13 PRO MAX', 2800, 4669, 1), ('Samsung', 'Galaxy S22 Ultra', 2200, 3099, 1), ('Xiaomi', '12X', 1300, 1749, 1), ('OnePlus', '9 Pro 5G', 1120, 1599, 1),
		('Samsung', 'Galaxy Tab S7+', 1250, 1999, 2), ('Apple', 'iPad Pro 12.9-İnch (5th Gen)', 2300, 3069, 2), 
		('Razer', 'Kraken X Lite 7.1', 45, 89, 3),('Apple', 'AirPods pro', 360, 549, 3), ('Samsung', 'Galaxy Buds Pro', 250, 449, 3)

EXEC AddingProductToCart @Id = 2
EXEC DeletingProductFromCart @Id = 2

Select * from SumOfCart
Select * from ShowInfo
Select * from ShowCartInfo

