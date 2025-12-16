document.addEventListener('DOMContentLoaded', function () {

    console.log("login.js carregado");

    const loginForm = document.getElementById('loginForm');
    const mensagemDiv = document.getElementById('mensagem');
    const loginButton = document.getElementById('btn-login');
    const buttonText = document.getElementById('btn-text');
    const spinner = document.getElementById('spinner');

    function setLoginButtonState(isLoading) {
        loginButton.disabled = isLoading;
        buttonText.style.display = isLoading ? 'none' : 'inline';
        spinner.style.display = isLoading ? 'inline-block' : 'none';
    }

    function mostrarMensagem(texto, tipo) {
        mensagemDiv.textContent = texto;
        mensagemDiv.className = `mensagem ${tipo}`;
        mensagemDiv.style.display = 'block';
    }

    if (!loginForm) {
        console.error("Form loginForm não encontrado");
        return;
    }

    loginForm.addEventListener('submit', function (e) {
        e.preventDefault();
        console.log("SUBMIT INTERCEPTADO");

        const usuario = document.getElementById('usuario').value.trim();
        const senha = document.getElementById('senha').value.trim();

        if (!usuario || !senha) {
            mostrarMensagem('Preencha todos os campos.', 'erro');
            return;
        }

        setLoginButtonState(true);

        fetch(CONTEXT_PATH + '/AuthServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `action=login&usuario=${encodeURIComponent(usuario)}&senha=${encodeURIComponent(senha)}`
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                if (data.requires2FA) {
                    window.location.href = CONTEXT_PATH + '/twoFactor.jsp';
                } else {
                    window.location.href = CONTEXT_PATH + '/menu.jsp';
                }
            } else {
                mostrarMensagem(data.message || 'Erro de autenticação', 'erro');
                setLoginButtonState(false);
            }
        })
        .catch(err => {
            console.error(err);
            mostrarMensagem('Erro ao comunicar com o servidor.', 'erro');
            setLoginButtonState(false);
        });
    });

});
