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
	/**    Tried to validate reviews:   
		if(reviewRating == null || reviewDate == null || reviewComment == null){
            return;
        }
        String sqlc = "SELECT customerId FROM customer WHERE userId = ?";
        PreparedStatement pstc = con.prepareStatement(sqlc);
        pstc.setString(1,userId);
        ResultSet rstc = pstc.executeQuery();
        while (rstc.next()){
            customerId = rstc.getString(1);
        }
        String sqlr = "SELECT customerId, productId FROM review WHERE productId = ? AND customerId = ?";
        PreparedStatement pstr = con.prepareStatement(sqlr);
        pstr.setInt(1, Integer.parseInt(productId));
        pstr.setString(2, customerId);
        ResultSet rstr = pstr.executeQuery();
       if (rstr.first()){
           out.println("You have already written a review!");
           return;
       }else{
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date rDate = null;
				try {
					rDate = sdf.parse(reviewDate);
				} catch (Exception e) {
				}
	 **/