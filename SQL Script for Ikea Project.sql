#Schema Related
CREATE SCHEMA IF NOT EXISTS ikea;
USE ikea;

#Discount
CREATE TABLE Discount
(
        Discount_ID VARCHAR(10) NOT NULL,
        Created_At datetime,
        Name VARCHAR(50),
        Active char CHECK(Active IN ('Y' , 'N')),
        Discount_Percentage INT,
        Deleted_At datetime,
    
        CONSTRAINT Discount_PK PRIMARY KEY (Discount_ID)
); 

#Customer
CREATE TABLE Customer
(
        Customer_ID   VARCHAR(10) NOT NULL,  
        Type_Of_Customer VARCHAR(10) CHECK(Type_Of_Customer IN ('Member' , 'Guest')),
  
      CONSTRAINT Customer_PK PRIMARY KEY(Customer_ID)
);

#Available Colours
CREATE TABLE Available_Colours
(
        Colour_ID   VARCHAR(10) NOT NULL,  
        Colour VARCHAR(20),

        CONSTRAINT Colour_PK PRIMARY KEY(Colour_ID)
);




#Guest
CREATE TABLE Guest
(
Guest_ID  VARCHAR(10) NOT NULL, 
Email     VARCHAR(20) NOT NULL,

CONSTRAINT Guest_PK PRIMARY KEY(Guest_ID),
CONSTRAINT Guest_FK FOREIGN KEY(Guest_ID) REFERENCES Customer (Customer_ID)
);

#Member
CREATE TABLE Member
(
Member_ID    VARCHAR(10) NOT NULL, 
First_Name    VARCHAR(20),
Last_Name    VARCHAR(20),
Email              VARCHAR (20),
Street_Address1  VARCHAR (50),
Street_Address2  VARCHAR (50),
City                       VARCHAR(20),
State                     VARCHAR(20),
Postal_Code         INT,
Country                 VARCHAR(20),
Phone_Number     VARCHAR(15),


CONSTRAINT Member_PK PRIMARY KEY(Member_ID),
CONSTRAINT Member_FK FOREIGN KEY(Member_ID) REFERENCES Customer (Customer_ID)

);

#Store
CREATE TABLE Store
(
        Store_ID          VARCHAR(5)    NOT NULL,
        Store_Name        VARCHAR(25)    ,
        Store_Address1    VARCHAR(30)    ,
        Store_Address2    VARCHAR(30)    ,
        City              VARCHAR(20)    ,              
        State             CHAR(2)        ,
        Postal_Code       VARCHAR(10)    ,
        Country           VARCHAR(10)    ,
        Phone_Number      VARCHAR(15)    ,
 
        CONSTRAINT Store_PK PRIMARY KEY (Store_ID)
);

#Inventory
CREATE TABLE Inventory
(
        Inventory_ID VARCHAR(10) NOT NULL,
        Store_ID VARCHAR(5) NOT NULL,
        Product_Count INT,
        Inventory_Value INT,
            
     CONSTRAINT Inventory_PK PRIMARY KEY (Inventory_ID),
    CONSTRAINT Inventory_FK FOREIGN KEY(Store_ID) REFERENCES Store (Store_ID)
); 

#Order
CREATE TABLE Orders
(
Order_ID    INT NOT NULL,  
Customer_ID VARCHAR(10)  NOT NULL,
Order_Quantity INT,
Total_Price INT,
Status VARCHAR(20),
Delivery_Option VARCHAR(20),


CONSTRAINT Order_PK PRIMARY KEY(Order_ID),
CONSTRAINT Order_FK1 FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID)
);



#Payment
CREATE TABLE Payment
(
        Payment_ID VARCHAR(10) NOT NULL,
        Mode_Of_Payment VARCHAR(15),
        Status VARCHAR(10),
        Order_ID INT NOT NULL,
            
        CONSTRAINT Payment_PK PRIMARY KEY (Payment_ID),
    CONSTRAINT Payment_FK FOREIGN KEY(Order_ID) REFERENCES Orders (Order_Id)
); 

#Product Category
CREATE TABLE Product_Category
(
        Product_Category_ID          VARCHAR(6)      NOT NULL,
        Product_Category_Name         VARCHAR(20)    NOT NULL,
        CONSTRAINT Product_CategoryPK PRIMARY KEY (Product_Category_ID)
);

#Product
CREATE TABLE Product
(
        Product_ID      VARCHAR(6)    NOT NULL,
        Product_Name       VARCHAR(25),
        Price           DECIMAL(6,2),              
        Warranty       VARCHAR(20),
        Sellable_Online   BOOLEAN,
        L  INT,
        B   INT,
        H    INT,
    Product_Category_ID VARCHAR(6),
    
        CONSTRAINT Product_PK PRIMARY KEY (Product_ID),
        CONSTRAINT Product_FK FOREIGN KEY (Product_Category_ID) REFERENCES   Product_Category(Product_Category_ID)
);

