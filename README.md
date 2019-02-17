# BeeStore

## BDD - Cucumber

#### Setup test database

Check test database and development database is not the same, and run below command:

``` sh

$ bin/rails db:environment:set RAILS_ENV=test && bin/rails db:drop db:create db:migrate db:seed RAILS_ENV=test

```

#### Online guides

- Cucumber: https://github.com/cucumber/cucumber

- Capybara: https://github.com/jnicklas/capybara

- Rspec: http://www.relishapp.com/rspec/

#### Install for Selenium Webdriver

- Chrome: https://www.google.com/chrome/

- Chrome Driver

``` sh

$ brew install chromedriver

```

#### Run Cucumber

``` sh

# run all feature

$ cucumber

# run single feature

$ cucumber feature_path -r features
