<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Reservations</title>
</head>
<body>
	<h2>
		<b>Reservation List</b>
	</h2>
	<p>
	<a href='checkUserLoginDetails.jsp'>Home</a></p> 
	<%
		int total;
		int reserveIndex;
		try {

			String user = (String)request.getSession().getAttribute("username"); 
			String pass = (String)request.getSession().getAttribute("password"); 

			
			//System.out.println(filterBy + " " + sortBy + " " + filterData + " " + filterType + " " + user + " " + pass);

			Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
					+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
					+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
			
			String str = "SELECT reservationNo, username FROM reservation WHERE username LIKE \"" + user + "\"";
			//str = "SELECT airlineID, flightID, deptTime, arrTime, depAirp, arrAirp, price, date FROM flight";
			
			System.out.println(str);
			Statement st = con.createStatement();
			ResultSet resultReservations = st.executeQuery(str);
			String currReservationNo = "";
			
			while(resultReservations.next()) {
				currReservationNo = resultReservations.getString("reservationNo");
				%>
				<p><b>Reservation Number: <%=currReservationNo %></b></p>
				<% 
				str = "SELECT ticketNo, type, flex, class, reservationNo FROM ticket WHERE username LIKE \"" + user + "\" AND reservationNo=" + currReservationNo;
				//str = "SELECT airlineID, flightID, deptTime, arrTime, depAirp, arrAirp, price, date FROM flight";
				
				System.out.println(str);
				st = con.createStatement();
				ResultSet resultTickets = st.executeQuery(str);
				String currTicketNo = "";
				String currType = "";
				String currFlex = "";
				String currClass = "";
				while(resultTickets.next()) {
					currTicketNo = resultTickets.getString("ticketNo");
					currType = resultTickets.getString("type");
					currFlex = resultTickets.getString("flex");
					currClass = resultTickets.getString("class");
					if(currType == null) {
						currType = "Unknown";
					}
					else if(currType.compareTo("0") == 0) 
						currType = "One Way";
					else if(currType.compareTo("1") == 0) 
						currType = "Round Trip";
					
					if(currFlex == null) {
						currFlex = "Unknown";
					}
					else if(currFlex.compareTo("0") == 0) 
						currFlex = "No";
					else if(currFlex.compareTo("1") == 0) 
						currFlex = "Yes";
					
					if(currClass == null) {
						currClass = "Unknown";
					}
					else if(currClass.compareTo("0") == 0) 
						currClass = "Economy";
					else if(currClass.compareTo("1") == 0) 
						currClass = "Business";
					
					if(currTicketNo != null) {
						%>
							<p>Ticket Number: <%=currTicketNo %></p>
							<p>Type: <%=currType%></p>
							<p>Flex: <%=currFlex%></p>
							<p>Class: <%=currClass%></p>	
							<p>Flights:</p>
							<%
								str = "SELECT f.airlineID, f.flightID, f.deptTime, f.arrTime, f.depAirp, f.arrAirp, f.price, f.date, c.queuePos FROM flight f, componentOf c, ticket t WHERE f.airlineID LIKE c.airlineID AND f.flightID=c.flightID AND t.ticketNo=c.ticketNo AND t.ticketNo=" + currTicketNo;
								System.out.println(str);
								st = con.createStatement();
								ResultSet result = st.executeQuery(str);
								%>
								<table border="5" bgcolor="white" cellspacing="4" cellpadding="4">
									<tr bgcolor="pink">
										<th>Airline ID</th>
										<th>Flight Number</th>
										<th>Date</th>		
										<th>Departure Airport</th>
										<th>Arrival Airport</th>
										<th>Departure Time</th>
										<th>Arrival Time</th>
										<th>Price</th>
										<th>Queue Position</th>
									</tr>
				
									<%
											while (result.next()) {
												String currQueuePos = result.getString("queuePos");
												str = "SELECT a.capacity FROM aircraft a, flight f WHERE a.aircraftID = f.aircraftID AND f.airlineID LIKE '" + result.getString("airlineID") + "' AND f.flightID = " + result.getString("flightID"); 
												System.out.println(str);
												st = con.createStatement();
												ResultSet aircraftCapacity = st.executeQuery(str);
												if(!aircraftCapacity.next() || aircraftCapacity.getString("capacity") == null || currQueuePos == null) {
													System.out.println("Error with queues.");
													currQueuePos = "Unknown";
												}
												else {
													String capacity = aircraftCapacity.getString("capacity");
													if(Integer.parseInt(capacity) < Integer.parseInt(currQueuePos)) {
														currQueuePos = "" + (Integer.parseInt(currQueuePos) - Integer.parseInt(capacity));
													}
													else {
														currQueuePos = "On flight";
													}
												}
									%>
				
									<tr bgcolor="pink">
										<td><%=result.getString("airlineID")%></td>
										<td><%=result.getString("flightID")%></td>
										<td><%=result.getString("date")%></td>			
										<td><%=result.getString("depAirp")%></td>
										<td><%=result.getString("arrAirp")%></td>
										<td><%=result.getString("deptTime")%></td>
										<td><%=result.getString("arrTime")%></td>
										<td><%=result.getString("price")%></td>
										<td><%=currQueuePos%></td>							
									</tr>
							
									<%
									} %>
								</table>
						<% 
					}
				}
			}
		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html>