package org.example.kitapkosem2;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/misafir-giris")
public class MisafirGirisServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession oturum = request.getSession(true);
        oturum.setAttribute("misafir", true);
        response.sendRedirect("kitaplar.jsp");
    }
}

