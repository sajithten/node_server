#The first thing we need to do is define from what image we want to build from. Here we will use the latest LTS (long term support) version 8 of node available from the Docker Hub:

FROM node:8

#Next we create a directory to hold the application code inside the image, this will be the working directory for your application:

# Create app directory
WORKDIR /usr/src/app

#This image comes with Node.js and NPM already installed so the next thing we need to do is to install your app dependencies using the npm binary. Please note that if you are using npm version 4 or earlier a package-lock.json file will not be generated.

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

#Note that, rather than copying the entire working directory, we are only copying the package.json file. This allows us to take advantage of cached Docker layers. bitJudo has a good explanation of this here.

#To bundle your app's source code inside the Docker image, use the COPY instruction:

# Bundle app source
COPY . .

#Your app binds to port 8080 so you'll use the EXPOSE instruction to have it mapped by the docker daemon:

EXPOSE 5000

#Last but not least, define the command to run your app using CMD which defines your runtime. Here we will use the basic npm start which will run node server.js to start your server:

CMD [ "npm", "start" ]
