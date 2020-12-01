<! buttons !>
<table class="buttons" border="0" width="100%">
    <tr>    
        <th class="buttons" align="left"><a href="index.jsp"><img src="images/icon.png" alt="Home" height="100" ></a></th>      <!-- Home -->
        <th class="buttons"><a href="listprod.jsp">Begin Shopping</a></th>      <!-- listprod   -->
        <th class="buttons"><a href="customer.jsp">Customer Info</a></th>       <!-- customer   -->
        <th class="buttons"><a href="admin.jsp?task=Add+New+Product">Administators</a></th>          <!-- admin   defaults to Add New Product   -->
        <th class="buttons"><a href="listorder.jsp">List All Orders</a></th>    <!-- listorder  -->
<!--    <th class="buttons"><a href="ship.jsp">Shipment</a></th>                <!-- ship       -->
        <th class="buttons" align="right"><a href="addcart.jsp"><img src="images/cart.png" alt="Cart" height="100" ></a></th>   <!-- Cart -->
    </tr>

    <tr>    
        <th class="buttons"><a href="login.jsp">Login</a></th>
        <th class="buttons"><a href="createUser.jsp">Create an account</a></th>
        <th class="buttons"></th>   <!-- Spacer -->
<!--    <th class="buttons"></th>   <!-- Spacer -->
        <th class="buttons"></th>   <!-- Spacer -->
        <th class="buttons" align="right"><%@ include file="logininfo.jsp" %></th>   <!-- Login info -->
        <th class="buttons"><a href="logout.jsp">Logout</a></th>
    </tr>
</table>

<!-- banner image below buttons -->
<div id="bannerimage"></div>