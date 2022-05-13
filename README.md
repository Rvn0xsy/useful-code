## usaefull-code

### ASP.NET

- [ASP.NET/cmd.asmx](./ASP.NET/cmd.asmx) ASPX扩展名容易被查杀，ASMX主要用于执行命令
- [ASP.NET/read-webconfig.shtml](./ASP.NET/read-webconfig.shtml)利用shtml特性可以读取站点内的文件
- [ASP.NET/writefile.ashx](./ASP.NET/writefile.ashx)若asmx、aspx都不能上传了，可以试试ashx格式的。

### JAVA

- [JAVA/writefile.jsp](./JAVA/writefile.jsp) 主要用于绕过WAF进行文件上传，需在header头中指定绝对路径
- [JAVA/writefile-script.jsp](./JAVA/writefile-script.jsp) 如果限制了`<%`、`<%@`等字符，可以使用`<jsp:scriptlet>`标记。
- [JAVA/script-engine-header.jsp](./JAVA/script-engine-header.jsp) 使用JAVA的ScriptEngine实现灵活的代码执行入口，输入点在Header头中，比普通的文件小马好用一些。
- [JAVA/script-engine-body.jsp](./JAVA/script-engine-body.jsp) 使用JAVA的ScriptEngine实现灵活的代码执行入口，输入点在Body中，比普通的文件小马好用一些。
- [JAVA/exec-command.js](./JAVA/exec-command.js) 使用JAVA的ScriptEngine实现灵活的代码执行入口，这个js是用于放置在Header中发送到服务器上执行命令的代码。
- [JAVA/writefile-print.jsp](./JAVA/writefile-print.jsp) 使用`java.io.PrintWriter`可以跳过`new File`关键字写入文件。
- [JAVA/jsp-expression-exec.jsp](./JAVA/jsp-expression-exec.jsp) 如果限制了`<%`、`<%@`、`<jsp:declaration>`、`<jsp:scriptlet>`等字符，可以使用expression表达式代替。


### Other

- [Apache/htaccess.txt](./Other/Apache/htaccess.txt) Apache+php组合时，不能上传.php后缀可以试试这个
- [IIS/web.config](./Other/IIS/web.config) 当存在任意文件上传时（文件名可控），可以用web.config设置当前目录解析格式。

### PHP

- [PHP/write.php](./PHP/write.php) 主要用于文件写入


### Encoder

![](./images/unicode-jsp.jpg)

- [Encoder/unicode-jsp.html](./Encoder/unicode-jsp.html) :ram: Unicode编码JSP代码 [在线地址](https://payloads.online/tools/unicode-jsp.html) :star:

