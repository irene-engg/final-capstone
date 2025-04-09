# Step 1: Use Node.js as the base image for building the application
FROM node:18-alpine AS build

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the package.json and package-lock.json (if available) to install dependencies first
COPY package*.json ./

# Step 4: Install the project dependencies
RUN npm install

# Step 5: Copy all other files to the container (including source code)
COPY . .

# Step 6: Build the React app for production using Vite
RUN npm run build

# Step 7: Use a lightweight web server (nginx) to serve the static build files
FROM nginx:alpine

# Step 8: Copy the build output from the previous step to the nginx container
COPY --from=build /app/dist /usr/share/nginx/html

# Copy nginx template (not directly to the conf.d directory)
COPY nginx/default.conf /etc/nginx/templates/default.conf.template

# Set environment variable with a default value
ENV BACKEND_URL="http://localhost:5000"

# Step 9: Expose port 80 for the web server
EXPOSE 80

# Step 10: Create an entrypoint script to substitute environment variables
RUN echo '#!/bin/sh \n\
envsubst < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf \n\
nginx -g "daemon off;"' > /docker-entrypoint.sh && \
chmod +x /docker-entrypoint.sh

# Use the entrypoint script
ENTRYPOINT ["/docker-entrypoint.sh"]
