pipeline {
    agent any
    environment {
        //######################젠킨스 설정##############################
            JENKINS_CREDENTIALSID= 'rayful'
        //##############################################################

        //######################git 설정################################
            GIT_URL = 'https://github.com/Ea-Bell/testGItJenkinsTest.git'
            GIT_BRANCH= 'main'
        //##############################################################

        //######################설정####################################
            TARGET_IP='192.168.10.173'
            TARGET_ID='EaBell'
            TARGET_BUILD_FILEPATH='/home/EaBell/temp/build' 
        //##############################################################
    }
    stages {
        stage('GitHub Repository Clone') {
            steps {
                git branch: 'main',
                credentialsId: 'JENKINS_CREDENTIALSID',
                url: 'https://github.com/Ea-Bell/testGItJenkinsTest.git'
            }
        }
        // stage('npm build'){
        //     steps {
        //         echo 'buildteset'
        //          dir('my-app'){
        //             bat 'npm install'
        //             bat 'npm run build'
        //          }
        //     }
        // }
        // stage('Deploy'){
        //     steps{
        //         echo 'send builFile jenkins -> targetServer'
        //         dir('my-app'){
        //             bat "ssh ${env.TARGET_ID}@${env.TARGET_IP} 'rm -rf ${env.TARGET_BUILD_FILEPATH}'"
        //             bat "scp -r build ${env.TARGET_ID}@${env.TARGET_IP}:${env.TARGET_BUILD_FILEPATH}"
        //             bat "ssh ${env.TARGET_ID}@${env.TARGET_IP} 'chmod -R 755 ${env.TARGET_BUILD_FILEPATH}'"
        //         }
        //     }
        // }
    }
}
