package org.example.kitapkosem2;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession oturum = request.getSession(false);
        int kullaniciId = (int) oturum.getAttribute("kullanici_id");

        String baslik = request.getParameter("baslik");
        String yazar = request.getParameter("yazar");
        String tur = request.getParameter("tur");
        String aciklama = request.getParameter("aciklama");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kitapkosem", "root", "Sule_sahan340");

            String sql = "INSERT INTO kitap (baslik, yazar, tur, aciklama, kullanici_id) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, baslik);
            stmt.setString(2, yazar);
            stmt.setString(3, tur);
            stmt.setString(4, aciklama);
            stmt.setInt(5, kullaniciId);
            stmt.executeUpdate();

            response.sendRedirect("kitaplar.jsp");
        } catch (Exception e) {
            throw new ServletException("Veritabanı hatası: " + e.getMessage());
        }
    }
}
