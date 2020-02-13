<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Flights</title>
</head>
<body>
<a href='checkAdminLoginDetails.jsp'>Home</a><br/>
<% 
String airportID = request.getParameter("airportID");
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
		+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
		+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 

String str = "SELECT * FROM flight WHERE depAirp = '" + airportID + "' OR arrAirp = '" + airportID + "'";
Statement st = con.createStatement();
ResultSet result = st.executeQuery(str); %>

<table border="5" bgcolor="white" cellspacing="4" cellpadding="4">
<tr bgcolor="pink">
	<th>Airline ID</th>
	<th>Flight Number</th>
	<th>Date</th>		
	<th>Departure Airport</th>
	<th>Arrival Airport</th>
	<th>Departure Time</th>
	<th>Arrival Time</th>
	<th>Price</th>
	<th>Type</th>
</tr>

<%
		while (result.next()) {
		String type = result.getString("type");
		if(type == null || type.compareTo("") == 0)
			type = "Unknown";
		else if(type.compareTo("0") == 0)
			type = "Domestic";
		else
			type = "International";
%>

<tr bgcolor="pink">
	<td><%=result.getString("airlineID")%></td>
	<td><%=result.getString("flightID")%></td>
	<td><%=result.getString("date")%></td>			
	<td><%=result.getString("depAirp")%></td>
	<td><%=result.getString("arrAirp")%></td>
	<td><%=result.getString("deptTime")%></td>
	<td><%=result.getString("arrTime")%></td>
	<td><%=result.getString("price")%></td>		
	<td><%=type%></td>				
</tr>
<%
	}
%>

</table>
