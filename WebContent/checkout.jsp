<!DOCTYPE html>
<html>
<head>
<title>Ramon World CheckOut</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>



<! buttons !>
<table class="buttons" border="0" width="100%"><tr>     <th class="buttons" align="left"><a href="shop.html"><img src="images/icon.png" alt="Home" height="100" ></a></th>
                                                        <th class="buttons"><a href="listprod.jsp">Begin Shopping</a></th>
                                                        <th class="buttons"><a href="listorder.jsp">List All Orders</a></th>
                                                        <th class="buttons" align="right"><a href="addcart.jsp"><img src="images/cart.png" alt="Cart" height="100" ></a></th></tr></table>

<! banner image below buttons !>
<div id="bannerimage"></div>

<div id="main-content">

<h1>Enter your customer id and password to complete the transaction:</h1>

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

