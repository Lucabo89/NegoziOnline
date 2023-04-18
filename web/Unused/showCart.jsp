

<html>

<jsp:useBean id="cart" scope= "session" class="sessione.Carrello" />
<jsp:setProperty name="cart" property="*" />

<%	
            cart.processRequest(request);   
%>

<FONT size = 5 COLOR="#CC0000">
<br> You have the following items in your cart:
<ol>
<% 
	String[] items = cart.getItems();
	for (int i=0; i<items.length; i++) {
%>
   <li><% out.print(items[i]); %> 
        <%  } %>
</ol>

</FONT>

<hr>
<%@ include file ="index.jsp" %>
</html>