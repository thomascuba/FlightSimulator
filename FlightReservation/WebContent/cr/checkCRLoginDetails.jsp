<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
	String user = request.getParameter("username"); 
	String pass = request.getParameter("password");
	if(user == null) {
		user = (String)request.getSession().getAttribute("username"); 
	}
	if(pass == null) {
		pass = (String)request.getSession().getAttribute("password");
	}
	request.getSession().setAttribute("username", user);
	request.getSession().setAttribute("password", pass);
 
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
			+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
			+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
	String str = "select u.username, u.password from user u JOIN employee e ON u.username LIKE e.username WHERE u.username = '" + user + "'";
	System.out.println(str);
	Statement st= con.createStatement(); 
	ResultSet rsCR=st.executeQuery(str);
	str = "select u.username, u.password from user u JOIN admin a ON u.username LIKE a.username WHERE u.username = '" + user + "'";
	System.out.println(str);
	st = con.createStatement();
	ResultSet rsAdmin = st.executeQuery(str);
    
	if(rsCR.next()) { 
		System.out.println(rsCR.getString("username"));
		
		if(rsCR.getString("password").equals(pass)) { 
			out.println( "<p align='center'> Welcome, representative " + user + ". Every day is a good day to be a customer rep for 57FlightReservation!</p>");
			out.println( "<p align='center'> <a href='makeReservationForUser.jsp'>Buy Ticket For User</a></p>");
			out.println( "<p align='center'> <a href='editReservationForUser.jsp'>Edit Reservations For User</a></p>");
			out.println( "<p align='center'> <a href='manageAircrafts.jsp'>Manage Aircrafts</a></p>");
			out.println( "<p align='center'> <a href='manageAirlines.jsp'>Manage Airlines</a></p>");
			out.println( "<p align='center'> <a href='manageAirports.jsp'>Manage Airports</a></p>");
			out.println( "<p align='center'> <a href='manageFlights.jsp'>Manage Flights</a></p>");
			out.println( "<p align='center'> <a href='waitingListQuery.jsp'>Waiting List Query</a></p>");
			out.println("<p align='center'> <a href='../logout.jsp'>Logout</a></p>"); 
		} 
		else {
			out.println("Invalid password, please try again." + "<p align='left'> <a href='../logout.jsp'>Home</a> </p>"); 
		}
	}
	
	
	else if(rsAdmin.next()) { 
		System.out.println(rsAdmin.getString("username"));
		if(rsAdmin.getString("password").equals(pass)) { 
			out.println( "<p align='center'> Welcome, administrator " + user + ". Admins can do customer rep stuff too!</p>");
			out.println( "<p align='center'> <a href='makeReservationForUser.jsp'>Make Reservation For User</a></p>");
			out.println( "<p align='center'> <a href='editReservationForUser.jsp'>Edit Reservations For User</a></p>");
			out.println( "<p align='center'> <a href='manageAircrafts.jsp'>Manage Aircrafts</a></p>");
			out.println( "<p align='center'> <a href='manageAirlines.jsp'>Manage Airlines</a></p>");
			out.println( "<p align='center'> <a href='manageAirports.jsp'>Manage Airports</a></p>");
			out.println( "<p align='center'> <a href='manageFlights.jsp'>Manage Flights</a></p>");
			out.println( "<p align='center'> <a href='waitingListQuery.jsp'>Waiting List Query</a></p>");
			out.println("<p align='center'> <a href='../logout.jsp'>Logout</a></p>"); 
		} 
		else {
			out.println("Invalid password, please try again." + "<p align='left'> <a href='../logout.jsp'>Home</a> </p>"); 
		}
	}
	
	else
		out.println("Invalid username, please try again." + "<p align='left'> <a href='../logout.jsp'>Home</a> </p>"); 
	%>

</body>
</html>
