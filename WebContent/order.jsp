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

// Get customer id
String custId = request.getParameter("customerId");
String password = request.getParameter("password");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
session.getAttribute("productList");
// Make connection
try{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e){
	out.println("ClassNotFoundException: " +e);
}
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try ( Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();) { 
	if (custId == null || custId.equals("")){ //if null entered
		out.println("<h1>Invalid customer id. Please go back and try again!</h1>");
		%>
			<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
			<%
	}else if (productList == null){ //if empty cart
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
			out.println("<h1>Please enter a valid Customer ID!</h1>");
			%>
			<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
			<%
			return;
		}
		//Determine if customer id exists in the database
		String sqlc = "SELECT customerId, firstName, lastName, address, city, state, postalCode, country, password FROM customer WHERE customerId = ?";
		PreparedStatement pstc = con.prepareStatement(sqlc);
		pstc.setInt(1, num);
		ResultSet rstc = pstc.executeQuery();
		int orderId = 0;
		String cFirstName = "";
		String cLastName = "";

		if(!rstc.next()){
			out.println("<h1>Invalid customer id. Please go back and try again!</h1><br>");
			%>
			<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
			<%
			return;
		}else{
			String dbpw = rstc.getString(9);

			if(!dbpw.equals(password)){ //check if password matches the one stored in db
				out.println("<h1>Incorrect Password. Please go back and try again!</h1><br>");
				%>
				<h2><a href="checkout.jsp">Back to Checkout Page</a></h2>
				<%
				return;
			}
		}
		cFirstName = rstc.getString(2);
		cLastName = rstc.getString(3);
		String address = rstc.getString(4);
		String city = rstc.getString(5);
		String state = rstc.getString(6);
		String postalCode = rstc.getString(7);
		String country = rstc.getString(8);

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

		double total =0;
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();

		while (iterator.hasNext()){ 
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String productId = (String) product.get(0);
			out.print("<tr><td>"+productId+"</td>");
			out.print("<td>"+product.get(1)+"</td>");
			out.print("<td align=\"center\">"+product.get(3)+"</td>");
			String price = (String) product.get(2);
            double pr = Double.parseDouble(price.substring(1));;
			int qty = ( (Integer)product.get(3)).intValue();
			out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
			out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
			out.println("</tr>");
			total += pr*qty;

			sql = "INSERT INTO orderproduct VALUES(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, orderId);
			pstmt.setInt(2, Integer.parseInt(productId));
			pstmt.setInt(3, qty);
			pstmt.setDouble(4, pr);
			pstmt.executeUpdate();				
		}
		out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
				+"<td aling=\"right\">"+currFormat.format(total)+"</td></tr>");
		out.println("</table>");

		// Update order total
		sql = "UPDATE ordersummary SET totalAmount=? WHERE orderId=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setDouble(1, total);
		pstmt.setInt(2, orderId);			
		pstmt.executeUpdate();						

		out.println("<h2>Order completed.  Will be shipped soon...</h2>");
		out.println("<h2>Your order reference number is: "+orderId+"</h2>");
		out.println("<h2>Shipping to customer: "+custId+" Name: "+cFirstName+" "+cLastName+"</h2>");

		// Clear session variables (cart)
		session.setAttribute("productList", null);  

	}
}

catch (SQLException e){
	out.println(e);
}
%>
<br><br><h2><a href="listprod.jsp">Continue Shopping</a></h2>

</div>
</BODY>
</HTML>