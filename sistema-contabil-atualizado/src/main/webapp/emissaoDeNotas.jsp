<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Emissão de Notas - Sistema Contábil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="resources/css/consolidated_styles.css">
</head>
<body>

<div class="container">

    <h1>Emissão de Notas</h1>

    <div id="message" class="message"></div>

    <!-- DADOS DA NOTA -->
    <div class="card">
        <h2>Dados da Nota</h2>

        <div class="row">
            <div>
                <label>Número da Nota</label>
                <input type="text" id="numeroNota" placeholder="Gerado automaticamente">
            </div>
            <div>
                <label>Data de Emissão</label>
                <input type="date" id="dataEmissao" required>
            </div>
            <div>
                <label>Tipo de Nota</label>
                <select id="tipoNota">
                    <option value="NFE">NF-e (Produto)</option>
                    <option value="NFSE">NFS-e (Serviço)</option>
                </select>
            </div>
        </div>
    </div>

    <!-- DADOS DO CLIENTE -->
    <div class="card">
        <h2>Cliente / Destinatário</h2>

        <div class="row">
            <div>
                <label>Nome / Razão Social</label>
                <input type="text" id="clienteNome" required>
            </div>
            <div>
                <label>CPF / CNPJ</label>
                <input type="text" id="clienteDocumento" required>
            </div>
            <div>
                <label>Email</label>
                <input type="email" id="clienteEmail">
            </div>
        </div>
    </div>

    <!-- ITENS DA NOTA -->
    <div class="card">
        <h2>Itens da Nota</h2>

        <table id="tabelaItens">
            <thead>
                <tr>
                    <th>Descrição</th>
                    <th>Qtd</th>
                    <th>Valor Unitário</th>
                    <th>Total</th>
                    <th>Ação</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>

        <div class="actions">
            <button class="btn btn-secondary" onclick="adicionarItem()">+ Adicionar Item</button>
        </div>

        <div class="total">
            Total da Nota: R$ <span id="totalNota">0,00</span>
        </div>
    </div>

    <!-- AÇÕES -->
    <div class="actions">
        <button class="btn btn-primary" onclick="emitirNota()">Emitir Nota</button>
        <a href="menu.jsp" class="btn btn-danger">Cancelar</a>
    </div>

</div>

<script>
    function adicionarItem() {
        const tbody = document.querySelector('#tabelaItens tbody');
        const tr = document.createElement('tr');

        tr.innerHTML = `
            <td><input type="text" class="descricao"></td>
            <td><input type="number" class="quantidade" value="1" min="1" onchange="calcularTotal()"></td>
            <td><input type="number" class="valor" step="0.01" value="0" onchange="calcularTotal()"></td>
            <td class="totalItem">0,00</td>
            <td><button class="btn btn-danger" onclick="this.closest('tr').remove(); calcularTotal()">X</button></td>
        `;

        tbody.appendChild(tr);
    }

    function calcularTotal() {
        let total = 0;

        document.querySelectorAll('#tabelaItens tbody tr').forEach(tr => {
            const qtd = parseFloat(tr.querySelector('.quantidade').value) || 0;
            const valor = parseFloat(tr.querySelector('.valor').value) || 0;
            const subtotal = qtd * valor;

            tr.querySelector('.totalItem').innerText = subtotal.toFixed(2).replace('.', ',');
            total += subtotal;
        });

        document.getElementById('totalNota').innerText = total.toFixed(2).replace('.', ',');
    }

    function emitirNota() {
        const itens = [];

        document.querySelectorAll('#tabelaItens tbody tr').forEach(tr => {
            itens.push({
                descricao: tr.querySelector('.descricao').value,
                quantidade: tr.querySelector('.quantidade').value,
                valor: tr.querySelector('.valor').value
            });
        });

        const payload = {
            area: 'notas',
            action: 'emitirNota',
            tipoNota: document.getElementById('tipoNota').value,
            dataEmissao: document.getElementById('dataEmissao').value,
            clienteNome: document.getElementById('clienteNome').value,
            clienteDocumento: document.getElementById('clienteDocumento').value,
            clienteEmail: document.getElementById('clienteEmail').value,
            itens: itens
        };

        fetch('MainServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        })
        .then(r => r.json())
        .then(data => {
            const msg = document.getElementById('message');
            if (data.status === 'success') {
                msg.className = 'message success';
                msg.innerText = data.message;
            } else {
                msg.className = 'message error';
                msg.innerText = data.message;
            }
            msg.style.display = 'block';
        })
        .catch(() => {
            alert('Erro ao emitir nota.');
        });
    }
</script>

</body>
</html>
