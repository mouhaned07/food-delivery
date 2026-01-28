pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo '📥 Récupération du code'
                checkout scm
            }
        }

        stage('Build Docker Images') {
            steps {
                echo '🐳 Build des images Docker'
                sh 'docker compose build'
            }
        }

        stage('Security Scan (Trivy)') {
            steps {
                echo '🔐 Scan de sécurité Trivy'
                sh '''
                trivy image --severity HIGH,CRITICAL frontend || true
                trivy image --severity HIGH,CRITICAL backend || true
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo '🚀 Déploiement Kubernetes'
                sh 'kubectl apply -f k8s/'
            }
        }
    }
}

