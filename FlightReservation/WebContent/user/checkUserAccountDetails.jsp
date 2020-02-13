<%@ page import ="java.sql.*" %>
<%
    String username = request.getParameter("username");   
    String pass = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336group57.czwjws1df8fh.us-east-2.rds.amazonaws.com:3306/FlightReservation","CS336Group57", "H3yhaveyoutriedmountaindewkickstart");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from user where username='" + username + "'");
    if(pass == null || pass.compareTo("") == 0)
        out.println("Please enter a password. <a href='../home.jsp'>Home</a>");
    else if (rs.next()) {
        out.println("An account with that username already exists. <a href='../home.jsp'>Home</a>");
    } 
    else {
    	st.executeUpdate("INSERT INTO user VALUES ('" + username + "', '" + pass + "')");
    	out.println("Success! <a href='../home.jsp'>Return home</a>");
    }
%>