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
                script {
                    // On utilise le plugin Docker pour charger l'outil 'docker'
                    docker.withTool('docker') {
                        echo '🐳 Construction de l\'image Docker...'
                        sh 'docker build -t ${IMAGE_NAME}:latest .'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withTool('docker') {
                        withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'DOCKER_PASS')]) {
                            echo '📤 Envoi vers Docker Hub...'
                            sh """
                            echo ${DOCKER_PASS} | docker login -u mouhaned07 --password-stdin
                            docker push ${IMAGE_NAME}:latest
                            """
                        }
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo '🚀 Déploiement Kubernetes...'
                sh 'kubectl apply -f k8s/ || echo "Erreur Kubernetes"'
            }
        }
    }
}