pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'tonkaxxx/anout-me-pet'
        KUBE_CONFIG = credentials('kubeconfig')
    }

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Test') {
            steps {
                sh 'echo "Running some tests..."'
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'kubectl apply -f k8s/'
                sh 'kubectl rollout status deployment/webapp'
            }
        }
    }

    post {
        failure {
            sh 'echo "Something went wrong!"'
        }
        success {
            sh 'echo "Well done!"'
        }
    }
}
