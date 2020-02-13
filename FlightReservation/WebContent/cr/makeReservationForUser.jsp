<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Add Reservation</title>
   </head>
   <body>
<% 
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
		+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
		+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
String user = (String)request.getSession().getAttribute("username");
String str = "SELECT * FROM reservation WHERE username = '" + user + "'";
Statement st = con.createStatement();
ResultSet resultReservations = st.executeQuery(str);

str = "SELECT * from airline";
st = con.createStatement();
ResultSet resultAirlines = st.executeQuery(str);

%> 
   	<p>
     <form action="makeReservationForUser2.jsp" method="POST">
	   Username: <input type="text" name="username"/> <br/>
       Airline ID: <select name="airlineID" size=1>
				<%
					while(resultAirlines.next()) {
				%>
					<option value=<%=resultAirlines.getString("airlineID") %>><%=resultAirlines.getString("airlineID") %></option>
					<%} %>
				</select>&nbsp;<br>
       Flight ID: <input type="text" name="flightID"/> <br/>
       Reservation Number: <select name="reservationNo" size=1>
       				<option value="new">New Reservation</option>
				<%
					while(resultReservations.next()) {
				%>
					<option value=<%=resultReservations.getString("reservationNo") %>><%=resultReservations.getString("reservationNo") %></option>
					<%} %>
				</select>&nbsp;<br>
       Type: 
     	<select name="type" size=1>
		<option value="0">One Way</option>
		<option value="1">Round Trip</option>
		</select>&nbsp;<br/>
		Class:
		<select name="class" size=1>
		<option value="0">Economy</option>
		<option value="1">Business</option>
		</select>&nbsp;<br/>
		<input type="checkbox" name = "flex" value = "1">Flexible datetime<br/>	
       <input type="submit" value="Add"/>
     </form>
    </p>
   </body>
</html>