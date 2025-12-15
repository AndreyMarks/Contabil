<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Autenticação de 2 Fatores - Sistema Contábil</title>
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h1>Autenticação de 2 Fatores</h1>
            <p>Um código de verificação foi enviado para o seu e-mail. Por favor, insira-o abaixo.</p>
            
            <form id="twoFactorForm">
                <div class="form-group">
                    <label for="codigo2FA">Código de Verificação:</label>
                    <input type="text" id="codigo2FA" name="codigo2FA" required maxlength="6">
                </div>
                
                <button type="submit" class="btn-login">Verificar</button>
            </form>
            
            <div id="mensagem" class="mensagem"></div>
        </div>
    </div>
    
    <script src="resources/js/twoFactor.js"></script>
</body>
</html>
