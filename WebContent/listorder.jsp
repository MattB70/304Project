<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>Ramon's World Orders</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>

<div id="banner">
        <div id="banner-content" style="background: url('images/banner.png') no-repeat center;">
                <table border="1"><tr><th><a href="shop.html"><img src="images/icon.png" alt="Home" height="200" ></a></th><th><a href="listprod.jsp">Begin<br>Shopping</a></th><th><a href="listorder.jsp">List All<br>Orders</a></th></tr></table>
        </div>
</div>


<div id="main-content">

<h1>Order List: </h1>
	
<%
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
try{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e){
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

// Make connection
try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) 
{	
	String q1 = "SELECT O.orderId, O.orderDate, O.customerId, C.firstName, C.lastName, O.totalAmount "
			   +"FROM ordersummary O LEFT JOIN customer C ON O.customerId = C.customerId";

	ResultSet rst = stmt.executeQuery(q1);

	out.println("<table border=1><tr><th>OrderId</th><th>Order Date</th><th>CustomerId</th><th>Customer Name</th><th>Total Amount</th></tr>");
	
	while (rst.next()){			
		out.println("<tr><td>"+rst.getString(1)+"</td><td>"+rst.getString(2)+"</td><td>"+rst.getString(3)+"</td><td>"+rst.getString(4)+" "+rst.getString(5)+"</td><td>"+currFormat.format(rst.getFloat(6))+"</td></tr>");
		
		String q2 = "SELECT productId, quantity, price "
				   +"FROM orderproduct "
				   +"WHERE orderId = ?";
		String ordId = rst.getString("orderId");
		PreparedStatement pst = con.prepareStatement(q2);
		pst.setString(1, ordId);
		ResultSet rst2 = pst.executeQuery();

		out.println("<tr align=right><td colspan=5><table border=1><th>Product Id  </th> <th>Quantity  </th> <th>Price  </th></tr>");
			while(rst2.next()){
			out.println("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getString(2)+"</td><td>"+currFormat.format(rst2.getFloat(3))+"</td></tr>");
		}
		out.println("</table></td></tr>");
	}
	if (con!=null) con.close();
}
catch (SQLException ex) { 	
	out.println(ex); 
}
%>
</div>
</body>
</html>