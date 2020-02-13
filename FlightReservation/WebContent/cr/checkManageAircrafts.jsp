<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Aircraft Results</title>
</head>	
<body>
<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
	String type = request.getParameter("type");
	String aircraftID = request.getParameter("aircraftID");
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
			+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
			+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
	Statement st= con.createStatement();
	ResultSet check;
    String str;
    try {
    	Integer.parseInt(aircraftID);
		if(type.compareTo("add") == 0) {
			str = "SELECT * from aircraft WHERE aircraftID LIKE '" + aircraftID + "'";
			check = st.executeQuery(str);
			if(check.next()) {
				out.println("An aircraft with that ID already exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
			else {
				str = "INSERT INTO aircraft(aircraftID) VALUES('" + aircraftID + "')";
				st= con.createStatement();
				st.executeUpdate(str);
				out.println("Successfully inserted new aircraft with ID " + aircraftID + ". <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
		}
		else if(type.compareTo("edit") == 0) {
			str = "SELECT * from aircraft WHERE aircraftID LIKE '" + aircraftID + "'";
			System.out.println(str);
			check = st.executeQuery(str);
			if(!check.next()) {
				out.println("No aircraft with that ID exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
			else {
				String newAircraftID = request.getParameter("newAircraftID");
				Integer.parseInt(newAircraftID);
				str = "SELECT * from aircraft WHERE aircraftID LIKE '" + newAircraftID + "'";
				System.out.println(str);
				check = st.executeQuery(str);
				if(check.next()) {
					out.println("Aircraft with proposed new ID already exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
				}
				else {
					str = "UPDATE aircraft SET aircraftID='" + newAircraftID + "' WHERE aircraftID LIKE '" + aircraftID + "'";
					st= con.createStatement();
					st.executeUpdate(str);
					out.println("Successfully changed aircraft ID " + aircraftID + " to " + newAircraftID + ". <a href='checkCRLoginDetails.jsp'>Home</a>");
				}
			}
		}
		else if(type.compareTo("delete") == 0) {
			str = "SELECT * from aircraft WHERE aircraftID LIKE '" + aircraftID + "'";
			check = st.executeQuery(str);
			if(!check.next()) {
				out.println("No aircraft with that ID exists. <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
			else {
				str = "DELETE FROM aircraft WHERE aircraftID LIKE '" + aircraftID + "'";
				st= con.createStatement();
				st.executeUpdate(str);
				out.println("Successfully deleted aircraft with ID " + aircraftID + ". <a href='checkCRLoginDetails.jsp'>Home</a>");
			}
		}
    }
    catch(Exception e) {
		out.println("Error: Aircraft ID must be an integer. <a href='checkCRLoginDetails.jsp'>Home</a>");
    }
	%>
</br>

</body>
</html>
