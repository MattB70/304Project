<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>

<%@ include file="header.jsp" %>

<div id="main-content">

<script>
function update(newid, newqty){
	window.location="showcart.jsp?update="+newid+"&newqty="+newqty;
}
</script>
<form name = "cart">
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
ArrayList<Object> product = new ArrayList<Object>();
String id = request.getParameter("delete");
String update = request.getParameter("update");
String newqty = request.getParameter("newqty");

if (productList == null){	
	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

	// if id not null, remove item from the shopping cart
	if(id != null && (!id.equals(""))) {
		if(productList.containsKey(id)) {
			productList.remove(id);
		}
	}
	
	// if update isn't null, update the quantity
	if(update != null && (!update.equals(""))) {
		if (productList.containsKey(update)) { // find item in shopping cart
			product = (ArrayList<Object>) productList.get(update);
			product.set(3, (new Integer(newqty))); // change quantity to new quantity
		}
		else {
			productList.put(id,product);
		}
	}
	out.println("<h1>Your Shopping Cart</h1>");
	out.println("<table><tr><th>Remove From Cart</th><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
	int count = 0;
	double total = 0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) {	
		count++;
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4){
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		out.print("<tr><td><a href=\"showcart.jsp?delete=" + product.get(0) + "\">");	
		out.print("Remove Item from cart</a></td>");
		out.print("<td>"+product.get(0)+"</td>");	// Id
		out.print("<td>"+product.get(1)+"</td>");		// Product Name
		out.print("<td align=center><input type=\"text\" name=\"newqty"+count+"\" size=\"3\" value=\""
			+product.get(3)+"\">");
		out.println("<input type=button OnClick=\"update("+product.get(0)+", document.cart.newqty"+count+".value)\" value=\"Update\">");
					
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try{
			pr = Double.parseDouble(price.toString().substring(1));
		}
		catch (Exception e)	{
			out.println(e+" Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try	{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e){
			out.println(e+" Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		
		
		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");			// Price
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");	// Subtotal
		out.println("</tr>");
		total = total +pr*qty;
	}
	
	out.println("<tr><td colspan=\"5\" align=\"right\"><b>Order Total</b></td>"+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");			// Total
	out.println("</table>");

	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
session.setAttribute("productList", productList);
%>

<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</div>
</form>
</body>
</html> 

