pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = credentials('id-of-your-credential')  //or AWS_ACCOUNT_ID = '4xxxxxxxx4'
        AWS_REGION = credentials('aws-region')    // your region i.e  AWS_REGION = 'eu-north-1'
        ECR_REPOSITORY = 'nginx-custom' // Your ECR repository name
        IMAGE_TAG = "${BUILD_NUMBER}"                   // Use Jenkins build number as the image tag
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}"  // 456555753493.dkr.ecr.eu-north-1.amazonaws.com/nginx-custom
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Assuming your custom index.html is in the source code
                git 'https://github.com/princewillopah/Jenkins-AWS-SM-ECR-Demo.git'
            }
        }
        
        stage('Login to AWS ECR') {
            steps {
                script {
                    // Logging in to ECR
                    sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REPOSITORY_URI'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build your custom NGINX Docker image
                    sh 'docker build -t $ECR_REPOSITORY:$IMAGE_TAG .'
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    // Tag the Docker image
                    sh 'docker tag $ECR_REPOSITORY:$IMAGE_TAG $REPOSITORY_URI:$IMAGE_TAG'
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    // Push the Docker image to ECR
                    sh 'docker push $REPOSITORY_URI:$IMAGE_TAG'
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image successfully pushed to ECR.'
        }
        failure {
            echo 'Failed to push Docker image to ECR.'
        }
    }
}
