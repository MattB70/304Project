<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
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
<%
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
if (productList == null)
{	out.println("No products");
	productList = new HashMap<String, ArrayList<Object>>();
}
// Read parameters
String id = request.getParameter("id");
String qty = request.getParameter("qty");
out.println("ID: "+id);
// Update quantity for product selected
if (productList.containsKey(id)) 
{ // find item in shopping cart
	ArrayList<Object> product = (ArrayList<Object>) productList.get(id);
	product.set(3, (new Integer(qty))); 	// change quantity to new quantity
}
session.setAttribute("productList", productList);
%>

</div>
</body>
</html
