# Use a Node.js runtime as a base image
FROM node:14-alpine 

# Set the working directory to /app inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files into the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the project files into the container
COPY . .

# Build the Vue.js app
RUN npm run build

# Set the environment variable for serving the app
ENV HOST=0.0.0.0

# Expose port 8080 for serving the app
EXPOSE 8080

# Start the app when the container is run
CMD ["npm", "run", "serve"]
