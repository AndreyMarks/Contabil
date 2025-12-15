<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema Contábil</title>
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h1>Bem-vindo ao Sistema Contábil</h1>
            
            <form id="loginForm">
                <div class="form-group">
                    <label for="usuario">Usuário:</label>
                    <input type="text" id="usuario" name="usuario" required>
                </div>
                
                <div class="form-group">
                    <label for="senha">Senha:</label>
                    <input type="password" id="senha" name="senha" required>
                </div>
                
                <button type="submit" class="btn-login">Entrar</button>
            </form>
            
            <div id="mensagem" class="mensagem"></div>
        </div>
    </div>
    
    <script src="resources/js/login.js"></script>
</body>
</html>
