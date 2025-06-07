package org.example.kitapkosem2;


import org.example.kitapkosem2.DBUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/dbtest")
public class DBTestServlet2 extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection conn = DBUtil.getConnection()) {
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            out.println("<h2>Veritabanı bağlantısı başarılı!</h2>");
        } catch (Exception e) {
            throw new ServletException("Veritabanı bağlantısı başarısız: " + e.getMessage());
        }
    }
}