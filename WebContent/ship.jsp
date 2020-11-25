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
		%>
		<div id="main-content">
			<h2><a href="index.jsp">Back to Main Page</a></h2>
		</div>
		<%
		return;
	}else{
		int num = -1;
		try{
			num = Integer.parseInt(orderId);	
		}catch(Exception e){
			out.println("<h1>Invalid Order ID.</h1>");
			%>
			<div id="main-content">
				<h2><a href="index.jsp">Back to Main Page</a></h2>
			</div>
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
		Integer productId = rst.getInt("productId");
		String sql2 ="SELECT * FROM  productInventory WHERE productId ="+productId;
		PreparedStatement pst2 = con.prepareStatement(sql2);
		ResultSet rst2 = pst2.executeQuery();
		if(!rst2.next()){
			out.println("<h1>Shipment not done. Insufficient inventory for Product ID: "+productId +"</h1>");
			%>
			<div id="main-content">
				<h2><a href="index.jsp">Back to Main Page</a></h2>
			</div>
			<%
			return;
		} else if(rst.getInt("quantity")>rst2.getInt("quantity")){
			out.println("<h1>Shipment not done. Insufficient inventory for Product ID: "+productId +"</h1>");
			%>
			<div id="main-content">
				<h2><a href="index.jsp">Back to Main Page</a></h2>
			</div>
			<%
			return;
		}
			out.println("<h2>Ordered Product: "+rst.getInt("productId"));
			out.println(" Qty: " + rst.getInt("quantity"));
			out.println(" Previous Inventory: " + rst2.getInt("quantity"));
			out.println(" New Inventory:"+ (rst2.getInt("quantity")-rst.getInt("quantity"))+" </h2>");
			String sql3 = "UPDATE productInventory "
					+ "SET quantity = quantity – (SELECT OP.quantity FROM orderproduct OP WHERE orderId = ? AND OP.productId =?) WHERE productId =? ";
			PreparedStatement pst3 = con.prepareStatement(sql3);
			pst3.executeUpdate();
		}
	out.println("<h1>Shipment successfully processed. </h1>");
	// TODO: Create a new shipment record.
	//String sqlShip = "INSERT INTO shipment "...
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
	
	closeConnection();
}
catch (SQLException ex) { 	
	out.println(ex); 
}
%>                       				
<div id="main-content">
<h2><a href="index.jsp">Back to Main Page</a></h2>

</div>
</body>
</html>
