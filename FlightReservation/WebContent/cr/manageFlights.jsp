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
<a href='checkCRLoginDetails.jsp'>Home</a><br/>
<a href='addFlight.jsp'>Add Flight</a><br/>
<% 
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
		+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
		+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 

String str = "SELECT * FROM airline";
Statement st = con.createStatement();
ResultSet resultAirlines = st.executeQuery(str);
st = con.createStatement();
ResultSet resultAirlines2 = st.executeQuery(str);
%>
<form action="editFlight.jsp" method="POST">
Flight ID: <input type="text" name="flightID"/> Airline ID: <select name="airlineID" size=1>
				<%
					while(resultAirlines.next()) {
				%>
					<option value=<%=resultAirlines.getString("airlineID") %>><%=resultAirlines.getString("airlineID") %></option>
					<%} %>
				</select>&nbsp;<br>
				<input type="submit" value="Edit Flight"/>
				
</form>
<form action="deleteFlight.jsp" method="POST">
Flight ID: <input type="text" name="flightID"/> Airline ID: <select name="airlineID" size=1>
				<%
					while(resultAirlines2.next()) {
				%>
					<option value=<%=resultAirlines2.getString("airlineID") %>><%=resultAirlines2.getString("airlineID") %></option>
					<%} %>
				</select>&nbsp;<br>
					<input type="submit" value="Delete Flight"/>
</form>
</body>
</html>