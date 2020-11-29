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
<title>Create User Account Page</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
        
<%@ include file="header.jsp" %>
<div id="main-content">
    <%
    out.println("<h2 style=\"color:#ADD8E6; white-space:nowrap;\">Please fill in the required fields. </h2><br>");
    %>
    <form name="MyForm" method=post action="createUser.jsp">
    <table style="display:inline">
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
            <td><input type="text" name="firstName"  size=40 maxlength=15></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
            <td><input type="text" name="lastName" size=40 maxlength="15"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
            <td><input type="text" name="email" size=40 maxlength="30"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
            <td><input type="text" name="phoneNum" size=40 maxlength="12"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
            <td><input type="text" name="address" size=40 maxlength="30"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
            <td><input type="text" name="city" size=40 maxlength="20"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Province/State:</font></div></td>
            <td><input type="text" name="state" size=40 maxlength="2"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
            <td><input type="text" name="postalCode" size=40 maxlength="7"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
            <td><input type="text" name="country" size=40 maxlength="20"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
            <td><input type="text" name="username"  size=40 maxlength=10></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
            <td><input type="password" name="password" size=40 maxlength="10"></td>
        </tr>
        </table>
<br/>
<input class="submit" type="submit" name="createAccount" value="Create Account">
</form>
<%
%> 
</div>
</body>
</html>
