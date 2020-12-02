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

<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>

<div id="main-content">

<% 

// Get customer id
String custId = request.getParameter("customerId");
String password = request.getParameter("password");
//get payment info
String paytype = request.getParameter("paymentType");
String paynum = request.getParameter("paymentNumber");
String payexdate = request.getParameter("paymentExpiryDate");
//get shipping info
String shipaddress = request.getParameter("address");
String shipcity = request.getParameter("city");
String shipstate = request.getParameter("state");
String shippostal = request.getParameter("postal");
String shipcountry = request.getParameter("country");

@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
session.getAttribute("productList");

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try { getConnection();
	if (custId == null || custId.equals("")){ 
		//if null entered
		out.println("<h1>Invalid customer id. Please go back to the previous page and try again!</h1>");
		%>
			<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
			<%
	}else if (productList == null){ 
		//if empty cart
		out.println("<h1>Your shopping cart is empty! Please add a product.</h1>");
		%>
			<h2><a href="listprod.jsp">Back to Product Page</a></h2>
			<%
	}else{
		// Determine if customer id entered is an integer
		int num = -1;
		try{
			num = Integer.parseInt(custId);	
		}catch(Exception e){
			out.println("<h1>Invalid Customer ID. Please go back and try again!</h1>");
			%>
			<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
			<%
			return;
		}
	
		//Determine if customer id exists in the database
		String sqlc = "SELECT customerId, firstName, lastName, address, city, C.state, postalCode, country, password, T.tax, T.shipping FROM customer C JOIN taxes T ON C.state = T.state WHERE customerId = ?";
		PreparedStatement pstc = con.prepareStatement(sqlc);
		pstc.setInt(1, num);
		ResultSet rstc = pstc.executeQuery();
		int orderId = 0;
		String cFirstName = "";
		String cLastName = "";

		String sqlcheck = "SELECT customerId, paymentType, paymentNumber, paymentExpiryDate FROM paymentmethod WHERE customerId=?";
		PreparedStatement pstcheck = con.prepareStatement(sqlcheck);
		pstcheck.setInt(1,num);
		ResultSet rstcheck = pstcheck.executeQuery();

		if(!rstc.next()||!rstcheck.next()){
			out.println("<h1>Invalid Customer ID. Please go back and try again!</h1><br>");
			%>
			<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
			<%
			return;
		}else{
			String dbpw = rstc.getString(9);
			//strings for payment checks
			String checkpt = rstcheck.getString(2);
			String checkpn = rstcheck.getString(3);
			String checkped = rstcheck.getString(4);
			//strings for shipment checks
			String dbaddress = rstc.getString(4);
			String dbcity = rstc.getString(5);
			String dbstate = rstc.getString(6);
			String dbpostal = rstc.getString(7);
			String dbcountry = rstc.getString(8);
			if(!dbpw.equals(password)){
				 //check if password matches the one stored in db
				out.println("<h1>Incorrect Password. Please go back and try again!</h1><br>");
				%>
				<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
				<%
				return;
			}
			if(!checkpt.equals(paytype)){
				 //check if payment type matches the one stored in db
				out.println("<h1>Incorrect Payment Type. Please go back and try again!</h1><br>");
				%>
				<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
				<%
				return;
			}
			if(!checkpn.equals(paynum)){
				 //check if payment number matches the one stored in db
				out.println("<h1>Incorrect Payment Number. Please go back and try again!</h1><br>");
				%>
				<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
				<%
				return;
			}
			if(!checkped.equals(payexdate)){
				 //check if payment expiry date matches the one stored in db
				out.println("Entered: "+payexdate);
				out.println("Expected: "+checkped);
				out.println("<h1>Incorrect Payment Expiry Date. Please go back and try again!</h1><br>");
				%>
				<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
				<%
				return;
			}
			if(!dbaddress.equals(shipaddress)){
				 //check if shipping address matches the one stored in db
				out.println("<h1>Incorrect Shipping address compared to what's on file. Please go back and try again!</h1><br>");
				%>
				<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
				<%
				return;
			}
			if(!dbcity.equals(shipcity)){
				 //check if shipping city matches the one stored in db
				out.println("<h1>Incorrect Shipping city compared to what's on file. Please go back and try again!</h1><br>");
				%>
				<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
				<%
				return;
			}
			if(!dbstate.equals(shipstate)){
				 //check if shipping state matches the one stored in db
				out.println("<h1>Incorrect Shipping state compared to what's on file. Please go back and try again!</h1><br>");
				%>
				<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
				<%
				return;
			}
			if(!dbpostal.equals(shippostal)){
				 //check if shipping postal code matches the one stored in db
				out.println("<h1>Incorrect Postal code compared to what's on file. Please go back and try again!</h1><br>");
				%>
				<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
				<%
				return;
			}
			if(!dbcountry.equals(shipcountry)){
				 //check if shipping country matches the one stored in db
				out.println("<h1>Incorrect Country compared to what's on file. Please go back and try again!</h1><br>");
				%>
				<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
				<%
				return;
			}
		}
		//getting values
		cFirstName = rstc.getString(2);
		cLastName = rstc.getString(3);
		String address = rstc.getString(4);
		String city = rstc.getString(5);
		String state = rstc.getString(6);
		String postalCode = rstc.getString(7);
		String country = rstc.getString(8);
		double tax = rstc.getDouble(10);
		double shipping = rstc.getDouble(11);

		// Enter order information into database
		String sql = "INSERT INTO ordersummary (customerId, orderDate) VALUES(?, ?);";

		// Retrieve auto-generated key for orderId
		PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		pstmt.setInt(1, num);
		pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
		pstmt.executeUpdate();
		ResultSet keys = pstmt.getGeneratedKeys();
		keys.next();
		orderId = keys.getInt(1);

		out.println("<h1>Your Order Summary</h1>");
		out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

		double total = 0;
		double total_withshipping = 0;
		double total_notax = 0;
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();

		while (iterator.hasNext()){ 
			//Traversing the hashmap
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String productId = (String) product.get(0);
			out.print("<tr><td>"+productId+"</td>");
			out.print("<td>"+product.get(1)+"</td>");
			out.print("<td align=\"center\">"+product.get(3)+"</td>");
			String price = (String) product.get(2);
            double pr = Double.parseDouble(price.substring(1));
			int qty = ( (Integer)product.get(3)).intValue();
			out.print("<td align=\"left\">"+currFormat.format(pr)+"</td>");
			out.print("<td align=\"left\">"+currFormat.format(pr*qty)+"</td></tr>");
			out.println("</tr>");
			total_notax += pr*qty;
			total += pr*qty*(1+(tax/100));

			//inserting into orderproduct table
			sql = "INSERT INTO orderproduct VALUES(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, orderId);
			pstmt.setInt(2, Integer.parseInt(productId));
			pstmt.setInt(3, qty);
			pstmt.setDouble(4, pr);
			pstmt.executeUpdate();				
		}
		total_withshipping = shipping + total;
		out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
				+"<td aling=\"right\">"+currFormat.format(total_notax)+"</td></tr>");	// Plain total
		out.println("<tr><td colspan=\"4\" align=\"right\"><b><span title=\"Tax depends on location\">Tax: "+tax+"%</span></b></td>"
				+"<td aling=\"right\">"+currFormat.format(total)+"</td></tr>");			// Total with tax
		out.println("<tr><td colspan=\"4\" align=\"right\"><b><span title=\"Shipping depends on location\">Shipping: "+currFormat.format(shipping)+"</span></b></td>"
				+"<td aling=\"right\">"+currFormat.format(total_withshipping)+"</td></tr>");						// Total with tax and shipping
		out.println("</table>");

		// Update order total
		sql = "UPDATE ordersummary SET totalAmount=? WHERE orderId=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setDouble(1, total);
		pstmt.setInt(2, orderId);			
		pstmt.executeUpdate();						

		out.println("<br><h2>Order completed.  Will be shipped soon...</h2>");
		out.println("<h2>Your order reference number is: "+orderId+"</h2>");
		out.println("<h2>Shipping to customer: "+custId+", Name: "+cFirstName+" "+cLastName+"</h2>");

		// Clear session variables (cart)
		session.setAttribute("productList", null);  
	}
	//close connection
	closeConnection();
}
catch (SQLException e){
	out.println(e);
}
%>
<br><br><h2><a href="listprod.jsp">Continue Shopping</a></h2>

</div>
</BODY>
</HTML>