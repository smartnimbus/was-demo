pipeline {
    agent none
    stages {
        stage('Package Application') {
            agent {
                docker {
                    image 'maven:3-alpine'
                    args '-v /root/.m2:/root/.m2'
                }
            }
            steps {
                sh 'mvn --version'
                sh 'mvn -B -DskipTests clean package'
            }
        //}
        //stage('Build Was Image') {
            agent none
            steps {
                script {
                    def customImage = docker.build("was8:${env.BUILD_ID}")
                }
            }
        //}      
        //stage('Run image') {
            agent none
            steps {
                script {
                    sh "docker run --name was8-${env.BUILD_ID} -p 9043:9043 -p 9443:9443 -d was8:${env.BUILD_ID}"
                    sh "docker exec was8-${env.BUILD_ID} cat /tmp/PASSWORD"
                }
            }
        }
    }
}


