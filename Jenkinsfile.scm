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
        stage('npm install'){
            steps {
                echo 'install'
                 dir('my-app'){
                    sh 'npm install'
                 }
            }
        }
        // stage('npm build'){
        //     steps {
        //         echo 'buildteset'
        //          dir('my-app'){
        //             sh 'npm run build'
        //          }
        //     }
        // }
    }
}