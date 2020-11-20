<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
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

try ( Connection con = DriverManager.getConnection(url, uid, pw);) { 

	PreparedStatement pstmt = con.prepareStatement("SELECT customerId, firstName, lastName, password FROM Customer WHERE customerId = ?");
	if(productList == null)
	{
		out.println("<h2>No items in cart!</h2>");
	}
	else
	{
		int id = Integer.parseInt(custId);
		pstmt.setInt(1, id);
		ResultSet rst = pstmt.executeQuery();

		if(rst.next())
		{
			// Header
			out.println("<h1>Your Order Summary</h1>");


		while (rst2.next()){


			double total = 0;

			pstmt.setString(1, "2019-10-15 10:25:55.0");			//orderDate
			pstmt.setDouble(2, rst2.getDouble(3)*rst2.getInt(2));	//totalAmount
			pstmt.setString(3, address);							//shiptoAddress
			pstmt.setString(4, city);								//shiptoCity
			pstmt.setString(5, state);								//shiptoState
			pstmt.setString(6, postalCode);							//shiptoPostalCode
			pstmt.setString(7, country);							//shiptoCountry
			pstmt.setInt(8, Integer.parseInt(custId));				//customerId

			int updated = pstmt.executeUpdate();

			// Retrieve auto-generated key for orderId
			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			int orderId = keys.getInt(1);


			/*
			sql = "SELECT address, city, state, postalCode, country "
			 	+ "FROM customer "
			 	+ "WHERE customerId = "+custId;
			pst = con.prepareStatement(sql);
			ResultSet rstc = pst.executeQuery();
			rstc.next();
			*/
		}

		out.println("</table>");
		
		if (con!=null) con.close();


		//end session
		session.setAttribute("productList", null); 
		

	}
	else	// There exists no products in the cart
	{
		out.println("<h2>No items in cart!</h2>");
	}



} catch(NumberFormatException e) { 
	out.println("<h2>Invalid custId: "+custId+"</h2>");
} catch (SQLException e) { 	
	out.println("SQLException: " +e); 
} catch(Exception e) {
	out.println("<h2>"+e+"</h2>");
}



// Save order information to database


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT
	//get previous insert
	//if (rst.getInt() != null){
	//	sql = "INSERT INTO orderproduct (orderId, productId, quantity, price)"
	//		+ "VALUES ('rst.getObject(0)','rst.getObject(1)','rst.getObject(2)','rst.getObject(3)')";
	//	//syntax for values and columns
	//	pst = con.prepareStatement(sql);
	//	rst = pst.executeQuery();
	//	
	//}
	//else(con!=null) con.close();
		//check it is non null/not current
	//while .hasnext()
	//insert into table
	//exit
// Update total amount for order record
	//could recursive SUM(amount)
// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</div>
</BODY>
</HTML>

