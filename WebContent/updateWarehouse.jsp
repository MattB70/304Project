<%@ include file="jdbc.jsp" %>
<%
	String warehouseId = request.getParameter("warehouseId");
	String warehouseName = request.getParameter("warehouseName");
	String sql = "UPDATE warehouse SET ";
	try{
		getConnection();

		//Create the SQL statement
		if(warehouseName != null && !warehouseName.equals(""))
		{
			sql=sql.concat("warehouseName= '"+warehouseName+"' ");
		}
		if(warehouseId != null && !warehouseId.equals(""))
		{
			sql=sql.concat("WHERE warehouseId= '"+warehouseId+"' ");
		}
		else
		{
			closeConnection();
			response.sendRedirect("admin.jsp?task=Update+Warehouse"); // If customerId not specified, redirect back to admin page...
		}
		//Run the SQL
		PreparedStatement pst = con.prepareStatement(sql);
		pst.executeUpdate();
	}
	catch(SQLException ex){	out.println("SQLException: "+ex);	}
	catch(Exception ex){	out.println("Exception: "+ex);		}
	finally{
		closeConnection();
		out.print("<br>"+sql+"<br>");
		response.sendRedirect("admin.jsp?task=Update+Warehouse"); // Return
	}
%>