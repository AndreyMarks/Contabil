<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Gestão de Funcionários - Sistema Contábil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>
<div class="container">
    <h1>Gestão de Funcionários</h1>
    <div class="card">
        <h2>Adicionar Funcionário</h2>
        <div class="form-grid">
            <div><label>Nome</label><input type="text" placeholder="Nome completo"></div>
            <div><label>CPF</label><input type="text" placeholder="000.000.000-00"></div>
            <div><label>Email</label><input type="email" placeholder="email@example.com"></div>
            <div><label>Cargo</label><input type="text" placeholder="Cargo"></div>
            <div><label>Departamento</label><select><option>Administrativo</option><option>Operacional</option><option>Financeiro</option></select></div>
            <div><label>Salário</label><input type="number" step="0.01" placeholder="0.00"></div>
        </div>
        <button class="btn" onclick="adicionarFuncionario()">Adicionar</button>
    </div>
    <div class="card">
        <h2>Funcionários Cadastrados</h2>
        <table>
            <thead><tr><th>Matrícula</th><th>Nome</th><th>CPF</th><th>Cargo</th><th>Departamento</th><th>Status</th><th>Ação</th></tr></thead>
            <tbody>
                <tr><td>001</td><td>João Silva</td><td>123.456.789-00</td><td>Analista</td><td>Administrativo</td><td><span class="status ativo">Ativo</span></td><td><button class="btn btn-secondary" onclick="editarFuncionario(1)">Editar</button> <button class="btn btn-danger" onclick="deletarFuncionario(1)">Deletar</button></td></tr>
                <tr><td>002</td><td>Maria Santos</td><td>987.654.321-00</td><td>Gerente</td><td>Financeiro</td><td><span class="status ativo">Ativo</span></td><td><button class="btn btn-secondary" onclick="editarFuncionario(2)">Editar</button> <button class="btn btn-danger" onclick="deletarFuncionario(2)">Deletar</button></td></tr>
            </tbody>
        </table>
    </div>
    <p style="margin-top: 20px;"><a href="menu.jsp">← Voltar ao Menu</a></p>
</div>
<script>
    function adicionarFuncionario() { alert('Funcionário adicionado com sucesso!'); }
    function editarFuncionario(id) { alert('Editando funcionário ' + id); }
    function deletarFuncionario(id) { if(confirm('Deseja deletar?')) alert('Funcionário deletado!'); }
</script>
</body>
</html>
