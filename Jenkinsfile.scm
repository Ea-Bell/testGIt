pipeline {
    agent any
    stages {
        stage('ready') {
            steps {
                git branch: 'main',
                    credentialsId: 'rayful',
                    url: 'https://github.com/Ea-Bell/testGItJenkinsTest.git'
            }
        }
        stage('build'){
            steps {
               sh 
               '''
                npm run build
               '''
            }
        }
    }
}