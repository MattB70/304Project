<%@ include file="jdbc.jsp" %>
<%
	String userId = request.getParameter("userId");
	String email = request.getParameter("email");
	String phonenum = request.getParameter("phonenum");
	String customerId = request.getParameter("customerId");
	String sql = "UPDATE customer SET ";
	boolean comma = false;
	try{
		getConnection();

		//Create the SQL statement
		if(userId != null && !userId.equals(""))
		{
			sql=sql.concat("userid= '"+userId+"' ");
			comma = true;
		}
		if(email != null && !email.equals(""))
		{
			if(comma)sql=sql.concat(", ");
			sql=sql.concat("email= '"+email+"' ");
			comma = true;
		}
		if(phonenum != null && !phonenum.equals(""))
		{
			if(comma)sql=sql.concat(", ");
			sql=sql.concat("phonenum= '"+phonenum+"' ");
			comma = true;
		}
		if(customerId != null && !customerId.equals(""))
		{
			sql=sql.concat("WHERE customerId= '"+customerId+"' ");
		}
		else
		{
			closeConnection();
			response.sendRedirect("admin.jsp?task=Update+Customer"); // If customerId not specified, redirect back to admin page...
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
		response.sendRedirect("admin.jsp?task=Update+Customer"); // Return
	}
%>