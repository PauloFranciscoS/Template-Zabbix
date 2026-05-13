# Zabbix Template - Nobreak SNMP (UPS-MIB)

Template completo para monitoramento de Nobreaks e UPS que utilizam a RFC 1628 (UPS-MIB) via SNMP. Desenvolvido e testado no **Zabbix 7.0**.

Este template não apenas coleta os dados via SNMP, mas também utiliza *Simple Checks* (ICMP) para monitorar a disponibilidade da placa de rede do Nobreak.

## 📦 O que este template monitora?

### 🔋 Bateria
* Carga Restante da Bateria (%)
* Tensão da Bateria (V) - *Com pré-processamento automático*
* Temperatura da Bateria (°C)
* Status de Saúde da Bateria (Normal, Bateria Baixa, Esgotada, etc.)

### ⚡ Energia (Entrada e Saída)
* Tensão de Entrada da Rede (V)
* Frequência de Entrada (Hz)
* Tensão de Saída para os Equipamentos (V)
* Fonte de Saída Atual (Detector instantâneo de queda de energia)

### 🌐 Rede
* Status do Ping (Nobreak Acessível/Inacessível)
* Perda de Pacotes ICMP (%)

## 🚨 Triggers (Alertas) Inclusas
* **[Alta]** Nobreak operando na Bateria (Falta de energia da concessionária!)
* **[Desastre]** Nobreak com bateria abaixo de 30% (Risco de Desligamento)
* **[Média]** Temperatura do Nobreak Alta (> 35°C)
* **[Alta]** Nobreak Inacessível (Ping Down)
* **[Aviso]** Alta perda de pacotes na rede (>20% em 5 min)

## ⚙️ Como Instalar

1. Faça o download do arquivo `template_nobreak.yaml` deste repositório.
2. No seu Zabbix, vá em **Data collection** -> **Templates** e clique em **Import**.
3. Selecione o arquivo e importe.
4. Vá até o Host do seu Nobreak e vincule o template `Template Nobreak SNMP`.
5. **Importante:** Certifique-se de configurar a Macro `{$SNMP_COMMUNITY}` no seu Host com a community string correta do seu equipamento (ex: `public`).
6. Adicione uma interface **SNMP** no host com o IP do Nobreak.

---
*Template criado para ajudar a comunidade Zabbix.*
