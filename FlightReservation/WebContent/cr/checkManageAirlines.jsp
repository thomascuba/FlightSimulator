<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Airline Results</title>
</head>	
<body>
<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
	String type = request.getParameter("type");
	String airlineID = request.getParameter("airlineID");
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
			+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
			+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
	Statement st= con.createStatement();
	ResultSet check;
    String str;
    if(airlineID == null || airlineID.length() == 2) {
		if(type.compareTo("add") == 0) {
			str = "SELECT * from airline WHERE airlineID LIKE '" + airlineID + "'";
			check = st.executeQuery(str);
			if(check.next()) {
				out.println("An airline with that ID already exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
			else {
				str = "INSERT INTO airline(airlineID) VALUES('" + airlineID + "')";
				st= con.createStatement();
				st.executeUpdate(str);
				out.println("Successfully inserted new airline with ID " + airlineID + ". <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
		}
		else if(type.compareTo("edit") == 0) {
			str = "SELECT * from airline WHERE airlineID LIKE '" + airlineID + "'";
			System.out.println(str);
			check = st.executeQuery(str);
			if(!check.next()) {
				out.println("No airport with that ID exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
			else {
				String newAirlineID = request.getParameter("newAirlineID");
				if(newAirlineID.length() == 2) {
					str = "SELECT * from airline WHERE airlineID LIKE '" + newAirlineID + "'";
					System.out.println(str);
					check = st.executeQuery(str);
					if(check.next()) {
						out.println("Airline with proposed new ID already exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
					}
					else {
					str = "UPDATE airline SET airlineID='" + newAirlineID + "' WHERE airlineID LIKE '" + airlineID + "'";
					st= con.createStatement();
					st.executeUpdate(str);
					out.println("Successfully changed airline ID " + airlineID + " to " + newAirlineID + ". <a href='checkCRLoginDetails.jsp'>Home</a>");
					}
				}
				else
					out.println("Error: New airline ID must be two characters long. <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
		}
		else if(type.compareTo("delete") == 0) {
			str = "SELECT * from airline WHERE airlineID LIKE '" + airlineID + "'";
			check = st.executeQuery(str);
			if(!check.next()) {
				out.println("No airline with that ID exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
			else {
				str = "DELETE FROM airline WHERE airlineID LIKE '" + airlineID + "'";
				st= con.createStatement();
				st.executeUpdate(str);
				out.println("Successfully deleted airline with ID " + airlineID + ". <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
		}
    }
    else
		out.println("Error: Airline ID must be two characters long. <a href='checkCRLoginDetails.jsp'>Home</a>");
	%>
</br>

</body>
</html>
