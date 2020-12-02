<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>



<%@ include file="header.jsp" %>



<div id="main-content">


<%
	String userName = (String) session.getAttribute("authenticatedUser");
	out.print("<h2>Customer Profile</h2><br><br>");
%>



<%!	// Helper for printing table
	String formatRow(String title, String info){
		return "<tr><th>	"+title+"			</th><td>"+info+"</td></tr>";
	}
%>



<%

	try	{
		getConnection();
		// Connect and query
		String sql = "SELECT customerId,firstName,lastName,email,phonenum,address,city,state,postalCode,country,userid FROM customer WHERE userId = ?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, userName);
		ResultSet rst = pst.executeQuery();
		rst.next();

		// Print Customer Info
		out.print("<table border=3>");
		out.print(formatRow("id", 			rst.getString(1)));
		out.print(formatRow("First Name", 	rst.getString(2)));
		out.print(formatRow("Last Name", 	rst.getString(3)));
		out.print(formatRow("Email", 		rst.getString(4)));
		out.print(formatRow("Phone", 		rst.getString(5)));
		out.print(formatRow("Address", 		rst.getString(6)));
		out.print(formatRow("City", 		rst.getString(7)));
		out.print(formatRow("State", 		rst.getString(8)));
		out.print(formatRow("Postal Code", 	rst.getString(9)));
		out.print(formatRow("Country", 		rst.getString(10)));
		out.print(formatRow("User id", 		rst.getString(11)));
		out.print("</table>");
		%>
        <br>
		<h2><a href="listUserOrders.jsp">Click here to see all of your orders!</a></h2>
        <%
	}
	catch(Exception ex){
		out.print("<span title=\""+ex+"\">You must be logged in to view customer info...</span>");
	}
	finally{
		closeConnection();
	}
%>


</div>
</body>
</html>

