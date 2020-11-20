<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
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
@SuppressWarnings({"unchecked"})
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



try ( Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();) { 
	// Determine if valid customer id was entered
	Integer.parseInt(custId);

	// Determine if there are products in the shopping cart
	String sql = "SELECT COUNT(productId) "
				+"FROM ordersummary OS JOIN orderproduct OP ON OS.orderId = OP.orderId "
				+"WHERE OS.customerId = "+custId;
	PreparedStatement pst = con.prepareStatement(sql);
	ResultSet rst = pst.executeQuery();
	rst.next();
	if(rst.getInt(1) > 0)	// There exists products in the cart
	{
		// Header
		out.println("<h1>Your Order Summary</h1>");



		// Do the stuff
		sql = "SELECT P.productId, P.productName, OP.quantity, P.productPrice "
					+"FROM product P JOIN orderproduct OP ON P.productId = OP.productId";
		pst = con.prepareStatement(sql);
		rst = pst.executeQuery();	

		out.println("<table border=1><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th></tr>");
	
		while (rst.next()){	
			out.println("<tr><td>" + rst.getString(1) +"</td><td>"+ rst.getString(2) +"</td><td>"+ rst.getString(3) +"</td><td>"+ currFormat.format(rst.getFloat(4)) + "</td></tr>");
		}
		out.println("</table>");
		if (con!=null) con.close();



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

