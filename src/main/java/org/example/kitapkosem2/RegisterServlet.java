package org.example.kitapkosem2;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String kullaniciAdi = request.getParameter("kullanici_adi");
        String sifre = request.getParameter("sifre");

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO kullanici (kullanici_adi, sifre) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, kullaniciAdi);
            stmt.setString(2, sifre);
            stmt.executeUpdate();

            response.sendRedirect("login.jsp");
        } catch (Exception e) {
            throw new ServletException("Veritabanı hatası: " + e.getMessage());
        }
    }
}
