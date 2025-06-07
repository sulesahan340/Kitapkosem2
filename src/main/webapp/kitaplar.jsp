<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
  HttpSession oturum = request.getSession(false);
  boolean misafir = false;

  if (oturum == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  if (oturum.getAttribute("misafir") != null) {
    misafir = true;
  } else if (oturum.getAttribute("kullanici_adi") == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  String url = "jdbc:mysql://localhost:3306/kitapkosem";
  String kullanici = "root";
  String sifre = "Sule_sahan340";

  String arama = request.getParameter("arama");
  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Kitap Listesi</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <style>
    .custom-container {
      max-width: 1000px;
    }
  </style>
</head>
<body>
<div class="container custom-container mt-5">
  <h2 class="mb-4 text-center">Kitap Listesi</h2>

  <!-- Arama Formu -->
  <form method="get" class="mb-4">
    <div class="input-group">
      <input type="text" name="arama" class="form-control" placeholder="Kitap ismine göre ara" value="<%= arama != null ? arama : "" %>">
      <button type="submit" class="btn btn-outline-secondary">Ara</button>
    </div>
  </form>

  <% if (!misafir) { %>
  <div class="mb-3 text-end">
    <a href="kitap_ekle.jsp" class="btn btn-primary">Yeni Kitap Ekle</a>
  </div>
  <% } else { %>
  <div class="alert alert-warning">
    Misafir olarak giriş yaptınız. Kitap eklemek için <a href="register.jsp">kayıt olun</a>.
  </div>
  <% } %>

  <%
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection(url, kullanici, sifre);

      if (arama != null && !arama.trim().isEmpty()) {
        stmt = conn.prepareStatement("SELECT * FROM kitap WHERE baslik LIKE ?");
        stmt.setString(1, "%" + arama + "%");
      } else {
        stmt = conn.prepareStatement("SELECT * FROM kitap");
      }

      rs = stmt.executeQuery();

      if (!rs.isBeforeFirst()) {
  %>
  <div class="alert alert-info">Uygun kitap bulunamadı.</div>
  <%
  } else {
  %>
  <div class="table-responsive">
    <table class="table table-bordered table-striped align-middle">
      <thead class="table-dark">
      <tr>
        <th>BASLIK</th>
        <th>YAZAR</th>
        <th>TÜR</th>
        <th>AÇIKLAMA</th>
      </tr>
      </thead>
      <tbody>
      <%
        while (rs.next()) {
      %>
      <tr>
        <td><a href="kitapDetay.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("baslik") %></a></td>
        <td><%= rs.getString("yazar") %></td>
        <td><%= rs.getString("tur") %></td>
        <td><%= rs.getString("aciklama") %></td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>
  <%
    }
  } catch (Exception e) {
  %>
  <div class="alert alert-danger">Hata oluştu: <%= e.getMessage() %></div>
  <%
    } finally {
      if (rs != null) try { rs.close(); } catch (Exception ignore) {}
      if (stmt != null) try { stmt.close(); } catch (Exception ignore) {}
      if (conn != null) try { conn.close(); } catch (Exception ignore) {}
    }
  %>
</div>
</body>
</html>








