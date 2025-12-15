<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Conciliação Bancária - Sistema Contábil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>
<div class="container">
    <h1>Conciliação Bancária</h1>
    <div class="card">
        <h2>Dados da Conciliação</h2>
        <div class="form-grid">
            <div><label>Banco</label><select><option>Banco do Brasil</option><option>Caixa</option><option>Bradesco</option></select></div>
            <div><label>Agência</label><input type="text" placeholder="0001"></div>
            <div><label>Conta</label><input type="text" placeholder="123456-7"></div>
            <div><label>Período</label><input type="month"></div>
        </div>
        <button class="btn" onclick="iniciarConciliacao()">Iniciar Conciliação</button>
    </div>
    <div class="cards">
        <div class="card-stat"><h3>Saldo Banco</h3><p>R$ 50.000,00</p></div>
        <div class="card-stat"><h3>Saldo Sistema</h3><p>R$ 48.500,00</p></div>
        <div class="card-stat"><h3>Diferença</h3><p>R$ 1.500,00</p></div>
    </div>
    <div class="card">
        <h2>Movimentações Pendentes</h2>
        <table>
            <thead><tr><th>Data</th><th>Descrição</th><th class="valor">Valor</th><th>Status</th></tr></thead>
            <tbody><tr><td colspan="4">Nenhuma movimentação pendente</td></tr></tbody>
        </table>
    </div>
    <p style="margin-top: 20px;"><a href="menu.jsp">← Voltar ao Menu</a></p>
</div>
<script>
    function iniciarConciliacao() { alert('Conciliação iniciada!'); }
</script>
</body>
</html>
