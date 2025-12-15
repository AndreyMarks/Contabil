<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Férias e Rescisões - Sistema Contábil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>
<div class="container">
    <h1>Férias e Rescisões</h1>
    <div class="card">
        <div class="tabs">
            <button class="tab-btn active" onclick="mudarAba(event, 'ferias')">Férias</button>
            <button class="tab-btn" onclick="mudarAba(event, 'rescisoes')">Rescisões</button>
        </div>
        <div id="ferias" class="tab-content active">
            <h2>Gestão de Férias</h2>
            <div class="form-grid">
                <div><label>Funcionário</label><select><option>Selecione</option><option>João Silva</option><option>Maria Santos</option></select></div>
                <div><label>Data Início</label><input type="date"></div>
                <div><label>Data Fim</label><input type="date"></div>
                <div><label>Tipo</label><select><option>Férias</option><option>Férias Coletivas</option></select></div>
            </div>
            <button class="btn" onclick="registrarFerias()">Registrar Férias</button>
            <h3 style="margin-top: 20px;">Férias Registradas</h3>
            <table>
                <thead><tr><th>Funcionário</th><th>Período</th><th>Dias</th><th>Status</th></tr></thead>
                <tbody><tr><td colspan="4">Nenhuma féria registrada</td></tr></tbody>
            </table>
        </div>
        <div id="rescisoes" class="tab-content">
            <h2>Gestão de Rescisões</h2>
            <div class="form-grid">
                <div><label>Funcionário</label><select><option>Selecione</option><option>João Silva</option><option>Maria Santos</option></select></div>
                <div><label>Data Rescisão</label><input type="date"></div>
                <div><label>Motivo</label><select><option>Pedido de Demissão</option><option>Demissão por Justa Causa</option><option>Demissão sem Justa Causa</option></select></div>
            </div>
            <button class="btn" onclick="registrarRescisao()">Registrar Rescisão</button>
            <h3 style="margin-top: 20px;">Rescisões Registradas</h3>
            <table>
                <thead><tr><th>Funcionário</th><th>Data</th><th>Motivo</th><th>Status</th></tr></thead>
                <tbody><tr><td colspan="4">Nenhuma rescisão registrada</td></tr></tbody>
            </table>
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
    function registrarFerias() { alert('Férias registradas com sucesso!'); }
    function registrarRescisao() { alert('Rescisão registrada com sucesso!'); }
</script>
</body>
</html>
