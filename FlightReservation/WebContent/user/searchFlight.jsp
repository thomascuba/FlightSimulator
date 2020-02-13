<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h2>
		<b>Flight List</b>
	</h2>
	<p> 
	<a href='checkUserLoginDetails.jsp'>Home</a></p> 
	<%
		int total;
		int reserveIndex;
		ArrayList<String> airlineIDs = new ArrayList<String>();
		ArrayList<String> flightIDs = new ArrayList<String>();
		try {

			String filterBy = request.getParameter("filterBy");
			String filterType = request.getParameter("filterType");
			String sortBy = request.getParameter("sortBy"); 
			String filterData = request.getParameter("filterData"); 
			String user = (String)request.getSession().getAttribute("username"); 
			String pass = (String)request.getSession().getAttribute("password"); 

			
			//System.out.println(filterBy + " " + sortBy + " " + filterData + " " + filterType + " " + user + " " + pass);

			Class.forName("com.mysql.jdbc.Driver"); 
			java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
					+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
					+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 			
			String str = "SELECT * FROM flight";
			
			if(filterBy != null && filterData != null && filterBy.compareTo("") != 0) {
				if(filterBy.compareTo("price") == 0) {
					 try { 
					        int i = Integer.parseInt(filterData); 
					        str += " WHERE price";
							if(filterType == null || filterType.compareTo("") == 0) {
								str += " = ";
							}
							else {
								str += " " + filterType + " ";
							}
							str += i;
					    } catch(Exception e) {}				
				}
				else if(filterBy.compareTo("airlineID") == 0) {
					str += " WHERE airlineID LIKE \"" + filterData +"\"";
				}
			}
			
			if(sortBy != null && sortBy.compareTo("") != 0) {
				str += " ORDER BY " + sortBy;
			}
			
			System.out.println(str);
			Statement st = con.createStatement();
			ResultSet result = st.executeQuery(str);
			
			st = con.createStatement();
			str = "SELECT airlineID FROM airline";
			ResultSet airlines = st.executeQuery(str);
			
			st = con.createStatement();
			str = "SELECT airportID FROM airport";
			ResultSet airports = st.executeQuery(str);
			
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
			<th>Type</th>
		</tr>

		<%
				while (result.next()) {
					flightIDs.add(result.getString("flightID"));
					airlineIDs.add(result.getString("airlineID"));
					String type = result.getString("type");
					if(type == null || type.compareTo("") == 0)
						type = "Unknown";
					else if(type.compareTo("0") == 0)
						type = "Domestic";
					else
						type = "International";
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
			<td><%=type%></td>								
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

	<br>
	<form method="post" action="searchFlight.jsp">
		<table id = "table">
			<tr>
				<td>Sort by:</td>
				<td><select name="sortBy" size=1>
				<option value=""></option>
				<option value="price">Price</option>
				<option value="deptTime">Departure Time</option>	
				<option value="arrTime">Arrival Time</option>
				</select>&nbsp;<br></td>
			</tr>
			<tr>
				<td>Filter by:</td>
				
				<td>
				
				<select name="filterBy" size=1>
				<option value=""></option>
				<option value="price">Price</option>
				<option value="airlineID">Airline</option>	
				</select>&nbsp;
				
				<select name="filterType" size=1>
				<option value=""></option>
				<option value="=">=</option>	
				<option value="<="><</option>
				<option value=">=">></option>	
				</select>&nbsp;
				
				<input type="text" name="filterData"><br>
				
				</td>
			</tr>
		</table>
		
			 <br> <input type="submit" value="Submit Query">
	</form>
	<br>
</body>
</html>
