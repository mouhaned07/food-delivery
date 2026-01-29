pipeline {
    agent any

    environment {
        IMAGE_NAME = "mouhaned/food-delivery"
        // On s'assure que kubectl sait où regarder
        KUBECONFIG = "/root/.kube/config"
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Récupération du code depuis GitHub...'
                git branch: 'main', 
                    url: 'https://github.com/mouhaned07/food-delivery.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Chargement de l'outil Docker configuré dans Jenkins
                    docker.withTool('docker') {
                        echo '🐳 Construction de l\'image Docker...'
                        sh 'docker build -t $IMAGE_NAME:latest .'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withTool('docker') {
                        // Utilisation des identifiants DockerHub configurés dans Jenkins
                        withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'DOCKER_PASS')]) {
                            echo '📤 Envoi de l\'image vers Docker Hub...'
                            // REMPLACEZ 'mouhaned07' par votre vrai nom d'utilisateur Docker Hub
                            sh '''
                            echo $DOCKER_PASS | docker login -u mouhaned07 --password-stdin
                            docker push $IMAGE_NAME:latest
                            '''
                        }
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo '🚀 Déploiement sur le cluster Kubernetes...'
                // Utilise le binaire kubectl installé via votre fichier docker.jenkins
                sh '''
                kubectl apply -f k8s/namespace.yml || true
                kubectl apply -f k8s/deployment.yml
                kubectl apply -f k8s/service.yml
                '''
            }
        }
    }
}
