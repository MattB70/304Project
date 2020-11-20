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

<! buttons !>
<table class="buttons" border="0" width="100%"><tr>     <th class="buttons" align="left"><a href="shop.html"><img src="images/icon.png" alt="Home" height="100" ></a></th>
                                                        <th class="buttons"><a href="listprod.jsp">Begin Shopping</a></th>
                                                        <th class="buttons"><a href="listorder.jsp">List All Orders</a></th>
                                                        <th class="buttons" align="right"><a href="addcart.jsp"><img src="images/cart.png" alt="Cart" height="100" ></a></th></tr></table>

<! banner image below buttons !>
<div id="bannerimage"></div>

<div id="main-content">
<script>
function update(newid, newqty){
	window.location="showcart.jsp?update="+newid+"&newqty="+newqty;
}
</script>

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

	// if id not null, then user is trying to remove that item from the shopping cart
	if(id != null && (!id.equals(""))) {
		if(productList.containsKey(id)) {
			productList.remove(id);
		}
	}
	
	// if update isn't null, the user is trying to update the quantity
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
	out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

	int count = 0;
	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) {	
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		product = (ArrayList<Object>) entry.getValue();
		count++;
		if (product.size() < 4){
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td>"+product.get(0)+"</td>");	// Id
		out.print("<td>"+product.get(1)+"</td>");		// Product Name
		out.print("<td align=\"center\"><input type=\"text\" name=\"newqty"+count+"\" size=\"3\" value=\""
			+product.get(3)+"\"></td>");
		
		// id and name format:  								quantity<id>						quantity<id>
		out.print("<td><form><input type=\"number\" id=\"quantity"+product.get(0)+"\" name=\"quantity"+product.get(0)+"\" value=\""+product.get(3)+"\" min=\"0\" max=\"100\"><input type=\"button\" onclick=\"updateQuantity("+product.get(0)+")\" value=\"Update\"> </form></td>");		// Quantity
		
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
		out.print("<td><a href=\"showcart.jsp?delete=" + product.get(0) + "\">");
		out.print("Remove Item from cart</a></td>");
		// allow customer to change quantities for a product in their shopping cart
		out.println("<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"button\" onclick=\"update("
			+product.get(0)+", document.form1.newqty"+count+".value)\" value=\"Update Quantity\">");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");			// Total
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

