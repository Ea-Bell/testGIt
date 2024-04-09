pipeline {
    agent any
    stages {
        stage('GitHub Repository Clone') {
            steps {
                git branch: 'main',
                    credentialsId: 'rayful',
                    url: 'https://github.com/Ea-Bell/testGItJenkinsTest.git'
            }
            steps{
                echo 'step2 Test입니다'
            }
        }
        stage('build'){
            steps {
                echo 'buildteset'
                // npm run build
            }
        }
    }
}