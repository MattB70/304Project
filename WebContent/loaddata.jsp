<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>LOAD DATA</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>


<%@ include file="header.jsp" %>


<div style="white-space: nowrap;">
<%

out.print("<h1>Connecting to database.</h1><br><br>");        
String fileName = "/usr/local/tomcat/webapps/shop/orderdb_sql.ddl";

try{
    getConnection();
    // Create statement
    Statement stmt = con.createStatement();
    
    Scanner scanner = new Scanner(new File(fileName));
    // Read commands separated by ;
    scanner.useDelimiter(";");
    while (scanner.hasNext()){
        String command = scanner.next();
        if (command.trim().equals(""))
            continue;
        out.print("<br />"+command);        // Uncomment if want to see commands executed
        try{
            stmt.execute(command);
        }
        catch (Exception e)
        {	// Keep running on exception.  This is mostly for DROP TABLE if table does not exist.
            out.println("<br>");
            out.println("<br>");
            out.println("<h3 style=\"color:red;\">EXCEPTION: . . . "+e+"</h3>");
            out.println("<br>");
            out.println("<br>");
        }
    }	 
    closeConnection();
    
    out.print("<br><br><h1>Database loaded.</h1>");
}
catch (Exception e){
    out.println("<br>");
    out.println("<br>");
    out.println("<h3 style=\"color:red;\">EXCEPTION: . . . "+e+"</h3>");
    out.println("<br>");
    out.println("<br>");
}  
%>
</div>
</body>
</html> 
