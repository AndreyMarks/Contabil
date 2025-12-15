<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Relatórios Financeiros - Sistema Contábil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>
<div class="container">
    <h1>Relatórios Financeiros</h1>
    
    <!-- FILTROS -->
    <div class="card">
        <h2>Filtros</h2>
        <div class="form-grid">
            <div>
                <label>Período Inicial</label>
                <input type="date" id="dataInicio">
            </div>
            <div>
                <label>Período Final</label>
                <input type="date" id="dataFim">
            </div>
            <div>
                <label>Tipo de Relatório</label>
                <select id="tipoRelatorio">
                    <option value="">Selecione</option>
                    <option value="balanco">Balanço Patrimonial</option>
                    <option value="resultado">Demonstração de Resultado</option>
                    <option value="fluxo">Fluxo de Caixa</option>
                    <option value="mutacoes">Mutações do Patrimônio</option>
                </select>
            </div>
        </div>
        <div style="margin-top: 15px;">
            <button class="btn btn-primary" onclick="gerarRelatorio()">Gerar Relatório</button>
        </div>
    </div>
    
    <!-- RELATÓRIOS DISPONÍVEIS -->
    <div class="card">
        <h2>Relatórios Disponíveis</h2>
        <div class="relatorios-grid">
            <div class="relatorio-item">
                <h3>Balanço Patrimonial</h3>
                <p>Demonstração da situação patrimonial da empresa em determinada data.</p>
                <button class="btn btn-primary" onclick="abrirRelatorio('balanco')">Visualizar</button>
            </div>
            <div class="relatorio-item">
                <h3>Demonstração de Resultado</h3>
                <p>Resultado do exercício (lucro ou prejuízo) em determinado período.</p>
                <button class="btn btn-primary" onclick="abrirRelatorio('resultado')">Visualizar</button>
            </div>
            <div class="relatorio-item">
                <h3>Fluxo de Caixa</h3>
                <p>Entradas e saídas de caixa durante o período selecionado.</p>
                <button class="btn btn-primary" onclick="abrirRelatorio('fluxo')">Visualizar</button>
            </div>
            <div class="relatorio-item">
                <h3>Mutações do Patrimônio</h3>
                <p>Variações do patrimônio líquido durante o período.</p>
                <button class="btn btn-primary" onclick="abrirRelatorio('mutacoes')">Visualizar</button>
            </div>
        </div>
    </div>
    
    <p style="margin-top: 20px;">
        <a href="menu.jsp">← Voltar ao Menu</a>
    </p>
</div>

<script>
    function gerarRelatorio() {
        const dataInicio = document.getElementById('dataInicio').value;
        const dataFim = document.getElementById('dataFim').value;
        const tipoRelatorio = document.getElementById('tipoRelatorio').value;
        
        if (!dataInicio || !dataFim || !tipoRelatorio) {
            alert('Por favor, preencha todos os filtros.');
            return;
        }
        
        const params = new URLSearchParams({
            area: 'financeiro',
            action: 'gerarRelatorio',
            tipo: tipoRelatorio,
            dataInicio: dataInicio,
            dataFim: dataFim
        });
        
        fetch('MainServlet?' + params)
            .then(r => r.json())
            .then(data => {
                if (data.status === 'success') {
                    alert('Relatório gerado com sucesso!');
                } else {
                    alert('Erro ao gerar relatório: ' + data.message);
                }
            })
            .catch(() => alert('Erro ao gerar relatório.'));
    }
    
    function abrirRelatorio(tipo) {
        const params = new URLSearchParams({
            area: 'financeiro',
            action: 'abrirRelatorio',
            tipo: tipo
        });
        
        fetch('MainServlet?' + params)
            .then(r => r.json())
            .then(data => {
                if (data.status === 'success') {
                    alert('Relatório: ' + tipo + '\n\n' + JSON.stringify(data.dados, null, 2));
                } else {
                    alert('Erro ao abrir relatório: ' + data.message);
                }
            })
            .catch(() => alert('Erro ao abrir relatório.'));
    }
</script>
</body>
</html>
