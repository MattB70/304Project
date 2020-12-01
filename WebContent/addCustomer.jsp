<%@ include file="jdbc.jsp" %>
<%
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String email = request.getParameter("email");
	String phonenum = request.getParameter("phonenum");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String postalCode = request.getParameter("postalCode");
	String country = request.getParameter("country");
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	String sql = "";
	try{
		if(	firstName == null || lastName == null || email == null || phonenum == null ||
			address == null || city == null || state == null || postalCode == null ||
			country == null || userid == null || password == null)
		{
			
			response.sendRedirect("admin.jsp?task=Add+Customer"); // Form not filled out... Return without doing anything...
		}
		getConnection();
		//Create SQL
		sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) "
					+"VALUES('"+firstName+"','"+lastName+"','"+email+"','"+phonenum+"','"+address+"','"+city+"','"+state+"','"+postalCode+"','"+country+"','"+userid+"','"+password+"')";
		PreparedStatement pst = con.prepareStatement(sql);
		//Run the SQL
		pst.executeUpdate();
	}
	catch(SQLException ex){	out.println("SQLException: "+ex);	}
	catch(Exception ex){	out.println("Exception: "+ex);		}
	finally{
		closeConnection();
		out.print("<br>"+sql+"<br>");
		response.sendRedirect("admin.jsp?task=Add+Customer"); // Return
	}
%>