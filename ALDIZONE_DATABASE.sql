-- Create the ALDIZON database
CREATE DATABASE IF NOT EXISTS ALDIZON;
USE ALDIZON;

-- Create the Manufacturer table
CREATE TABLE Manufacturer (
    ManufacturerID INT PRIMARY KEY,
    Manufacturer_Name VARCHAR(255) NOT NULL,
    Manufacturer_Address VARCHAR(255),
    Manufacturer_PhoneNumber VARCHAR(20),
    Manufacturer_Email VARCHAR(100)
);


-- Create the Product table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Product_Name VARCHAR(255) NOT NULL,
    Product_Price DECIMAL(10, 2) NOT NULL,
    Product_Description TEXT,
    Stock_Level INT,
    Graduated_Prices FLOAT,
    Availability BOOLEAN,
    ManufacturerID INT,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)
);

-- Create the Customer table
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL
    
);

-- Create a table for the shopping cart
CREATE TABLE ShoppingCart (
    CartID INT PRIMARY KEY,
    CustomerID INT NOT NULL, -- Not applicable for guests
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
    
);

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Status ENUM('open', 'in progress', 'shipped', 'completed', 'canceled') NOT NULL,
    OrderDate DATETIME,
    DeliveryAddress VARCHAR(255) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create a table for payment methods
CREATE TABLE PaymentMethods (
    PaymentMethodID INT PRIMARY KEY,
    Name VARCHAR(100)
);

-- Create a junction table for orders and payment methods (assuming multiple payment methods per order)
CREATE TABLE OrderPaymentMethods (
    OrderID INT,
    PaymentMethodID INT,
    PRIMARY KEY (OrderID, PaymentMethodID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID)
    
);

-- Create the OrderItem table
CREATE TABLE OrderItem (
    OrderItemID INT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PriceAtOrder DECIMAL(10, 2),
    Discount DECIMAL(10, 2),
    ShippingCost DECIMAL(10, 2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY Product (ProductID) REFERENCES Product(ProductID)
);

-- Create a table for guest orders
CREATE TABLE GuestOrders (
    OrderID INT PRIMARY KEY,
    GuestName VARCHAR(100),
    GuestEmail VARCHAR(100),
    OrderDate DATETIME
);

-- Create the Store table
CREATE TABLE Store (
    StoreID INT,
    ProductID INT,
    Location VARCHAR(255) NOT NULL,
    StockInStore INT,
    Availability BOOLEAN,
    PRIMARY KEY (StoreID, ProductID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create the Country table
CREATE TABLE Country (
    CountryCode VARCHAR(2) PRIMARY KEY,
    CountryName VARCHAR(255) NOT NULL,
    StoreID INT,
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);

-- Create the Language table
CREATE TABLE Language (
    LanguageID INT PRIMARY KEY,
    LanguageName VARCHAR(50) NOT NULL
);

-- Create the ProductLanguage table (for multilingual product descriptions)
CREATE TABLE ProductLanguage (
    ProductID INT,
    LanguageID INT,
    Description TEXT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (LanguageID) REFERENCES Language(LanguageID)
);


-- Create the Review table
CREATE TABLE CustomerReview (
    ReviewID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    Rating INT,
    ReviewDate DATETIME,
    Comment TEXT,
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- Create the Category table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
	ProductID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create the Subcategory table
CREATE TABLE Subcategory (
    SubcategoryID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create the Brand table
CREATE TABLE Brand (
    BrandID INT PRIMARY KEY,
    ProductID INT,
    Name VARCHAR(100) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
