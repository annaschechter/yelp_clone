Yelp Clone
==========
Yelp Clone is the week 8 project at Makers Academy. In this we learnt to Ruby-on-Rails applications.
Specification
-------------
Yelp Clone replicates the functionality of Yelp for reviewing restaurants. Yelp clone has the following functionality:
* website users can register/login/login
* sign-in with Facebook option is available to users
* visitors can create new restaurants using a form, specifying a name, restaurant description and uploading a photo
* any restaurant can be edited and deleted by its creator
*visitors can leave reviews for restaurants, providing a numerical score (1-5) and a comment about their experience
* the restaurants listings page displays all the reviews, along with the average rating of each restaurant
* restaurant rating and average ratings to be displayed as stars
* users can endorse reviews and the number of endorsements for each review is displayed on the restaurants listings page


Languages and Tools
-------------------
* Ruby
* Rails
* PostgreSQL
* RSpec
* Capybara
* Poltergeist
* JavaScript
* OmniAuth
* HTML
* CSS

How to use
----------
Clone the repository:
```
$ git clone https://github.com/annaschechter/yelp_clone.git
```
Install the gems:
```
$ bundle install
```
Create test and development databases:
```
$ psql
# create database yelp_clone_test;
# create database yelp_clone_development;
```
Migrate test and development databases:
```
$ bin/rake db:migrate RAILS_ENV=development
$ bin/rake db:migrate RAILS_ENV=test
```
Install ImageMagick:
```
$ brew install imagemagick
```
Install PhantomJS:
```
$ brew install phantomjs
```
Run RSpec to see the tests:
```
$ rspec
```
Start the app:
```
$ rails s
```
In your browser visit http://localhost:3000/