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
                    bat 'npm install'
                 }
            }
        }
        stage('npm build'){
            steps {
                echo 'buildteset'
                 dir('my-app'){
                    bat 'npm run build'
                 }
            }
        }
        stage('before remove buildFile'){
            steps{
                echo 'test'
                dir('my-app'){
                    bat 'ssh EaBell@192.168.10.173 "rm -rf /home/EaBell/temp/build"'
                }
            }
        }
        stage('send buildFile'){
            steps{
                echo 'send builFile jenkins -> targetServer'
                dir('my-app'){
                    bat 'scp build EaBell@192.168.10.173:~/temp'
                    bat 'ssh EaBell@192.168.10.173 "chmod -R 755 /home/EaBell/temp/build"'
                }
            }
        }
    }
}
