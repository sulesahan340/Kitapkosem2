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
  String kullaniciAdi = null;
  if (session != null && session.getAttribute("kullanici_id") != null) {
    kullaniciId = (Integer) session.getAttribute("kullanici_id");
    kullaniciAdi = (String) session.getAttribute("kullanici_adi");
  }
%>

<html>
<head>
  <title>Kitap Detayı</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: rgba(218, 92, 208, 0.93); /* Mor arka plan */
      color: #fff;
      min-height: 100vh;
      padding: 40px 0;
    }
    .container {
      background: rgba(232, 172, 229, 0.93);
      border-radius: 15px;
      padding: 30px 40px;
      max-width: 900px;
      margin: auto;
      box-shadow: 0 8px 20px rgba(0,0,0,0.3);
    }
    h2, h3 {
      color: #f1e6ff;
      font-weight: 700;
    }
    .book-info p {
      font-size: 1.1rem;
      margin-bottom: 10px;
    }
    .average-rating {
      font-size: 1.2rem;
      margin-top: 10px;
      margin-bottom: 30px;
      color: #ffd700; /* Altın rengi */
    }
    .comment-card {
      background: #593f9f;
      border-radius: 10px;
      padding: 15px 20px;
      margin-bottom: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.2);
    }
    .comment-card strong {
      color: #ffd700;
    }
    .comment-card em {
      color: #d3c1ff;
    }
    .comment-card p {
      margin-top: 8px;
      font-size: 1rem;
      color: #f4ebff;
    }
    .rating-stars {
      color: #ffd700;
      font-size: 1.1rem;
    }
    form label {
      font-weight: 600;
      margin-top: 15px;
      display: block;
    }
    form textarea, form select, form input[type="text"] {
      width: 100%;
      padding: 8px 10px;
      border-radius: 8px;
      border: none;
      font-size: 1rem;
      margin-top: 5px;
    }
    form input[type="submit"] {
      background-color: #4e30b8;
      border: none;
      padding: 12px 25px;
      color: white;
      border-radius: 25px;
      font-weight: 700;
      margin-top: 20px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    form input[type="submit"]:hover {
      background-color: #6a4baf;
    }
    .info-message {
      background-color: #7e62d1;
      padding: 15px 20px;
      border-radius: 10px;
      color: #eee;
      text-align: center;
      font-weight: 600;
      margin-top: 30px;
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
  <h2><%= kitapRs.getString("baslik") %></h2>
  <div class="book-info">
    <p><strong>Yazar:</strong> <%= kitapRs.getString("yazar") %></p>
    <p><strong>Tur:</strong> <%= kitapRs.getString("tur") %></p>
    <p><strong>Aciklama:</strong> <%= kitapRs.getString("aciklama") %></p>
  </div>

  <div class="average-rating">
    <% if (ortalamaVar) { %>
    Ortalama Puan: <%= String.format("%.2f", ortalamaPuan) %> / 5
    <% } else { %>
    Henuz puan verilmedi.
    <% } %>
  </div>

  <hr style="border-color: #d3c1ff;">

  <h3>Yorumlar</h3>
  <% boolean yorumVarMi = false;
    while (yorumRs.next()) {
      yorumVarMi = true;
  %>
  <div class="comment-card">
    <strong><%= yorumRs.getString("kullanici_adi") %></strong>
    <em> - <%= yorumRs.getTimestamp("tarih") %></em><br>
    <span class="rating-stars">
            <%
              int puan = yorumRs.getInt("puan");
              for (int i = 0; i < puan; i++) {
            %>
              &#9733;
            <% }
              for (int i = puan; i < 5; i++) {
            %>
              &#9734;
            <% } %>
          </span>
    <p><%= yorumRs.getString("yorum") %></p>
  </div>
  <% }
    if (!yorumVarMi) { %>
  <p>Henuz yorum yapilmamis.</p>
  <% } %>

  <hr style="border-color: #d3c1ff;">

  <% if (kullaniciId != null) { %>
  <h3>Yorum Yaz</h3>
  <form action="AddCommentServlet" method="post">
    <input type="hidden" name="kitapId" value="<%= kitapId %>">

    <label for="yorum">Yorum:</label>
    <textarea id="yorum" name="yorum" rows="4" required></textarea>

    <label for="puan">Puan (1-5):</label>
    <select id="puan" name="puan" required>
      <option value="">Seciniz</option>
      <% for (int i = 1; i <= 5; i++) { %>
      <option value="<%= i %>"><%= i %></option>
      <% } %>
    </select>

    <input type="submit" value="Gonder">
  </form>
  <% } else { %>
  <div class="info-message">
    Yorum yapmak için <a href="login.jsp">giriş yapmalı</a> ya da <a href="register.jsp">kayıt olmalısınız</a>.
  </div>
  <% } %>
  <% } else { %>
  <p>Kitap bulunamadi.</p>
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




