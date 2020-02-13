<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%

String flightID = request.getParameter("flightID");
String airlineID = request.getParameter("airlineID");

Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
		+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
		+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
String user = (String)request.getSession().getAttribute("username");

String str = "SELECT a.capacity FROM aircraft a, flight f WHERE a.aircraftID = f.aircraftID AND f.airlineID LIKE '" + airlineID + "' AND f.flightID = " + flightID;
System.out.println(str);
Statement st = con.createStatement();
ResultSet aircraftCapacity = st.executeQuery(str);

String capacity = null;
if(!aircraftCapacity.next()) {
	System.out.println("Error with queues.");
	out.println("There was an error parsing queues.<a href='checkCRLoginDetails.jsp'>Home</a>");
}
else {
	out.println("<a href='checkCRLoginDetails.jsp'>Home</a>");
	capacity = aircraftCapacity.getString("capacity");
	
	str = "SELECT t.username, c.queuePos FROM ticket t, componentOf c WHERE c.queuePos > " + capacity + " AND t.ticketNo = c.ticketNo AND c.airlineID LIKE '" + airlineID + "' AND c.flightID = " + flightID + " ORDER BY c.queuePos"; 
	st = con.createStatement();
	ResultSet result = st.executeQuery(str);
	%>
	<title>Queue Summary For Flight With Flight ID <%=flightID %> and Airline ID <%=airlineID %></title>
</head>
<body>
<table border="5" bgcolor="white" cellspacing="4" cellpadding="4">
		<tr bgcolor="pink">
			<th>Username</th>
			<th>Queue Position</th>
		</tr>
					<%
					while (result.next()) {
						String currQueuePos = "" + (Integer.parseInt(result.getString("queuePos")) - Integer.parseInt(capacity));
			%>

			<tr bgcolor="pink">
				<td><%=result.getString("username")%></td>
				<td><%=currQueuePos%></td>							
			</tr>
	
			<%
			} %>
</body>
</html>
<%
}		
%>
