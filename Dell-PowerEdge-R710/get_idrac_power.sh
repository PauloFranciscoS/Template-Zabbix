#!/bin/bash
# Proteção absoluta contra caracteres especiais na senha
IP="$1"
USER="$2"
PASS="$3"

sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password -o ConnectTimeout=15 "$USER@$IP" "racadm getconfig -g cfgServerPower"
