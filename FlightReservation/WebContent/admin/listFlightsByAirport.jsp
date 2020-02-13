<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
   <head>
      <title>List Flights By Airport</title>
   </head>
<% 
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
		+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
		+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 

String str = "SELECT * FROM airport";
Statement st = con.createStatement();
ResultSet resultAirports = st.executeQuery(str);

%> 
   <body>
   <a href='checkAdminLoginDetails.jsp'>Home</a><br/>
   	<p>  <form action="checkListFlightsByAirport.jsp" method="POST">
       Airport: <select name="airportID" size=1>
				<%
					while(resultAirports.next()) {
				%>
					<option value=<%=resultAirports.getString("airportID") %>><%=resultAirports.getString("airportID") %></option>
					<%} %>
				</select>&nbsp;<br>
       <input type="submit" value="List Flights"/>
     </form>
    </p>
   </body>
</html>