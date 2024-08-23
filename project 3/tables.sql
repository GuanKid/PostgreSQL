-- Users Table
CREATE TABLE Users (
    User_ID SERIAL PRIMARY KEY,
    Username VARCHAR(100) NOT NULL
);

-- Products Table
CREATE TABLE Products (
    Id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL
);

-- Cart Table
CREATE TABLE Cart (
    ProductId INT PRIMARY KEY,
    Qty INT NOT NULL,
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);

-- OrderHeader Table
CREATE TABLE OrderHeader (
    OrderID SERIAL PRIMARY KEY,
    User_ID INT NOT NULL,
    Orderdate TIMESTAMP NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductId INT,
    Qty INT NOT NULL,
    PRIMARY KEY (OrderID, ProductId),
    FOREIGN KEY (OrderID) REFERENCES OrderHeader(OrderID),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);



INSERT INTO Users (Username)
VALUES 
('Arnold'),
('Sheryl');


INSERT INTO Products (name, price)
VALUES 
('Coke', 10.00),
('Chips', 5.00),
('Pepsi', 8.00),
('Cookies', 7.50);

INSERT INTO OrderHeader (User_ID, Orderdate)
VALUES 
(1, '2024-08-15 15:30:00'), 
(2, '2024-08-16 16:00:00'); 


INSERT INTO OrderDetails (OrderID, ProductId, Qty)
VALUES 
(1, 1, 2),  
(1, 2, 1), 
(2, 3, 2),  
(2, 4, 1);  


DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 1) THEN
        UPDATE Cart SET Qty = Qty + 1 WHERE ProductId = 1;
    ELSE
        INSERT INTO Cart (ProductId, Qty) VALUES (1, 1);
    END IF;
END $$;

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 2) THEN
        UPDATE Cart SET Qty = Qty + 1 WHERE ProductId = 2;
    ELSE
        INSERT INTO Cart (ProductId, Qty) VALUES (2, 1);
    END IF;
END $$;



DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 1 AND Qty > 1) THEN
        UPDATE Cart SET Qty = Qty - 1 WHERE ProductId = 1;
    ELSE
        DELETE FROM Cart WHERE ProductId = 1;
    END IF;
END $$;

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 2 AND Qty > 1) THEN
        UPDATE Cart SET Qty = Qty - 1 WHERE ProductId = 2;
    ELSE
        DELETE FROM Cart WHERE ProductId = 2;
    END IF;
END $$;



-- Insert into OrderHeader
INSERT INTO OrderHeader (User_ID, Orderdate)
VALUES (1, CURRENT_TIMESTAMP);  -- Assuming User_ID 1 is checking out

-- Get the last inserted OrderID
DO $$
DECLARE
    last_order_id INT;
BEGIN
    -- Insert into OrderHeader and get the last inserted OrderID
    INSERT INTO OrderHeader (User_ID, Orderdate)
    VALUES (1, CURRENT_TIMESTAMP)
    RETURNING OrderID INTO last_order_id;

    -- Insert Cart contents into OrderDetails using the last inserted OrderID
    INSERT INTO OrderDetails (OrderID, ProductId, Qty)
    SELECT last_order_id, ProductId, Qty FROM Cart;

    -- Clear the cart after inserting its contents into OrderDetails
    DELETE FROM Cart;
END $$;




-- Add 2 Cokes
INSERT INTO Cart (ProductId, Qty) VALUES (1, 2);
SELECT * FROM Cart;

-- Add 1 Chips
INSERT INTO Cart (ProductId, Qty) VALUES (2, 1);
SELECT * FROM Cart;


-- Remove 1 Coke
DO $$
BEGIN
	UPDATE Cart
SET Qty = Qty - 1
WHERE ProductId = 1;
END $$;
SELECT * FROM Cart;


-- Checkout
DO $$ 
DECLARE
    last_order_id INT;
BEGIN
    -- Insert into OrderHeader and get the last OrderID
    INSERT INTO OrderHeader (User_ID, Orderdate) 
    VALUES (1, CURRENT_TIMESTAMP)
    RETURNING OrderID INTO last_order_id;

    -- Insert Cart contents into OrderDetails
    INSERT INTO OrderDetails (OrderID, ProductId, Qty)
    SELECT last_order_id, ProductId, Qty FROM Cart;

    -- Clear the cart
    DELETE FROM Cart;
END $$;

-- Check the results
SELECT * FROM OrderHeader;
SELECT * FROM OrderDetails;



-- Print all orders
SELECT * FROM OrderHeader;

-- Print all orders with details (joining tables)
SELECT oh.OrderID, oh.Orderdate, od.ProductId, od.Qty
FROM OrderHeader oh
JOIN OrderDetails od ON oh.OrderID = od.OrderID;



CREATE OR REPLACE FUNCTION AddItemToCart(p_ProductId INT, p_Quantity INT) RETURNS VOID AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = p_ProductId) THEN
        UPDATE Cart SET Qty = Qty + p_Quantity WHERE ProductId = p_ProductId;
    ELSE
        INSERT INTO Cart (ProductId, Qty) VALUES (p_ProductId, p_Quantity);
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION RemoveItemFromCart(p_ProductId INT) RETURNS VOID AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = p_ProductId AND Qty > 1) THEN
        UPDATE Cart SET Qty = Qty - 1 WHERE ProductId = p_ProductId;
    ELSE
        DELETE FROM Cart WHERE ProductId = p_ProductId;
    END IF;
END;
$$ LANGUAGE plpgsql;
