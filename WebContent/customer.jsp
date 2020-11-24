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

<%
	// Connect and query
	getConnection();
	String sql = "SELECT customerId,firstName,lastName,email,phonenum,address,city,state,postalCode,country,userid FROM customer WHERE userId = ?";
	PreparedStatement pst = con.prepareStatement(sql);
	pst.setString(1, userName);
	ResultSet rst = pst.executeQuery();
	rst.next();

	// Print Customer Info
	out.print("<table>");
	out.print("<tr><td><h3>	Id			</h3></td><td>"+rst.getString(1)+"</td></tr>");
	out.print("<tr><td><h3>	First Name	</h3></td><td>"+rst.getString(2)+"</td></tr>");
	out.print("<tr><td><h3>	Last Name	</h3></td><td>"+rst.getString(3)+"</td></tr>");
	out.print("<tr><td><h3>	Email		</h3></td><td>"+rst.getString(4)+"</td></tr>");
	out.print("<tr><td><h3>	Phone		</h3></td><td>"+rst.getString(5)+"</td></tr>");
	out.print("<tr><td><h3>	Address		</h3></td><td>"+rst.getString(6)+"</td></tr>");
	out.print("<tr><td><h3>	City		</h3></td><td>"+rst.getString(7)+"</td></tr>");
	out.print("<tr><td><h3>	State		</h3></td><td>"+rst.getString(8)+"</td></tr>");
	out.print("<tr><td><h3>	Postal Code	</h3></td><td>"+rst.getString(9)+"</td></tr>");
	out.print("<tr><td><h3>	Country		</h3></td><td>"+rst.getString(10)+"</td></tr>");
	out.print("<tr><td><h3>	User id		</h3></td><td>"+rst.getString(11)+"</td></tr>");
	out.print("</table>");

	
	closeConnection();
	
%>
</div>
</body>
</html>

