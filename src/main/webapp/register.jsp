<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Kayıt Ol</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
  <h2>Kayıt Ol</h2>
  <form action="register" method="post">
    <label>Kullanıcı Adı:</label>
    <input type="text" name="kullanici_adi" required>

    <label>Şifre:</label>
    <input type="password" name="sifre" required>

    <input type="submit" value="Kayıt Ol">
  </form>
  <p>Zaten hesabın var mı? <a href="login.jsp">Giriş Yap</a></p>
</div>
</body>
</html>

