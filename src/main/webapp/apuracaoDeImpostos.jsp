<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Apuração de Impostos</title>
  <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>

<header>
  <h1>Apuração de Impostos</h1>
  <p>Cálculo e controle de obrigações fiscais</p>
</header>

<main>

  <section class="box">
    <label>Período:</label>
    <select>
      <option>Janeiro 2024</option>
      <option>Fevereiro 2024</option>
      <option>Março 2024</option>
    </select>
  </section>

  <section class="cards">
    <div class="card"><h3>Base de Cálculo</h3><p>R$ 210.000,00</p></div>
    <div class="card red"><h3>Total de Impostos</h3><p>R$ 26.825,00</p></div>
    <div class="card yellow"><h3>Pendente</h3><p>R$ 22.400,00</p></div>
    <div class="card green"><h3>Pago</h3><p>R$ 4.425,00</p></div>
  </section>

  <section class="box">
    <table>
      <thead>
        <tr>
          <th>Imposto</th>
          <th>Alíquota</th>
          <th>Base</th>
          <th>Valor</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="i" items="${impostos}">
          <tr>
            <td>${i.nome}</td>
            <td>${i.aliquota}</td>
            <td>${i.base}</td>
            <td>${i.valor}</td>
            <td class="${i.status == 'Pago' ? 'pago' : 'pendente'}">
              ${i.status}
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </section>

</main>

<footer>
  <p>Sistema Contábil Web © 2025</p>
</footer>

</body>
</html>
