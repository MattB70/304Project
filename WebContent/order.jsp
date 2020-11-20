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
DONE+6 marks - 	for traversing list of products and storing each ordered product in the orderproduct table
DONE+2 marks - 	for updating total amount for the order in OrderSummary table
DONE+2 marks - 	for displaying the order information including all ordered items
	+1 mark - 	for clearing the shopping cart (sessional variable) after order has been successfully placed
DONE+1 mark - 	for closing connection (either explicitly or as part of try-catch with resources syntax)
*/
// Get customer id
String custId = request.getParameter("customerId");
String password = request.getParameter("password");
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


			// CUSTOEMR INFO ===================================================
			// Do the stuff
			String sql = "SELECT address, city, state, postalCode, country "
						+"FROM customer "
						+"WHERE customerId = "+custId;
			pstmt = con.prepareStatement(sql);
			ResultSet rstc = pstmt.executeQuery();
			rstc.next();
			String address = rstc.getString(1);
			String city = rstc.getString(2);
			String state = rstc.getString(3);
			String postalCode = rstc.getString(4);
			String country = rstc.getString(5);
			
			// ===================================================================
			

			out.println("<table border=1><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th></tr>");


			double total = 0;


			// Retrieve auto-generated key for orderId
			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			orderId = keys.getInt(1);


			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
				String price = (String) product.get(2);
				double pr = Double.parseDouble(price.substring(1));
				int qty = ( (Integer)product.get(3)).intValue();

				total = total + pr*qty;

				
				// get product name
				sql = "SELECT productName "
				+"FROM product "
				+"WHERE productId = "+productId;
				pstmt = con.prepareStatement(sql);
				ResultSet rst2 = pstmt.executeQuery();
				rst2.next();
				String productName = rst2.getString(1);


				//insert into ordersummary
				//can probably insert the value we just got into the orderproduct table
				sql = "INSERT INTO ordersummary (orderDate, totalAmount, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry, customerId) "
					+ "VALUES (?,?,?,?,?,?,?,?)";
				// Use retrieval of auto-generated keys.
				pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				
				LocalTime now = LocalTime.now();
				Time time = Time.valueOf( now );
				
				pstmt.setString(1, "2019-10-15 10:25:55.0");			//orderDate
				pstmt.setDouble(2, total);								//totalAmount
				pstmt.setString(3, address);							//shiptoAddress
				pstmt.setString(4, city);								//shiptoCity
				pstmt.setString(5, state);								//shiptoState
				pstmt.setString(6, postalCode);							//shiptoPostalCode
				pstmt.setString(7, country);							//shiptoCountry
				pstmt.setInt(8, Integer.parseInt(custId));				//customerId

				int updatedOS = pstmt.executeUpdate();
				

				out.println("<tr><td>" + productId +"</td><td>"+ productName +"</td><td>"+ qty +"</td><td>"+ currFormat.format(pr) + "</td></tr>");

				/*
				sql = "INSERT INTO orderproduct (orderId, productId, quantity, price) "
					+ "VALUES (?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, orderId);					//orderId
				pstmt.setString(2, rst2.getString(1));		//productId
				pstmt.setString(3, rst2.getString(2));		//quantity
				pstmt.setString(4, rst2.getString(3));		//price
				int updatedOP = pstmt.executeUpdate();
				*/
				
			}
		}
		else
		{
			out.println("<h2>Invalid Customer Id! Customer not found.</h2>");
		}

		//productList.clear();

		out.println("</table>");

		if (con!=null) con.close();

		out.println("<h2>Order completed. Will be shipped soon...</h2>");
		out.println("<h2>Your order reference number is: "+orderId+"</h2>");
		out.println("<h2>Shipping to customer:"+custId+" Name: </h2>");

		//end session
		session.setAttribute("productList", null);
		

	}



} catch(NumberFormatException e) { 
	out.println("<h2>Invalid custId: "+custId+"</h2>");
} catch (SQLException e) { 	
	out.println("SQLException: " +e); 
} catch(Exception e) {
	out.println("<h2>"+e+"</h2>");
}
%>


<script>

	//let stateObj = { id: "100" };
	//window.history.replaceState(stateObj, "Page 3", "/shop/order.jsp"); 

</script>

</div>
</BODY>
</HTML>

