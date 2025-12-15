<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Plano de Contas - Sistema Contábil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>
<div class="container">
    <h1>Plano de Contas</h1>
    
    <div id="message-area" class="message"></div>
    
    <!-- FORMULÁRIO DE ADIÇÃO -->
    <div class="card">
        <h2>Adicionar Conta</h2>
        <form onsubmit="salvarConta(event)">
            <div class="form-grid">
                <div>
                    <label>Código da Conta</label>
                    <input type="text" name="codigoConta" placeholder="Ex: 1.1.1.01" required>
                </div>
                <div>
                    <label>Nome da Conta</label>
                    <input type="text" name="nomeConta" placeholder="Ex: Caixa" required>
                </div>
                <div>
                    <label>Tipo</label>
                    <select name="tipoConta" required>
                        <option value="">Selecione</option>
                        <option value="Ativo">Ativo</option>
                        <option value="Passivo">Passivo</option>
                        <option value="Patrimônio Líquido">Patrimônio Líquido</option>
                        <option value="Receita">Receita</option>
                        <option value="Despesa">Despesa</option>
                    </select>
                </div>
                <div>
                    <label>Natureza</label>
                    <select name="natureza" required>
                        <option value="">Selecione</option>
                        <option value="Devedora">Devedora</option>
                        <option value="Credora">Credora</option>
                    </select>
                </div>
            </div>
            <div class="actions">
                <button type="reset" class="btn btn-secondary">Limpar</button>
                <button type="submit" class="btn btn-primary">Salvar Conta</button>
            </div>
        </form>
    </div>
    
    <!-- LISTA DE CONTAS -->
    <div class="card">
        <h2>Contas Cadastradas</h2>
        <div id="contas-table-container">Carregando...</div>
    </div>
    
    <p style="margin-top: 20px;">
        <a href="menu.jsp">← Voltar ao Menu</a>
    </p>
</div>

<script>
    function showMessage(type, text) {
        const el = document.getElementById('message-area');
        el.className = 'message ' + type;
        el.textContent = text;
        el.style.display = 'block';
        setTimeout(() => el.style.display = 'none', 4000);
    }
    
    function listarContas() {
        const container = document.getElementById('contas-table-container');
        container.innerHTML = 'Carregando...';
        
        fetch('MainServlet?area=contabilidade&action=listarContas')
            .then(r => r.json())
            .then(data => {
                if (!data || data.status !== 'success' || !data.contas || data.contas.length === 0) {
                    container.innerHTML = '<p>Nenhuma conta cadastrada.</p>';
                    return;
                }
                
                let html = `
                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Nome</th>
                                <th>Tipo</th>
                                <th>Natureza</th>
                                <th>Ação</th>
                            </tr>
                        </thead>
                        <tbody>
                `;
                
                data.contas.forEach(c => {
                    html += `
                        <tr>
                            <td>${c.codigo || '-'}</td>
                            <td>${c.nome || '-'}</td>
                            <td><span class="categoria">${c.tipo || '-'}</span></td>
                            <td>${c.natureza || '-'}</td>
                            <td>
                                <button class="btn btn-danger" onclick="deletarConta('${c.codigo}')">Deletar</button>
                            </td>
                        </tr>
                    `;
                });
                
                html += '</tbody></table>';
                container.innerHTML = html;
            })
            .catch(() => {
                container.innerHTML = '<p>Erro ao carregar contas.</p>';
            });
    }
    
    function salvarConta(e) {
        e.preventDefault();
        const form = e.target;
        const btn = form.querySelector('button[type="submit"]');
        const data = new URLSearchParams(new FormData(form));
        data.append('area', 'contabilidade');
        data.append('action', 'salvarConta');
        
        btn.disabled = true;
        btn.textContent = 'Salvando...';
        
        fetch('MainServlet', { method: 'POST', body: data })
            .then(r => r.json())
            .then(resp => {
                if (resp.status === 'success') {
                    showMessage('success', resp.message);
                    form.reset();
                    listarContas();
                } else {
                    showMessage('error', resp.message);
                }
            })
            .catch(() => showMessage('error', 'Erro de rede'))
            .finally(() => {
                btn.disabled = false;
                btn.textContent = 'Salvar Conta';
            });
    }
    
    function deletarConta(codigo) {
        if (confirm('Deseja deletar esta conta?')) {
            const data = new URLSearchParams();
            data.append('area', 'contabilidade');
            data.append('action', 'deletarConta');
            data.append('codigoConta', codigo);
            
            fetch('MainServlet', { method: 'POST', body: data })
                .then(r => r.json())
                .then(resp => {
                    if (resp.status === 'success') {
                        showMessage('success', resp.message);
                        listarContas();
                    } else {
                        showMessage('error', resp.message);
                    }
                })
                .catch(() => showMessage('error', 'Erro de rede'));
        }
    }
    
    document.addEventListener('DOMContentLoaded', listarContas);
</script>
</body>
</html>
