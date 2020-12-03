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

<tr><td>Payment Type: </td><td><input type="paymentType" name="paymentType" size="30"></td></tr>
<tr><td>Payment Number: </td><td><input type="paymentNumber" name="paymentNumber" size="30"></td></tr>
<tr><td>Payment Expiry Date: </td><td><input type="paymentExpiryDate" name="paymentExpiryDate" size="30"></td></tr>

<tr><td>Shipping address: </td><td><input type="address" name="address" size="30"></td></tr>
<tr><td>City: </td><td><input type="city" name="city" size="30"></td></tr>
<tr><td>State: </td><td><input type="state" name="state" size="30"></td></tr>
<tr><td>Postal Code: </td><td><input type="postal" name="postal" size="30"></td></tr>
<tr><td>Country: </td><td><input type="country" name="country" size="30"></td></tr>
<tr><td style='text-align:center;'><input type='reset' name='reset' value='Reset'></td><td style='text-align:center;'><input type='submit' name='submit' value='Submit'></td></tr>
</table>
</form>
<%-- <%
getConnection();

//get payment and shipment info
//maybe input info then insert into tables?
String sql = "SELECT * " 
           + "FROM shipment s, paymentmethod p ";
           //+ "WHERE ";
PreparedStatement pst = con.prepareStatement(sql);
ResultSet rst = pst.executeQuery();

%>
<%
closeConnection();
%> --%>

</div>
</body>
</html>

