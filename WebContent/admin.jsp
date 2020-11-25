<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>
<div id="main-content">

<%
// TODO: Include files auth.jsp and jdbc.jsp
// done above

%>
<%

// TODO: Write SQL query that prints out total order amount by day
try{
getConnection();
//get the orderdate and sum for the orders made
String sql = "SELECT CAST(orderDate AS DATE), SUM(totalAmount)" 
            +"FROM ordersummary "
            +"WHERE orderDate BETWEEN '2010-01-01' AND '2020-11-20' "
            +"GROUP BY CAST(orderDate AS DATE)"
            +"ORDER BY 1";
            //currently adding the dates totals together
            //totals are offset back 2 days???

PreparedStatement pst = con.prepareStatement(sql);
ResultSet rst = pst.executeQuery();
    out.println("</td></tr><tr><td>"+"Order Date: "+"</td><td>"+" Total:" +"</tr><br>");

while(rst.next()){
  
    //print it out
    //need to make pretty but brain too smooth
    out.println("</td></tr><tr><td>"+"/n "+rst.getDate(1)+"</td><td>"+" /n "+rst.getDouble(2)+"</tr><br>");
    out.println("</table>");
    }
out.println("<h2><a href=listprod.jsp>Continue Shopping</a></h2>");


}
catch (SQLException ex) { 	
	out.println(ex); 
}
finally {closeConnection();}
%>

</div>
</body>
</html>

