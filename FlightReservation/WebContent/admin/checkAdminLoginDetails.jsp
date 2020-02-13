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
	
		String str = "select u.username, u.password from user u JOIN admin a ON u.username LIKE a.username WHERE u.username = '" + user +"'";
		System.out.println(str);
		Statement st = con.createStatement();
		ResultSet rsAdmin = st.executeQuery(str);	
		
		if(rsAdmin.next()) { 
			System.out.println(rsAdmin.getString("username"));
			if(rsAdmin.getString("password").equals(pass)) {
				out.println( "<p align='center'> Welcome, administrator " + user + ".");
				out.println( "<p align='center'> <a href='manageUserData.jsp'>Manage User Data</a></p>");
				out.println( "<p align='center'> <a href='editReservationForUser.jsp'>List Reservations</a></p>");
				out.println( "<p align='center'> <a href='manageAircrafts.jsp'>Revenue Query</a></p>");
				out.println( "<p align='center'> <a href='manageAirlines.jsp'>Sales Report</a></p>");
				out.println( "<p align='center'> <a href='manageAirports.jsp'>Who's The Whale?</a></p>");
				out.println( "<p align='center'> <a href='listFlightsByActivity.jsp'>List Flights By Activity</a></p>");
				out.println( "<p align='center'> <a href='listFlightsByAirport.jsp'>List Flights By Airport</a></p>");
				out.println("<p align='center'> <a href='../logout.jsp'>Logout</a></p>"); 
			}
			else
				out.println("Invalid password, please try again." + "<p align='left'> <a href='../logout.jsp'>Home</a> </p>"); 
		}
		
		else
			out.println("Invalid username, please try again." + "<p align='left'> <a href='../logout.jsp'>Home</a> </p>"); 

	%>

</body>
</html>
