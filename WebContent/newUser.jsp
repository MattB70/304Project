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
<title>Create User Validation Page</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
<%@ include file="header.jsp" %>
<div id="main-content">
<%
try{
	getConnection();
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phoneNum = request.getParameter("phoneNum");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalCode");
    String country = request.getParameter("country");
    String username = request.getParameter("user");
    String password = request.getParameter("pw");

    String sql = "SELECT * FROM customer WHERE userId = ?";
    PreparedStatement pst = con.prepareStatement(sql);
    pst.setString(1, username);
    ResultSet rst = pst.executeQuery();
    if(rst.next()){
        out.println("<h2 style=\"color:#E46F6F; white-space:nowrap;\">ERROR: USER: "+username+" ALREADY EXISTS</h2>");
        out.println("<h2 style=\"color:#E46F6F; white-space:nowrap;\">Please go back and use a different username.</h2>");
        %>
        <br>
		<h2><a href="createUser.jsp">Back to Create Account Page</a></h2>
        <%
        return;
    } else if(firstName == null || firstName.equals("") || lastName == null || lastName.equals("") || 
                phoneNum == null || phoneNum.equals("") || address == null || address.equals("") ||
                 city == null || city.equals("") || state == null || state.equals("") ||
                 postalCode == null || postalCode.equals("") || country == null || country.equals("")){
        out.println("<h2 style=\"color:#E46F6F; white-space:nowrap;\">ERROR: MISSING FIELDS</h2>");
        out.println("<h2 style=\"color:#E46F6F; white-space:nowrap;\">Please go back and be sure to enter all of the given fields.</h2>");
        %>
        <br>
        <h2><a href="createUser.jsp">Back to Create Account Page</a></h2>
        <%
    } else if(email == null || !email.contains("@")){
        out.println("<h2 style=\"color:#E46F6F; white-space:nowrap;\">ERROR: INVALID EMAIL</h2>");
        out.println("<h2 style=\"color:#E46F6F; white-space:nowrap;\">Please go back and enter a valid email.</h2>");
        %>
        <br>
		<h2><a href="createUser.jsp">Back to Create Account Page</a></h2>
        <%
    } else if(username == null || username.equals("")){
        out.println("<h2 style=\"color:#E46F6F; white-space:nowrap;\">ERROR: MISSING USERNAME</h2>");
        out.println("<h2 style=\"color:#E46F6F; white-space:nowrap;\">Please go back and enter a username.</h2>");
        %>
        <br>
		<h2><a href="createUser.jsp">Back to Create Account Page</a></h2>
        <%
        return;
    
    } else {
        String sql2 = "INSERT INTO customer VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement pst2 = con.prepareStatement(sql2);
        pst2.setString(1, firstName);
        pst2.setString(2, lastName);
        pst2.setString(3, email);
        pst2.setString(4, phoneNum);
        pst2.setString(5, address);
        pst2.setString(6, city);
        pst2.setString(7, state);
        pst2.setString(8, postalCode);
        pst2.setString(9, country);
        pst2.setString(10, username);
        pst2.setString(11, password);
        pst2.executeUpdate();

        String sql3 = "SELECT customerId FROM customer WHERE userid = ?";
        PreparedStatement pst3 = con.prepareStatement(sql3);
        pst3.setString(1, username);
        ResultSet rst3 = pst3.executeQuery();
        rst3.next();
        Integer custId = rst3.getInt("customerId");
        out.println("<h2 style=\"color:#ADD8E6; white-space:nowrap;\">Your account has been created.</h2>");
        out.println("<h2 style=\"color:#ADD8E6; white-space:nowrap;\">Your Customer ID is "+custId+"</h2>");
        %>
        <br>
		<h2><a href="login.jsp">Click here to login.</a></h2>
        <%
    }
}
catch (SQLException ex) { 	
	out.println(ex); 
}
%> 
</div>>
</body>
</html>
