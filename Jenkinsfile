pipeline {
    agent any

    environment {
        DEV_REPO = "thanikavel/dev"
        PROD_REPO = "thanikavel/prod"
        DOCKER_CREDS = "dockerhub-creds"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/Thanikkt/devops-build.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-build .'
            }
        }

        stage('Push to DEV Repo') {
            when {
                branch 'dev'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDS}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin
                    docker tag devops-build $DEV_REPO:latest
                    docker push $DEV_REPO:latest
                    '''
                }
            }
        }

        stage('Push to PROD Repo') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDS}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin
                    docker tag devops-build $PROD_REPO:latest
                    docker push $PROD_REPO:latest
                    '''
                }
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
}
