<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ticket Purchase Results</title>
</head>
<body>

	<%
		String airlineID = request.getParameter("airlineID");
		String flightID = request.getParameter("flightID");
		String reservationNo = request.getParameter("reservationNo");
		String type = request.getParameter("type");
		String flex = request.getParameter("flex");
		String cls = request.getParameter("class");
		if(flex == null) {
			flex = "0";
		}
		//System.out.println(type + " " + flex + "end");
		//System.out.println(airlineID + " " + flightID + " " + reservationNo);
		Statement st;
		String str;
		try {
	        String user = request.getParameter("username");
	        System.out.println(user);
	        Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
					+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
					+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart");
			str = "SELECT * FROM user WHERE username LIKE \"" + user + "\"";
			System.out.println(str);
			st = con.createStatement();
			ResultSet resultUser = st.executeQuery(str);
			if(user != null && user.compareTo("") != 0 && resultUser.next()) {
				if(reservationNo.compareTo("new") != 0) {
					int i = Integer.parseInt(reservationNo);
		        	str = "SELECT * FROM reservation WHERE reservationNo=" + reservationNo + " AND username LIKE \"" + user + "\"";
					System.out.println(str);
					st = con.createStatement();
					ResultSet result = st.executeQuery(str);
					if(!result.next()) {
				    	out.println("Invalid reservation number for given user. <a href='checkCRLoginDetails.jsp'>Home</a>");
					}
					else if(flightID != null && airlineID != null && flightID.compareTo("") != 0){
						
						int j = Integer.parseInt(flightID);
						str = "SELECT * FROM flight WHERE airlineID LIKE \"" + airlineID + "\" AND flightID =" + j;
						System.out.println(str);
						st = con.createStatement();
						ResultSet result2 = st.executeQuery(str);
						if(!result2.next()) {
					    	out.println("Invalid airlineID or flightID. <a href='checkCRLoginDetails.jsp'>Home</a>");
						}
						else {
							int newTicketNo = -1;
							str = "SELECT MAX(ticketNo) AS highestTicket FROM ticket";
							System.out.println(str);
							st = con.createStatement();
							ResultSet resultTicketNo = st.executeQuery(str);
							while(resultTicketNo.next()) {
								System.out.println(resultTicketNo.getString("highestTicket"));
								if(resultTicketNo.getString("highestTicket") != null)
									newTicketNo = Integer.parseInt(resultTicketNo.getString("highestTicket")) + 1;
							}
							if(newTicketNo == -1)
								newTicketNo = 0;
							
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
							
							str = "INSERT INTO ticket(username, ticketNo, type, flex, class, reservationNo) VALUES(\"" + user + "\", " + newTicketNo + ", " + type + ", " + flex + ", " + cls + ", " + i + ")";
							System.out.println(str);
							st = con.createStatement();
							st.executeUpdate(str);
							
							str = "INSERT INTO componentOf(ticketNo, flightID, airlineID, queuePos) VALUES(" + newTicketNo + ", " + j + ", \"" + airlineID + "\", " + newQueuePos + ")";
							System.out.println(str);
							st = con.createStatement();
							st.executeUpdate(str);
							
							str = "SELECT a.capacity FROM aircraft a, flight f WHERE a.aircraftID = f.aircraftID AND f.airlineID LIKE '" + airlineID + "' AND f.flightID = " + flightID; 
							System.out.println(str);
							st = con.createStatement();
							ResultSet aircraftCapacity = st.executeQuery(str);
							if(!aircraftCapacity.next()) {
								System.out.println("Error with queues.");
								out.println("Ticket successfully added to new reservation! Your new ticket number is " + newTicketNo +". <a href='checkCRLoginDetails.jsp'>Home</a>");
							}
							else {
								String capacity = aircraftCapacity.getString("capacity");
								if(Integer.parseInt(capacity) < newQueuePos) {
									out.println("Ticket successfully added to reservation number " + i + ", but the flight is full. Your queue position is " + (newQueuePos - Integer.parseInt(capacity)) + ". Your new ticket number is " + newTicketNo +". <a href='checkCRLoginDetails.jsp'>Home</a>");
								}
								else {
									out.println("Ticket successfully added to reservation number " + i + ". Your new ticket number is " + newTicketNo +". <a href='checkCRLoginDetails.jsp'>Home</a>");
								}
							}
							
						}
					}
				}
				else if(flightID != null && airlineID != null && flightID.compareTo("") != 0) {
					System.out.println("new reservation");
					int newReservationNo = -1;
					str = "SELECT MAX(reservationNo) AS highestReservation FROM reservation";
					System.out.println(str);
					st = con.createStatement();
					ResultSet resultReservationNo = st.executeQuery(str);
					while(resultReservationNo.next()) {
						System.out.println(resultReservationNo.getString("highestReservation"));
						if(resultReservationNo.getString("highestReservation") != null)
							newReservationNo = Integer.parseInt(resultReservationNo.getString("highestReservation")) + 1;
					}
					if(newReservationNo == -1)
						newReservationNo = 0;
					
					str = "INSERT INTO reservation(reservationNo, username) VALUES(" + newReservationNo + ", '" + user + "')";
					System.out.println(str);
					st = con.createStatement();
					st.executeUpdate(str);
					
					int j = Integer.parseInt(flightID);
					str = "SELECT * FROM flight WHERE airlineID LIKE \"" + airlineID + "\" AND flightID =" + j;
					System.out.println(str);
					st = con.createStatement();
					ResultSet result2 = st.executeQuery(str);
					if(!result2.next()) {
				    	out.println("Invalid airlineID or flightID. <a href='checkCRLoginDetails.jsp'>Home</a>");
					}
					else {
						int newTicketNo = -1;
						str = "SELECT MAX(ticketNo) AS highestTicket FROM ticket";
						System.out.println(str);
						st = con.createStatement();
						ResultSet resultTicketNo = st.executeQuery(str);
						while(resultTicketNo.next()) {
							System.out.println(resultTicketNo.getString("highestTicket"));
							if(resultTicketNo.getString("highestTicket") != null)
								newTicketNo = Integer.parseInt(resultTicketNo.getString("highestTicket")) + 1;
						}
						if(newTicketNo == -1)
							newTicketNo = 0;
						
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
						
						str = "INSERT INTO ticket(username, ticketNo, type, flex, class, reservationNo) VALUES(\"" + user + "\", " + newTicketNo + ", " + type + ", " + flex + ", " + cls + ", " + newReservationNo + ")";
						System.out.println(str);
						st = con.createStatement();
						st.executeUpdate(str);
						
						str = "INSERT INTO componentOf(ticketNo, flightID, airlineID, queuePos) VALUES(" + newTicketNo + ", " + j + ", \"" + airlineID + "\", " + newQueuePos + ")";
						System.out.println(str);
						st = con.createStatement();
						st.executeUpdate(str);
						
						str = "SELECT a.capacity FROM aircraft a, flight f WHERE a.aircraftID = f.aircraftID AND f.airlineID LIKE '" + airlineID + "' AND f.flightID = " + flightID; 
						System.out.println(str);
						st = con.createStatement();
						ResultSet aircraftCapacity = st.executeQuery(str);
						if(!aircraftCapacity.next()) {
							System.out.println("Error with queues.");
							out.println("Ticket successfully added to new reservation! Your new ticket number is " + newTicketNo +". <a href='checkCRLoginDetails.jsp'>Home</a>");
						}
						else {
							String capacity = aircraftCapacity.getString("capacity");
							if(Integer.parseInt(capacity) < newQueuePos) {
								out.println("Ticket successfully added to new reservation, but the flight is full. Your queue position is " + (newQueuePos - Integer.parseInt(capacity)) + ". Your new ticket number is " + newTicketNo +". <a href='checkCRLoginDetails.jsp'>Home</a>");
							}
							else {
								out.println("Ticket successfully added to new reservation! Your new ticket number is " + newTicketNo +". <a href='checkCRLoginDetails.jsp'>Home</a>");
							}
						}		
						
					}
				}			
				else {
			    	out.println("Invalid input for given user. 	<a href='checkCRLoginDetails.jsp'>Home</a>");
				}
			}
			else {
		    	out.println("Invalid input for given user. 	<a href='checkCRLoginDetails.jsp'>Home</a>");
			}
	    } catch(Exception e) {
	    	out.println(e);
	    	out.println("Invalid input for given user. 	<a href='checkCRLoginDetails.jsp'>Home</a>");
	    }				
			
	%>
</body>
</html>