<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
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
// TODO: Write SQL query that prints out total order amount by day
try{
getConnection();
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
//get the orderdate and sum for the orders made
String sql = "SELECT DATEADD(day, 2, CAST(orderDate AS DATE)), SUM(totalAmount)" 
            +"FROM ordersummary "
            +"WHERE orderDate BETWEEN '2018-01-01' AND '2020-11-20' "
            +"GROUP BY CAST(orderDate AS DATE)"
            +"ORDER BY 1";
            //currently adding the dates totals together
            //totals are offset back 2 days???

PreparedStatement pst = con.prepareStatement(sql);
ResultSet rst = pst.executeQuery();
    out.println("<table><tr><th>"+"Order Date: "+"</th><th>"+" Total:" +"</th></tr>");

while(rst.next()){
  
    //print it out
    //need to make pretty but brain too smooth
    out.println("<tr><td>"+rst.getDate(1)+"</td><td>"+currFormat.format(rst.getDouble(2))+"</td></tr>");
    }
    out.println("</table><br>");
    out.println("<h2><a href=listprod.jsp>Continue Shopping</a></h2>");


}
catch (SQLException ex) { 	
	out.println(ex); 
}
finally {
    closeConnection();}
%>

</div>
</body>
</html>

