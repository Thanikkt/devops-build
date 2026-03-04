pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = "thanikavel/dev"
        DOCKER_PROD_REPO = "thanikavel/prod"
        IMAGE_NAME = "devops-build"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'dev', url: 'https://github.com/Thanikkt/devops-build.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to DEV Repo') {
            when {
                branch 'dev'
            }
            steps {
                sh '''
                docker tag $IMAGE_NAME $DOCKER_DEV_REPO:latest
                docker push $DOCKER_DEV_REPO:latest
                '''
            }
        }

        stage('Push to PROD Repo') {
            when {
                branch 'master'
            }
            steps {
                sh '''
                docker tag $IMAGE_NAME $DOCKER_PROD_REPO:latest
                docker push $DOCKER_PROD_REPO:latest
                '''
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker rm -f devops-container || true
                docker run -d -p 80:80 --name devops-container $IMAGE_NAME
                '''
            }
        }
    }
}
