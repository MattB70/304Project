<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<html>
<head>
<title>Ramon's World - Product Information</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<div id="main-content">
<%
// Get product name to search for
// TODO: Retrieve and display info for the product

try{
getConnection();

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
String productId = request.getParameter("id");
String sql = "SELECT P.productId, P.productName, P.productPrice, P.productImageURL, P.productImage, P.productDesc, C.categoryName "
               + "FROM product P, category C "
               + "WHERE P.categoryId = C.categoryId AND productId = ?";

PreparedStatement pst = con.prepareStatement(sql);
pst.setString(1, productId);
ResultSet rst = pst.executeQuery();

while(rst.next()){
	String addCartLink = "addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price=" + currFormat.format(rst.getDouble(3));
    String binaryLink =  "displayImage.jsp?id="+rst.getString(1);
    String imageInFile = rst.getString(4);
    String imageInBinary = rst.getString(5);

    out.println("<table border=3><th colspan = 2><h1>"+rst.getString(2)+ " - "+ rst.getString(6)
  +"</h1></th><tr><td style='text-align:center;' colspan = 2>");
  if (imageInFile != null){
     out.println("<img style='height:500px' src='"+ rst.getString(4) + "'>");
  }
  if (imageInBinary != null){
      out.println("<img style='height:500px' src=\"" + binaryLink + "\">");
  }
    out.println("</td></tr><tr><td>"+"Id: "+rst.getString(1)+"</td><td>"+"Price: "+currFormat.format(rst.getDouble(3))+"</tr><br>");
    out.println("</table>");
    out.println("<h2><a href=\"" + addCartLink + "\">Add to Cart</a></h2>");
    out.println("<h2><a href=listprod.jsp>Continue Shopping</a></h2>");
}
closeConnection();
}
catch (SQLException ex) { 	
	out.println(ex); 
}
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>
</div>
</body>
</html>

