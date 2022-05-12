var result = "";
var ProcessBuilder = Java.type("java.lang.ProcessBuilder");
var Scanner = Java.type("java.util.Scanner");
var scanner = new Scanner(new ProcessBuilder("ls").start().getInputStream()).useDelimiter("\\A");
result = scanner.hasNext() ? scanner.next() :"";