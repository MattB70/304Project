<%@ include file="jdbc.jsp" %>
<%
    String productId = request.getParameter("productId");
	String reviewRating = request.getParameter("reviewRating");
	String reviewDate = request.getParameter("reviewDate");
	String reviewComment = request.getParameter("reviewComment");
	String userId = request.getParameter("authenticatedUser");
	String customerId = request.getParameter("customerId");
	String sql = "";
	try{
		if(	reviewRating == null || reviewDate == null || reviewComment == null || userId == null ||customerId == null ){
			
			response.sendRedirect("writeareview.jsp?id="+productId); // Form not filled out... Return without doing anything...
		}
		getConnection();
		//Create SQL
		sql = "INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) "
					+"VALUES('"+reviewRating+"','"+reviewDate+"','"+customerId+"','"+productId+"','"+reviewComment+"')";
		PreparedStatement pst = con.prepareStatement(sql);
		//Run the SQL
		pst.executeUpdate();
	}
	catch(SQLException ex){	out.println("SQLException: "+ex);	}
	catch(Exception ex){	out.println("Exception: "+ex);		}
	finally{
		closeConnection();
    }
%>
