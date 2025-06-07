<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession" %>
<%
  int kitapId = Integer.parseInt(request.getParameter("id"));

  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kitapkosem", "root", "Sule_sahan340");

  PreparedStatement kitapStmt = conn.prepareStatement("SELECT * FROM kitap WHERE id=?");
  kitapStmt.setInt(1, kitapId);
  ResultSet kitapRs = kitapStmt.executeQuery();

  PreparedStatement ortalamaStmt = conn.prepareStatement("SELECT AVG(puan) AS ortalama FROM yorumlar WHERE kitap_id = ?");
  ortalamaStmt.setInt(1, kitapId);
  ResultSet ortalamaRs = ortalamaStmt.executeQuery();
  double ortalamaPuan = 0;
  boolean ortalamaVar = false;
  if (ortalamaRs.next() && ortalamaRs.getDouble("ortalama") > 0) {
    ortalamaVar = true;
    ortalamaPuan = ortalamaRs.getDouble("ortalama");
  }

  PreparedStatement yorumStmt = conn.prepareStatement(
          "SELECT y.yorum, y.puan, y.tarih, k.kullanici_adi FROM yorumlar y " +
                  "JOIN kullanici k ON y.kullanici_id = k.id WHERE y.kitap_id = ? ORDER BY y.tarih DESC");
  yorumStmt.setInt(1, kitapId);
  ResultSet yorumRs = yorumStmt.executeQuery();

  Integer kullaniciId = null;
  if (session != null && session.getAttribute("kullanici_id") != null) {
    kullaniciId = (Integer) session.getAttribute("kullanici_id");
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Kitap Detayı</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #a34ac4; /* mor arka plan */
      color: white;
      min-height: 100vh;
      padding: 40px 0;
    }
    .container {
      background: #dfb5ef;
      border-radius: 15px;
      padding: 40px;
      max-width: 950px;
      margin: auto;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
    }
    .rating-stars {
      color: #ffd700;
      font-size: 1.1rem;
    }
    .comment-card {
      background: #6c3bb8;
      border-radius: 12px;
      padding: 15px 20px;
      margin-bottom: 20px;
      color: #fdfdfd;
    }
    .comment-card strong {
      color: #ffd700;
    }
    .comment-card em {
      color: #f1e0ff;
    }
    .average-rating {
      font-size: 1.2rem;
      color: #ffd700;
      margin-bottom: 25px;
    }
    .form-label {
      font-weight: 600;
    }
    .info-message {
      background-color: #7040a0;
      padding: 15px;
      border-radius: 10px;
      margin-top: 25px;
      color: #fff;
      text-align: center;
      font-weight: 500;
    }
    a {
      color: #ffd700;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="container">
  <% if (kitapRs.next()) { %>
  <h2 class="mb-4"><%= kitapRs.getString("baslik") %></h2>
  <div class="mb-3">
    <p><strong>Yazar:</strong> <%= kitapRs.getString("yazar") %></p>
    <p><strong>Tur:</strong> <%= kitapRs.getString("tur") %></p>
    <p><strong>Aciklama:</strong> <%= kitapRs.getString("aciklama") %></p>
  </div>

  <div class="average-rating mb-4">
    <% if (ortalamaVar) { %>
    Ortalama Puan: <%= String.format("%.2f", ortalamaPuan) %> / 5
    <% } else { %>
    Henuz puan verilmedi.
    <% } %>
  </div>

  <h4 class="mb-3">Yorumlar</h4>
  <% boolean yorumVarMi = false;
    while (yorumRs.next()) {
      yorumVarMi = true;
  %>
  <div class="comment-card">
    <div>
      <strong><%= yorumRs.getString("kullanici_adi") %></strong>
      <em> - <%= yorumRs.getTimestamp("tarih") %></em>
    </div>
    <div class="rating-stars mb-1">
      <%
        int puan = yorumRs.getInt("puan");
        for (int i = 0; i < puan; i++) { %> &#9733; <% }
      for (int i = puan; i < 5; i++) { %> &#9734; <% }
    %>
    </div>
    <p><%= yorumRs.getString("yorum") %></p>
  </div>
  <% } if (!yorumVarMi) { %>
  <p class="text-light">Henuz yorum yapilmamis.</p>
  <% } %>

  <hr class="my-4 border-light">

  <% if (kullaniciId != null) { %>
  <h4 class="mb-3">Yorum Yaz</h4>
  <form action="AddCommentServlet" method="post">
    <input type="hidden" name="kitapId" value="<%= kitapId %>">

    <div class="mb-3">
      <label for="yorum" class="form-label">Yorum</label>
      <textarea class="form-control" id="yorum" name="yorum" rows="4" required></textarea>
    </div>

    <div class="mb-3">
      <label for="puan" class="form-label">Puan</label>
      <select class="form-select" id="puan" name="puan" required>
        <option value="">Seciniz</option>
        <% for (int i = 1; i <= 5; i++) { %>
        <option value="<%= i %>"><%= i %></option>
        <% } %>
      </select>
    </div>

    <button type="submit" class="btn btn-warning px-4">Gonder</button>
  </form>
  <% } else { %>
  <div class="info-message">
    Yorum yapmak için <a href="login.jsp">giriş yapmalı</a> veya <a href="register.jsp">kayıt olmalısınız</a>.
  </div>
  <% } %>
  <% } else { %>
  <div class="alert alert-danger">Kitap bulunamadı.</div>
  <% } %>

  <%
    kitapRs.close();
    yorumRs.close();
    ortalamaRs.close();
    kitapStmt.close();
    yorumStmt.close();
    ortalamaStmt.close();
    conn.close();
  %>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>




