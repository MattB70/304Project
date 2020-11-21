<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.time.LocalTime" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Ramon World Order Summary</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>

<! buttons !>
<table class="buttons" border="0" width="100%"><tr>     <th class="buttons" align="left"><a href="shop.html"><img src="images/icon.png" alt="Home" height="100" ></a></th>
                                                        <th class="buttons"><a href="listprod.jsp">Begin Shopping</a></th>
                                                        <th class="buttons"><a href="listorder.jsp">List All Orders</a></th>
                                                        <th class="buttons" align="right"><a href="addcart.jsp"><img src="images/cart.png" alt="Cart" height="100" ></a></th></tr></table>

<! banner image below buttons !>
<div id="bannerimage"></div>

<div id="main-content">

<% 
// This file must save an order and all its products to the database as long as a valid customer id was entered.
/*
DONE+1 mark - 	for SQL Server connection information and making a successful connection
	+3 marks - 	for validating that the customer id is a number and the customer id exists in the database.
				Display an error if customer id is invalid.
DONE+1 mark - 	for showing error message if shopping cart is empty
DONE+3 marks - 	for inserting into ordersummary table and retrieving auto-generated id
	+6 marks - 	for traversing list of products and storing each ordered product in the orderproduct table
	+2 marks - 	for updating total amount for the order in OrderSummary table
	+2 marks - 	for displaying the order information including all ordered items
	+1 mark - 	for clearing the shopping cart (sessional variable) after order has been successfully placed
DONE+1 mark - 	for closing connection (either explicitly or as part of try-catch with resources syntax)
*/
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
// id, name, price, quantity
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");


// Make connection
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

int orderId = -1;

try (Connection con = DriverManager.getConnection(url, uid, pw); 
		Statement stmt = con.createStatement();) { 
	// Determine if valid customer id was entered
	String sql = "SELECT COUNT(*) FROM customer "
				+ "WHERE customerId = '" + custId + "' ";
	ResultSet rst = stmt.executeQuery(sql);
	rst.next();
	if(rst.getInt(1) != 1)
		out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
	
	// Save order information to database
	
	// Determine if there are products in the shopping cart
	else if (productList == null || productList.isEmpty()) 
	{	
		out.println("<H1>Your shopping cart is empty!</H1>");
	} else {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    Date date = new Date();
	    
	    float orderTotal = 0;
	    
	    Set<String> keys = productList.keySet();
	    for(String key: keys){
	    	ArrayList<Object> product = (ArrayList<Object>) productList.get(key);
	    	int curAmount = ((Integer) product.get(3)).intValue();
	    	float price = Float.parseFloat(product.get(2).toString());
	    	orderTotal += curAmount * price;
	    }
	    
	    sql = "INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES ('" + custId + 
	    				"', '" + formatter.format(date) + "', " + orderTotal + ")";
	    PreparedStatement psmt = con.prepareStatement(sql);
    	psmt.execute();
    	sql = "SELECT TOP 1 orderId, customerId, totalAmount FROM ordersummary ORDER BY orderId DESC";
	    rst = stmt.executeQuery(sql);
		rst.next();
		
		orderId = rst.getInt("orderId");
		int customerId = rst.getInt("customerId");
		float totalAmount = rst.getFloat("totalAmount");
		
		sql = "SELECT firstName, lastName FROM customer WHERE customerId = '" + customerId + "' ";
	    rst = stmt.executeQuery(sql);
		rst.next();
		
		String firstName = rst.getString("firstName");
		String lastName = rst.getString("lastName");
	    
	    for(String key: keys){
	    	ArrayList<Object> product = (ArrayList<Object>) productList.get(key);
	    	String productId = product.get(0).toString();
	    	String price = product.get(2).toString();
	    	int amount = ((Integer) product.get(3)).intValue();
	    	sql = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (" + orderId + ", " + productId +
	    			", " + amount + ", " + price + ")";
	    	psmt = con.prepareStatement(sql);
	    	psmt.execute();
	    }
	    
	    sql = "SELECT orderproduct.productId, quantity, price, productName FROM orderproduct, product WHERE orderId = '" + orderId + "' AND product.productId = orderproduct.productId";
	    rst = stmt.executeQuery(sql);
	    out.print("<div>");
	    out.print("<h1>Your Order Summary</h1>");
	    out.print("<table align=\"center\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
		while(rst.next()) {
			String prodId = rst.getString("productId");
			int quantity = rst.getInt("quantity");
			float prodPrice = rst.getFloat("price");
			float subTotal = (quantity * prodPrice);
			String prodName = rst.getString("productName");
			out.print("<tr><td>" + prodId + "</td><td>" + prodName + "</td><td align=\"center\">" + quantity + "</td><td align=\"right\">" +
			    	currFormat.format(prodPrice) + "</td><td align=\"right\">" + currFormat.format(subTotal) + "</td></tr></tr>");
		};
		out.print("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td><td aling=\"right\">" + currFormat.format(orderTotal) + "</td></tr>");
	    out.print("</table>");
	    out.print("<h2>Order completed.  Will be shipped soon...</h2>");
	    out.print("<h2>Your order reference number is: " + orderId + "</h2>");
	    out.print("<h2>Shipping to customer: " + custId + " Name: " + firstName + " " + lastName + "</h2>");
	    out.print("<h2><a href=\"shop.html\">Return to shopping</a></h2>");
	    out.print("</div>");
		
		sql = "SELECT productName FROM product ORDER BY productName ASC";
	    rst = stmt.executeQuery(sql);
		rst.next();
	    
	    session.setAttribute("orderId", orderId);
	    
	    session.setAttribute("productList", productList);
	 	
	 	if (!productList.isEmpty()) {
	 		session.removeAttribute("productList");
	 	} else {
	 		return;
	 	}
	    
	}
}
	
catch (SQLException ex) {
	out.println(ex);
}
%>
</BODY>
</HTML>