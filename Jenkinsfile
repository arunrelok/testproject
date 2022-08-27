def IMAGE_TAG  = "v1"
def IMAGE_NAME = "realoqui"
def DEV_BRANCH = 'main'

pipeline {
    
    agent any
    stages {
        stage('Build') { 
            steps {
               echo "Building...."
            }
        }
        stage('Package') {
            steps {
               script {
                    echo "docker build, tag and push image ${IMAGE_NAME}:${IMAGE_TAG}-${env.BUILD_NUMBER}"
                    def image = docker.build("${IMAGE_NAME}:${IMAGE_TAG}",".")
                    echo "Image Status : ${image}"
                }     
               
            }
        }
        stage('Test') { 
            steps {
                echo "Testing...."
            }
        }
        stage('Deploy') { 
            steps {
               echo "Deploying...."
            }
        }
    }
}
