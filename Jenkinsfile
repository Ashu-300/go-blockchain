pipeline {
    agent any

    environment {
        // --- Update with your real values ---
        DOCKER_REGISTRY = "ashutoshnigam300"
        IMAGE_NAME = "go-blockchain-image"
        // Optional: Jenkins credentials ID for Docker Hub login (recommended)
        DOCKERHUB_CREDENTIALS_ID = "dockerhub-creds"
        // Optional: Kubernetes credentials if used later
        KUBE_CREDENTIAL_ID = "k8s-service-account-creds"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build with Jenkins BUILD_NUMBER tag and also tag as latest
                    sh """
                    docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER} .
                    docker tag ${DOCKER_REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER} ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                // Secure login using Jenkins credentials (instead of hardcoding token)
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKERHUB_CREDENTIALS_ID}",
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh """
                    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER}
                    docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest
                    docker logout
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Use Kubernetes credentials defined in Jenkins
                withKubeConfig(credentialsId: KUBE_CREDENTIAL_ID) {
                    // Apply the deployment and service YAML
                    sh "kubectl apply -f deployment.yaml"
                    
                    // Wait for the rollout to complete
                    sh "kubectl rollout status deployment/blockchain-deployment --timeout=120s"
                }
            }
        }
    }

    post {
        success {
            echo "Deployment successful! Check the service URL."
        }
        failure {
            echo "Pipeline failed. Review logs for errors."
        }
    }
}
