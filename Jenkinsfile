pipeline {
    agent any
    stages {
        stage('Test Setup') {
            steps {
                // Force la création de l'espace de travail
                sh 'echo "Initialisation du dossier..." '
            }
        }
        stage('Build Docker') {
            steps {
                script {
                    // Utilise l'outil configuré dans Jenkins
                    docker.withTool('docker') {
                        sh 'docker --version'
                        // Si ça marche, on tente le build
                        // sh 'docker compose build' 
                    }
                }
            }
        }
    }
}
