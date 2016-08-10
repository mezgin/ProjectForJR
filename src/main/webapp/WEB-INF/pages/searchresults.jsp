
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>

<html>
<head>
    <title>UserData</title>

    <style>
      @import url("/resources/style/table.css");
    </style>

</head>
<body>
<a href="<c:url value="/users"/>">Back to users list</a>
<br/>
<br/>
<h1>Search results</h1>

<c:if test="${!empty listUsers}">
  <table class="table">
    <tr>
      <th width="60">Id</th>
      <th width="200">Name</th>
      <th width="40">Age</th>
      <th width="50">Admin</th>
      <th width="150">CreatedDate</th>
      <th width="40">Edit</th>
      <th width="50">Delete</th>
    </tr>
    <c:forEach items="${listUsers}" var="user">
      <tr>
        <td>${user.id}</td>
        <td><a href="/userdata/${user.id}" target="_blank">${user.name}</a></td>
        <td>${user.age}</td>
        <td>${user.admin}</td>
        <td>${user.createdDate}</td>
        <td><a href="<c:url value='/edit/${user.id}'/>">Edit</a></td>
        <td><a href="<c:url value='/remove/${user.id}'/>">Delete</a> </td>
      </tr>
    </c:forEach>
  </table>
</c:if>
</body>
</html>
