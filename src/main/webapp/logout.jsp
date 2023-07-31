<%
request.getSession().removeAttribute("currentUser");
response.sendRedirect("index.jsp");
%>
