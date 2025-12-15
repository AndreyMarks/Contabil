<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Folha de Pagamento - Sistema Contábil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>
<div class="container">
    <h1>Folha de Pagamento</h1>
    <div class="card">
        <h2>Gerar Folha de Pagamento</h2>
        <div class="form-grid">
            <div><label>Mês/Ano</label><input type="month"></div>
            <div><label>Departamento</label><select><option>Todos</option><option>Administrativo</option><option>Operacional</option></select></div>
        </div>
        <button class="btn" onclick="gerarFolha()">Gerar Folha</button>
    </div>
    <div class="cards">
        <div class="card-stat"><h3>Total Bruto</h3><p>R$ 45.000,00</p></div>
        <div class="card-stat"><h3>Total Descontos</h3><p>R$ 8.500,00</p></div>
        <div class="card-stat"><h3>Total Líquido</h3><p>R$ 36.500,00</p></div>
    </div>
    <div class="card">
        <h2>Funcionários</h2>
        <table>
            <thead><tr><th>Matrícula</th><th>Nome</th><th>Cargo</th><th class="valor">Salário Base</th><th class="valor">Descontos</th><th class="valor">Líquido</th></tr></thead>
            <tbody>
                <tr><td>001</td><td>João Silva</td><td>Analista</td><td class="valor">R$ 5.000,00</td><td class="valor">R$ 900,00</td><td class="valor">R$ 4.100,00</td></tr>
                <tr><td>002</td><td>Maria Santos</td><td>Gerente</td><td class="valor">R$ 8.000,00</td><td class="valor">R$ 1.500,00</td><td class="valor">R$ 6.500,00</td></tr>
            </tbody>
        </table>
    </div>
    <p style="margin-top: 20px;"><a href="menu.jsp">← Voltar ao Menu</a></p>
</div>
<script>
    function gerarFolha() { alert('Folha de pagamento gerada com sucesso!'); }
</script>
</body>
</html>
