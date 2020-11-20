<%@ page import="java.sql.*,java.util.*" %>

<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>

<! buttons !>
<table class="buttons" border="0" width="100%"><tr>     <th class="buttons" align="left"><a href="shop.html"><img src="images/icon.png" alt="Home" height="100" ></a></th>
                                                        <th class="buttons"><a href="listprod.jsp">Begin Shopping</a></th>
                                                        <th class="buttons"><a href="listorder.jsp">List All Orders</a></th>
                                                        <th class="buttons" align="right"><a href="addcart.jsp"><img src="images/cart.png" alt="Cart" height="100" ></a></th></tr></table>

<! banner image below buttons !>
<div id="bannerimage"></div>

<div id="main-content">
<%
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
String productId = request.getParameter("productId");

// Make the connection
try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) {

String sql = "DELETE FROM orderproduct WHERE productId ="+productId;
stmt.executeUpdate(sql);
}catch(SQLException ex){
    out.println(ex);
}
%>

</div>
</body>
</html
