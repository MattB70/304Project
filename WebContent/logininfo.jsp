<!DOCTYPE html>
<html>
<head>
<style>
</style>
</head>
<body>
<div> <!--    content:    -->


<%
  try{
    String userName = (String) session.getAttribute("authenticatedUser");

    if(userName == null)
    {
      out.print("");
    }
    else if(userName.equals(null))
    {
      out.print("Logged in with no username");
    }
    else
    {
      out.print("Logged in as "+userName);
    }

  }
  catch(Exception ex)
  {
    out.print("Exception at logininfo");
  }
%>


</div>
</body>
</html>