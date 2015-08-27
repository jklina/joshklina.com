 === Exposition

This is a very boring blogging platform based on Rails geared toward Rails developers. It has very little in the way of frills and is designed to get up and running fast with an easy to understand codebase.

This is not designed as a dependency, but more as a starting kit. Once you're up and running you can add what you like and treat it as you like.

== Features
* Tagging
* Basic user authentication
* Markdown that support code snippets
* Basic slug management
* Built in support for static pages using thoughtbot's [High_Voltage](http://thoughtbot.github.io/high_voltage/ "High Voltage")

That's about it.

== Requirements
This application is currently tested on Ruby 2.2.2 and the PostgreSQL database.

== Configuration
Configuration is the same as your standard Rails App. Some steps you'll need to take:

* Fork the repository
* Clone your forked repository
* Install the dependencies: `bundle install`
* Configure the database.yml to your needs. If you're using the Postgre app on OS X, then you should be ready to go out of the box.
* Setup the DB. `rake db:setup`
* Create your admin user in the console. `User.create(name: 'Your Name', email: 'your@email.com', password: 'secrect', password_confirmation: 'secret')`

== Customization
As mentioned earlier this is meant more as a starting point then as a library, therefore there's really no need to overide; just change the styles and markup to whatever you like. I have a very basic and boring starter theme in place. Feel free to make it your own, or use it. The project uses [thoughtbot's SASS libraries](http://bourbon.io/ "Bourbon").

* Frontend styles and markup are where you would expect them to be. So:
  * app/assets/stylesheets
  * app/views/layouts/application.html.haml
  * app/views

* Admin styles and markup are in the Admin namespace. So:
  * app/assets/stylesheets/admin
  * app/views/layouts/admin.html.haml
  * app/views/admin

= Static Pages
You can add static pages by using the high_voltage. Instructions can be found at the gem's [website](http://thoughtbot.github.io/high_voltage/ "High Voltage")

== Deployment instructions
You can deploy the app however you like, but I like Heroku. Especially their [hobby plan](https://www.heroku.com/pricing "Heroku Pricing"). To deploy on Heroku:

* `heroku create [your app name]
* `git push heroku master`
* `heroku run rake db:setup`
* Create your admin user in the console.
  * `heroku run rails console`
  * `User.create(name: 'Your Name', email: 'your@email.com', password: 'secrect', password_confirmation: 'secret')`
* `heroku open`

== Todo:
* Figure out a clean and easy way to allow image uploads that doesn't complicate setup
* Add RSS support

== Running the Test Suite
`bin/rspec spec`

