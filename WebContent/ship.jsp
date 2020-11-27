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

<div id="main-content">
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
			<h2><a href="index.jsp">Back to Main Page</a></h2>
		<%
		return;
	}else{
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
	con.setAutoCommit(false);
	
	// TODO: Retrieve all items in order with given id
	String sql = "SELECT * FROM orderproduct WHERE orderId = ?";
	PreparedStatement pst = con.prepareStatement(sql);
	pst.setString(1, orderId);
	ResultSet rst = pst.executeQuery();
	
	while(rst.next()){
		String productId = rst.getString("productId");
		String sql2 ="SELECT * FROM  productInventory WHERE productId = ?";
		PreparedStatement pst2 = con.prepareStatement(sql2);
		pst2.setString(1,productId);
		ResultSet rst2 = pst2.executeQuery();
		rst2.next();
		if(rst.getInt("quantity")>rst2.getInt("quantity")){
			out.println("<h2 style=\"color:#E46F6F; white-space:nowrap;\">Shipment not done.</h2>");
			out.println("<h2 style=\"color:#E46F6F; white-space:nowrap;\">Insufficient inventory for Product ID: "+productId +"</h2><br>");
			%>
				<h2><a href="index.jsp">Back to Main Page</a></h2>
			<%
			con.rollback();
			return;
		} else{
			out.println("<h2><table><tr><th>Ordered Product </th><td><h1>"+rst.getInt("productId") + "</h1></td></tr>");
			out.println("<tr><th>Qty </th><td><h1>" + rst.getInt("quantity") + "</h1></td></tr>");
			out.println("<tr><th>Previous Inventory </th><td><h1>" + rst2.getInt("quantity") + "</h1></td></tr>");
			if(rst2.getInt("quantity")-rst.getInt("quantity") <= 0) out.println("<tr><th>New Inventory </th><td><h1 style=\"color:#E46F6F\">"+ (rst2.getInt("quantity")-rst.getInt("quantity"))+"</h1></td></tr></table></h2><br>");
			else 													out.println("<tr><th>New Inventory </th><td><h1>"+ (rst2.getInt("quantity")-rst.getInt("quantity"))+"</h1></td></tr></table></h2><br>");
			
			String sql3 = "UPDATE productInventory "
					+ "SET quantity = " + (rst2.getInt("quantity")-rst.getInt("quantity"))
					+ "WHERE productId =? ";
			PreparedStatement pst3 = con.prepareStatement(sql3);
			pst3.setString(1, productId);			
			pst3.executeUpdate();
			
			String shipmentDesc = ("There are " +rst.getInt("quantity")+ "products in this shipment." );
			String sqlShip = "INSERT INTO shipment (shipmentDate, shipmentDesc, warehouseId) VALUES (?,?,?)";       
			PreparedStatement pst4 = con.prepareStatement(sqlShip);
			pst4.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
			pst4.setString(2, shipmentDesc);
			pst4.setInt(3, rst2.getInt("warehouseId"));
			pst4.executeUpdate();
			}
		}
	out.println("<h2 style=\"color:#6FAAE4; white-space:nowrap;\">Shipment successfully processed. </h2><br>");
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
	con.setAutoCommit(true);
	closeConnection();
}
catch (SQLException ex) { 	
	out.println(ex); 
}
%>                       				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</div>
</body>
</html>
