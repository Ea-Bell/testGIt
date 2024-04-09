pipeline {
    agent any
    stages {
        stage('GitHub Repository Clone') {
            steps {
                git branch: 'main',
                    credentialsId: 'rayful',
                    url: 'https://github.com/Ea-Bell/testGItJenkinsTest.git'
            }
        }
        stage('build'){
            steps {
                echo 'buildteset'
                 dir('my-app'){
                    sh 'npm install'
                    sh 'npm run build'
                 }
            }
        }
    }
}