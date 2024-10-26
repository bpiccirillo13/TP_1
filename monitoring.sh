#!/bin/bash

echo "-----------------------------------"
echo "Informations système - $(date)"
echo "Architecture:" $(uname -m)
echo "Version du kernel:" $(uname -r)
echo "Nombre de processeurs:" $(nproc)
echo "Mémoire vive libre:" $(free -m | grep Mem | awk '{print $4 " MB"}')
echo "Espace disque libre:" $(df -h / | grep '/$' | awk '{print $4}')
echo "Utilisation du CPU:" $(top -bn1 | grep Cpu | awk '{print 100 - $8 "%"}')
echo "Dernier redémarrage:" $(who -b | awk '{print $3, $4}')
if lsblk | grep -q lvm; then
  echo "LVM actif: Oui"
else
  echo "LVM actif: Non"
fi
echo "Connexions actives:" $(who | wc -l)
echo "Adresse IP:" $(hostname -I | awk '{print $1}')
echo "Adresse MAC:" $(ip link show | grep ether | awk '{print $2}')
echo "-----------------------------------"
