# Zabbix Template - Dell PowerEdge R710 (Enterprise)

Template avançado para monitoramento de servidores Dell PowerEdge R710 através da interface iDRAC. Compatível com **Zabbix 7.4**.

Este template utiliza uma abordagem híbrida, combinando coletas via **SNMP**, acessos via **SSH** (comando `racadm`) e **Scripts Externos** para obter métricas precisas de consumo de energia, temperatura da placa-mãe, disponibilidade e inventário.

## 📦 O que este template monitora?

### ⚡ Energia (Power)
* Consumo Total Acumulado de Energia (kWh)
* Consumo Atual de Energia (W)
* Amperagem Atual (A)
* *Os dados de energia são extraídos de forma dependente e via script externo.*

### 🌡️ Sensores Ambientais
* Temperatura Ambiente da Placa-Mãe (System Board Ambient) em °C

### 💻 Inventário e Sistema (System Info)
* Nome do Sistema (System name)
* Modelo do Servidor (SystemModel)
* Asset Tag (Etiqueta de Patrimônio)
* Versão da BIOS (via SSH)
* Versão de Firmware da iDRAC

### 🌐 Conectividade
* ICMP Ping (Disponibilidade)
* ICMP Loss (Perda de pacotes)

## 🚨 Triggers (Alertas) Inclusos

* **[Alta]** Host indisponível: Perda de comunicação ICMP
* **[Alta]** Temperatura System Board Ambient Crítica: Acima do limite Failure (>47°C)
* **[Aviso]** Temperatura System Board Ambient Alta: Acima do limite Warning (>42°C)
* **[Alta]** Temperatura System Board Ambient Crítica: Abaixo do limite Failure (<3°C)
* **[Aviso]** Temperatura System Board Ambient Baixa: Abaixo do limite Warning (<8°C)

## ⚙️ Requisitos e Instalação

### 1. Macros do Zabbix
Para que as coletas via SSH e Script Externo funcionem, você **deve** configurar as seguintes macros no Host ou no Zabbix:
* `{$IDRAC_USER}`: Usuário da iDRAC (Padrão: `root`)
* `{$IDRAC_PASSWORD}`: Senha da iDRAC

### 2. Dependência de Script Externo
Este template requer um script externo chamado `get_idrac_power.sh` rodando no seu Zabbix Server/Proxy. 
O script deve ser capaz de receber os parâmetros `["{HOST.CONN}","{$IDRAC_USER}","{$IDRAC_PASSWORD}"]` e retornar os dados crus (Raw Data) que o Zabbix fará o parsing usando Expressões Regulares (Regex) nativas do template.

### 3. Importação
1. Importe o arquivo `Dell PowerEdge R710 - Enterprise.yaml` no seu Zabbix.
2. Crie o Host com a interface SNMP e interface Agent (para o ping/script).
3. Associe o template e preencha as macros.
