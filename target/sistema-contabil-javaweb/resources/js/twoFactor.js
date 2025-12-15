document.addEventListener('DOMContentLoaded', function() {
    const twoFactorForm = document.getElementById('twoFactorForm');
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

    twoFactorForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const codigo2FA = document.getElementById('codigo2FA').value;
        
        if (!codigo2FA) {
            mostrarMensagem('Por favor, insira o código de verificação.', 'erro');
            return;
        }

        // Requisição AJAX para o Servlet de Autenticação para verificar o código 2FA
        fetch('AuthServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `action=verify2FA&codigo2FA=${encodeURIComponent(codigo2FA)}`
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                mostrarMensagem('Autenticação bem-sucedida! Redirecionando...', 'sucesso');
                setTimeout(() => {
                    window.location.href = 'menu.jsp';
                }, 1500);
            } else {
                mostrarMensagem(data.message || 'Código de verificação incorreto!', 'erro');
            }
        })
        .catch(error => {
            console.error('Erro na requisição:', error);
            mostrarMensagem('Erro de comunicação com o servidor.', 'erro');
        });
    });
});
