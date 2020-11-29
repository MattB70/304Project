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
	<title>Review</title>
	</head>
	<h1>Write a Review: </h1>
	<h2>Please fill-in the following fields to rate 
	<%
	try	{
		String productId = request.getParameter("productId");
		getConnection();
		String sql = "SELECT productName FROM product WHERE productId = ?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, Integer.parseInt(productId));
		ResultSet rst = pst.executeQuery();
		while(rst.next()){
			out.print(rst.getString(1));
		}
		String productLink = "product.jsp?id=" + rst.getInt(2);
        out.println("<h2><a href=\"" + productLink + "\">Back to Product</a></h2>"); 
		
	}catch(Exception e){
		out.print("this product");
	}
	%>
	</h2>

	<form name="writeReview">
		<table>
			<tr>
				<th><label for="reviewRating">Rating: </label></th>
				<td><input required type="number" name="reviewRating" size=40 placeholder="0-5" min="0" max= "5" title="Please rate your experience between 0 and 5 (5 being an excellent experience)"></td>
			</tr>
		<%
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat dateFormatter = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		
		out.print("<tr>"
					+"<th>Date: </label></th>"
					+"<td><input name='reviewDate' value="+ dateFormatter.format(date) +"></td>"
					+"</tr>");
		%>

			<tr>
				<th><label for="reviewComment">Comment: </label></th>
				<td><textarea name="reviewComment" form="writeReview" placeholder="Enter your comment here..." style="padding:'10px 20px';margin:'10px 0';border:'1px solid #ccc';border-radius:'4px'"></textarea></td>
			</tr>
		</table>
		<input class="submit" type="submit" name="SubmitReview" value="Submit">
                
	</form>
</html>