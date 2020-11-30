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


}
catch (SQLException ex) { 	
	out.println(ex); 
}
            // CHART
%>






<canvas id="line-chart" width="auto" height="auto"></canvas>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>

<script>
new Chart(document.getElementById("line-chart"), {
  type: 'line',
  data: {
            // label dates: should print something like " '2019-10-15', '2019-10-16', '2019-10-17' "
    labels: [<%
                
                out.print(" '2019-10-15', '2019-10-16', '2019-10-17' ");

            %>],
    datasets: [{
                // label dates: should print something like " 509.10, 106.75, 327.85 "
        data:   [<%

                    out.print(" 509.10, 106.75, 327.85 ");

                %>],
        label: "Total Order Amount ($)",
        borderColor: "#0062ad",
        fill: true
      }
    ]
  },
  options: {
    title: {
      display: true,
      text: 'OrderTotal    by    OrderDate'
    }
  }
});
</script>






<%

try{
    getConnection();
    
    out.println("</table>");

    out.println("</td><td>");


            //   |Q2   CUSTOMER LIST
            // --+--
            //   |

            // SQL
            // Get customer info
            String sql = "SELECT customerid, firstName, lastName, userid FROM customer";
            PreparedStatement pst = con.prepareStatement(sql);
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

