pipeline {
    agent any

    environment {
        DOCKER_USER = "mouhaned07"

        ADMIN_IMAGE    = "food-delivery-admin"
        BACKEND_IMAGE  = "food-delivery-backend"
        FRONTEND_IMAGE = "food-delivery-frontend"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "📥 Récupération du code..."
                git branch: 'main', url: 'https://github.com/mouhaned07/food-delivery.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                echo "🐳 Build des images Docker..."
                sh '''
                  docker build -t $DOCKER_USER/$ADMIN_IMAGE:latest admin
                  docker build -t $DOCKER_USER/$BACKEND_IMAGE:latest backend
                  docker build -t $DOCKER_USER/$FRONTEND_IMAGE:latest frontend
                '''
            }
        }

        stage('Login & Push Docker Images') {
            steps {
                echo "🔐 Login DockerHub & Push images..."
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                
                        docker push $DOCKER_USER/$ADMIN_IMAGE:latest
                        docker push $DOCKER_USER/$BACKEND_IMAGE:latest
                        docker push $DOCKER_USER/$FRONTEND_IMAGE:latest
                
                        docker logout
                    '''
                   }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "🚀 Déploiement sur Minikube..."
                withCredentials([file(credentialsId: 'kubeconfig-creds', variable: 'KUBE_CONFIG_PATH')]) {
                    sh '''
                        # 1. On crée le namespace SEUL en premier
                        kubectl apply -f k8s/namespace.yml --kubeconfig=${KUBE_CONFIG_PATH}
                
                        # 2. On attend que Kubernetes l'enregistre bien
                        sleep 5
                
                        # 3. On déploie le reste (le flag -f k8s/ va tout prendre)
                        kubectl apply -f k8s/ --kubeconfig=${KUBE_CONFIG_PATH}
                    '''
                }
            }
        }
    }
    post {
        success {
            echo "✅ Pipeline terminé avec succès 🎉"
        }
        failure {
            echo "❌ Pipeline échoué"
        }
    }
}

