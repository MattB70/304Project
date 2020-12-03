<!DOCTYPE html>
<html>
<head>
<style>
</style>
        <title>Ramon's World Gift Shop Main Page</title>
        
        <link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>

<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>


<%@ include file="header.jsp" %>



<div id="main-content" align="center">
        <br>
        <img src="images/welcometext.png" alt="RamonWorld" align = "center">
        <br>
        <br>
        <br>
        <br>
        <h2 align="center">Recommended Products - Click to See Details</h2>
        <br>

        <%      // Get recommended items based on customer ID.
                int customerId;
                int orderId;
                int categoryId;
                int productId;
                int productIds[] = new int[6];                  // recommended product ids
                for(int i = 1; i < 7; i++) productIds[i-1] = i;   // Initialize default product ids

                try{
                        getConnection();
                       
                        String userName = (String) session.getAttribute("authenticatedUser");
                        if(userName != null)
                        {       // IF a customer is logged in, use their customer id to determine user specific recommended products:
                                // Get customer Id:
                                String sql = "SELECT customerId FROM customer WHERE userId = ?";
                                PreparedStatement pst = con.prepareStatement(sql);
                                pst.setString(1, userName);
                                ResultSet rst = pst.executeQuery();

                                if(rst.next())
                                {
                                        customerId = rst.getInt(1);
                                        // Get most recent orderId for customer:
                                        sql = "SELECT orderId, orderDate FROM ordersummary WHERE customerId = ? ORDER BY orderDate DESC";
                                        pst = con.prepareStatement(sql);
                                        pst.setInt(1, customerId);
                                        rst = pst.executeQuery();
                                        if(rst.next())
                                        {
                                                orderId = rst.getInt(1);
                                                // Get a categoryId from product from orderId:
                                                sql = "SELECT categoryId FROM orderproduct OP JOIN product P ON OP.productId = P.productId WHERE orderId = ?";
                                                pst = con.prepareStatement(sql);
                                                pst.setInt(1, orderId);
                                                rst = pst.executeQuery();
                                                rst.next();
                                                categoryId = rst.getInt(1);
                                                // Get productIds to display with categoryId:
                                                sql = "SELECT productId FROM product WHERE categoryId = ?";
                                                pst = con.prepareStatement(sql);
                                                pst.setInt(1, categoryId);
                                                rst = pst.executeQuery();
                                                // Add product Ids to array:
                                                int i = 0;
                                                while(rst.next() && i < 6)
                                                {
                                                        productIds[i] = rst.getInt(1);
                                                        i++;
                                                }
                                        }else{
                                                productIds = populateDefaults(productIds);
                                        }
                                }else{
                                        productIds = populateDefaults(productIds);
                                }
                        }
                        else    // IF a customer is NOT logged in, display recommended items based on global sales:
                        {
                                productIds = populateDefaults(productIds);
                        }
                }
                catch(SQLException ex){ out.print(ex); }
                catch(Exception ex){ out.print(ex); }
                finally{ closeConnection(); }

        %>

        <%!
                int[] populateDefaults(int[] productIds) throws Exception
                {
                        int productId;
                        int categoryId;
                        // Get most popular productId from orderproduct:
                        String sql = "SELECT productId, SUM(quantity) FROM orderproduct GROUP BY productId ORDER BY SUM(quantity) DESC";
                        PreparedStatement pst = con.prepareStatement(sql);
                        ResultSet rst = pst.executeQuery();
                        rst.next();
                        productId = rst.getInt(1);
                        
                        // Get categoryId from popular productId:
                        sql = "SELECT categoryId FROM product WHERE productId = ?";
                        pst = con.prepareStatement(sql);
                        pst.setInt(1, productId);
                        rst = pst.executeQuery();
                        rst.next();
                        categoryId = rst.getInt(1);

                        // Get productIds to display with categoryId:
                        sql = "SELECT productId FROM product WHERE categoryId = ?";
                        pst = con.prepareStatement(sql);
                        pst.setInt(1, categoryId);
                        rst = pst.executeQuery();

                        // Add product Ids to array:
                        int i = 0;
                        while(rst.next() && i < 6)
                        {
                                productIds[i] = rst.getInt(1);
                                i++;
                        }
                        return productIds;
                }
        %>


        <table align="center" width="Page" border="30" cellpadding="5">
                <tr>

                        <td align="center" valign="center">
                                <%
                                        out.print("<a href= product.jsp?id="+productIds[0]+"><img src=\"images/"+productIds[0]+".jpg\" alt=\"product image\" height=\"300\"></a>");
                                %>
                        </td>
                        
                        <td align="center" valign="center">
                                <%
                                        out.print("<a href= product.jsp?id="+productIds[1]+"><img src=\"images/"+productIds[1]+".jpg\" alt=\"product image\" height=\"300\"></a>");
                                %>
                        </td>

                        <td align="center" valign="center">
                                <%
                                        out.print("<a href= product.jsp?id="+productIds[2]+"><img src=\"images/"+productIds[2]+".jpg\" alt=\"product image\" height=\"300\"></a>");
                                %>
                        </td>
                        
                </tr> 
                <tr>

                        <td align="center" valign="center">
                                <%
                                        out.print("<a href= product.jsp?id="+productIds[3]+"><img src=\"images/"+productIds[3]+".jpg\" alt=\"product image\" height=\"300\"></a>");
                                %>
                        </td>
                        
                        <td align="center" valign="center">
                                <%
                                        out.print("<a href= product.jsp?id="+productIds[4]+"><img src=\"images/"+productIds[4]+".jpg\" alt=\"product image\" height=\"300\"></a>");
                                %>
                        </td>

                        <td align="center" valign="center">
                                <%
                                        out.print("<a href= product.jsp?id="+productIds[5]+"><img src=\"images/"+productIds[5]+".jpg\" alt=\"product image\" height=\"300\"></a>");
                                %>
                        </td>
                        
                </tr>
        </table>
</div>
</body>
</head>


