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
String aircraftID = request.getParameter("aircraftID");
String depAirp = request.getParameter("depAirp");
String arrAirp = request.getParameter("arrAirp");
String deptTime = request.getParameter("deptTime");
String arrTime = request.getParameter("arrTime");
String price = request.getParameter("price");
String date = request.getParameter("date");
String type = request.getParameter("type");


if(deptTime == null || deptTime.compareTo("") == 0) {
	deptTime = "null";
}
else {
	deptTime = "'" + deptTime + "'";
}

if(arrTime == null || arrTime.compareTo("") == 0) {
	arrTime = "null";
}
else {
	arrTime = "'" + arrTime + "'";
}

if(price == null || price.compareTo("") == 0) {
	price = "null";
}

if(date == null || date.compareTo("") == 0) {
	date = "null";
}
else {
	date = "'" + date + "'";
}

Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
		+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
		+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
Statement st= con.createStatement();
if(flightID != null && flightID.compareTo("") != 0 && airlineID != null) {
	String str = "SELECT * from flight WHERE flightID = " + flightID + " AND airlineID = '" + airlineID + "'";
	ResultSet check = st.executeQuery(str);
	if(!check.next()) {
		str = "INSERT INTO flight(airlineID, aircraftID, flightID, depAirp, arrAirp, deptTime, arrTime, price, date, type) VALUES('" + airlineID + "', " + aircraftID + ", " + flightID + ", '" + depAirp + "', '" + arrAirp + "', " + deptTime +", " + arrTime + ", " + price + ", " + date + ", " + type + ")";
		System.out.println(str);
		st = con.createStatement();
		st.executeUpdate(str);
		out.println("Successfully inserted flight with flight ID " + flightID + " and airline ID " + airlineID + ". <a href='checkCRLoginDetails.jsp'>Home</a>");
	}
	else
		out.println("Error: The given flight ID already exists for this airline. <a href='checkCRLoginDetails.jsp'>Home</a>");
}
else
	out.println("Error: You must insert a flight ID. <a href='checkCRLoginDetails.jsp'>Home</a>");

%>
</body>
</html>