document.addEventListener('DOMContentLoaded', function() {
    const logoutBtn = document.getElementById('logoutBtn');

    logoutBtn.addEventListener('click', function() {
        // Requisição AJAX para o Servlet de Autenticação para fazer logout
        fetch('AuthServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'action=logout'
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                // Redireciona para a página de login
                window.location.href = 'login.jsp';
            } else {
                alert('Erro ao fazer logout. Tente novamente.');
            }
        })
        .catch(error => {
            console.error('Erro na requisição de logout:', error);
            alert('Erro de comunicação com o servidor durante o logout.');
        });
    });
});
