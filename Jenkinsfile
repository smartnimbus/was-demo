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
        }
        stage('Build Was Image') {
            //agent none 
            steps {
                script {
                    def customImage = docker.build("was8:${env.BUILD_ID}")
                }
            }
        }      
        stage('Run image') {
            agent any  
            steps {
                script {
                    echo "docker version"
                    //sh "docker stop \$(docker ps -q -f \"name=was*\")"
                    sh "docker run --name was8-${env.BUILD_ID} -p 9043:9043 -p 9443:9443 -d was8:${env.BUILD_ID}"
                    sh "docker exec was8-${env.BUILD_ID} cat /tmp/PASSWORD"
                }
            }
        }
    }
    post {
        always {
            echo 'One way or another, I have finished'
            //deleteDir() /* clean up our workspace */
        }
        success {
            echo 'I succeeeded!'
        }
        unstable {
            echo 'I am unstable :/'
        }
        failure {
            echo 'I failed :('
        }
        changed {
            echo 'Things were different before...'
        }
    }
}


