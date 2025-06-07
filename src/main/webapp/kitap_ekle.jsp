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
<html>
<head>
  <title>Yeni Kitap Ekle</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    body {
      background-color: #6a4baf;
      color: #fff;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 40px;
    }

    .selam {
      font-size: 18px;
      margin-bottom: 20px;
      align-self: flex-start;
    }

    h2 {
      font-size: 32px;
      margin-bottom: 20px;
      text-transform: uppercase;
    }

    form {
      background-color: #ffffff22;
      padding: 30px;
      border-radius: 12px;
      width: 350px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.4);
      backdrop-filter: blur(6px);
    }

    label {
      font-weight: bold;
    }

    input[type="text"],
    textarea {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      margin-bottom: 20px;
      border-radius: 5px;
      border: none;
    }

    textarea {
      resize: vertical;
    }

    input[type="submit"] {
      background-color: #fff;
      color: #6a4baf;
      border: none;
      padding: 10px 20px;
      font-weight: bold;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #ddd;
    }

    .geri-don {
      margin-top: 30px;
      text-decoration: none;
      color: #ddd;
      font-size: 14px;
      transition: color 0.3s ease;
    }

    .geri-don:hover {
      color: white;
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="selam"> Merhaba <strong><%= kullaniciAdi %></strong>, yeni bir kitap ekleyebilirsin:):</div>

<h2>Yeni Kitap Ekle</h2>

<form action="AddBookServlet" method="post">
  <label for="baslik">BASLIK:</label>
  <input type="text" id="baslik" name="baslik" required>

  <label for="yazar">YAZAR:</label>
  <input type="text" id="yazar" name="yazar" required>

  <label for="tur">TUR:</label>
  <input type="text" id="tur" name="tur">

  <label for="aciklama">ACIKLAMA:</label>
  <textarea id="aciklama" name="aciklama" rows="4"></textarea>

  <input type="submit" value="Kaydet">
</form>

<a href="kitaplar.jsp" class="geri-don"> Geri Don</a>

</body>
</html>


