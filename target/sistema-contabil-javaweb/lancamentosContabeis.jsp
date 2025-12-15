<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Lançamentos Contábeis</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>

<div class="container">
    <h1>Lançamentos Contábeis</h1>

    <div id="message-area" class="message"></div>

    <div class="grid">

        <!-- FORMULÁRIO -->
        <div class="card">
            <h2>Novo Lançamento</h2>

            <form id="formLancamento" onsubmit="salvarLancamento(event)">
                <div class="form-grid">

                    <div>
                        <label>Data</label>
                        <input type="date" name="dataLancamento" required>
                    </div>

                    <div>
                        <label>Valor (R$)</label>
                        <input type="number" step="0.01" name="valor" required>
                    </div>

                    <div>
                        <label>Conta Contábil</label>
                        <select name="contaContabil" required>
                            <option value="">Selecione</option>
                            <option value="11101">Caixa</option>
                            <option value="21101">Fornecedores</option>
                            <option value="41101">Receita de Vendas</option>
                        </select>
                    </div>

                    <div style="grid-column:1/-1">
                        <label>Histórico</label>
                        <input type="text" name="historico" required>
                    </div>

                </div>

                <div class="actions">
                    <button type="reset" class="btn-secondary">Limpar</button>
                    <button type="submit" class="btn-primary">Salvar</button>
                </div>
            </form>
        </div>

        <!-- LISTA -->
        <div class="card">
            <h2>Lançamentos Recentes</h2>
            <div id="lancamentos-table-container">Carregando...</div>
        </div>

    </div>

    <p style="margin-top:20px;">
        <a href="menu.jsp">← Voltar ao menu</a>
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

    function listarLancamentos() {
        const container = document.getElementById('lancamentos-table-container');
        container.innerHTML = 'Carregando...';

        fetch('MainServlet?area=contabilidade&action=listarLancamentos')
            .then(r => r.json())
            .then(data => {

                if (!data || data.status !== 'success' || !data.lancamentos || data.lancamentos.length === 0) {
                    container.innerHTML = '<p>Nenhum lançamento encontrado.</p>';
                    return;
                }

                let html = `
                    <table>
                        <thead>
                            <tr>
                                <th>Data</th>
                                <th>Histórico</th>
                                <th>Conta</th>
                                <th class="valor">Valor</th>
                            </tr>
                        </thead>
                        <tbody>
                `;

                data.lancamentos.forEach(l => {
                    const dataLanc = l.data || l.data_lancamento || '-';
                    const historico = l.historico || l.descricao || '-';
                    const conta = l.conta || l.conta_contabil || '-';
                    const valor = l.valor
                        ? Number(l.valor).toFixed(2).replace('.', ',')
                        : '0,00';

                    html += `
                        <tr>
                            <td>${dataLanc}</td>
                            <td>${historico}</td>
                            <td>${conta}</td>
                            <td class="valor">R$ ${valor}</td>
                        </tr>
                    `;
                });

                html += '</tbody></table>';
                container.innerHTML = html;
            })
            .catch(() => {
                container.innerHTML = '<p>Erro ao carregar lançamentos.</p>';
            });
    }

    function salvarLancamento(e) {
        e.preventDefault();

        const form = e.target;
        const btn = form.querySelector('button[type="submit"]');
        const data = new URLSearchParams(new FormData(form));

        data.append('area', 'contabilidade');
        data.append('action', 'salvarLancamento');

        btn.disabled = true;
        btn.textContent = 'Salvando...';

        fetch('MainServlet', { method: 'POST', body: data })
            .then(r => r.json())
            .then(resp => {
                if (resp.status === 'success') {
                    showMessage('success', resp.message);
                    form.reset();
                    listarLancamentos();
                } else {
                    showMessage('error', resp.message);
                }
            })
            .catch(() => showMessage('error', 'Erro de rede'))
            .finally(() => {
                btn.disabled = false;
                btn.textContent = 'Salvar';
            });
    }

    document.addEventListener('DOMContentLoaded', listarLancamentos);
</script>

</body>
</html>
