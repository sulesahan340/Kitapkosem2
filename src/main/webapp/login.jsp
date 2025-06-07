<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giriş Yap</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Özel Stil -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>Giriş Yap</h2>

    <form method="post" action="login">
        <label for="kullanici_adi">Kullanıcı Adı:</label>
        <input type="text" id="kullanici_adi" name="kullanici_adi" required>

        <label for="sifre">Şifre:</label>
        <input type="password" id="sifre" name="sifre" required>

        <input type="submit" value="Giriş">
    </form>

    <form method="get" action="kitaplar">
        <input type="hidden" name="misafir" value="true">
        <input type="submit" value="Misafir Girişi ile Devam Et">
    </form>

    <p style="color: red; text-align: center;"><%= request.getAttribute("hata") != null ? request.getAttribute("hata") : "" %></p>

    <a href="register.jsp">Hesabınız yok mu? Kayıt olun</a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

