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
String str = "SELECT * FROM reservation WHERE username = '" + user + "'";
Statement st = con.createStatement();
ResultSet resultReservations = st.executeQuery(str);
%>
   	<p>
     <form action="checkCancelUserReservation.jsp" method="POST">
  	Reservation Number: <select name="reservationNo" size=1>
				<%
					while(resultReservations.next()) {
				%>
					<option value=<%=resultReservations.getString("reservationNo") %>><%=resultReservations.getString("reservationNo") %></option>
					<%} %>
				</select>&nbsp;<br>
       <input type="submit" value="Submit"/>
     </form>
    </p>
   </body>
</html>