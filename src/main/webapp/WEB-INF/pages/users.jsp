<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />

    <title>Users Page</title>

    <style>
        @import url("/resources/style/table.css");
        @import url("/resources/style/hint.css");
    </style>
</head>
<body>
<a href="../../index.jsp">Back to main menu</a>

<br/>
<br/>
<h1> <c:if test="${!empty user.name}">Edit existing user</c:if>
    <c:if test="${empty user.name}">Add new user</c:if>
</h1>

<c:url var="addAction" value="/users/adduser"/>

<form:form action="${addAction}" commandName="user">

    <table class="table">
        <tr>
            <c:if test="${!empty user.name}">
                <th>
                    <form:label path="id">
                        <spring:message text="Id"/>
                    </form:label>
                </th>
            </c:if>

            <th>
                <form:label path="name" class="tooltip"> <span class="custom info">The name length must be 1 - 25 characters!</span>
                    <spring:message text="Name" />
                </form:label>
            </th>

            <th>
                <form:label path="age" class="tooltip"> <span class="custom info">The age must be 1 - 3 characters!</span>
                    <spring:message text="Age"/>
                </form:label>
            </th>

            <th>
                <form:label path="admin">
                    <spring:message text="Admin"/>
                </form:label>
            </th>

            <th>
                <form:label path="createdDate" class="tooltip"> <span class="custom info">Date formats create a user: yyyy-mm-DD HH:mm it can be empty! </span>
                    <spring:message text="CreatedDate"/>
                </form:label>
            </th>
        </tr>

        <tr>

            <c:if test="${!empty user.name}">
            <td>
                <form:input path="id" readonly="true" size="8" disabled="true"/>
                <form:hidden path="id"/>
            </td>
            </c:if>
            <td>
                <form:input path="name"/>
            </td>

            <td>
                <form:input path="age"/>
            </td>

            <td>
                <form:radiobutton path="admin" value="true"/>Yes
                <form:radiobutton path="admin" value="false"/>No
            </td>

            <td>
                <form:input path="createdDate"/>
            </td>
        <tr>
            <td colspan="5" align="center">
                <c:if test="${!empty user.name}">
                    <input type="submit" value="<spring:message text="Edit User"/>"/>
                </c:if>

                <c:if test="${empty user.name}">
                    <input type="submit" value="<spring:message text="Add User"/>"/>
                </c:if>
            </td>
        </tr>
        </tr>
    </table>
</form:form>

<h1>Search users</h1>

<table>

    <tr>
        <c:url var="searchuser" value="/searchresults"/>
        <form:form action="${searchuser}" commandName="searchuser">
            <table>

                <tr>
                    <td>
                        <form:label path="name">
                            <spring:message text="Name"/>
                        </form:label>
                    </td>

                    <td>
                        <form:input path="name"/>
                    </td>

                    <td>
                        <input type="submit" name="action" value="<spring:message text="Search by Name"/>"/>
                    </td>
                </tr>
            </table>
        </form:form>
    </tr>
</table>

<h1>User List</h1>

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
                <td><a href="<c:url value='/remove/${user.id}'/>">Delete</a></td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<div>

    <c:url value="/users" var="prev">
        <c:param name="page" value="${page-1}"/>
    </c:url>
    <c:if test="${page > 1}">
        <a href="<c:out value="${prev}" />" class="pn prev">Prev</a>
    </c:if>

    <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
        <c:choose>
            <c:when test="${page == i.index}">
                <span>${i.index}</span>
            </c:when>
            <c:otherwise>
                <c:url value="/users" var="url">
                    <c:param name="page" value="${i.index}"/>
                </c:url>
                <a href='<c:out value="${url}" />'>${i.index}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:url value="/users" var="next">
        <c:param name="page" value="${page + 1}"/>
    </c:url>
    <c:if test="${page + 1 <= maxPages}">
        <a href='<c:out value="${next}" />' class="pn next">Next</a>
    </c:if>
</div>
</body>
</html>
