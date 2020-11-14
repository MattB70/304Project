<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Ramon's World Gift Shop</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
<h2 align="left"><a href="shop.html"> Home Page</a></h2>
<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>
<h2>All Products</h2>

<%
 // Get product name to search for
String name = request.getParameter("productName");	
//Note: Forces loading of SQL Server driver
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
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

// Make the connection
try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) {
		//CHECK: Part 3 of question 2 --> We may need to modify "LIKE" clause
	String sql = "SELECT productName, price, productId FROM Product WHERE productName LIKE %?% AND Inventory > 0 ORDER BY productName";
	PreparedStatement pst = con.prepareStatement(sql);
	ResultSet rst = pst.executeQuery();	
	String prodName = rst.getString("productName");
	pst.setString(1, prodName);	

	out.println("<table border=1><tr><th> </th><th>Product Name</th><th>Price</th></tr>");
	
	while (rst.next()){	
	out.println("<tr><td><a href=\"addcart.jsp?id=" + rst.getString(3) + "&name=" + rst.getString(1)
							+ "&price=" + rst.getString(2) + "\">Add to cart</a>" + "</td><td>" + rst.getString(1)
							+ "</td><td>" + rst.getString(2) + "</td></tr>");
	}
	out.println("</table>");
	if (con!=null) con.close();
}
catch (SQLException ex) { 	
	out.println(ex); 
} 
// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>