<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Ativo Imobilizado</title>
    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>

<%
  class Ativo {
    String descricao, categoria, data;
    double valorOriginal, depreciacao, valorLiquido;
    Ativo(String d, String c, String dt, double vo, double dep, double vl) {
      descricao=d; categoria=c; data=dt; valorOriginal=vo; depreciacao=dep; valorLiquido=vl;
    }
  }
  java.util.List<Ativo> ativos = new java.util.ArrayList<>();
  ativos.add(new Ativo("Imóvel - Sede","Imóveis","15/01/2020",500000,50000,450000));
  ativos.add(new Ativo("Máquina Industrial A","Máquinas","20/06/2021",150000,30000,120000));
  ativos.add(new Ativo("Computador Desktop","Equipamentos","10/03/2022",5000,2000,3000));
  request.setAttribute("ativos", ativos);
%>

<header>
  <h1>Ativo Imobilizado</h1>
  <p>Gestão de bens e depreciação</p>
</header>

<main>

  <section class="cards">
    <div class="card">
      <h3>Valor Original Total</h3>
      <p>R$ 655.000,00</p>
    </div>
    <div class="card red">
      <h3>Depreciação Acumulada</h3>
      <p>R$ 82.000,00</p>
    </div>
    <div class="card green">
      <h3>Valor Líquido</h3>
      <p>R$ 573.000,00</p>
    </div>
  </section>

  <section class="box">
    <table>
      <thead>
        <tr>
          <th>Descrição</th>
          <th>Categoria</th>
          <th>Data Aquisição</th>
          <th>Valor Original</th>
          <th>Depreciação</th>
          <th>Valor Líquido</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="a" items="${ativos}">
          <tr>
            <td>${a.descricao}</td>
            <td><span class="categoria">${a.categoria}</span></td>
            <td>${a.data}</td>
            <td>R$ ${a.valorOriginal}</td>
            <td class="red">R$ ${a.depreciacao}</td>
            <td class="green">R$ ${a.valorLiquido}</td>
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
