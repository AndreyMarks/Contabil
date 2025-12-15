<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Livro Diário/Razão - Sistema Contábil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>
<div class="container">
    <h1>Livro Diário/Razão</h1>
    <div class="card">
        <h2>Filtros</h2>
        <div class="form-grid">
            <div><label>Período Inicial</label><input type="date" id="dataInicio"></div>
            <div><label>Período Final</label><input type="date" id="dataFim"></div>
            <div><label>Conta</label><select id="contaSelecionada"><option value="">Todas</option><option value="11101">Caixa</option><option value="11102">Banco</option></select></div>
        </div>
        <button class="btn" onclick="filtrarDados()">Filtrar</button>
    </div>
    <div class="card">
        <div class="tabs">
            <button class="tab-btn active" onclick="mudarAba(event, 'diario')">Livro Diário</button>
            <button class="tab-btn" onclick="mudarAba(event, 'razao')">Livro Razão</button>
        </div>
        <div id="diario" class="tab-content active">
            <h2>Livro Diário</h2>
            <div id="diario-table-container">Carregando...</div>
        </div>
        <div id="razao" class="tab-content">
            <h2>Livro Razão</h2>
            <div id="razao-table-container">Carregando...</div>
        </div>
    </div>
    <p style="margin-top: 20px;"><a href="menu.jsp">← Voltar ao Menu</a></p>
</div>
<script>
    function mudarAba(event, abaId) {
        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
        event.target.classList.add('active');
        document.getElementById(abaId).classList.add('active');
    }
    function filtrarDados() { alert('Dados filtrados com sucesso!'); }
    document.addEventListener('DOMContentLoaded', () => {
        document.getElementById('diario-table-container').innerHTML = '<table><thead><tr><th>Data</th><th>Conta</th><th>Histórico</th><th class="valor">Débito</th><th class="valor">Crédito</th></tr></thead><tbody><tr><td colspan="5">Nenhum lançamento encontrado</td></tr></tbody></table>';
    });
</script>
</body>
</html>
