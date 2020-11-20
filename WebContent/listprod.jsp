<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Ramon World Gift Shop</title>
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

<h2>Browse products by category and search by product name:</h2>

<form method="get" action="listprod.jsp">
<select size = "1" name= "categoryName">
<option>All</option>
<option>T-Shirts</option>
<option>Mugs</option>
<option>Magnets</option>
<option>Lanyards</option>
<option>Keychains</option>
<option>Post Cards</option>
<option>Hats</option>
<option>Bobble Heads</option>
</select>
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Clear"> <br>(Leave blank for all products)
</form>
<br>


<%
 // Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("categoryName");
boolean hasNameEntered = name != null && !name.equals("");
boolean hasCategoryEntered = category != null && !category.equals("") && !category.equals("All");

if(name == null) name = ""; // ensure name is never null.
String filter = "";
String sql = "";
//Note: Forces loading of SQL Server driver
if(hasNameEntered && hasCategoryEntered){
	filter = "<h2>Products matching: "+name+"in category: "+category+"</h2>";
	name = '%'+name+'%';
	sql = "SELECT P.productId, P.productName, P.productPrice, P.productImageURL, P.productDesc, C.categoryName FROM product P, category C WHERE P.categoryId = C.categoryId AND productName LIKE ? AND categoryName LIKE ?"; 
}
else if(hasNameEntered && !hasCategoryEntered){
	filter = "<h2>Products matching: "+name+"</h2>";
	name = '%'+name+'%';
	sql = "SELECT P.productId, P.productName, P.productPrice, P.productImageURL, P.productDesc, C.categoryName FROM product P, category C WHERE P.categoryId = C.categoryId AND productName LIKE ?"; 
}
else if(!hasNameEntered && hasCategoryEntered){
	filter = "<h2>Products in category: "+category+"</h2>";
	sql = "SELECT P.productId, P.productName, P.productPrice, P.productImageURL, P.productDesc, C.categoryName FROM product P, category C WHERE P.categoryId = C.categoryId AND categoryName LIKE ?"; 
}else{
filter = "<h2>All products: </h2>";
	sql = "SELECT P.productId, P.productName, P.productPrice, P.productImageURL, P.productDesc, C.categoryName FROM product P, category C WHERE P.categoryId = C.categoryId"; 	
}
out.println(filter);
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

// Make the connection
try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) {

	PreparedStatement pst = con.prepareStatement(sql);
	if (hasNameEntered){
		pst.setString(1, name);	
		if (hasCategoryEntered){
			pst.setString(2, category);
		}
	}else if (hasCategoryEntered){
		pst.setString(1, category);
	}
	ResultSet rst = pst.executeQuery();	

	out.println("<table><tr><th> </th><th>Category</th><th>Product Name</th><th>Description</th><th>Image</th><th>Price</th></tr>");
	while (rst.next()){	

		String link = "addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price=" + currFormat.format(rst.getDouble(3));
		out.print("<tr><td><a href=\"" + link + "\">Add to Cart</a></td><td>"+rst.getString(6)+"</td><td>"+rst.getString(2)+"</td><td>"+rst.getString(5)+"</td><td>"+ "<img style='height:200px' src='"+ rst.getString("productImageURL") +"' alt=\"image unavailable\">" +"</td><td>"+currFormat.format(rst.getDouble(3))+"</td></tr>");
	}
	out.println("</table>");
	if (con!=null) con.close();
}
catch (SQLException ex) { 	
	out.println(ex); 
} 
%>
</div>
</body>
</html>