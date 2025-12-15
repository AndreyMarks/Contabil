<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Principal - Sistema Contábil</title>
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>
    <div class="menu-container">
        <header class="header">
            <h1>Sistema Contábil</h1>
            <button id="logoutBtn" class="btn-logout">Sair</button>
        </header>
        
        <main class="main-content">
            <h2>Bem-vindo, <%= session.getAttribute("usuario") != null ? session.getAttribute("usuario") : "Usuário" %>!</h2>
            <p>Selecione uma opção abaixo para começar.</p>
            
            <div class="menu-grid">
                <section class="menu-section">
                    <h2>Contabilidade</h2>
                    <div class="button-group">
                        <button class="btn-menu" onclick="window.location.href='lancamentosContabeis.jsp'">Lançamentos Contábeis</button>
                        <button class="btn-menu" onclick="window.location.href='planoDeContas.jsp'">Plano de Contas</button>
                        <button class="btn-menu" onclick="window.location.href='relatoriosFinanceiros.jsp'">Relatórios Financeiros</button>
                        <button class="btn-menu" onclick="window.location.href='livroDiarioRazao.jsp'">Livro Diário/Razão</button>
                        <button class="btn-menu" onclick="window.location.href='conciliacaoBancaria.jsp'">Conciliação Bancária</button>
                        <button class="btn-menu" onclick="window.location.href='ativoImobilizado.jsp'">Ativo Imobilizado</button>
                    </div>
                </section>
                
                <section class="menu-section">
                    <h2>Fiscal</h2>
                    <div class="button-group">
                        <button class="btn-menu" onclick="window.location.href='emissaoDeNotas.jsp'">Emissão de Notas</button>
                        <button class="btn-menu" onclick="window.location.href='apuracaoDeImpostos.jsp'">Apuração de Impostos</button>
                        <button class="btn-menu" onclick="window.location.href='declaracoes.jsp'">Declarações</button>
                    </div>
                </section>
                
                <section class="menu-section">
                    <h2>Recursos Humanos</h2>
                    <div class="button-group">
                        <button class="btn-menu" onclick="window.location.href='folhaDePagamento.jsp'">Folha de Pagamento</button>
                        <button class="btn-menu" onclick="window.location.href='gestaoDeFuncionarios.jsp'">Gestão de Funcionários</button>
                        <button class="btn-menu" onclick="window.location.href='feriasERescisoes.jsp'">Férias e Rescisões</button>
                    </div>
                </section>
            </div>
        </main>
    </div>
    
    <script src="resources/js/menu.js"></script>
</body>
</html>
