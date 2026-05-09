<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String name = (String) session.getAttribute("name");
String email = (String) session.getAttribute("email");
String className = (String) session.getAttribute("className");
String subjects = (String) session.getAttribute("subject");

if(name == null){
    response.sendRedirect("login.html");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Dashboard</title>



<style>

/* Body */
body{
margin:0;
font-family: 'Segoe UI', sans-serif;
background: linear-gradient(135deg,#eef2ff,#f4f6fb);
}

/* Sidebar */
.sidebar{
width:230px;
height:100vh;
background: linear-gradient(180deg,#1e3a8a,#2563eb);
color:white;
position:fixed;
padding-top:20px;
}

.sidebar h2{
text-align:center;
margin-bottom:30px;
}

.sidebar a{
display:block;
padding:12px 20px;
color:white;
text-decoration:none;
transition:0.3s;
}

.sidebar a:hover{
background:rgba(255,255,255,0.2);
border-radius:5px;
}

.logout{
background:red;
margin:20px;
text-align:center;
border-radius:6px;
}

/* Main */
.main{
margin-left:250px;
padding:40px;
}

/* Welcome */
.welcome{
font-size:28px;
font-weight:bold;
margin-bottom:20px;
}

/* Card */
.card{
background:rgba(255,255,255,0.7);
backdrop-filter:blur(10px);
padding:25px;
border-radius:12px;
box-shadow:0 8px 20px rgba(0,0,0,0.1);
width:60%;
}

/* Subject cards */
.subject-container{
display:flex;
gap:15px;
margin-top:20px;
flex-wrap:wrap;
}

.subject-card{
background:white;
padding:15px 25px;
border-radius:10px;
box-shadow:0 5px 15px rgba(0,0,0,0.1);
font-weight:bold;
transition:0.3s;
}

.subject-card:hover{
transform:translateY(-5px);
background:#2563eb;
color:white;
}

</style>

</head>

<body>

<!-- Sidebar -->
<div class="sidebar">

<h2>Dashboard</h2>

<a href="#">🏠 Home</a>
<a href="#">📚 My Courses</a>
<a href="#">👤 Profile</a>

<a href="logout.jsp" class="logout">Logout</a>

</div>

<!-- Main Content -->
<div class="main">

<div class="welcome">
Welcome, <%= name %> 👋
</div>

<!-- Profile Card -->
<div class="card">

<h3>Student Details</h3>

<p><b>Name:</b> <%= name %></p>
<p><b>Email:</b> <%= email %></p>
<p><b>Class:</b> <%= className %></p>
<p><b>Subjects:</b> <%= subjects %></p>

</div>

<!-- Subjects Cards -->
<div class="subject-container">

<%
if(subjects != null){
    String[] arr = subjects.split(",");

    for(String s : arr){
%>

<div class="subject-card">
<%= s.trim() %>
</div>

<%
    }
}
%>

</div>

</div>

</body>
</html>
