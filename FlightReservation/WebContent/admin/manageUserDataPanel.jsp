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
<%
String user = request.getParameter("username");
String operation = request.getParameter("operation");
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://"
		+ "cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/"
		+ "FlightReservation","CS336Group57","H3yhaveyoutriedmountaindewkickstart"); 
String str = "";
Statement st = null;
if(operation != null && operation.compareTo("") != 0) {
	if(operation.compareTo("0") == 0) {
		str = "DELETE FROM user WHERE username = '" + user + "'";
		st = con.createStatement();
		st.executeUpdate(str);
	}
	else if(operation.compareTo("1") == 0) {
		str = "INSERT INTO employee(username) VALUES('" + user + "')";
		st = con.createStatement();
		st.executeUpdate(str);
	}
	else if(operation.compareTo("2") == 0) {
		str = "INSERT INTO admin(username) VALUES('" + user + "')";
		st = con.createStatement();
		st.executeUpdate(str);
	}
	else if(operation.compareTo("3") == 0) {
		str = "DELETE FROM admin WHERE username = '" + user + "'";
		st = con.createStatement();
		st.executeUpdate(str);
		str = "SELECT * FROM employee WHERE username = '" + user + "'";
		st = con.createStatement();
		ResultSet resultCR2 = st.executeQuery(str);
		if(!resultCR2.next()) {
			str = "INSERT INTO employee(username) VALUES('" + user + "')";
			st = con.createStatement();
			st.executeUpdate(str);
		}
			
	}
	else if(operation.compareTo("4") == 0) {
		str = "DELETE FROM employee WHERE username = '" + user + "'";
		st = con.createStatement();
		st.executeUpdate(str);
	}
	
	else if(operation.compareTo("5") == 0) {
		String newUsername = request.getParameter("newUsername");
		str = "UPDATE  user SET username = '" + newUsername + "' WHERE username = '" + user + "'";
		st = con.createStatement();
		st.executeUpdate(str);
	}
	
	else if(operation.compareTo("6") == 0) {
		String newPassword = request.getParameter("newPassword");
		str = "UPDATE  user SET password = '" + newPassword + "' WHERE username = '" + user + "'";
		st = con.createStatement();
		st.executeUpdate(str);
	}
}

str = "SELECT * FROM user WHERE username = '" + user + "'";
st = con.createStatement();
ResultSet resultUser = st.executeQuery(str);

str = "SELECT * FROM employee WHERE username = '" + user + "'";
st = con.createStatement();
ResultSet resultCR = st.executeQuery(str);

str = "SELECT * FROM admin WHERE username = '" + user + "'";
st = con.createStatement();
ResultSet resultAdmin = st.executeQuery(str);

if(!resultUser.next()) {
	out.println("Invalid username. <a href='checkAdminLoginDetails.jsp'>Home</a><br/>");
}
else {
	out.println(" <form action=\"manageUserDataPanel.jsp\" method=\"POST\"><input type=\"hidden\" name=\"operation\" value=\"6\"><input type=\"hidden\" name=\"username\" value=" + user + "><input type=\"text\" name=\"newPassword\"/>	<input type=\"submit\" value=\"Change Password\"/>	</form> <form action=\"manageUserDataPanel.jsp\" method=\"POST\"><input type=\"hidden\" name=\"operation\" value=\"5\"><input type=\"hidden\" name=\"username\" value=" + user + "><input type=\"text\" name=\"newUsername\"/>	<input type=\"submit\" value=\"Change Username\"/>	</form>");
	if(resultAdmin.next())
		out.println(" <form action=\"manageUserDataPanel.jsp\" method=\"POST\"><input type=\"hidden\" name=\"operation\" value=\"3\"><input type=\"hidden\" name=\"username\" value=" + user + "><input type=\"submit\" value=\"Demote to Customer Service Rep\"/>	</form>");
	else if(resultCR.next()) 
		out.println(" <form action=\"manageUserDataPanel.jsp\" method=\"POST\"><input type=\"hidden\" name=\"operation\" value=\"4\"><input type=\"hidden\" name=\"username\" value=" + user + "><input type=\"submit\" value=\"Demote to User\"/>	</form> <form action=\"manageUserDataPanel.jsp\" method=\"POST\"><input type=\"hidden\" name=\"operation\" value=\"2\"><input type=\"hidden\" name=\"username\" value=" + user + "><input type=\"submit\" value=\"Promote to Admin\"/>	</form>");
	else
		out.println(" <form action=\"manageUserDataPanel.jsp\" method=\"POST\"><input type=\"hidden\" name=\"operation\" value=\"1\"><input type=\"hidden\" name=\"username\" value=" + user + "><input type=\"submit\" value=\"Promote to Customer Service Rep\"/>	</form>");
	out.println(" <form action=\"manageUserDataPanel.jsp\" method=\"POST\"><input type=\"hidden\" name=\"operation\" value=\"0\"><input type=\"hidden\" name=\"username\" value=" + user + "><input type=\"submit\" value=\"Delete User\"/>	</form>");
	out.println("<a href='checkAdminLoginDetails.jsp'>Home</a><br/>");

}
%>



</body>
</html>