pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-username/anketa-app'
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
                sh 'python -m pytest tests/'
                sh 'flake8 app.py'
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
            slackSend channel: '#alerts', message: "Build ${currentBuild.currentResult}: ${env.JOB_NAME} ${env.BUILD_NUMBER}"
        }
    }
}
