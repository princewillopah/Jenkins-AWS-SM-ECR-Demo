# Jenkins-AWS-SM-ECR-Demo


This is if you do not want to use the default nginx page during test
You can use the official NGINX Docker image for testing. To pull it from Docker Hub, use the following command:
Create or edit the index.html on your host machine using any text editor you prefer.
Copy the new file to the container:


            docker pull nginx
            docker run -d -p 8081:80 nginx
            docker cp index.html 0af19ccd3524:/usr/share/nginx/html/index.html 