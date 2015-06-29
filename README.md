# Classroom

## Development
- __Web App__
  - Fork the repo.
  - Clone from your fork
  - npm install
  - bower install
- __Database__
  - The schema is in /server/config/schema.sql
  - [Install mysql](https://dev.mysql.com/doc/refman/5.6/en/osx-installation-pkg.html) (or brew install mysql) and start the mysql service with ``mysql.server start``
  - Import the schema with the command ``mysql -u root -p < server/config/schema.sql``
- __Running the app__
  - Rename start.sh.example to start.sh and edit it to use the username and password for your mysql database.
  - Run ``chmod +x start.sh`` to make the start.sh file executable.
  - Run ``npm start`` to start the server with nodemon.


## Directory Layout and Description of Files

- /
  - client/
    - app/
      - attendance
      - auth/ -- Login and Signup views
      - grades/ 
      - landing_page
      - services
    - lib/
    - style/
    index.html
  - node_modules/
  - server/
    - config/
      - db.js -- Configuration for knex/mysql/bookshelf. Uses environment variables defined from the start.sh which is run with the ``npm start`` command.
      - express.js -- Required from server/server.js and sets up our express app and imports our routes.
      - schema.sql -- Seed the initial database with ``mysql -u username -p password < server/config/schema.sql``.
    - controllers/
      - ... -- Each controller has its own model and route in their respective folders.
    - models/
      - ... -- Each model has its own controller and route in their respective folders.
    - routes/
      - ... -- Each route has its own controller and model in their respective folders.
    - views/
    server.js
  - tests/
    - server
      - controllers
      - routes
  - .bowerrc -- Configure ``bower install`` to install to the client/lib directory.
  - .dockerignore -- Ignore the node_modules folder when a docker file runs the ADD or COPY command. The primary reason for this is that we need to do a fresh npm install when building docker images. Some modules install differently between Mac and Linux (bcrypt specifically). It can be the source of bugs causing great frustration and fury.
  - .gitignore -- Ignore config, tmp, and lib files.
  - bower.json -- Installs to client/lib due to .bowerrc config.
  - CONTRIBUTING.md
  - docker_build.sh -- Builds docker images from scratch. This should be run the first time you start using docker to deploy/develop the app and again each time you want to push your local changes to the docker containers. Develop locally. Run docker_build.sh when you are ready to test your changes on docker and push to deployment.
  - docker_start.sh -- Restarts the containers. Use this to start the containers again after a reboot or any time they stop/crash. No changes you make to your local filesystem will be reflected by running this command. To reflect changes, run docker_build.sh.
  - mysql_Dockerfile -- Copies the schema file from server/config/schema.sql and sets the environment variable for MYSQL_ROOT_PASSWORD which is required for the official mysql base docker image. __*Edit this environment variable and don't push it to GitHub!!!*__
  - msyql_start.sh -- This runs the mysql container as a background process with the -d flag. It maps port 3306 on the container to 3306 on the host machine. It gives the container a name of classroom-db. It uses the classroom/mysql:v1 image which was created with the docker_build.sh command.
  - node_Dockerfile
  - node_start.sh
  - package.json
  - README.md
  - start.sh.example
  - STYLE-GUIDE.md

## Deployment

### Docker

- If you're using Mac, you'll have to install boot2docker and docker: https://docs.docker.com/installation/mac/
- Make sure you set up boot2docker correctly (boot2docker init, boot2docker up, boot2docker start, boot2docker shellinit, etc...). *Don't forget to type ``$(boot2docker shellinit)`` every time you open a new terminal window and want to use docker commands.*
- Scripts have been created to handle docker instance setup.
  - docker_build.sh (Necessary on the first build and every time you want to push changes you make locally to the docker containers).
  - docker_start.sh (Necessary every time you want to spin up a container of the image you made with docker_build).
  - node_start.sh (Only necessary if you want to spin up the node container by itself for testing purposes or if it crashed).
  - mysql_start.sh (Only necessary if you want to spin up the mysql container by itself for testing purposes or if it crashed).
- Once the containers are up and running, you should be able to access them at 192.168.59.103:3000 on your local machine.

## Problems you might run into during deployment/development
- [ERROR] InnoDB: Cannot allocate memory for the buffer pool
  - You might receive this error while trying to start the MySQL server on a VPS with limited resourcs (such as a $5 DigitalOcean droplet.
  - This is caused by not having enough memory. The solution https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-12-04
- MySQL ERROR! The server quit without updating PID file...
  - Seems to be fixed with a reboot.
  - This could be because of an edit to your my.cnf file that MySQL is unhappy with.
  - It could also be for some other reason I haven't been able to narrow down.
- ...dial unix /var/run/docker.sock: no such file or directory. Are you trying to connect to a TLS-enabled daemon without TLS?...
  - Started getting this after a boot2docker upgrade.
  - After running $(boot2docker shellinit) I got a different error: An error occurred trying to connect: Get https://192.168.59.103:2376/v1.19/containers/json: x509: certificate is valid for 127.0.0.1, 10.0.2.15, not 192.168.59.103
  - __*Fixed with*__ restarting the docker service inside boot2docker -- ``boot2docker ssh 'sudo /etc/init.d/docker restart'


## Team

Product Owner: Richard Stanley
Scrum Lord: Eric Ihli
Product Team: Jake Lee, Devon Harvey
