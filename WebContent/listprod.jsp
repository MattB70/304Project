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

<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

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
<input type="submit" value="Submit"><input type="reset" value="Reset"> <br>(Leave blank for all products)
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

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try { 
		getConnection();  // Make the connection
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

	out.println("<table border=3><tr><th> </th><th>Category</th><th>Product Name</th><th>Description</th><th>Image</th><th>Price</th></tr>");
	while (rst.next()){	

		String addCartLink = "addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price=" + currFormat.format(rst.getDouble(3));
		String productLink = "product.jsp?id=" + rst.getInt(1);
		
		out.print("<tr><td><a href=\"" + addCartLink + "\">Add to Cart</a></td><td>"+rst.getString(6)
		+"</td><td><a href=\""+ productLink+"\">" + rst.getString(2) +"</a></td><td>"+rst.getString(5)
		+"</td><td style='text-align:center;'>"+ "<img style='height:200px;' src='"
		+ rst.getString("productImageURL")+"' alt=\"image unavailable\">" +"</td><td>"
		+currFormat.format(rst.getDouble(3))+"</td></tr>");
	}
	out.println("</table>");
	closeConnection();
}
catch (SQLException ex) { 	
	out.println(ex); 
} 
%>
</div>
</body>
</html>