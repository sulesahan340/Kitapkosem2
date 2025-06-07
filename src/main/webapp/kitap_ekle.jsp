<%@ page session="true" %>
<%
  HttpSession oturum = request.getSession(false);

  if (oturum == null || oturum.getAttribute("kullanici_id") == null) {
    if (oturum != null && oturum.getAttribute("misafir") != null) {
      response.sendRedirect("register.jsp");
    } else {
      response.sendRedirect("login.jsp");
    }
    return;
  }

  String kullaniciAdi = (String) oturum.getAttribute("kullanici_adi");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Yeni Kitap Ekle</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #6a4baf;
      color: #fff;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 40px;
    }

    .form-container {
      background-color: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(6px);
      padding: 30px 40px;
      border-radius: 15px;
      max-width: 500px;
      width: 100%;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.4);
    }

    .form-container h2 {
      color: #fff;
      margin-bottom: 25px;
      font-weight: bold;
      text-align: center;
    }

    label {
      color: #fff;
      font-weight: 600;
    }

    .form-control {
      margin-bottom: 20px;
      border-radius: 8px;
    }

    .btn-primary {
      background-color: #fff;
      color: #6a4baf;
      font-weight: bold;
      border: none;
      border-radius: 25px;
      padding: 10px 20px;
      width: 100%;
    }

    .btn-primary:hover {
      background-color: #e0d8ff;
    }

    .selam {
      color: #fff;
      font-size: 18px;
      margin-bottom: 15px;
      text-align: center;
    }

    .geri-don {
      display: block;
      text-align: center;
      margin-top: 20px;
      color: #ddd;
      font-size: 14px;
      text-decoration: none;
    }

    .geri-don:hover {
      color: #fff;
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="form-container">
  <div class="selam">Merhaba <strong><%= kullaniciAdi %></strong>, yeni bir kitap ekleyebilirsin :)</div>

  <h2>Yeni Kitap Ekle</h2>

  <form action="AddBookServlet" method="post">
    <div class="mb-3">
      <label for="baslik" class="form-label">Başlık:</label>
      <input type="text" id="baslik" name="baslik" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="yazar" class="form-label">Yazar:</label>
      <input type="text" id="yazar" name="yazar" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="tur" class="form-label">Tür:</label>
      <input type="text" id="tur" name="tur" class="form-control">
    </div>

    <div class="mb-3">
      <label for="aciklama" class="form-label">Açıklama:</label>
      <textarea id="aciklama" name="aciklama" rows="4" class="form-control"></textarea>
    </div>

    <input type="submit" value="Kaydet" class="btn btn-primary">
  </form>

  <a href="kitaplar.jsp" class="geri-don">← Geri Dön</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


