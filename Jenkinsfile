pipeline {
    agent any

    environment {
        IMAGE_NAME = "mouhaned07/food-delivery"
        // On définit le nom de l'outil configuré dans Jenkins Tools
        DOCKER_TOOL = 'docker' 
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
                    // Utilise l'outil nommé 'docker' configuré dans Administrer Jenkins > Tools
                    def dockerPath = tool name: "${DOCKER_TOOL}", type: 'docker-installer'
                    withEnv(["PATH+DOCKER=${dockerPath}/bin"]) {
                        echo '🐳 Construction de l\'image Docker...'
                        sh 'docker build -t ${IMAGE_NAME}:latest .'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    def dockerPath = tool name: "${DOCKER_TOOL}", type: 'docker-installer'
                    withEnv(["PATH+DOCKER=${dockerPath}/bin"]) {
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
                // Le binaire kubectl doit être dans /usr/local/bin comme dans votre docker.jenkins
                sh 'kubectl apply -f k8s/ || echo "Erreur Kubernetes"'
            }
        }
    }
} // Fin du pipeline