pipeline {
    agent any

    environment {
        IMAGE_NAME = "mouhaned/food-delivery"
        DOCKER_BIN = "/usr/bin/docker"
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Récupération du code...'
                git branch: 'main', url: 'https://github.com/mouhaned07/food-delivery.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Jenkins va utiliser l'emplacement configuré dans l'interface Tools
                    def dockerTool = tool name: 'docker', type: 'docker-installer'
                    withEnv(["PATH+DOCKER=${dockerTool}/bin"]) {
                    sh 'docker build -t $IMAGE_NAME:latest .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'DOCKER_PASS')]) {
                        echo '📤 Connexion et Envoi vers Docker Hub...'
                        sh """
                        echo ${DOCKER_PASS} | ${DOCKER_BIN} login -u mouhaned07 --password-stdin
                        ${DOCKER_BIN} push ${IMAGE_NAME}:latest
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo '🚀 Déploiement Kubernetes...'
                sh 'kubectl apply -f k8s/ || echo "Erreur k8s ignorée"'
            }
        }
    }
}