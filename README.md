# **SJI ROR Demo Project**

This project is intended to manage fuel purchased by truck drivers. Admin can modify the cost of purchase. A prebuilt mobile app should be able to consume APIs from the app.

### **Prerequisites**

To run this game, installation of `ruby (version: 3.1.2)` and `bundler` are required.

### **How to Install**

Clone the repository in your local machine with the following command:

    `git clone git@github.com:saadrumon/sji-demo-project.git`

Then go inside the project directory using terminal and install required packages as follow:

    `cd sji-demo-project && bundle install`

Install javascript packages using yarn.

    `yarn install`

Now, copy the .env.sample file into .env file. Insert appropriate values in the .env file.

    `cp .env.sample .env && nano .env`

### How it Works

Navigate inside the project directory and run database creation and migration commands.

    `rails db:create && rails db:migrate`

Run the seed files to popultate data for Player and Team models.

    `rails db:seed`

Start the application server.

    `rails s`

Open the browser and hit the following url to check out the application:

    `http://localhost:3000/`

To test the APIs, you can import the following Postman collection:

  `https://www.getpostman.com/collections/b2245e4f66e034013bfd`
