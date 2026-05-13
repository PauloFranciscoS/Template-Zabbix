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
Este template exige a execução de um script externo na máquina do seu Zabbix Server ou Zabbix Proxy. O script utiliza o pacote `sshpass` para realizar a autenticação.

**Passo a passo da instalação do script:**
1. Instale o utilitário `sshpass` no seu servidor Zabbix Linux:
   ```bash
   apt update && apt install sshpass -y  # Para Debian/Ubuntu
   yum install sshpass -y                # Para RHEL/CentOS
   ```
2. Baixe o script get_idrac_power.sh deste repositório.
3. Mova o script para o diretório de ExternalScripts do Zabbix (o padrão é /usr/lib/zabbix/externalscripts/):
  ```bash
  mv get_idrac_power.sh /usr/lib/zabbix/externalscripts/ 
   ```
4. Ajuste as permissões e o dono do arquivo para que o usuário do Zabbix consiga executá-lo sem tomar "Permission Denied":
   ```bash
   chown zabbix:zabbix /usr/lib/zabbix/externalscripts/get_idrac_power.sh
   chmod +x /usr/lib/zabbix/externalscripts/get_idrac_power.sh 
   ```
5. Importação no Zabbix
   Importe o arquivo Dell PowerEdge R710 - Enterprise.yaml no seu frontend do Zabbix (Data collection > Templates > Import).
   
   Vá em Data collection > Hosts e crie (ou edite) o Host do seu servidor Dell.
   
   Adicione uma interface SNMP com o IP da iDRAC e uma interface Agent (pode ser o mesmo IP) para que os itens de Ping e do Script Externo consigam usar a macro {HOST.CONN}.
   
   Vá na aba "Templates" e associe o template recém-importado.
   
   Vá na aba "Macros" e preencha as credenciais.
