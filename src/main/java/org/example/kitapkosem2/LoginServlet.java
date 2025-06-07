package org.example.kitapkosem2;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String kullanici_adi = request.getParameter("kullanici_adi");
        String sifre = request.getParameter("sifre");

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM kullanici WHERE kullanici_adi = ? AND sifre = ?";


            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, kullanici_adi);
            stmt.setString(2, sifre);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();
                session.setAttribute("kullanici_adi", kullanici_adi);
                session.setAttribute("kullanici_id", rs.getInt("id"));
                response.sendRedirect("kitaplar.jsp");
            } else {

                request.setAttribute("hata", "Kullanıcı adı veya şifre yanlış.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException("Veritabanı hatası: " + e.getMessage());
        }
    }
}
