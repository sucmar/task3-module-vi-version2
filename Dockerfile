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

# Install json-server globally
RUN npm install -g json-server

# Set the environment variable for serving the app
ENV HOST=0.0.0.0

# Copy the JSON data file into the container
COPY ./src/db/db.json .

# Expose port 8080 for serving the app and port 3000 for the JSON Server
EXPOSE 8080 3000

# Start the JSON Server and the Vue.js app when the container is run
CMD ["sh", "-c", "json-server --watch ./src/db/db.json --port 3000 & npm run serve"]
