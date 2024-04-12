pipeline {
    agent any

    environment {
        GIT_URL = 'https://github.com/Ea-Bell/testGItJenkinsTest.git'
        GIT_BRANCH= 'main'
        CREDENTIALSID= 'rayful'
        TARGET_IP='192.168.10.173'
        TARGET_ID='EaBell'
        TARGET_BUILD_FILEPATH='/home/EaBell/temp/build' 
    }
    stages {
        stage('GitHub Repository Clone') {
            steps {
                git branch: ${GIT_BRANCH},
                    credentialsId: ${CREDENTIALSID},
                    url: ${GIT_URL}
            }
        }
        stage('npm build'){
            steps {
                echo 'buildteset'
                 dir('my-app'){
                    bat 'npm install'
                    bat 'npm run build'
                 }
            }
        }
        stage('Deploy'){
            steps{
                echo 'send builFile jenkins -> targetServer'
                dir('my-app'){
                    bat 'ssh '{TARGET_ID}'@'${TARGET_IP}' "rm -rf '${TARGET_BUILD_FILEPATH}'"'
                    bat 'scp -r build '{TARGET_ID}'@'${TARGET_IP}':'${TARGET_BUILD_FILEPATH}''
                    bat 'ssh '{TARGET_ID}'@'${TARGET_IP}' "chmod -R 755 '${TARGET_BUILD_FILEPATH}'"'
                }
            }
        }
    }
}
