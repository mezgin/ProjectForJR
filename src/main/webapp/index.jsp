<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title a>Test task for JR</title>
</head>
<body>
<h3>Test task for JR</h3>
<br/>
<br/>
<form>
    <input type="button" name="action" value="Click to begin!" onClick='location.href="<c:url value="/users"/>"'/>
</form>

<br/>
<br/>
</body>
</html>
