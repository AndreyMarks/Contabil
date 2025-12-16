document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('loginForm');
    const mensagemDiv = document.getElementById('mensagem');
    const loginButton = document.getElementById('btn-login');
    const buttonText = document.getElementById('btn-text');
    const spinner = document.getElementById('spinner');

    function setLoginButtonState(isLoading) {
        if (isLoading) {
            loginButton.classList.add('loading');
            buttonText.style.display = 'none';
            spinner.style.display = 'inline-block';
            loginButton.disabled = true;
        } else {
            loginButton.classList.remove('loading');
            buttonText.style.display = 'inline';
            spinner.style.display = 'none';
            loginButton.disabled = false;
        }
    }

    function mostrarMensagem(texto, tipo) {
        mensagemDiv.textContent = texto;
        mensagemDiv.className = 'mensagem ' + tipo;
        mensagemDiv.style.display = 'block';

        setTimeout(function() {
            mensagemDiv.style.display = 'none';
        }, 5000);
    }

    if (!loginForm) {
        console.error('loginForm não encontrado');
        return;
    }

    loginForm.addEventListener('submit', function(e) {
        e.preventDefault();

        const usuario = document.getElementById('usuario').value;
        const senha = document.getElementById('senha').value;

        if (!usuario || !senha) {
            mostrarMensagem('Por favor, preencha todos os campos.', 'erro');
            return;
        }

        setLoginButtonState(true);

        fetch('AuthServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'action=login&usuario=' + encodeURIComponent(usuario) +
                  '&senha=' + encodeURIComponent(senha)
        })
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            if (data.status === 'success') {
                if (data.requires2FA) {
                    window.location.href = 'twoFactor.jsp';
                } else {
                    mostrarMensagem('Login bem-sucedido! Redirecionando...', 'sucesso');
                    setTimeout(function() {
                        window.location.href = 'menu.jsp';
                    }, 1500);
                }
            } else {
                mostrarMensagem(data.message || 'Erro de autenticação!', 'erro');
                setLoginButtonState(false);
            }
        })
        .catch(function(error) {
            console.error('Erro na requisição:', error);
            mostrarMensagem('Erro de comunicação com o servidor.', 'erro');
            setLoginButtonState(false);
        });
    });

});
