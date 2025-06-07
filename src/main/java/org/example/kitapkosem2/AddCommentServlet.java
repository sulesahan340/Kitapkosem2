package org.example.kitapkosem2;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/AddCommentServlet")
public class AddCommentServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/kitapkosem";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Sule_sahan340";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("kullanici_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int kullaniciId = (Integer) session.getAttribute("kullanici_id");
        int kitapId = Integer.parseInt(request.getParameter("kitapId"));
        String yorum = request.getParameter("yorum");
        int puan = Integer.parseInt(request.getParameter("puan"));

        if (puan < 1 || puan > 5 || yorum == null || yorum.trim().isEmpty()) {
            response.sendRedirect("kitapDetay.jsp?id=" + kitapId);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "INSERT INTO yorumlar (kitap_id, kullanici_id, yorum, puan) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, kitapId);
            stmt.setInt(2, kullaniciId);
            stmt.setString(3, yorum);
            stmt.setInt(4, puan);

            stmt.executeUpdate();

            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("kitapDetay.jsp?id=" + kitapId);
    }
}

