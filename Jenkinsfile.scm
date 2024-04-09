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
                echo "Current working directory: ${pwd()}"
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