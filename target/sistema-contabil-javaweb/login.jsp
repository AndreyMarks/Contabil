<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Login - Sistema Contábil</title>

    <!-- CSS -->
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/resources/css/consolidated_styles.css">
</head>
<body>

<div class="login-container">
    <div class="login-form">
        <h1>Bem-vindo ao Sistema Contábil</h1>

        <form id="loginForm" autocomplete="off">
            <div class="form-group">
                <label for="usuario">Usuário:</label>
                <input
                    type="text"
                    id="usuario"
                    name="usuario"
                    required
                    autocomplete="username"
                >
            </div>

            <div class="form-group">
                <label for="senha">Senha:</label>
                <input
                    type="password"
                    id="senha"
                    name="senha"
                    required
                    autocomplete="current-password"
                >
            </div>

            <button type="submit" id="btn-login">
                <span id="btn-text">Entrar</span>
                <span id="spinner" style="display:none;">Carregando...</span>
            </button>
        </form>

        <div id="mensagem" class="mensagem" style="display:none;"></div>
    </div>
</div>

<script>
    const CONTEXT_PATH = "<%= request.getContextPath() %>";
</script>

<!-- JS -->
<script src="<%= request.getContextPath() %>/resources/js/login.js"></script>

</body>
</html>
