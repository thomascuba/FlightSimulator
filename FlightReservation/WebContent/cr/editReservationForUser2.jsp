<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<% String user = request.getParameter("username"); %>
<title>My Reservations</title>
</head>
<body>
	<h2>
		<b>Reservation List For <%=user%></b>
	</h2>
	<p> 
	
	<%
		int total;
		int reserveIndex;
		String removedFlightID = request.getParameter("removedFlightID");
		String removedAirlineID = request.getParameter("removedAirlineID");
		String ticketFlightRemovedFrom = request.getParameter("ticketFlightRemovedFrom");
		String addedFlightID = request.getParameter("addedFlightID");
		String addedAirlineID = request.getParameter("addedAirlineID");
		String ticketFlightAddedTo = request.getParameter("ticketFlightAddedTo");
		String removedTicket = request.getParameter("removedTicket");
		String removedReservation = request.getParameter("removedReservation");
			Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
					+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
					+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
			String str = "select * from user where username='" + user + "'";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(str);
		    if (!rs.next()) {
		        out.println("The given user does not exist. <a href='checkCRLoginDetails.jsp'>Home</a>");
		        return;
		    } else {
		    	out.println("<a href='checkCRLoginDetails.jsp'>Home</a></p>");
				//System.out.println(filterBy + " " + sortBy + " " + filterData + " " + filterType + " " + user + " " + pass);
				
				if(removedReservation != null && removedReservation.compareTo("") != 0) {
					str = "SELECT * FROM ticket WHERE reservationNo=" + removedReservation;
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
					str = "DELETE FROM reservation WHERE reservationNo=" + removedReservation;
					st = con.createStatement();
					st.executeUpdate(str);
				}
					
				
				else if(removedTicket != null && removedTicket.compareTo("")!= 0) {
					str = "SELECT * FROM componentOf WHERE ticketNo = " + removedTicket;
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
					str = "DELETE FROM ticket WHERE ticketNo=" + removedTicket;
					st = con.createStatement();
					st.executeUpdate(str);
				}	
				
				else if(removedFlightID != null && removedFlightID.compareTo("") != 0 && removedAirlineID != null && removedAirlineID.compareTo("") != 0 && ticketFlightRemovedFrom != null && ticketFlightRemovedFrom.compareTo("") != 0) {
					str = "SELECT queuePos FROM componentOf WHERE flightID = " + removedFlightID + " AND airlineID LIKE '" + removedAirlineID + "' AND ticketNo = " + ticketFlightRemovedFrom;
					System.out.println(str);
					st = con.createStatement();
					ResultSet currQueueNo = st.executeQuery(str);
					if(!currQueueNo.next()) {
						System.out.println("Error with queues.");
					}
					else {
						String currQueuePos = currQueueNo.getString("queuePos");
						str = "UPDATE componentOf SET queuePos = queuePos - 1 WHERE flightID = " + removedFlightID + " AND airlineID LIKE '" + removedAirlineID + "' AND queuePos > " + currQueuePos;
						System.out.println(str);
						st = con.createStatement();
						st.executeUpdate(str);
					}
					
					str = "DELETE FROM componentOf WHERE flightID=" + removedFlightID + " AND airlineID LIKE '" + removedAirlineID + "' AND ticketNo=" + ticketFlightRemovedFrom;
					st = con.createStatement();
					st.executeUpdate(str);
				}	
				
				else if(addedFlightID != null && addedFlightID.compareTo("") != 0 && addedAirlineID != null && addedAirlineID.compareTo("") != 0 && ticketFlightAddedTo != null && ticketFlightAddedTo.compareTo("") != 0) {
					str = "SELECT * FROM flight WHERE flightID=" + addedFlightID;
					System.out.println(str);
					st = con.createStatement();
					ResultSet flightIDCheck = st.executeQuery(str);
					
					str = "SELECT * FROM componentOf WHERE flightID=" + addedFlightID + " AND airlineID LIKE '" + addedAirlineID + "' AND ticketNo=" + ticketFlightAddedTo;
					System.out.println(str);
					st = con.createStatement();
					ResultSet componentCheck = st.executeQuery(str);
					
					if(flightIDCheck.next() && !componentCheck.next()) {

						int newQueuePos = -1;
						str = "SELECT MAX(queuePos) AS highestQueuePos FROM componentOf WHERE airlineID LIKE '" + addedAirlineID + "' AND flightID = " + addedFlightID;
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
						
						str = "INSERT INTO componentOf(ticketNo, flightID, airlineID, queuePos) VALUES(" + ticketFlightAddedTo + ", " + addedFlightID + ", \"" + addedAirlineID + "\", " + newQueuePos + ")";
						System.out.println(str);
						st = con.createStatement();
						st.executeUpdate(str);
					}
				}	
				
				str = "SELECT reservationNo, username FROM reservation WHERE username LIKE \"" + user + "\"";
				//str = "SELECT airlineID, flightID, deptTime, arrTime, depAirp, arrAirp, price, date FROM flight";
				
				System.out.println(str);
				st = con.createStatement();
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
															System.out.println(capacity);
															System.out.println(currQueuePos);
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
				} %> <br>
		     <form action="editReservationForUser2.jsp" method="POST">
		      Add flight with flightID <input type="text" name="addedFlightID"/> 
		       and airlineID 
		       <% str = "SELECT * from airline";
				st = con.createStatement();
				ResultSet resultAirlines = st.executeQuery(str);
				%>
		       <select name="addedAirlineID" size=1>
				<%
					while(resultAirlines.next()) {
				%>
					<option value=<%=resultAirlines.getString("airlineID") %>><%=resultAirlines.getString("airlineID") %></option>
					<%} %>
				</select>&nbsp;
				to ticket number
				<select name="ticketFlightAddedTo" size=1>
				<option value=""></option>
				<%
					str = "SELECT ticketNo FROM ticket WHERE username LIKE '" + user + "'";
					System.out.println(str);
					st = con.createStatement();
					ResultSet resultTickets = st.executeQuery(str);
					while(resultTickets.next()) {
				%>
					<option value=<%=resultTickets.getString("ticketNo") %>><%=resultTickets.getString("ticketNo") %></option>
					<%} %>
				</select>&nbsp;<br>
		       Remove flight with flightID <input type="text" name="removedFlightID"/> 
		       and airlineID 
		       <% str = "SELECT * from airline";
				st = con.createStatement();
				resultAirlines = st.executeQuery(str);
				%>
		       <select name="removedAirlineID" size=1>
				<%
					while(resultAirlines.next()) {
				%>
					<option value=<%=resultAirlines.getString("airlineID") %>><%=resultAirlines.getString("airlineID") %></option>
					<%} %>
				</select>&nbsp;
				from ticket number
				<select name="ticketFlightRemovedFrom" size=1>
				<option value=""></option>
				<%
					str = "SELECT ticketNo FROM ticket WHERE username LIKE '" + user + "'";
					System.out.println(str);
					st = con.createStatement();
					resultTickets = st.executeQuery(str);
					while(resultTickets.next()) {
				%>
					<option value=<%=resultTickets.getString("ticketNo") %>><%=resultTickets.getString("ticketNo") %></option>
					<%} %>
				</select>&nbsp;<br>
				Delete ticket <select name="removedTicket" size=1>
				<option value=""></option>
				<%
					str = "SELECT ticketNo FROM ticket WHERE username LIKE '" + user + "'";
					System.out.println(str);
					st = con.createStatement();
					resultTickets = st.executeQuery(str);
					while(resultTickets.next()) {
				%>
					<option value=<%=resultTickets.getString("ticketNo") %>><%=resultTickets.getString("ticketNo") %></option>
					<%} %>
				</select>&nbsp;<br>
		       Remove reservation
		       <select name="removedReservation" size=1>
				<option value=""></option>
				<%
					str = "SELECT reservationNo FROM reservation WHERE username LIKE '" + user + "'";
					System.out.println(str);
					st = con.createStatement();
					resultReservations = st.executeQuery(str);
					while(resultReservations.next()) {
				%>
					<option value=<%=resultReservations.getString("reservationNo") %>><%=resultReservations.getString("reservationNo") %></option>
					<%} %>
				</select>&nbsp;<br>
				<input type="hidden" name="username" value=<%=user%> />
		       <input type="submit" value="Submit"/>
		     </form>
		<% } 

	%>
</body>
</html>