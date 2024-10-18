#!/bin/bash

# Fonction pour écrire les informations sur tous les terminaux
function display_info {
    {
        echo "-----------------------------------"
        echo "Informations système - $(date)"
        echo "Architecture: $(uname -m)"
        echo "Version du kernel: $(uname -r)"
        echo "Nombre de processeurs physiques: $(nproc --all | awk '{print $1/2}')"
        echo "Nombre de processeurs virtuels: $(nproc --all)"
        echo "Mémoire vive disponible: $(free -m | awk '/^Mem:/{print $7 " MB (" $3/$2*100 "% utilisé)"}')"
        echo "Mémoire totale disponible: $(df -h / | awk 'NR==2{print $4 " (" $5 " utilisé)"}')"
        echo "Taux d'utilisation des processeurs: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1 "%"}')"
        echo "Date et heure du dernier redémarrage: $(who -b | awk '{print $3, $4}')"
        echo "LVM actif: $(if [ $(lsblk | grep lvm | wc -l) -gt 0 ]; then echo "Oui"; else echo "Non"; fi)"
        echo "Connexions actives: $(who | wc -l)"
        echo "Utilisateurs connectés: $(who | cut -d ' ' -f1 | sort | uniq | wc -l)"
        echo "Adresse IPv4: $(hostname -I | awk '{print $1}')"
        echo "Adresse MAC: $(ip link show | awk '/ether/ {print $2}')"
        echo "Commandes exécutées avec sudo: $(grep 'sudo' /var/log/auth.log | wc -l)"
        echo "-----------------------------------"
    } | wall
}
