<%@ include file="jdbc.jsp" %>
<%
	if (request.getParameter("productName") != null && request.getParameter("productPrice") != null && request.getParameter("productDesc") != null && request.getParameter("categoryId") != null) {
		try {
			getConnection();
			String sql = "INSERT INTO product (productName, productPrice, productDesc, categoryId) VALUES (?, ?, ?, ?)";
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, request.getParameter("productName"));
			pst.setDouble(2, Double.parseDouble(request.getParameter("productPrice"))); //price needs to be entered in double format -- catch exceptions
			pst.setString(3, request.getParameter("productDesc"));
			pst.setInt(4, Integer.parseInt(request.getParameter("categoryId")));
			pst.executeUpdate();
		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			closeConnection();
		}
	}
	response.sendRedirect("admin.jsp");
%>


