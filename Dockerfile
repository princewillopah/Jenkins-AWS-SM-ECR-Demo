# Use the official NGINX base image
FROM nginx:latest

# Copy your custom index.html to the default NGINX directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
