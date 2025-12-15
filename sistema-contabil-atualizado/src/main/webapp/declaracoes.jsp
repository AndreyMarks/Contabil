<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Declarações - Sistema Contábil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>
<div class="container">
    <h1>Declarações</h1>
    <div class="card">
        <h2>Declarações Disponíveis</h2>
        <div class="declaracoes-grid">
            <div class="decl-item">
                <h3>ECF - Escrituração Contábil Fiscal</h3>
                <p>Transmissão obrigatória de dados contábeis à Receita Federal.</p>
                <button class="btn" onclick="abrirDeclaracao('ecf')">Gerar</button>
            </div>
            <div class="decl-item">
                <h3>ECD - Escrituração Contábil Digital</h3>
                <p>Arquivo digital com toda a escrituração contábil da empresa.</p>
                <button class="btn" onclick="abrirDeclaracao('ecd')">Gerar</button>
            </div>
            <div class="decl-item">
                <h3>IRPJ - Imposto de Renda Pessoa Jurídica</h3>
                <p>Declaração do imposto de renda da empresa.</p>
                <button class="btn" onclick="abrirDeclaracao('irpj')">Gerar</button>
            </div>
            <div class="decl-item">
                <h3>CSLL - Contribuição Social sobre Lucro Líquido</h3>
                <p>Declaração da contribuição social da empresa.</p>
                <button class="btn" onclick="abrirDeclaracao('csll')">Gerar</button>
            </div>
        </div>
    </div>
    <div class="card">
        <h2>Histórico de Declarações</h2>
        <table>
            <thead><tr><th>Tipo</th><th>Período</th><th>Data Envio</th><th>Status</th></tr></thead>
            <tbody>
                <tr><td>ECF</td><td>2024/01</td><td>15/02/2024</td><td><span class="status enviado">Enviado</span></td></tr>
                <tr><td>ECD</td><td>2023</td><td>31/03/2024</td><td><span class="status enviado">Enviado</span></td></tr>
                <tr><td>IRPJ</td><td>2023</td><td>-</td><td><span class="status pendente">Pendente</span></td></tr>
            </tbody>
        </table>
    </div>
    <p style="margin-top: 20px;"><a href="menu.jsp">← Voltar ao Menu</a></p>
</div>
<script>
    function abrirDeclaracao(tipo) { alert('Gerando declaração: ' + tipo.toUpperCase()); }
</script>
</body>
</html>
