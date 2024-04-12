pipeline {
    agent any
    environment {
        SSH_CONFIG_NAME = 'MySSHServer' // SSH 구성 이름 설정
    }
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
        stage('SSH transfer') {
            steps{
                script {
                    sshPublisher(
                    continueOnError: false, failOnError: true,
                    publishers: [
                        sshPublisherDesc(
                        configName: "${env.SSH_CONFIG_NAME}",
                        verbose: true,
                        transfers: [
                            sshTransfer(
                            sourceFiles: "my-app/build/*", // 전송할 파일 경로 설정
                            removePrefix: "my-app/build", // 제거할 접두사 설정 (옵션)
                            remoteDirectory: "/home/EaBell/temp", // 원격 디렉토리 경로 설정
                            execCommand: "run commands after copy?"
                            )
                        ])
                    ])
                }
            }
        }
        // stage('send buildFile'){
        //     steps{
        //         echo 'send builFile jenkins -> targetServer'
        //         dir('my-app'){
        //             // bat 'sftp build EaBell@192.168.10.173:~/temp'
        //             bat 'ssh EaBell@192.168.10.173 "chmod -R 755 /home/EaBell/temp/build"'
        //         }
        //     }
        // }
    }
}
