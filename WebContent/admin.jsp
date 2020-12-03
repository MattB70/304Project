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

  <!-- Database restore -->
  <button onclick="myFunction()">Restore Database</button>
  <script> // Database Restore Button
  function myFunction() {
    var txt;
    if (confirm("Are you sure you wish to restore the database? This action cannot be undone.")) {
      window.location.href = "loaddata.jsp";
    }
  }
  </script>
  <br>
  <br>


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
    labels: [
            <%
                String sqlChart = "SELECT DATEADD(day, 2, CAST(orderDate AS DATE)), SUM(totalAmount) FROM ordersummary WHERE orderDate BETWEEN '2018-01-01' AND '2020-11-20' GROUP BY CAST(orderDate AS DATE) ORDER BY 1";
                PreparedStatement pstL = con.prepareStatement(sqlChart);
                ResultSet rstL = pstL.executeQuery();

                while(rstL.next()){ out.println("'"+rstL.getString(1) + "', "); }

            %>
            ],
    datasets: [{
                // label dates: should print something like " 509.10, 106.75, 327.85 "
        data:   [
                <%

                    PreparedStatement pstD = con.prepareStatement(sqlChart);
                    ResultSet rstD = pstD.executeQuery();

                    while(rstD.next()){ out.println(rstD.getDouble(2) + ", "); }

                %>
                ],
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
        out.println("</table>");
        out.println("</td><td>");
            //   |Q2   CUSTOMER LIST
            // --+--
            //   |

            // SQL
            // Get customer info
            String sql = "SELECT customerid, firstName, lastName, userid, email, phonenum FROM customer";
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rst1 = pst.executeQuery();

            // PRINTING
            out.print("<h3>All Customers:</h3><br>");
            out.println("<table border=2><tr><th>"+ "ID" +"</th><th>"+ "NAME" +"</th><th>"+ "USERID" +"</th><th>"+ "EMAIL" +"</th><th>"+ "PHONE NUM" +"</th></tr>");

            while(rst1.next()){
            
                //print it out
                out.println("<tr><td>"+rst1.getString(1)+"</td><td>"+rst1.getString(2)+" "+rst1.getString(3)+"</td><td>"+rst1.getString(4)+"</td><td>"+rst1.getString(5)+"</td><td>"+rst1.getString(6)+"</td></tr>");
            }

            out.println("</table>");

    out.print("</td></tr></table>");

    }catch (SQLException ex) { 	
	    out.println(ex); 
    }
  %>




   <br><br><br><h1>Select what task you would like to complete:</h1><br>
<form method="get" action="admin.jsp">
<select size = "1" name= "task">

<option>Add New Product</option>
<option>Add Warehouse</option>
<option>Update Warehouse</option>
<option>Add Customer</option>
<option>Update Customer</option>
</select>
<input type="submit" value="Submit"><br>
</form> 

  <%
    try{
      String task = request.getParameter("task");
    
     if (task.equals("Add New Product")) {
        out.print(
          "<br><h2>Add a New Product: </h2><br>"+
          "<form action=\"addNewProduct.jsp\">"+
            "<table>"+
              "<tr><th>Name: </th><td><input type=\"text\" name=\"productName\"></td></tr>"+
              "<tr><th>Price: </th><td><input type=\"text\" name=\"productPrice\"></td></tr>"+
              "<tr><th>Description: </th><td><input type=\"text\" name=\"productDesc\"></td></tr>"+
              "<tr><th>Category Id: </th><td><input type=\"text\" name=\"categoryId\"></td></tr>"+
          "<tr><td style='text-align:center;' colspan = 2 ><input type=\"submit\" name=\"submit\" value=\"Submit\"></td></tr>"+
            "</table>"+
          "</form>"
        );
      }
     
      else if(task.equals("Add Warehouse"))
      {
        out.print(
          "<br><h2>Add a Warehouse: </h2><br>"+
          "<form action=\"addWarehouse.jsp\">"+
            "<table>"+
              "<tr><th>Warehouse Name: </th><td><input type=\"text\" name=\"warehouseName\"></td></tr>"+
          "<tr><td style='text-align:center;' colspan = 2 ><input type=\"submit\" name=\"submit\" value=\"Submit\"></td></tr>"+
            "</table>"+
          "</form>"
        );

      }
      else if(task.equals("Update Warehouse"))
      {
        out.print(
          "<br><h2>Update a Warehouse: </h2><br>"+
          "<form action=\"updateWarehouse.jsp\">"+
            "<table>"+
              "<tr><th>Warehouse ID: </th><td><input type=\"text\" name=\"warehouseId\"></td></tr>"+
              "<tr><th>Warehouse Name: </th><td><input type=\"text\" name=\"warehouseName\"></td></tr>"+
          "<tr><td style='text-align:center;' colspan = 2 ><input type=\"submit\" name=\"submit\" value=\"Submit\"></td></tr>"+
            "</table>"+
          "</form>"
        );

      }
      else if(task.equals("Add Customer"))
      {
        out.print(
          "<br><h2>Add a Customer: </h2><br>"+
          "<form action=\"addCustomer.jsp\">"+
            "<table>"+
              "<tr><th>firstName: </th><td><input type=\"text\" name=\"firstName\"></td></tr>"+
              "<tr><th>lastName: </th><td><input type=\"text\" name=\"lastName\"></td></tr>"+
              "<tr><th>email: </th><td><input type=\"text\" name=\"email\"></td></tr>"+
              "<tr><th>phonenum: </th><td><input type=\"text\" name=\"phonenum\"></td></tr>"+
              "<tr><th>address: </th><td><input type=\"text\" name=\"address\"></td></tr>"+
              "<tr><th>city: </th><td><input type=\"text\" name=\"city\"></td></tr>"+
              "<tr><th>state: </th><td><input type=\"text\" name=\"state\"></td></tr>"+
              "<tr><th>postalCode: </th><td><input type=\"text\" name=\"postalCode\"></td></tr>"+
              "<tr><th>country: </th><td><input type=\"text\" name=\"country\"></td></tr>"+
              "<tr><th>userid: </th><td><input type=\"text\" name=\"userid\"></td></tr>"+
              "<tr><th>password: </th><td><input type=\"text\" name=\"password\"></td></tr>"+
          "<tr><td style='text-align:center;' colspan = 2 ><input type=\"submit\" name=\"submit\" value=\"Submit\"></td></tr>"+
            "</table>"+
          "</form>"
        );

      }
      else if(task.equals("Update Customer"))
      {
        out.print(
          "<br><h2>Update a Customer: </h2><br>"+
          "<form action=\"updateCustomer.jsp\">"+
            "<table>"+
              "<tr><th>Customer ID: </th><td><input type=\"text\" name=\"customerId\"></td></tr>"+
              "<tr><th>User ID: </th><td><input type=\"text\" name=\"userId\"></td></tr>"+
              "<tr><th>Email: </th><td><input type=\"text\" name=\"email\"></td></tr>"+
              "<tr><th>Phone Number: </th><td><input type=\"text\" name=\"phonenum\"></td></tr>"+
          "<tr><td style='text-align:center;' colspan = 2 ><input type=\"submit\" name=\"submit\" value=\"Submit\"></td></tr>"+
            "</table>"+
          "</form>"
        );

      }
    }
    catch (Exception ex) { 	
      out.println(ex); 
    }
    closeConnection();  // close connection without a finally, this is easier when there are so many try/catch
  %>

</div>
</body>
</html>

