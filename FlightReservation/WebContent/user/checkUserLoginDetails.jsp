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
 
	System.out.println(user);
	System.out.println(pass);
	Class.forName("com.mysql.jdbc.Driver"); 
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
			+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
			+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
	String str = "SELECT * FROM user WHERE username = '" + user + "'";
	Statement st= con.createStatement(); 
	ResultSet rs=st.executeQuery(str);
    
	if(rs.next()) 
	{ 
	
		
		if(rs.getString(2).equals(pass)) 
		{ 

			out.println( "<p align='center'> Welcome, " + user + ".</p>");
			out.println( "<p align='center'> <a href='searchFlight.jsp'>Search Flights</a></p>");
			out.println( "<p align='center'> <a href='buyTicket.jsp'>Buy Ticket</a></p>");
			out.println( "<p align='center'> <a href='addFlightToTicket.jsp'>Add Flight To A Ticket</a></p>");
			out.println( "<p align='center'> <a href='showReservation.jsp'>My Reservations</a></p>");
			out.println( "<p align='center'> <a href='cancelReservation.jsp'>Cancel Reservation</a></p>");
			out.println("<p align='center'> <a href='../logout.jsp'>Logout</a></p>"); 
		} 
		
		else 
		{ 
			out.println("Invalid password, please try again." + "<p align='left'> <a href='../logout.jsp'>Home</a> </p>"); 
		} 
	}
	
	else
		out.println("Invalid username, please try again." + "<p align='left'> <a href='../logout.jsp'>Home</a> </p>"); 
	%>

</body>
</html>
