package achiever_web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Register_servlet")   // ✅ FIXED NAME
public class Register_servlet extends HttpServlet{
	

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get form data
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String className = request.getParameter("className");

        String[] subjects = request.getParameterValues("subjects");

        String subjectList = "";

        if (subjects != null) {
            subjectList = String.join(", ", subjects);
        }

        // Validation
        if (fullname == null || email == null || mobile == null || password == null || className == null ||
            fullname.isEmpty() || email.isEmpty() || mobile.isEmpty() || password.isEmpty() || className.isEmpty()) {

            out.println("<h3 style='color:red'>All fields are required!</h3>");
            return;
        }

        try (Connection con = Dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
            	 "INSERT INTO users(fullname,email,mobile,password,className,subjects) VALUES(?,?,?,?,?,?)")) {

            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, mobile);
            ps.setString(4, password);
            ps.setString(5, className);
            ps.setString(6, subjectList);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("login.html");
            } else {
                out.println("<h3 style='color:red'>Registration failed!</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red'>" + e.getMessage() + "</h3>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.getWriter().println("RegisterServlet is working!");
    }
}