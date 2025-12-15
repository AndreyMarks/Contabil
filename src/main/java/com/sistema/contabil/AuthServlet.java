package com.sistema.contabil;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

import org.json.simple.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {

    // Simulação de banco de dados de usuários: usuario -> senha, email
    private static final Map<String, String[]> USERS = new HashMap<>();
    static {
        USERS.put("admin", new String[]{"admin123", "admin@mailtrap.io"});
        USERS.put("contabil", new String[]{"contabil123", "contabil@mailtrap.io"});
        USERS.put("usuario", new String[]{"123456", "usuario@mailtrap.io"});
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        HttpSession session = request.getSession();

        String action = request.getParameter("action");

        if (action == null) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Ação não especificada.");
            out.print(jsonResponse.toJSONString());
            return;
        }

        switch (action) {
            case "login":
                handleLogin(request, jsonResponse, session);
                break;
            case "verify2FA":
                handleVerify2FA(request, jsonResponse, session);
                break;
            case "logout":
                handleLogout(jsonResponse, session);
                break;
            default:
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Ação inválida.");
                break;
        }

        out.print(jsonResponse.toJSONString());
    }

    private void handleLogin(HttpServletRequest request, JSONObject jsonResponse, HttpSession session) {
        String usuario = request.getParameter("usuario");
        String senha = request.getParameter("senha");

        if (USERS.containsKey(usuario) && USERS.get(usuario)[0].equals(senha)) {
            // Credenciais válidas
            String email = USERS.get(usuario)[1];
            String code2FA = generate2FACode();

            // Armazena informações na sessão para a verificação 2FA
            session.setAttribute("usuario", usuario);
            // Armazena o código e o timestamp de expiração (5 minutos a partir de agora)
long expirationTime = System.currentTimeMillis() + TimeUnit.MINUTES.toMillis(5);
session.setAttribute("2fa_code", code2FA);
session.setAttribute("2fa_expiration", expirationTime);
            session.setAttribute("2fa_authenticated", false); // Não autenticado ainda

            // Envia o código 2FA por e-mail (usando Mailtrap)
            boolean emailSent = EmailUtil.send2FACode(email, code2FA);

            if (emailSent) {
                jsonResponse.put("status", "success");
                jsonResponse.put("requires2FA", true);
            } else {
                // Em caso de falha no envio do e-mail, pode-se optar por falhar o login ou permitir o acesso sem 2FA 
                jsonResponse.put("message", "Falha ao enviar o código 2FA. Tente novamente.");
                session.invalidate(); // Invalida a sessão para evitar acesso
            }

        } else {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Usuário ou senha incorretos.");
        }
    }

    private void handleVerify2FA(HttpServletRequest request, JSONObject jsonResponse, HttpSession session) {
        String providedCode = request.getParameter("codigo2FA");
        String storedCode = (String) session.getAttribute("2fa_code");
Long storedExpiration = (Long) session.getAttribute("2fa_expiration");

// Verifica se o código expirou
if (storedExpiration != null && System.currentTimeMillis() > storedExpiration) {
    jsonResponse.put("status", "error");
    jsonResponse.put("message", "Código de verificação expirado. Tente fazer login novamente.");
    session.removeAttribute("2fa_code");
    session.removeAttribute("2fa_expiration");
    return;
}

        if (providedCode != null && storedCode != null && storedCode.equals(providedCode.trim())) {
            // Código 2FA válido
            session.setAttribute("2fa_authenticated", true);
            session.removeAttribute("2fa_code"); // Remove o código após o uso
session.removeAttribute("2fa_expiration");
            jsonResponse.put("status", "success");
        } else {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Código de verificação inválido.");
        }
    }

    private void handleLogout(JSONObject jsonResponse, HttpSession session) {
        session.invalidate();
        jsonResponse.put("status", "success");
    }

    private String generate2FACode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000); 
        return String.valueOf(code);
    }
}
