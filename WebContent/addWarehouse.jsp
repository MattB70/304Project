<%@ include file="jdbc.jsp" %>
<%
	String warehouseName = request.getParameter("warehouseName");
	String sql = "";
	try{
		if(	warehouseName == null)
		{
			response.sendRedirect("admin.jsp?task=Add+Warehouse"); // Form not filled out... Return without doing anything...
		}
		getConnection();
		//Create SQL
		sql = "INSERT INTO warehouse (warehouseName) "
					+" VALUES('"+warehouseName+"')";
		PreparedStatement pst = con.prepareStatement(sql);
		//Run the SQL
		pst.executeUpdate();
	}
	catch(SQLException ex){	out.println("SQLException: "+ex);	}
	catch(Exception ex){	out.println("Exception: "+ex);		}
	finally{
		closeConnection();
		out.print("<br>"+sql+"<br>");
		response.sendRedirect("admin.jsp?task=Add+Warehouse"); // Return
	}
%>