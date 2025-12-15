document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('loginForm');
    const mensagemDiv = document.getElementById('mensagem');

    // Função para mostrar mensagens de status
    function mostrarMensagem(texto, tipo) {
        mensagemDiv.textContent = texto;
        mensagemDiv.className = `mensagem ${tipo}`;
        mensagemDiv.style.display = 'block';
        
        setTimeout(() => {
            mensagemDiv.style.display = 'none';
        }, 5000);
    }

    // Verifica se o usuário já está logado (redirecionamento será feito pelo Servlet/JSP)
    // A lógica de verificação de sessão será movida para o backend (Servlet/JSP)

    loginForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const usuario = document.getElementById('usuario').value;
        const senha = document.getElementById('senha').value;
        
        if (!usuario || !senha) {
            mostrarMensagem('Por favor, preencha todos os campos.', 'erro');
            return;
        }

        // Requisição AJAX para o Servlet de Autenticação
        fetch('AuthServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `action=login&usuario=${encodeURIComponent(usuario)}&senha=${encodeURIComponent(senha)}`
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                if (data.requires2FA) {
                    // Se precisar de 2FA, redireciona para a página de 2FA
                    window.location.href = 'twoFactor.jsp';
                } else {
                    // Login direto (se 2FA não for necessário)
                    mostrarMensagem('Login bem-sucedido! Redirecionando...', 'sucesso');
                    setTimeout(() => {
                        window.location.href = 'menu.jsp';
                    }, 1500);
                }
            } else {
                mostrarMensagem(data.message || 'Erro de autenticação!', 'erro');
            }
        })
        .catch(error => {
            console.error('Erro na requisição:', error);
            mostrarMensagem('Erro de comunicação com o servidor.', 'erro');
        });
    });
});
