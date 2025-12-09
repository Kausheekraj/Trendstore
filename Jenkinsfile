pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_IMAGE    = 'yourname/trend'
        DOCKER_CREDS    = credentials('dockerhub-creds')  // add in Jenkins
        AWS_REGION      = 'us-east-2'
        EKS_CLUSTER     = 'trend-eks'
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/YOUR_GITHUB_USERNAME/Trend.git'
            }
        }

        stage('Build Docker image') {
            steps {
                sh """
                  docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} .
                  docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_IMAGE}:latest
                """
            }
        }

        stage('Push Docker image') {
            steps {
                sh """
                  echo ${DOCKER_CREDS_PSW} | docker login -u ${DOCKER_CREDS_USR} --password-stdin ${DOCKER_REGISTRY}
                  docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}
                  docker push ${DOCKER_IMAGE}:latest
                """
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh """
                  aws eks update-kubeconfig --name ${EKS_CLUSTER} --region ${AWS_REGION}
                  kubectl apply -f k8s/deployment.yaml
                  kubectl apply -f k8s/service.yaml
                """
            }
        }
    }

    post {
        success {
            echo "Deployment successful!"
        }
        failure {
            echo "Build or deployment failed."
        }
    }
}

