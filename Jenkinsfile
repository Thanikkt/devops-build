pipeline {
    agent any

    environment {
        DEV_REPO = "thanik/dev"
        PROD_REPO = "thanik/prod"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'dev', url: 'https://github.com/Thanikkt/devops-build.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-build .'
            }
        }

        stage('Push to DEV Repo') {
            steps {
                sh '''
                docker tag devops-build thanik/dev:latest
                docker push thanik/dev:latest
                '''
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker rm -f devops-container || true
                docker run -d -p 80:80 --name devops-container devops-build
                '''
            }
        }

    }
