 === Exposition

This is a very boring blogging platform based on Rails geared toward Rails developers. It has very little in the way of frills and is designed to get up and running fast with an easy to understand codebase. 

This is not designed as a dependency, but more as a starting kit. Once you're up and running you can add what you like and treat it as you like.

== Features
* Tagging
* Basic user authentication
* Markdown that support code snippets
* Basic slug management

That's about it.

== Requirements
This application is currently tested on Ruby 2.2.2 and the PostgreSQL database.

== Configuration
Configuration is the same as your standard Rails App. Some steps you'll need to take:

* Clone the repository

* Install the dependencies: `bundle install`

* Configure the database.yml to your needs. If you're using the Postgre app on OS X, then you should be ready to go out of the box.

* Setup the DB. `rake db:setup`

* Create your admin user in the console. `User.new(name: 'Your Name', email: 'your@email.com', password: 'secrect', password_confirmation: 'secret')`

== Customization
As mentioned earlier this is meant more as a starting point then as a library, therefore there's really no need to overide; just change the styles and markup to whatever you like. I have a very basic and boring starter theme in place. Feel free to make it your own, or use it.

* Frontend styles and markup are where you would expect them to be. So:
  * app/assets/stylesheets
  * app/views/layouts/application.html.haml
  * app/views

* Admin styles and markup are in the Admin namespace. So:
  * app/assets/stylesheets/admin
  * app/views/layouts/admin.html.haml
  * app/views/admin

== Running the Test Suite
`bin/rspec spec`

* Deployment instructions
You can deploy the app however you like, but I like Heroku. Especially their [hobby plan](https://www.heroku.com/pricing "Heroku Pricing"). To deploy on Heroku:



