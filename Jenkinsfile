pipeline {
    agent any

    environment {
        
        // AWS_ACCOUNT_ID = credentials('aws-account-id')  //or AWS_ACCOUNT_ID = '4xxxxxxxx3'
        // AWS_REGION = credentials('aws-region')    // your region i.e  AWS_REGION = 'eu-west-1'
        GITHUB_CREDS = credentials('github-aws-cred')
        AWS_ACCOUNT_ID = credentials('my-aws-account-id-sm')  // this will retriev the secrete from secret manager
        AWS_REGION = credentials('my-aws-region-sm')    // this will retriev the secrete from secret manager
        ECR_REPOSITORY = 'custom-image-2' // Your ECR repository name
        IMAGE_TAG = "${BUILD_NUMBER}"                   // Use Jenkins build number as the image tag
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}"  // 4xxxxxxxx3.dkr.ecr.eu-west-1.amazonaws.com/nginx-custom
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Assuming your custom index.html is in the source code
                // git 'https://github.com/$GITHUB_CREDS_USR/Jenkins-AWS-SM-ECR-Demo.git'
                 git 'https://github.com/princewillopah/Jenkins-AWS-SM-ECR-Demo.git'
            }
        }
        
        stage('Login to AWS-buil-tag-push-image') {
            steps {
                script {
                    // Logging in to ECR
                    sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REPOSITORY_URI'
                    // Build your custom NGINX Docker image
                    sh 'docker build -t $ECR_REPOSITORY:$IMAGE_TAG .'
                    // Tag the Docker image
                    sh 'docker tag $ECR_REPOSITORY:$IMAGE_TAG $REPOSITORY_URI:$IMAGE_TAG'
                    // Push the Docker image to ECR
                    sh 'docker push $REPOSITORY_URI:$IMAGE_TAG'

                }
            }
        }
        stage('List All Branches in this repo') {
            steps {
                script {
                    // Logging in to ECR
                    sh 'curl -s -u $GITHUB_CREDS_USR:$GITHUB_CREDS_PSW https://api.github.com/repos/$GITHUB_CREDS_USR/Jenkins-AWS-SM-ECR-Demo/branches'
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


//// //  sh 'aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com'
//// //  sh 'docker build -t ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG} .'
//// //  sh 'docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}'


















































