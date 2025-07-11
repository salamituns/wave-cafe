# Use nginx as base image
FROM nginx:alpine

# Copy the application files to nginx html directory
COPY . /usr/share/nginx/html/

# Configure nginx to serve the static content
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
