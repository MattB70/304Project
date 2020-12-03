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

        out.println("<table border=3><th colspan = 2><h2>"+rst.getString(2)+ " - "+ rst.getString(6)
    +"</h2></th><tr><td style='text-align:center;' colspan = 2>");
    if(imageInFile != null){ //rest of images stored in file
        out.println("<img style='height:500px' src=\""+ rst.getString(4) + "\">");
    }else if(imageInBinary != null){ //test for product 1 loaded from ddl file
        out.println("<img style='height:500px' src=\"displayImage.jsp?id="+rst.getInt(1)+"\">");
    } 
        out.println("</td></tr><tr><td>"+"Id: "+rst.getString(1)+"</td><td>"+"Price: "+currFormat.format(rst.getDouble(3))+"</tr><br>");
        out.println("</table><br>");
        String reviewLink = "writeareview.jsp?id=" + rst.getInt(1);
        out.println("<h2><a href=\"" + reviewLink + "\">Write a Review</a></h2>"); 
        out.println("<h2><a href=\"" + addCartLink + "\">Add to Cart</a></h2>");
        out.println("<h2><a href=listprod.jsp>Continue Shopping</a></h2>");
    }
%>
</div>
<div id="main-content">
<%
    String sql2 = "SELECT R.reviewRating, R.reviewDate, R.reviewComment, C.firstName, C.lastName "
                +"FROM review R, customer C "
                +"WHERE R.customerId = C.customerId AND productId = ?";

    PreparedStatement pst2 = con.prepareStatement(sql2);
    pst2.setInt(1, Integer.parseInt(productId));
    ResultSet rst2 = pst2.executeQuery();

    String sql3 = "SELECT R.reviewRating, R.reviewDate, R.reviewComment, C.firstName, C.lastName "
                +"FROM review R, customer C "
                +"WHERE R.customerId = C.customerId AND productId = ?";
    PreparedStatement pst3 = con.prepareStatement(sql3);
    pst3.setInt(1, Integer.parseInt(productId));
    ResultSet rst3 = pst3.executeQuery();

    out.println("<br><h1>Reviews: </h1>");
    if(rst3.next()){
        out.println("<table border=3><th>Rating</th><th>Customer Name</th><th>Date</th><th>Comment</th>");
    } else{
        out.println("<br><h2 style=\"color:#E46F6F; white-space:nowrap;\">This product currently has no reviews.</h2>");
    }
    while(rst2.next()){
    int reviewRating = rst2.getInt(1);
        if(reviewRating == 5){
            out.println("<tr><td> <img style='height:48px' src=\"images/5stars.png\" alt=\"5\"> </td><td>"+rst2.getString(4)+" "+rst2.getString(5)+"</td><td>"+rst2.getDate(2)+"</td><td>"+rst2.getString(3)+"</td></tr>");
        }
        else if(reviewRating == 4){
            out.println("<tr><td> <img style='height:48px' src=\"images/4stars.png\" alt=\"4\"> </td><td>"+rst2.getString(4)+" "+rst2.getString(5)+"</td><td>"+rst2.getDate(2)+"</td><td>"+rst2.getString(3)+"</td></tr>");
        }
        else if(reviewRating == 3){
            out.println("<tr><td> <img style='height:48px' src=\"images/3stars.png\" alt=\"3\"> </td><td>"+rst2.getString(4)+" "+rst2.getString(5)+"</td><td>"+rst2.getDate(2)+"</td><td>"+rst2.getString(3)+"</td></tr>");
        }
        else if(reviewRating == 2){
            out.println("<tr><td> <img style='height:48px' src=\"images/2stars.png\" alt=\"2\"> </td><td>"+rst2.getString(4)+" "+rst2.getString(5)+"</td><td>"+rst2.getDate(2)+"</td><td>"+rst2.getString(3)+"</td></tr>");
        }
        else if(reviewRating == 1){
            out.println("<tr><td> <img style='height:48px' src=\"images/1stars.png\" alt=\"1\"> </td><td>"+rst2.getString(4)+" "+rst2.getString(5)+"</td><td>"+rst2.getDate(2)+"</td><td>"+rst2.getString(3)+"</td></tr>");
        }
        else{
            out.println("<tr><td>"+reviewRating+"</td><td>"+rst2.getString(4)+" "+rst2.getString(5)+"</td><td>"+rst2.getDate(2)+"</td><td>"+rst2.getString(3)+"</td></tr>");
        }
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

