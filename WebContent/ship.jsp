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
<title>Ramon World Shipment Processing</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
try{
	getConnection();

	// TODO: Get order id
	String orderId = request.getParameter("orderId");
	// TODO: Check if valid order id
	if (orderId == null || orderId.equals("")){ 
		//if null entered
		out.println("<h1>Invalid Order ID.</h1>");
	}else{
		// Determine if Order ID entered is an integer
		int num = -1;
		try{
			num = Integer.parseInt(orderId);	
		}catch(Exception e){
			out.println("<h1>Invalid Order ID.</h1>");
			%>
			<h2><a href="index.jsp">Back to Main Page</a></h2>
			<%
			return;
		}
	}
	// TODO: Start a transaction (turn-off auto-commit)
	
	// TODO: Retrieve all items in order with given id
	String sql = "SELECT * FROM orderproduct WHERE orderId = ?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, orderId);
		ResultSet rst = pst.executeQuery();
		while(rst.next()){
			out.println("<h1>Ordered Product: "+rst.getInt(2)+"  Qty: " + rst.getInt(3)+"</h1>");
			
		}
	
	// TODO: Create a new shipment record.

	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
	
	closeConnection();
}
catch (SQLException ex) { 	
	out.println(ex); 
}
%>                       				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
