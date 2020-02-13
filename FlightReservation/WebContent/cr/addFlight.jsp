<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Flight</title>
</head>
<body>
	<%
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
			+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
			+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
	
	String str = "SELECT * FROM airline";
	Statement st = con.createStatement();
	ResultSet resultAirlines = st.executeQuery(str);
	
	str = "SELECT * FROM aircraft";
	st = con.createStatement();
	ResultSet resultAircrafts = st.executeQuery(str);
	
	str = "SELECT * FROM airport";
	st = con.createStatement();
	ResultSet resultAirports = st.executeQuery(str);
	
	st = con.createStatement();
	ResultSet resultAirports2 = st.executeQuery(str);
	
	%>
	<form action="checkAddFlight.jsp" method="POST">
		Flight ID: <input type="text" name="flightID"/><br/>
		Airline ID: <select name="airlineID" size=1>
				<%
					while(resultAirlines.next()) {
				%>
					<option value=<%=resultAirlines.getString("airlineID") %>><%=resultAirlines.getString("airlineID") %></option>
					<%} %>
				</select>&nbsp;<br>
		Aircraft ID: <select name="aircraftID" size=1>
				<%
					while(resultAircrafts.next()) {
				%>
					<option value=<%=resultAircrafts.getString("aircraftID") %>><%=resultAircrafts.getString("aircraftID") %></option>
					<%} %>
				</select>&nbsp;<br>
		Departure Airport: <select name="depAirp" size=1>
				<%
					while(resultAirports.next()) {
				%>
					<option value=<%=resultAirports.getString("airportID") %>><%=resultAirports.getString("airportID") %></option>
					<%} %>
				</select>&nbsp;<br>
		Arrival Airport: <select name="arrAirp" size=1>
				<%
					while(resultAirports2.next()) {
				%>
					<option value=<%=resultAirports2.getString("airportID") %>><%=resultAirports2.getString("airportID") %></option>
					<%} %>
				</select>&nbsp;<br>
		Departure Datetime: <input type="text" name="depTime"/><br/>
		Arrival Datetime: <input type="text" name="arrTime"/><br/>
		Date Of Operation: <input type="text" name="date"/><br/>
		Price: <input type="text" name="price"/><br/>
		Type: <select name="type" size=1>
		<option value="0">Domestic</option>
		<option value="1">International</option>
		</select>&nbsp;<br/>
		<input type="submit" value="Add Flight"/>
		</form>
</body>
</html>