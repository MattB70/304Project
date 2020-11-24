<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ramon World Shipment Processing</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
	<%@ include file="header.jsp" %>



	<div id="main-content">
<h1>Please enter your Order ID:</h1>
<form method="get" action="ship.jsp">
<table>
<tr><td>Order ID: </td><td><input type="text" name="orderid" size="30"></td></tr>
</table>
<input type="submit" value="Submit">
</form>
String ordId = request.getParameter("orderid");

	// TODO: Check if valid order id

	// TODO: Start a transaction (turn-off auto-commit)
	
	// TODO: Retrieve all items in order with given id

	// TODO: Create a new shipment record.
	
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
%>                       				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</div>
</body>
</html>
