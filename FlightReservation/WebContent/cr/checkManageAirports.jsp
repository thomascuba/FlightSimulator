<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Airport Results</title>
</head>	
<body>
<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
	String type = request.getParameter("type");
	String airportID = request.getParameter("airportID");
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
			+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
			+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
	Statement st= con.createStatement();
	ResultSet check;
    String str;
    if(airportID == null || airportID.length() == 3) {
		if(type.compareTo("add") == 0) {
			str = "SELECT * from airport WHERE airportID LIKE '" + airportID + "'";
			check = st.executeQuery(str);
			if(check.next()) {
				out.println("An airport with that ID already exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
			else {
				str = "INSERT INTO airport(airportID) VALUES('" + airportID + "')";
				st= con.createStatement();
				st.executeUpdate(str);
				out.println("Successfully inserted new airport with ID " + airportID + ". <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
		}
		else if(type.compareTo("edit") == 0) {
			str = "SELECT * from airport WHERE airportID LIKE '" + airportID + "'";
			System.out.println(str);
			check = st.executeQuery(str);
			if(!check.next()) {
				out.println("No airport with that ID exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
			else {
				String newAirportID = request.getParameter("newAirportID");
				if(newAirportID.length() == 3) {
					str = "SELECT * from aircraft WHERE aircraftID LIKE '" + newAirportID + "'";
					System.out.println(str);
					check = st.executeQuery(str);
					if(check.next()) {
						out.println("Airport with proposed new ID already exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
					}
					else {
					str = "UPDATE airport SET airportID='" + newAirportID + "' WHERE airportID LIKE '" + airportID + "'";
					st= con.createStatement();
					st.executeUpdate(str);
					out.println("Successfully changed airport ID " + airportID + " to " + newAirportID + ". <a href='checkCRLoginDetails.jsp'>Home</a>");
					}
				}
				else
					out.println("Error: New airport ID must be three characters long. <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
		}
		else if(type.compareTo("delete") == 0) {
			str = "SELECT * from airport WHERE airportID LIKE '" + airportID + "'";
			check = st.executeQuery(str);
			if(!check.next()) {
				out.println("No airport with that ID exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
			else {
				str = "DELETE FROM airport WHERE airportID LIKE '" + airportID + "'";
				st= con.createStatement();
				st.executeUpdate(str);
				out.println("Successfully deleted airport with ID " + airportID + ". <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
		}
    }
    else 
		out.println("Error: Airport ID must be three characters long. <a href='checkCRLoginDetails.jsp'>Home</a>");
	%>
</br>

</body>
</html>
