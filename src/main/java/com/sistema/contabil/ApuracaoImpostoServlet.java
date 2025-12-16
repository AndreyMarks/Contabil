package com.sistema.contabil;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/apuracaoImposto.jsp")
public class ApuracaoImpostoServlet extends HttpServlet {

    public static class Imposto {
        private String nome;
        private String aliquota;
        private String base;
        private String valor;
        private String status;

        public Imposto(String nome, String aliquota, String base, String valor, String status) {
            this.nome = nome;
            this.aliquota = aliquota;
            this.base = base;
            this.valor = valor;
            this.status = status;
        }

        public String getNome() { return nome; }
        public String getAliquota() { return aliquota; }
        public String getBase() { return base; }
        public String getValor() { return valor; }
        public String getStatus() { return status; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Imposto> impostos = new ArrayList<>();
        impostos.add(new Imposto("ICMS", "18%", "R$ 50.000", "R$ 9.000", "Pendente"));
        impostos.add(new Imposto("PIS", "1,65%", "R$ 50.000", "R$ 825", "Pago"));

        request.setAttribute("impostos", impostos);

        request.getRequestDispatcher("/apuracaoDeImpostos.jsp")
               .forward(request, response);
    }
}
