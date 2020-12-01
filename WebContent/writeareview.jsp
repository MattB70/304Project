<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp"%>
<%@ include file="header.jsp" %>
<link rel="stylesheet" type="text/css" href="style.css" />
<!DOCTYPE html>
<html>
<head>
<title>Review Form</title>
</head>	

<%
try	{
	getConnection();
	String productId = request.getParameter("id");
	String sql = "SELECT productName, productDesc FROM product WHERE productId = ?";
	PreparedStatement pst = con.prepareStatement(sql);
	pst.setString(1, productId);
	ResultSet rst = pst.executeQuery();
	while(rst.next()){
		out.println("<h1>Write a Review: </h1>");
		out.println("<h3>Fill in the following to rate: "+rst.getString(1)+" - "+rst.getString(2)+"</h3>");
	}
	%>
	<form name="writeReview" method=get action=writeareview.jsp>
	<table>
	<tr>
	<th><label for="reviewRating">Rating: </label></th>
	<td><input required type="number" name="reviewRating" placeholder="0" min="0" max= "5"></td>
	</tr>
	<%
	Date date = new Date(System.currentTimeMillis());
	SimpleDateFormat dateFormatter = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
	out.print("<tr><th>Date: </label></th><td><input name='reviewDate' value="+ dateFormatter.format(date) +"></td></tr>");
	%>

	<tr>
	<th><label for="reviewComment">Comment: </label></th>
	<td><input type="text" name="reviewComment" size="50" placeholder="Enter your comment here..."></td>
	<tr><td style='text-align:center;'><input type="reset" value="Reset"> </td><td style='text-align:right;'><input class="submit" type="submit" name="SubmitReview" value="Submit"></td></tr>
	</table>
	</form>
	<%
	String reviewRating = request.getParameter("reviewRating");
	String reviewDate = request.getParameter("reviewDate");
	String reviewComment = request.getParameter("reviewComment");
	String userId = request.getParameter("authenticatedUser");
	String customerId = null;
	/**    Tried to validate reviews:   
		if(reviewRating == null || reviewDate == null || reviewComment == null){
            return;
        }
        String sqlc = "SELECT customerId FROM customer WHERE userId = ?";
        PreparedStatement pstc = con.prepareStatement(sqlc);
        pstc.setString(1,userId);
        ResultSet rstc = pstc.executeQuery();
        while (rstc.next()){
            customerId = rstc.getString(1);
        }
        String sqlr = "SELECT customerId, productId FROM review WHERE productId = ? AND customerId = ?";
        PreparedStatement pstr = con.prepareStatement(sqlr);
        pstr.setInt(1, Integer.parseInt(productId));
        pstr.setString(2, customerId);
        ResultSet rstr = pstr.executeQuery();
       if (rstr.first()){
           out.println("You have already written a review!");
           return;
       }else{
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date rDate = null;
				try {
					rDate = sdf.parse(reviewDate);
				} catch (Exception e) {
				}
	 **/
	String insertR = "INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (?, ?, ?, ?, ?) ";
	PreparedStatement psti = con.prepareStatement(insertR);
	psti.setString(1, reviewRating);
	psti.setString(2, reviewDate);
	psti.setString(3, customerId);
	psti.setString(4, productId);
	psti.setString(5, reviewComment);
	psti.executeUpdate();
	closeConnection();
}catch (SQLException ex) { 	
	out.println(ex); 
}
%>

<br><h2><a href=listprod.jsp>Continue Shopping</a></h2>
</html>