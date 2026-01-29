pipeline {
    agent any

    environment {
        IMAGE_NAME = "mouhaned/food-delivery"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mouhaned07/food-delivery.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // On force Jenkins à chercher docker dans les dossiers système standards
                    withEnv(['PATH+EXTRA=/usr/bin:/usr/local/bin']) {
                        echo '🐳 Construction de l\'image...'
                        sh 'docker build -t $IMAGE_NAME:latest .'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withEnv(['PATH+EXTRA=/usr/bin:/usr/local/bin']) {
                        withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'DOCKER_PASS')]) {
                            sh '''
                            echo $DOCKER_PASS | docker login -u mouhaned07 --password-stdin
                            docker push $IMAGE_NAME:latest
                            '''
                        }
                    }
                }
            }
        }
    }
}
