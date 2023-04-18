<%-- 
    Document   : showProduct
    Created on : Jan 10, 2017, 11:44:05 AM
    Author     : bonny
--%>

<%@ page info="Home Page" %>
<%@ page contentType="text/html" %>
<%@ page buffer="30kb" %>
<%@ page session="true" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="sessione.*" %>
<%@ page import="blogics.*" %>
<%@ page import="db.*" %>
<%@ page import="java.util.Vector" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Proviamo il Carrello!</h1>
        <%
            Carrello cart = (Carrello) session.getAttribute("cart");
        
            cart.setItem("diocane");
            
            
        %>
    </body>
</html>
