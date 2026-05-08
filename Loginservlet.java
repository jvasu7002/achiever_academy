package achiever_web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Loginservlet")   // ✅ FIXED URL
public class Loginservlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = Dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT * FROM users WHERE email=? AND password=?")) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                // ✅ Get data from DB
                String name = rs.getString("fullname");
                String className = rs.getString("className");
                String subject = rs.getString("subjects");

                // ✅ Create session
                HttpSession session = request.getSession();

                session.setAttribute("name", name);
                session.setAttribute("email", email);
                session.setAttribute("className", className);
                session.setAttribute("subject", subject);

                // ✅ Redirect to dashboard
                response.sendRedirect("dashboard.jsp");

            } else {

                out.println("<h3 style='color:red'>Invalid Email or Password</h3>");

            }

        } catch (Exception e) {

            e.printStackTrace();
            out.println("<h3 style='color:red'>Database Error: " + e.getMessage() + "</h3>");

        }
    }
}