#Inventory Product
CREATE TABLE Inventory_Product
(
Inventory_ID                VARCHAR(10)     NOT NULL,
Product_ID                  VARCHAR(6)    NOT NULL,
CONSTRAINT Inventory_Product_PK PRIMARY KEY (Inventory_ID, Product_ID),
CONSTRAINT Inventory_Product_FK1 FOREIGN KEY (Inventory_ID) REFERENCES Inventory(Inventory_ID),
CONSTRAINT Inventory_Product_FK2 FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

#Store Product
CREATE TABLE Store_Product
(
Store_ID                VARCHAR(5)     NOT NULL,
Product_ID              VARCHAR(6)    NOT NULL,
CONSTRAINT Store_Product_PK PRIMARY KEY (Store_ID, Product_ID),
CONSTRAINT Store_Product_FK1 FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID),
CONSTRAINT Store_Product_FK2 FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

#Product Colour
CREATE TABLE Product_Colour
(Product_Colour_ID     VARCHAR(6)     NOT NULL,
Product_ID                    VARCHAR(12)    NOT NULL,
Colour_ID                      VARCHAR(10)   NOT NULL,

CONSTRAINT Product_Colour_PK PRIMARY KEY (Product_Colour_ID),
CONSTRAINT Product_Colour_FK1 FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
CONSTRAINT Product_Colour_FK2 FOREIGN KEY (Colour_ID) REFERENCES Available_Colours(Colour_ID)
);

#Order Items
CREATE TABLE Order_Items 
(
Order_Items_ID    INT NOT NULL, 
Order_ID INT,
Product_Colour_ID VARCHAR(20),
Quantity INT,

CONSTRAINT Order_Items_PK PRIMARY KEY (Order_Items_ID),
CONSTRAINT Order_Items_FK FOREIGN KEY(Order_ID) REFERENCES Orders (Order_ID),
CONSTRAINT Order_Items_FK2 FOREIGN KEY(Product_Colour_ID) REFERENCES Product_Colour (Product_Colour_ID)
);

#Product Discount
CREATE TABLE Product_Discount
(Product_ID                VARCHAR(12)     NOT NULL,
Discount_ID                VARCHAR(12)    NOT NULL,
CONSTRAINT Product_Discount_PK PRIMARY KEY ( Product_ID, Discount_ID),
CONSTRAINT Product_Discount_FK1 FOREIGN KEY (Product_ID) REFERENCES Product (Product_ID),
CONSTRAINT Product_Discountt_FK2 FOREIGN KEY (Discount_ID) REFERENCES Discount (Discount_ID));

###INSERT QUERIES BEGIN HERE 

#Discount Insert Statements
INSERT INTO Discount ( Discount_ID, Created_At, Name, Active, Discount_Percentage, Deleted_At ) VALUES
('D001','2021-07-01 1:00:00','Fourth of July','N',20,'2021-07-21 10:00:00'),
('D002','2021-11-20 10:00:00','Black Friday','N',15,'2021-11-30 10:00:00'),
('D003','2022-05-01 9:00:00','Mothers Day','Y',10,NULL);

#Customer Insert Statements
INSERT INTO Customer (Customer_ID, Type_Of_Customer) VALUES
('M_009', 'Member'),
('G_0081' , 'Guest'),
('M_102' , 'Member'),
('G_010' , 'Guest'),
('G_128' , 'Guest'),
('M_087' , 'Member');

#Guest Insert Statements
INSERT INTO Guest (Guest_ID, Email) VALUES
('G_0081' , 'sjaiswal@gmail.com'),
('G_010' , 'achheda@gmail.com'),
('G_128' , 'bhotta@yahoo.com');

#Member Insert Statements
INSERT INTO Member (Member_ID, First_Name, Last_Name, Email, Street_Address1, Street_Address2, City, State, Postal_code, Country, Phone_Number) VALUES
('M_009', 'Chandni', 'Shah', 'cshah@sfsu.edu', '490 W Capitol Ave', 'Apt 245', 'San Jose', 'CA', '95435', 'USA', '6697023451'),
('M_102' , 'Uma', 'Rajagopalan', 'uraj@yahoo.com', '978 Crescent Village', 'Unit 567', 'New York City', 'NY', '76540','USA', '9796532183'),
('M_087' , 'Sudharsanan', 'Sadagopan', NULL, '782 First Streeet', 'Suite 750', 'Philadelphia', 'PA', '71270', 'USA', '4097621345');

#Available Colour Insert Statements
INSERT INTO Available_Colours (Colour_ID, Colour) VALUES
('C1' , 'White'),
('C2' , 'Red'),
('C3' , 'Blue'),
('C4' , 'Black');

#Order Insert Statements
INSERT INTO Orders (Order_ID, Customer_ID, Order_Quantity, Total_Price, Status, Delivery_Option) VALUES
(10107, 'M_009', 3,  95.7, 'Paid', 'Pickup'), 
(10121, 'G_0081' , 4,  151.35, 'Pending', 'Delivery'),
(10134, 'M_102' , 1,  94.74, 'Paid', 'Delivery'),
(10145, 'G_010' , 5,  53.26, 'Paid', 'Pickup'),
(10159, 'G_128' , 9,  100, 'Pending', 'Delivery'),
(10168, 'M_087' , 6,  196.66,  'Paid', 'Pickup'),
(10170, 'M_009',4,53,'Paid','Delivery'),
('10172','M_102',2,34.99,'Paid','Pickup');

#Payment Insert Statements
INSERT INTO Payment (Payment_ID, Mode_Of_Payment, Status, Order_ID) VALUES
('P001','CreditCard','Completed',10107),
('P002','DebitCard','Completed',10121),
('P003','CreditCard','Completed',10134),
('P004','CashOnDelivery','Pending',10121);

INSERT INTO Store (Store_ID, Store_Name, Store_Address1, Store_Address2, City, State, Postal_Code, Country ,Phone_number ) VALUES
('S01',        'Ikea San Francisco','4400 Shellmound St' ,        'Emeryville' ,        'San Francisco','CA' ,94608,'USA','(657) 888-4531'), 
('S02' , 'Ikea Los Angeles','20700 S Avalon Blvd' , NULL,'Carson','CA' ,90746,'USA','(657) 888-4532'),
('S03','Ikea Palo Alto',        '1700 E Bayshore Rd','East Palo Alto',        'Palo Alto' ,'CA' ,        94303,        'USA',        '(657) 888-4533'),
('S04'        ,'Ikea Seattle'        ,'601 Short West'         ,'41st St'        ,'Seattle',        'WA'        ,98057,        'USA'        ,'(657) 888-4534'),
('S05'        ,'Ikea Tampa','1103 Norstar','22nd St',        'Tampa','FL',33605,'USA' ,'(657) 888-4535');

#Product Category Insert Statements
INSERT INTO Product_Category (Product_Category_ID, Product_Category_Name)VALUES
('PC10','Bed'),
('PC20','Outdoor Funiture'),
('PC30','Cookware');

#Inventory Insert Statements
INSERT INTO Inventory (Inventory_ID, Store_ID, Product_Count, Inventory_Value) VALUES
('I001','S01',200,20000),
('I002','S02',100,10000),
('I003','S03',4000,400000);

#Product Insert Statments
INSERT INTO Product(Product_ID, Product_Name, Price, Warranty, Sellable_Online,        L,B,H, Product_Category_ID) VALUES
('P401'        ,'FREKVENS',265      ,'2 months' ,TRUE,51,25,51,        'PC20'), 
('P402'        ,'NORDVIKEN',995,'3 months',        FALSE,10,25,70 ,'PC20'),
('P403'        , 'PLATSA'        ,1105,'6 months',TRUE,140,244,163,'PC10'),
('P404','INGOLF',        345              ,'2 months',TRUE,109,87,76,'PC10'),
('P405','TOMMARYD',        754,'3 months',        TRUE,34,26,        32,        'PC30'),
('P406','JANINGE',19,      '0 months',        FALSE,10,5,10,'PC30');

#Product-Color Insert
INSERT INTO Product_Colour(Product_Colour_ID,Product_ID,Colour_ID) VALUES
('PC1','P401','C1'), 
('PC2','P401','C2'),
('PC3','P402','C3'),
('PC4','P402','C4'),
('PC5','P403','C1'),
('PC6','P403','C2'),
('PC7',        'P404',        'C3'),
('PC8','P404','C4'),
('PC9','P405','C1'),
('PC10','P405','C2'),
('PC11'        ,'P406','C3'),
('PC12', 'P406','C4'),
('PC13','P406',        'C1'); 


#Order Items Insert
INSERT INTO Order_Items (Order_Items_ID, Order_ID, Product_Colour_ID, Quantity) VALUES
(101, 10107, 'PC1', 1),
(102, 10121, 'PC4', 4),
(103, 10107, 'PC6', 1),
(104, 10145, 'PC7', 5),
(105, 10159, 'PC10', 9),
(106, 10107, 'PC13', 1);

#Store_Product Insert
INSERT INTO Store_Product (Store_ID, Product_ID) VALUES
('S01','P401'),
('S01','P402'),
('S05','P403'),
('S04','P404'),
('S01','P405'),
('S01','P406'),
('S02','P404'),
('S02','P405'),
('S02','P406'),
('S03','P403'),
('S03','P404'),
('S03','P405');

#Inventory-Product Insert
INSERT INTO Inventory_Product( Inventory_ID, Product_ID) VALUES
('I001','P401'), 
('I003','P402'),
('I001','P403'),
('I002','P405');

#Product-Discount Insert
INSERT INTO Product_Discount ( Product_ID, Discount_ID) VALUES
('P401', 'D001'), 
('P401', 'D002'),
('P403', 'D003'),
('P404', 'D003'),
('P403', 'D002');

###Queries begin here 

select * from Discount;
select * from Customer;
select * from Guest;
select * from Member;
select * from Available_Colours ;
select * from Orders;
select * from inventory;
select * from Inventory_product;
select * from Order_items;
select * from Payment;
select * from Product;
select * from Product_category;
select * from Product_colour;
select * from Product_discount;
select * from Store;

#Q1 Customers Who Purchased Products worth more than $100
SELECT c.Customer_ID, 
        c.Type_Of_Customer, 
    g.email as Email, 
    #mem.email as Member_Email,
    o.Total_Price as Order_Total
FROM (Customer c, Orders o)
INNER JOIN
   Guest AS g
   ON c.Customer_ID  = g.Guest_ID
   

WHERE c.Customer_ID = o.Customer_ID
AND o.Total_Price>=100

UNION

SELECT c.Customer_ID, 
        c.Type_Of_Customer, 
    #g.email as Email, 
    mem.email as Member_Email,
    o.Total_Price as Order_Total
FROM (Customer c, Orders o)
INNER JOIN
   Member AS mem
   ON c.Customer_ID  = mem.Member_ID
WHERE c.Customer_ID = o.Customer_ID
AND o.Total_Price>=100

##Q2 :Type of Customer Generating most revenue ? 

SELECT COUNT(Type_Of_Customer) As 'Number of Customers',
Type_Of_Customer, SUM(Total_Price) As 'Sum of Total Sales'
FROM Orders
JOIN Customer
ON Orders.Customer_ID = Customer.Customer_ID
GROUP BY Type_Of_Customer
ORDER BY Total_Price;


##Q3: What is the most commonly used payment method?
SELECT COUNT(Mode_Of_Payment) As Count_Mode_Of_Payment ,Mode_Of_Payment FROM Payment
GROUP BY Mode_Of_Payment
ORDER BY COUNT(Mode_Of_Payment) DESC
LIMIT 1 ;

##Q4: Most sold product details

CREATE VIEW Sold_Products AS
 select oi.Quantity,p.Product_Name, p.Product_ID, pcol.Product_Colour_ID,pc.Product_Category_Name,ac.Colour
 FROM Product p, Product_Category pc, Order_Items oi,Available_Colours ac,Product_Colour pcol
 WHERE oi.Product_Colour_ID = pcol.Product_Colour_ID
 AND pcol.Product_ID = p.Product_ID
 AND pcol.Colour_ID = ac.Colour_ID
 AND pc.Product_Category_ID = p.Product_Category_ID;

 select * from Sold_Products 
 where Quantity = (select max(Quantity) from Sold_Products);
 
 ##Q5 :Availability of Inventory for the most sold Product
 
SELECT s.Store_Name, i.Product_Count,p.Product_ID,p.Product_Name 
FROM Inventory i, Product p,Inventory_Product ip,Store s
WHERE ip.Inventory_ID = i.Inventory_ID
AND ip.Product_ID = p.Product_ID
AND i.Store_ID = s.Store_ID
AND p.Product_ID IN (select Product_ID from Sold_Products 
where Quantity = (select max(Quantity) from Sold_Products));

##Q6: Products having discount greater than 10% and their before and after prices

SELECT p.Product_Name,d.Discount_Percentage as 'Discount %',Product_Category_Name as Product_Type,
 p.price as Original_Price,
ROUND((p.price - (p.price*d.Discount_Percentage/100)),2) as Discounted_Price
FROM Product p, Discount d, Product_Discount pd,Product_Category pc
WHERE p.Product_ID = pd.Product_ID
AND d.Discount_ID = pd.Discount_ID
AND p.Product_Category_ID = pc.Product_Category_ID
AND p.price IS NOT NULL
  AND d.Discount_Percentage > 10
ORDER BY d.Discount_Percentage DESC;




