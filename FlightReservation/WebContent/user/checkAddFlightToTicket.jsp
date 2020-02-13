<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Flight Results</title>
</head>
<body>

	<%
		String airlineID = request.getParameter("airlineID");
		String flightID = request.getParameter("flightID");
		String ticketNo = request.getParameter("ticketNo");
		Statement st;
		String str;
		try {
	        String user = (String)(request.getSession().getAttribute("username")); 
	        Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
					+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
					+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 			
			if(ticketNo != null && ticketNo.compareTo("") != 0){
	        	int i = Integer.parseInt(ticketNo); 
	        	str = "SELECT * FROM ticket WHERE ticketNo=" + i + " AND username LIKE \"" + user + "\"";
				System.out.println(str);
				st = con.createStatement();
				ResultSet result = st.executeQuery(str);
				if(!result.next()) {
			    	out.println("Invalid ticket number for given user. 	<a href='checkUserLoginDetails.jsp'>Home</a>");
				}
				else if(flightID != null && airlineID != null){
					int j = Integer.parseInt(flightID);
					str = "SELECT * FROM flight WHERE airlineID LIKE \"" + airlineID + "\" AND flightID =" + j;
					System.out.println(str);
					st = con.createStatement();
					ResultSet result2 = st.executeQuery(str);
					if(!result2.next()) {
				    	out.println("Invalid airlineID or flightID. <a href='checkUserLoginDetails.jsp'>Home</a>");
					}
					else {
						
						int newQueuePos = -1;
						str = "SELECT MAX(queuePos) AS highestQueuePos FROM componentOf WHERE airlineID LIKE '" + airlineID + "' AND flightID = " + flightID;
						System.out.println(str);
						st = con.createStatement();
						ResultSet resultQueuePos = st.executeQuery(str);
						while(resultQueuePos.next()) {
							System.out.println(resultQueuePos.getString("highestQueuePos"));
							if(resultQueuePos.getString("highestQueuePos") != null)
								newQueuePos = Integer.parseInt(resultQueuePos.getString("highestQueuePos")) + 1;
						}
						if(newQueuePos == -1)
							newQueuePos = 1;
						
						str = "INSERT INTO componentOf(ticketNo, flightID, airlineID, queuePos) VALUES(" + i + ", " + j + ", \"" + airlineID + "\", " + newQueuePos + ")";
						System.out.println(str);
						st = con.createStatement();
						st.executeUpdate(str);
						
						str = "SELECT a.capacity FROM aircraft a, flight f WHERE a.aircraftID = f.aircraftID AND f.airlineID LIKE '" + airlineID + "' AND f.flightID = " + flightID; 
						System.out.println(str);
						st = con.createStatement();
						ResultSet aircraftCapacity = st.executeQuery(str);
						
						if(!aircraftCapacity.next()) {
							System.out.println("Error with queues.");
							out.println("Flight successfully added to ticket. <a href='checkUserLoginDetails.jsp'>Home</a>");
						}
						else {
							String capacity = aircraftCapacity.getString("capacity");
							if(Integer.parseInt(capacity) < newQueuePos) {
								out.println("Flight successfully added to ticket, but the flight is full. Your queue position is " + (newQueuePos - Integer.parseInt(capacity)) + ". <a href='checkUserLoginDetails.jsp'>Home</a>");
							}
							else {
								out.println("Flight successfully added to ticket. <a href='checkUserLoginDetails.jsp'>Home</a>");
							}
						}
						
					}
				}
			}
			else {
		    	out.println("Invalid input for given user. 	<a href='checkUserLoginDetails.jsp'>Home</a>");
			}
	    } catch(Exception e) {
	    	out.println(e);
	    	out.println("Invalid input for given user. 	<a href='checkUserLoginDetails.jsp'>Home</a>");
	    }				
			
	%>
</body>
</html>