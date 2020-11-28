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

<%@ include file="header.jsp" %>

<div id="main-content">
<%
// TODO: Write SQL query that prints out total order amount by day
try{
    getConnection();
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

    // Display in quadrants, Q1 has Administrator Sales Report, Q2 has Customers list
    out.print("<table border=10><tr><td>");


            // Q1|      ADMINISTRATOR SALES REPORT
            // --+--
            //   |

            // SQL
            //get the orderdate and sum for the orders made
            String sql = "SELECT DATEADD(day, 2, CAST(orderDate AS DATE)), SUM(totalAmount)" 
                        +"FROM ordersummary "
                        +"WHERE orderDate BETWEEN '2018-01-01' AND '2020-11-20' "
                        +"GROUP BY CAST(orderDate AS DATE)"
                        +"ORDER BY 1";
                        //currently adding the dates totals together
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rst0 = pst.executeQuery();

            // PRINTING
            out.print("<h3>Sales Reports:</h3><br>");
            out.println("<table border=3><tr><th>"+"Order Date"+"</th><th>"+"Total Order Amount"+"</th></tr>");

            while(rst0.next()){
            
                //print it out
                out.println("<tr><td>"+rst0.getDate(1)+"</td><td>"+currFormat.format(rst0.getDouble(2))+"</td></tr>");
            }

            out.println("</table>");


    out.println("</td><td>");


            //   |Q2   CUSTOMER LIST
            // --+--
            //   |

            // SQL
            // Get customer info
            sql = "SELECT customerid, firstName, lastName, userid FROM customer";
            pst = con.prepareStatement(sql);
            ResultSet rst1 = pst.executeQuery();

            // PRINTING
            out.print("<h3>All Customers:</h3><br>");
            out.println("<table border=3><tr><th>"+ "ID" +"</th><th>"+ "NAME" +"</th><th>"+ "USERID" +"</th></tr>");

            while(rst1.next()){
            
                //print it out
                out.println("<tr><td>"+rst1.getString(1)+"</td><td>"+rst1.getString(2)+" "+rst1.getString(3)+"</td><td>"+rst1.getString(4)+"</td></tr>");
            }

            out.println("</table>");


    out.print("</td></tr></table>");

}
catch (SQLException ex) { 	
	out.println(ex); 
}
finally {
    closeConnection();
}
%>

</div>
</body>
</html>

