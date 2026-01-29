pipeline {
    agent any

    environment {
        IMAGE_NAME = "mouhaned07/food-delivery"
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
                echo '🐳 Construction de l\'image...'
                // Pas besoin de withTool car tu as lancé Jenkins en root avec accès au pipe Docker
                sh 'docker build -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'DOCKER_PASS')]) {
                    echo '📤 Envoi vers Docker Hub...'
                    sh """
                    echo ${DOCKER_PASS} | docker login -u mouhaned07 --password-stdin
                    docker push ${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo '🚀 Déploiement Kubernetes...'
                sh 'kubectl apply -f k8s/ || echo "Fichiers k8s manquants"'
            }
        }
    }
}