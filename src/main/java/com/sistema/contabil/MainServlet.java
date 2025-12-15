package com.sistema.contabil;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/MainServlet")
public class MainServlet extends HttpServlet {

    // Simulação de "Banco de Dados" em memória
    private static final List<Map<String, Object>> LANCAMENTOS = new ArrayList<>();
    private static final List<Map<String, Object>> FUNCIONARIOS = new ArrayList<>();

    static {
        // Dados iniciais de exemplo
        Map<String, Object> lancamento1 = new HashMap<>();
        lancamento1.put("id", 1);
        lancamento1.put("data", "2025-12-01");
        lancamento1.put("historico", "Pagamento de Aluguel");
        lancamento1.put("valor", 2500.00);
        lancamento1.put("conta", "Despesas Operacionais");
        LANCAMENTOS.add(lancamento1);

        Map<String, Object> func1 = new HashMap<>();
        func1.put("id", 101);
        func1.put("nome", "Ana Silva");
        func1.put("cargo", "Contadora");
        func1.put("salario", 5000.00);
        FUNCIONARIOS.add(func1);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        String area = request.getParameter("area");
        String action = request.getParameter("action");

        if (area == null || action == null) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Área ou Ação não especificada.");
            out.print(jsonResponse.toJSONString());
            return;
        }

        try {
            switch (area) {
                case "contabilidade":
                    handleContabilidade(action, request, jsonResponse);
                    break;
                case "fiscal":
                    handleFiscal(action, request, jsonResponse);
                    break;
                case "rh":
                    handleRH(action, request, jsonResponse);
                    break;
                default:
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "Área inválida.");
                    break;
            }
        } catch (Exception e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Erro interno do servidor: " + e.getMessage());
        }

        out.print(jsonResponse.toJSONString());
    }

    // --- Handlers por Área ---

    private void handleContabilidade(String action, HttpServletRequest request, JSONObject jsonResponse) {
        switch (action) {
            case "salvarLancamento":
                salvarLancamento(request, jsonResponse);
                break;
            case "listarLancamentos":
                listarLancamentos(jsonResponse);
                break;
            default:
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Ação de Contabilidade inválida.");
                break;
        }
    }

    private void handleFiscal(String action, HttpServletRequest request, JSONObject jsonResponse) {
        switch (action) {
            case "apurarImpostos":
                apurarImpostos(request, jsonResponse);
                break;
            default:
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Ação Fiscal inválida.");
                break;
        }
    }

    private void handleRH(String action, HttpServletRequest request, JSONObject jsonResponse) {
        switch (action) {
            case "cadastrarFuncionario":
                cadastrarFuncionario(request, jsonResponse);
                break;
            case "listarFuncionarios":
                listarFuncionarios(jsonResponse);
                break;
            default:
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Ação de RH inválida.");
                break;
        }
    }

    // --- Métodos de Lógica de Negócio (Simulados) ---

    private void salvarLancamento(HttpServletRequest request, JSONObject jsonResponse) {
        String data = request.getParameter("dataLancamento");
        String historico = request.getParameter("historico");
        String valorStr = request.getParameter("valor");
        String conta = request.getParameter("contaContabil");

        try {
            double valor = Double.parseDouble(valorStr);
            Map<String, Object> novoLancamento = new HashMap<>();
            novoLancamento.put("id", LANCAMENTOS.size() + 1);
            novoLancamento.put("data", data);
            novoLancamento.put("historico", historico);
            novoLancamento.put("valor", valor);
            novoLancamento.put("conta", conta);

            LANCAMENTOS.add(novoLancamento);

            jsonResponse.put("status", "success");
            jsonResponse.put("message", "Lançamento contábil salvo com sucesso (ID: " + novoLancamento.get("id") + ").");
            jsonResponse.put("lancamento", new JSONObject(novoLancamento));

        } catch (NumberFormatException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Valor inválido fornecido.");
        }
    }

    private void listarLancamentos(JSONObject jsonResponse) {
        JSONArray lancamentosArray = new JSONArray();
        lancamentosArray.addAll(LANCAMENTOS);

        jsonResponse.put("status", "success");
        jsonResponse.put("lancamentos", lancamentosArray);
    }

    private void apurarImpostos(HttpServletRequest request, JSONObject jsonResponse) {
        String periodo = request.getParameter("periodo");
        // Lógica de apuração simulada
        double totalReceita = 150000.00;
        double impostoSimples = totalReceita * 0.06; // Simples Nacional 6%

        JSONObject resultado = new JSONObject();
        resultado.put("periodo", periodo);
        resultado.put("totalReceita", totalReceita);
        resultado.put("impostoApurado", impostoSimples);
        resultado.put("vencimento", "2026-01-20");

        jsonResponse.put("status", "success");
        jsonResponse.put("message", "Apuração de impostos para o período " + periodo + " concluída.");
        jsonResponse.put("resultado", resultado);
    }

    private void cadastrarFuncionario(HttpServletRequest request, JSONObject jsonResponse) {
        String nome = request.getParameter("nome");
        String cargo = request.getParameter("cargo");
        String salarioStr = request.getParameter("salario");

        try {
            double salario = Double.parseDouble(salarioStr);
            Map<String, Object> novoFuncionario = new HashMap<>();
            novoFuncionario.put("id", FUNCIONARIOS.size() + 101);
            novoFuncionario.put("nome", nome);
            novoFuncionario.put("cargo", cargo);
            novoFuncionario.put("salario", salario);

            FUNCIONARIOS.add(novoFuncionario);

            jsonResponse.put("status", "success");
            jsonResponse.put("message", "Funcionário " + nome + " cadastrado com sucesso.");
            jsonResponse.put("funcionario", new JSONObject(novoFuncionario));

        } catch (NumberFormatException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Salário inválido fornecido.");
        }
    }

    private void listarFuncionarios(JSONObject jsonResponse) {
        JSONArray funcionariosArray = new JSONArray();
        funcionariosArray.addAll(FUNCIONARIOS);

        jsonResponse.put("status", "success");
        jsonResponse.put("funcionarios", funcionariosArray);
    }
}
