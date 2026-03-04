pipeline {
    agent any

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'dev', url: 'https://github.com/Thanikkt/devops-build.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-build .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 80:80 devops-build'
            }
        }

    }
}
