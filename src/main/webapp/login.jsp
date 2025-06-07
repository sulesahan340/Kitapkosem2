<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giriş Yap</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>Giriş Yap</h2>
    <form method="post" action="login">
        <label>Kullanıcı Adı:</label>
        <input type="text" name="kullanici_adi" required>

        <label>Şifre:</label>
        <input type="password" name="sifre" required>

        <input type="submit" value="Giriş">
    </form>

    <form method="get" action="kitaplar">
        <input type="hidden" name="misafir" value="true">
        <input type="submit" value="Misafir Girişi ile Devam Et">
    </form>

    <p style="color: red;"><%= request.getAttribute("hata") != null ? request.getAttribute("hata") : "" %></p>

    <a href="register.jsp">Hesabınız yok mu? Kayıt olun</a>
</div>
</body>
</html>

