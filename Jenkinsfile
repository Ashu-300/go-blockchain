pipeline {
    agent any   // Runs on any available Jenkins agent (node)

   

    stages {

    

        stage('Build') {
            steps {
                echo "Building the project..."
                // Example: If Node.js project
                
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
                // Example test commands
                
            }
        }

        stage('Package') {
            steps {
                echo "Packaging application..."
                // Example: Create Docker image
                
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying application..."
                // Example: Run Docker container
               
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment successful!"
        }
        failure {
            echo "❌ Build or test failed!"
        }
    }
}