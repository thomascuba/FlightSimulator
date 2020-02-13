<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Flight List By Activity</title>
</head>
<body>
	<h2>
		<b>Flight List By Activity</b>
	</h2>
	<p> 
	<a href='checkAdminLoginDetails.jsp'>Home</a></p> 
	<%
		ArrayList<String[]>stuff = new ArrayList<String[]>();
		try {

			
			//System.out.println(filterBy + " " + sortBy + " " + filterData + " " + filterType + " " + user + " " + pass);

			Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
					+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
					+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 	
			
			String str = "SELECT * FROM flight";			
			System.out.println(str);
			Statement st = con.createStatement();
			ResultSet result = st.executeQuery(str);
			
	%>


	<table border="5" bgcolor="white" cellspacing="4" cellpadding="4">
		<tr bgcolor="pink">
			<th>Airline ID</th>
			<th>Flight Number</th>
			<th>Tickets Sold</th>
			<th>Date</th>		
			<th>Departure Airport</th>
			<th>Arrival Airport</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Price</th>
			<th>Type</th>
		</tr>

		<%
				while (result.next()) {
					str = "SELECT COUNT(*) AS 'numTickets' FROM componentOf WHERE airlineID LIKE '" + result.getString("airlineID") + "' AND flightID = " +  result.getString("flightID");
					String[] currStuff = new String[10];
					System.out.println(str);
					st = con.createStatement();
					ResultSet countTickets = st.executeQuery(str);														
					countTickets.next();
					
					String type = result.getString("type");
					if(type == null || type.compareTo("") == 0)
						type = "Unknown";
					else if(type.compareTo("0") == 0)
						type = "Domestic";
					else
						type = "International";
										
					currStuff[0] = result.getString("airlineID");
					currStuff[1] = result.getString("flightID");
					currStuff[2] = countTickets.getString("numTickets");
					currStuff[3] = result.getString("date");			
					currStuff[4] = result.getString("depAirp");
					currStuff[5] = result.getString("arrAirp");
					currStuff[6] = result.getString("deptTime");
					currStuff[7] = result.getString("arrTime");
					currStuff[8] = result.getString("price");
					currStuff[9] = type;
					
					stuff.add(currStuff);
					System.out.println("stuff added");
				}
				Collections.sort(stuff, new Comparator<String[]>(){
				    @Override
				    public int compare(String[] s1, String[] s2){
						return(Integer.parseInt(s2[2]) - Integer.parseInt(s1[2]));
				    }
				});
				for(int i = 0; i < stuff.size(); i++) { %>
				
				<tr bgcolor="pink">
					<td><%=stuff.get(i)[0]%></td>
					<td><%=stuff.get(i)[1]%></td>	
					<td><%=stuff.get(i)[2]%></td>				
					<td><%=stuff.get(i)[3]%></td>				
					<td><%=stuff.get(i)[4]%></td>				
					<td><%=stuff.get(i)[5]%></td>				
					<td><%=stuff.get(i)[6]%></td>				
					<td><%=stuff.get(i)[7]%></td>		
					<td><%=stuff.get(i)[8]%></td>				
					<td><%=stuff.get(i)[9]%></td>													
				</tr>			
				<% 
				}
		%>
		
	</table>
	<%
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>
