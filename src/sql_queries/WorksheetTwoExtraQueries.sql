/*One interesting query would find the total customer deliveries by state
Relational Algebra: State FUNCTION(count) (Customer Order * Zips)
 */
SELECT Zips.state, COUNT(DISTINCT Customer_Order.order_id) AS num_orders
FROM Customer
JOIN Customer_Order ON Customer.username = Customer_Order.username_fk
JOIN Zips ON Customer_Order.zip_code_fk = Zips.zip_code
GROUP BY Zips.state;


 /*Another interesting query could find the oldest title ever sold
   Relational Algebra: FUNCTION(min year) (Customer Order Invoice Items * Books)
  */
SELECT MIN(Books.year) AS min_year
FROM Customer_Order_Invoice_Items
JOIN Books ON Books.isbn = Customer_Order_Invoice_Items.isbn_fk;


/*Lastly, a query could find the number of books fulfilled by warehouse
  Relational Algebra: id FUNCTION(sum quantity)(Warehouse ⋈ (id=warehouse_id) Customer_Order_Invoice_Items)
 */
SELECT Warehouse.id, SUM(Customer_Order_Invoice_Items.quantity) AS total_quantity
FROM Warehouse
JOIN Customer_Order_Invoice_Items ON Warehouse.id = Customer_Order_Invoice_Items.warehouse_id_fk
GROUP BY Warehouse.id;
