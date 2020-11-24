<!DOCTYPE html>
<html>
<head>
<title>Ramon World CheckOut</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>



<%@ include file="header.jsp" %>



<div id="main-content">

<h1>Enter your Customer ID and Password to complete the transaction:</h1>

<form method="get" action="order.jsp">
<table>
<tr><td>Customer ID: </td><td><input type="text" name="customerId" size="30"></td></tr>
<tr><td>Password: </td><td><input type="password" name="password" size="30"></td></tr>
</table>
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

</div>
</body>
</html>

