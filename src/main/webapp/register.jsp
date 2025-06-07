<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Kayıt Ol</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Özel Stil -->
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
  <h2>Kayıt Ol</h2>

  <form method="post" action="register">
    <label for="kullanici_adi">Kullanıcı Adı:</label>
    <input type="text" id="kullanici_adi" name="kullanici_adi" required>

    <label for="sifre">Şifre:</label>
    <input type="password" id="sifre" name="sifre" required>

    <input type="submit" value="Kayıt Ol">
  </form>

  <a href="login.jsp">Zaten hesabınız var mı? Giriş yapın</a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

