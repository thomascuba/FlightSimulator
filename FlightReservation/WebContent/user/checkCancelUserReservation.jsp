<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cancel Reservation Results</title>
</head>
<body>

	<%
		String ticketNo = request.getParameter("reservationNo");
		System.out.println(ticketNo);
		try { 
	        int i = Integer.parseInt(ticketNo); 
	        String user = (String)(request.getSession().getAttribute("username")); 
	        Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
					+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
					+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 			
			String str = "SELECT * FROM reservation WHERE reservationNo=" + i + " AND username LIKE \"" + user + "\"";
			System.out.println(str);
			Statement st = con.createStatement();
			ResultSet result = st.executeQuery(str);
			if(!result.next()) {
		    	out.println("Invalid reservation number for given user. <a href='checkUserLoginDetails.jsp'>Home</a>");
			}
			else {
				str = "SELECT * FROM ticket WHERE reservationNo=" + i;
				System.out.println(str);
				st = con.createStatement();
				ResultSet allTickets = st.executeQuery(str);
				
				while(allTickets.next()) {
					String currTicket = allTickets.getString("ticketNo");
					str = "SELECT * FROM componentOf WHERE ticketNo = " + currTicket;
					System.out.println(str);
					st = con.createStatement();
					ResultSet allComponents = st.executeQuery(str);
					while(allComponents.next()) {
						String currFlightID = allComponents.getString("flightID");
						String currAirlineID = allComponents.getString("airlineID");
						String currQueuePos = allComponents.getString("queuePos");
						str = "UPDATE componentOf SET queuePos = queuePos - 1 WHERE flightID = " + currFlightID + " AND airlineID LIKE '" + currAirlineID + "' AND queuePos > " + currQueuePos;
						System.out.println(str);
						st = con.createStatement();
						st.executeUpdate(str);
												
					}
				}
				
				

				
				str = "DELETE FROM reservation WHERE reservationNo=" + i + " AND username LIKE \"" + user + "\"";
				System.out.println(str);
				st = con.createStatement();
				st.executeUpdate(str);
				out.println("Reservation cancelled successfully. <a href='checkUserLoginDetails.jsp'>Home</a>");
			}
	    } catch(Exception e) {
	    	out.println(e);
	    	out.println("Invalid reservation number for given user. 	<a href='checkUserLoginDetails.jsp'>Home</a>");
	    }				
			
	%>
</body>
</html>