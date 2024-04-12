pipeline {
    agent any

    environment {
        JENKINS_CREDENTIALSID= 'rayful'
        GIT_URL = 'https://github.com/Ea-Bell/testGItJenkinsTest.git'
        GIT_BRANCH= 'main'
        TARGET_IP='192.168.10.173'
        TARGET_ID='EaBell'
        TARGET_BUILD_FILEPATH='/home/EaBell/temp/build' 
    }
    stages {
        stage('GitHub Repository Clone') {
            steps {
                git branch: env.GIT_BRANCH,
                credentialsId: env.JENKINS_CREDENTIALSID,
                url: env.GIT_URL
            }
        }
        stage('npm build') {
            steps {
                echo 'build test'
                dir('my-app') {
                    bat 'npm install'
                    bat 'npm run build'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo "send buildFile jenkins -> targetServer"
                dir('my-app') {
                    bat """
                        ssh ${TARGET_ID}@${TARGET_IP} "rm -rf ${TARGET_BUILD_FILEPATH}"
                        scp -r build ${TARGET_IP}@${TARGET_IP}:${TARGET_BUILD_FILEPATH}
                        ssh ${TARGET_ID}@${TARGET_IP} "chmod -R 755 ${TARGET_BUILD_FILEPATH}"
                        """
                }
            }
        }
    }
}