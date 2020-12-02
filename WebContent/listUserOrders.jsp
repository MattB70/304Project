<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<!DOCTYPE html>
<html>
<head>
<title>List Orders</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>

<div id="main-content">
    <%
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
	try	{
        getConnection();
        String userName = (String) session.getAttribute("authenticatedUser");
		String sql = "SELECT customerId,firstName,lastName FROM customer WHERE userId = ?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, userName);
		ResultSet rs = pst.executeQuery();
		rs.next();
        out.println("<h2>Orders placed by: "+rs.getString("firstName") + " "+ rs.getString("lastName")+"</h2>");
        
        String q1 = "SELECT O.orderId, O.orderDate, O.customerId, C.firstName, C.lastName, O.totalAmount "
               +"FROM ordersummary O LEFT JOIN customer C ON O.customerId = C.customerId WHERE O.customerId = ?";
        String q2 = "SELECT O.orderId, O.orderDate, O.customerId, C.firstName, C.lastName, O.totalAmount "
			   +"FROM ordersummary O LEFT JOIN customer C ON O.customerId = C.customerId WHERE O.customerId = ?";
        PreparedStatement stmt1 = con.prepareStatement(q1);
        PreparedStatement stmt2 = con.prepareStatement(q2);
        stmt1.setString(1, rs.getString("customerId"));
        stmt2.setString(1, rs.getString("customerId"));
        ResultSet rst1 = stmt1.executeQuery();
        ResultSet rst2 = stmt2.executeQuery();
        
        if(rst1.next()){
	        out.println("<table border=3><tr><th>OrderId</th><th>Order Date</th><th>CustomerId</th><th>Customer Name</th><th>Total Amount</th></tr>");
	        while (rst2.next()){			
		        out.println("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getString(2)+"</td><td>"+rst2.getString(3)+"</td><td>"+rst2.getString(4)+" "+rst2.getString(5)+"</td><td>"+currFormat.format(rst2.getFloat(6))+"</td></tr>");
            }
        } else{
            out.println("<h2 style=\"color:#E46F6F; white-space:nowrap;\">You have no orders placed... go treat yourself!</h2>");
        }

                
	}
	catch(Exception ex){
		out.print("<span title=\""+ex+"\">You must be logged in to view your orders!...</span>");
	}
	finally{
		closeConnection();
	}
%>
</div>
</body>
</html>