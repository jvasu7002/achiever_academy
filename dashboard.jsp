<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String name = (String) session.getAttribute("name");
String email = (String) session.getAttribute("email");
String className = (String) session.getAttribute("className");
String subjects = (String) session.getAttribute("subjects");

if(name == null){
    response.sendRedirect("login.html");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Dashboard</title>

<style>

/* =========================
   GLOBAL
========================= */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Segoe UI',sans-serif;
    background:linear-gradient(135deg,#eef2ff,#f4f6fb);
    color:#222;
}

/* =========================
   SIDEBAR
========================= */
.sidebar{
    width:250px;
    height:100vh;
    background:linear-gradient(180deg,#1e3a8a,#2563eb);
    color:white;
    position:fixed;
    left:0;
    top:0;
    padding-top:30px;
}

.sidebar h2{
    text-align:center;
    margin-bottom:35px;
    font-size:32px;
}

.sidebar a{
    display:block;
    padding:14px 25px;
    color:white;
    text-decoration:none;
    font-size:18px;
    margin:8px 15px;
    transition:0.3s;
}

.sidebar a:hover{
    background:rgba(255,255,255,0.2);
    border-radius:8px;
}

.logout{
    background:red;
    text-align:center;
    border-radius:8px;
    margin-top:25px;
}

/* =========================
   MAIN CONTENT
========================= */
.main{
    margin-left:250px;
    padding:40px;
}

.welcome{
    font-size:38px;
    font-weight:bold;
    margin-bottom:25px;
    color:#1e3a8a;
}

/* =========================
   PROFILE CARD
========================= */
.card{
    background:rgba(255,255,255,0.85);
    backdrop-filter:blur(10px);
    padding:30px;
    border-radius:18px;
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
    width:100%;
    max-width:800px;
    margin-bottom:30px;
}

.card h3{
    margin-bottom:20px;
    color:#1e3a8a;
    font-size:28px;
}

.card p{
    margin:12px 0;
    font-size:18px;
}

/* =========================
   SUBJECT CARDS
========================= */
.subject-container{
    display:flex;
    gap:15px;
    flex-wrap:wrap;
}

.subject-card{
    background:white;
    padding:15px 25px;
    border-radius:12px;
    box-shadow:0 5px 15px rgba(0,0,0,0.08);
    font-weight:bold;
    transition:0.3s;
    font-size:17px;
}

.subject-card:hover{
    transform:translateY(-5px);
    background:#2563eb;
    color:white;
}

/* =========================
   MOBILE RESPONSIVE
========================= */
@media screen and (max-width: 768px){

    .sidebar{
        width:100%;
        height:auto;
        position:relative;
        padding:20px 10px;
        text-align:center;
    }

    .sidebar h2{
        font-size:28px;
        margin-bottom:20px;
    }

    .sidebar a{
        width:90%;
        margin:8px auto;
        padding:12px;
        font-size:18px;
    }

    .main{
        margin-left:0;
        width:100%;
        padding:20px;
        text-align:center;
    }

    .welcome{
        font-size:32px;
        line-height:1.4;
    }

    .card{
        width:100%;
        padding:25px 18px;
        margin:20px auto;
    }

    .card h3{
        font-size:24px;
    }

    .card p{
        font-size:16px;
    }

    .subject-container{
        flex-direction:column;
        align-items:center;
    }

    .subject-card{
        width:100%;
        text-align:center;
        padding:14px;
        font-size:18px;
    }

    .logout{
        width:90%;
        margin:20px auto;
    }
}

@media screen and (max-width: 480px){

    .welcome{
        font-size:28px;
    }

    .sidebar h2{
        font-size:24px;
    }

    .sidebar a{
        font-size:16px;
    }

    .card h3{
        font-size:22px;
    }

    .subject-card{
        font-size:16px;
    }
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

    <!-- Student Details -->
    <div class="card">

        <h3>Student Details</h3>

        <p><b>Name:</b> <%= name %></p>
        <p><b>Email:</b> <%= email %></p>
        <p><b>Class:</b> <%= className %></p>
        <p><b>Subjects:</b> <%= subjects %></p>

    </div>

    <!-- Subject Cards -->
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
