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

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	out.print(userName);
	
	/*
	getConnection();
	String sql = "SELECT userId, password FROM customer WHERE userId = ?";
	PreparedStatement pst = con.prepareStatement(sql);
	pst.setString(1, userName);
	ResultSet rst = pst.executeQuery();
	rst.next();
	if(!rst.getString(1).equals(null))
	{
		out.print(rst.getString(1));
	}
	*/
%>

<%

// TODO: Print Customer information
String sql = "";

// Make sure to close connection
%>

</body>
</html>

