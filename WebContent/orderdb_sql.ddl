DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS shipment;
DROP TABLE IF EXISTS productinventory;
DROP TABLE IF EXISTS warehouse;
DROP TABLE IF EXISTS orderproduct;
DROP TABLE IF EXISTS incart;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS ordersummary;
DROP TABLE IF EXISTS paymentmethod;
DROP TABLE IF EXISTS customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY(1,1),
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('T-Shirts');
INSERT INTO category(categoryName) VALUES ('Mugs');
INSERT INTO category(categoryName) VALUES ('Magnets');
INSERT INTO category(categoryName) VALUES ('Lanyards');
INSERT INTO category(categoryName) VALUES ('Keychains');
INSERT INTO category(categoryName) VALUES ('Post Cards');
INSERT INTO category(categoryName) VALUES ('Hats');
INSERT INTO category(categoryName) VALUES ('Bobble Heads');


INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('I <3 Ramon', 1, 'Black',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('I <3 Ramon', 1,'White',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('I <3 Ramon',1,'Grey',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SomeoneGotMeThis', 1,'Black',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SomeoneGotMeThis', 1,'White',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SomeoneGotMeThis', 1,'Grey',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('EatSleepCode', 1,'Black',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('EatSleepCode', 1,'White',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('EatSleepCode', 1,'Grey',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('I <3 Ramon',2,'250 mL mug',15.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('I <3 Ramon',3,'2 x 3 inch',5.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('iWentToRamonsWorld',3,'2 x 3 inch',5.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Youre my Databae',3,'2 x 3 inch',5.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('I <3 Ramon',4,'30 inch - Black',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('I <3 Ramon',5,'Blue',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('I <3 Ramon',5,'Red',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('I <3 Ramon',5,'Yellow',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ramons World',5,'Purple',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ramons World',5,'Green',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ramons World',5,'Teal',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ramons World',6,'5 x 6 inch',2.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('EatSleepCode',6,'5 x 6 inch',2.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Theme Park',6,'5 x 6 inch',2.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Code',6,'5 x 6 inch',2.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ramons World',7,'Black',19.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ramons World',7,'Blue',19.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ramons World',7,'White',19.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ramon Bobble Head',8,'3 inch replica',40.00);
    
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');


INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);;

-- insert images
UPDATE Product SET productImageURL = 'images/2.jpg' WHERE productId = 2;
UPDATE Product SET productImageURL = 'images/3.jpg' WHERE productId = 3;
UPDATE Product SET productImageURL = 'images/4.jpg' WHERE productId = 4;
UPDATE Product SET productImageURL = 'images/5.jpg' WHERE productId = 5;
UPDATE Product SET productImageURL = 'images/6.jpg' WHERE productId = 6;
UPDATE Product SET productImageURL = 'images/7.jpg' WHERE productId = 7;
UPDATE Product SET productImageURL = 'images/8.jpg' WHERE productId = 8;
UPDATE Product SET productImageURL = 'images/9.jpg' WHERE productId = 9;
UPDATE Product SET productImageURL = 'images/10.jpg' WHERE productId = 10;
UPDATE Product SET productImageURL = 'images/11.jpg' WHERE productId = 11;
UPDATE Product SET productImageURL = 'images/12.jpg' WHERE productId = 12;
UPDATE Product SET productImageURL = 'images/13.jpg' WHERE productId = 13;
UPDATE Product SET productImageURL = 'images/14.jpg' WHERE productId = 14;
UPDATE Product SET productImageURL = 'images/15.jpg' WHERE productId = 15;
UPDATE Product SET productImageURL = 'images/16.jpg' WHERE productId = 16;
UPDATE Product SET productImageURL = 'images/17.jpg' WHERE productId = 17;
UPDATE Product SET productImageURL = 'images/18.jpg' WHERE productId = 18;
UPDATE Product SET productImageURL = 'images/19.jpg' WHERE productId = 19;
UPDATE Product SET productImageURL = 'images/20.jpg' WHERE productId = 20;
UPDATE Product SET productImageURL = 'images/21.jpg' WHERE productId = 21;
UPDATE Product SET productImageURL = 'images/22.jpg' WHERE productId = 22;
UPDATE Product SET productImageURL = 'images/23.jpg' WHERE productId = 23;
UPDATE Product SET productImageURL = 'images/24.jpg' WHERE productId = 24;
UPDATE Product SET productImageURL = 'images/25.jpg' WHERE productId = 25;
UPDATE Product SET productImageURL = 'images/26.jpg' WHERE productId = 26;
UPDATE Product SET productImageURL = 'images/27.jpg' WHERE productId = 27;
UPDATE Product SET productImageURL = 'images/28.jpg' WHERE productId = 28;
 
-- Loads image data for product 1
--UPDATE Product SET productImage = 