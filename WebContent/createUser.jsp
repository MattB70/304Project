<html>
<head>
<title>Create User Account Page</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
        
<%@ include file="header.jsp" %>
<div id="main-content">
    <%
    out.println("<h2 style=\"color:#ADD8E6; white-space:nowrap;\">Please fill in the required fields. </h2><br>");
    %>
    <form name="MyForm" method=post action="newUser.jsp">
    <table style="display:inline">
        <tr>
            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
            <td><input type="text" name="firstName" placeholder="Ramon" size=40 maxlength=15></td>
        </tr>
        <tr>
            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
            <td><input type="text" name="lastName" placeholder="Lawrence" size=40 maxlength="15"></td>
        </tr>
        <tr>
            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
            <td><input type="text" name="email" placeholder="RamonWorld@example.com" size=40 maxlength="40"></td>
        </tr>
        <tr>
            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
            <td><input type="text" name="phoneNum" placeholder="XXX-XXX-XXXX" size=40 maxlength="12"></td>
        </tr>
        <tr>
            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
            <td><input type="text" name="address" placeholder="3333 University Way" size=40 maxlength="40"></td>
        </tr>
        <tr>
            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
            <td><input type="text" name="city" placeholder="Kelowna" size=40 maxlength="20"></td>
        </tr>
        <tr>
            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Province/State:</font></div></td>
            <td><input type="text" name="state" placeholder="ie: British Columbia enter 'BC' " size=40 maxlength="2"></td>
        </tr>
        <tr>
            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
            <td><input type="text" name="postalCode" placeholder="XXX XXX" size=40 maxlength="7"></td>
        </tr>
        <tr>
            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
            <td><input type="text" name="country" placeholder="Canada" size=40 maxlength="20"></td>
        </tr>
        <tr>
            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
            <td><input type="text" name="user" placeholder="Enter a username..." size=40 maxlength=20></td>
        </tr>
        <tr>
            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
            <td><input type="password" name="pw" placeholder="Enter a password..." size=40 maxlength="20"></td>
        </tr>
         <tr><td style='text-align:center;'><input type='reset' name='reset' value='Reset'></td><td style='text-align:center;'><input type='submit' name='submit' value='Create Account'></td></tr>
        </table>
<br/>
</form>
</div>
</body>
</html>
