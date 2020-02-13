<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Add Flight</title>
   </head>
   <body>
<% 
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
		+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
		+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
String user = (String)request.getSession().getAttribute("username");

String str = "SELECT * from airline";
Statement st = con.createStatement();
ResultSet resultAirlines = st.executeQuery(str);

%> 
   	<p>
     <form action="checkWaitingListQuery.jsp" method="POST">
       AirlineID: <select name="airlineID" size=1>
				<%
					while(resultAirlines.next()) {
				%>
					<option value=<%=resultAirlines.getString("airlineID") %>><%=resultAirlines.getString("airlineID") %></option>
					<%} %>
				</select>&nbsp;<br>
       FlightID: <input type="text" name="flightID"/> <br/>
       <input type="submit" value="Query"/>
     </form>
    </p>
   </body>
</html>