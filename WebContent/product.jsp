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
               + "WHERE P.categoryId = C.categoryId AND P.productId = ?";

PreparedStatement pst = con.prepareStatement(sql);
pst.setInt(1, Integer.parseInt(productId));
ResultSet rst = pst.executeQuery();

while(rst.next()){
    String imageInFile = rst.getString(4);
    String imageInBinary = rst.getString(5);
    String addCartLink = "addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price=" + currFormat.format(rst.getDouble(3));

    out.println("<table border=3><th colspan = 2><h1>"+rst.getString(2)+ " - "+ rst.getString(6)
  +"</h1></th><tr><td style='text-align:center;' colspan = 2>");
 
  if (imageInBinary != null){ //test for product 1 loaded from ddl file
      out.println("<img style='height:500px' src=\"displayImage.jsp?id="+rst.getInt(1)+"\">");
  } else if (imageInFile != null){ //rest of images stored in file
     out.println("<img style='height:500px' src=\""+ rst.getString(4) + "\">");
  }
    out.println("</td></tr><tr><td>"+"Id: "+rst.getString(1)+"</td><td>"+"Price: "+currFormat.format(rst.getDouble(3))+"</tr><br>");
    out.println("</table><br>");
    String reviewLink = "writeareview.jsp?id=" + rst.getInt(1);
    out.println("<h2><a href=\"" + reviewLink + "\">Write a Review</a></h2>"); 
    out.println("<h2><a href=\"" + addCartLink + "\">Add to Cart</a></h2>");
    out.println("<h2><a href=listprod.jsp>Continue Shopping</a></h2>");
}
String sql2 = "SELECT R.reviewId, R.reviewRating, R.reviewDate, R.reviewComment, R.customerId, C.firstName, C.lastName "
              +"FROM review R, customer C "
              +"WHERE R.customerId = C.customerId AND productId = ?";

PreparedStatement pst2 = con.prepareStatement(sql2);
pst2.setInt(1, Integer.parseInt(productId));
ResultSet rst2 = pst2.executeQuery();

while(rst2.next()){
out.println("<h1>Reviews: </h2>");
out.println("<table borde=3><th>Rating</th><th>Customer Name</th><th>Date</th><th>Comment</th>");
out.println("<tr><td>"+rst2.getInt(2)+"</td><td>"+rst2.getString(6)+" "+rst2.getString(7)+"</td><td>"+rst.getDate(3)+"</td><td>"+rst2.getString(4)+"</td></tr></table>");

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

