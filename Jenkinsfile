pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Code récupéré depuis GitHub'
            }
        }

        stage('Build Docker') {
            steps {
                sh 'docker --version'
                sh 'docker compose version'
                sh 'docker compose build'
            }
        }
    }
}

