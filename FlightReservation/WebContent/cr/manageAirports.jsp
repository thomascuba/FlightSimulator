<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Airports</title>
</head>
<body>
<a href='checkCRLoginDetails.jsp'>Home</a>
 	<form action="checkManageAirports.jsp" method="POST">
		<select name="type" size=1>
		<option value="add">Add</option>
		<option value="edit">Edit</option>
		<option value="delete">Delete</option>
		</select>&nbsp;
		Airport ID: <input type="text" name="airportID"/> <br/>
		New Airport ID (if editing): <input type="text" name="newAirportID"/><br/>
		<input type="submit" value="Submit"/>
	</form>
</body>
</html>