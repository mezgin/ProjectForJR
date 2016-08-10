<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Data</title>

    <style>
      @import url("/resources/style/table.css");
    </style>

</head>

<body>
<a href="<c:url value="/users"/>">Back to users list</a>
<br/>
<br/>
<h1>User Details</h1>

<table class="table">
  <tr>
    <th width="60">Id</th>
    <th width="200">Name</th>
    <th width="40">Age</th>
    <th width="50">Admin</th>
    <th width="150">CreatedDate</th>
  </tr>
  <tr>
    <td>${user.id}</td>
    <td>${user.name}</td>
    <td>${user.age}</td>
    <td>${user.isAdmin}</td>
    <td>${user.createdDate}</td>
  </tr>
</table>
</body>
</html>
