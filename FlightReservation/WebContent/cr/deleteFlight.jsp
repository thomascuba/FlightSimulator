<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<% 
	String flightID = request.getParameter("flightID");
	String airlineID = request.getParameter("airlineID");
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
			+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
			+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
	if(flightID != null && flightID.compareTo("") != 0 && airlineID != null && airlineID.compareTo("") != 0) {
		String str = "SELECT flightID, airlineID FROM flight WHERE flightID = " + flightID + " AND airlineID = '" + airlineID + "'";
		Statement st = con.createStatement();
		ResultSet result = st.executeQuery(str);
		if(result.next()) {
			str = "DELETE FROM flight WHERE flightID = " + flightID + " AND airlineID = '" + airlineID + "'";
			st = con.createStatement();
			st.executeUpdate(str);
			out.println("Flight with flight ID " + flightID + " and airline ID " + airlineID + " removed successfully. <a href='checkCRLoginDetails.jsp'>Home</a>");
		}
		else
			out.println("Error: Flight with the given flight ID and airline ID does not exist. <a href='checkCRLoginDetails.jsp'>Home</a>");
	}
	else
		out.println("Error: You must insert a flight ID and airline ID. <a href='checkCRLoginDetails.jsp'>Home</a>");
	
%>
</body>
</html>