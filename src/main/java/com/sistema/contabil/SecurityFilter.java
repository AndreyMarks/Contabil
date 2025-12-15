package com.sistema.contabil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/menu.jsp", "/twoFactor.jsp"})
public class SecurityFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialização
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false); // Não cria nova sessão se não existir

        String loginURI = req.getContextPath() + "/login.jsp";
        String authServletURI = req.getContextPath() + "/AuthServlet";

        boolean loggedIn = session != null && session.getAttribute("usuario") != null;
        boolean twoFAAuthenticated = loggedIn && (Boolean) session.getAttribute("2fa_authenticated");
        boolean isLoginRequest = req.getRequestURI().equals(loginURI);
        boolean isAuthServletRequest = req.getRequestURI().equals(authServletURI);
        boolean isTwoFactorPage = req.getRequestURI().endsWith("/twoFactor.jsp");

        if (isLoginRequest || isAuthServletRequest) {
            // Permite acesso à página de login e ao Servlet de autenticação
            chain.doFilter(request, response);
            return;
        }

        if (loggedIn) {
            if (twoFAAuthenticated) {
                // Usuário logado e 2FA autenticado, permite acesso a todas as páginas protegidas
                if (isTwoFactorPage) {
                    // Se já autenticado, redireciona para o menu
                    res.sendRedirect(req.getContextPath() + "/menu.jsp");
                    return;
                }
                chain.doFilter(request, response);
            } else {
                // Usuário logado, mas 2FA pendente
                if (isTwoFactorPage) {
                    // Permite acesso à página de 2FA
                    chain.doFilter(request, response);
                } else {
                    // Redireciona para a página de 2FA
                    res.sendRedirect(req.getContextPath() + "/twoFactor.jsp");
                }
            }
        } else {
            // Não logado, redireciona para a página de login
            res.sendRedirect(loginURI);
        }
    }

    @Override
    public void destroy() {
        // Limpeza
    }
}
