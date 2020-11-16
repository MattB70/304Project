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
if(name == null) name = ""; // ensure name is never null.
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

	String sql = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE '%"+name+"%'";
	PreparedStatement pst = con.prepareStatement(sql);
	ResultSet rst = pst.executeQuery();	

	out.println("<table border=1><tr><th> </th><th>Product Name</th><th>Price</th></tr>");
	while (rst.next()){	
		String link = "addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price=" + currFormat.format(rst.getDouble(3));
		out.print("<tr><td><a href=\"" + link + "\">Add to Cart</a></td><td>"+rst.getString(2)+"</td><td>"+currFormat.format(rst.getDouble(3))+"</td></tr>");
	}
	out.println("</table>");
	if (con!=null) con.close();
}
catch (SQLException ex) { 	
	out.println(ex); 
} 
%>
</body>
</html>