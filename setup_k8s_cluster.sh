#!/bin/bash

echo "============================"
echo "🚀  DÉMARRAGE DU CLUSTER KUBERNETES"
echo "============================"

# 1️⃣ Démarrage du cluster Minikube avec 3 nœuds (1 master + 2 workers)
minikube start --nodes=3 --driver=docker

# 2️⃣ Vérification des nœuds
echo "============================"
echo "✅  LISTE DES NŒUDS DU CLUSTER"
echo "============================"
kubectl get nodes -o wide

# 3️⃣ Vérification du réseau et des pods système
echo "============================"
echo "📦  PODS SYSTÈME ACTIFS"
echo "============================"
kubectl get pods -A

# 4️⃣ Informations générales du cluster
echo "============================"
echo "🌐  INFORMATIONS DU CLUSTER"
echo "============================"
kubectl cluster-info

echo "============================"
echo "🎯  CLUSTER KUBERNETES INITIALISÉ AVEC SUCCÈS"
echo "============================"
