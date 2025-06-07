package org.example.kitapkosem2;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/kitaplar")
public class BookListServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/kitapkosem";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Sule_sahan340";

    public static class Book {
        public int id;
        public String baslik;
        public String yazar;
        public String tur;
        public String aciklama;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();


        String misafirParam = request.getParameter("misafir");
        if ("true".equals(misafirParam)) {
            session.setAttribute("misafir", true);
        }

        List<Book> kitaplar = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM kitap");

            while (rs.next()) {
                Book b = new Book();
                b.id = rs.getInt("id");
                b.baslik = rs.getString("baslik");
                b.yazar = rs.getString("yazar");
                b.tur = rs.getString("tur");
                b.aciklama = rs.getString("aciklama");
                kitaplar.add(b);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("kitaplar", kitaplar);
        request.getRequestDispatcher("kitaplar.jsp").forward(request, response);
    }
}

