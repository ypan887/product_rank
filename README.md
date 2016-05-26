A product hunt client app with simple adjustable display preference settings. Product hunt is a great website, but there are too many new interesting posts every day. This app is for people like me who wants to minimize their time on PH by focusing their attention only on the top posts. User can decide how many posts are enough for one day and how those posts should be sorted. 

# Introduction

I am using this project to learn redis and NoSQL store.

### Redis Cache
The app use redis as cache store. All current day’s posts fed from Api are stored in cache and are set to expire in 20 mins. This way, User can get new posts from server without sending out too many requests.

### Postgresql NoSQL
All non-current posts are stored in postgresql database as JSONB type. Product hunt Api respond with lots of information on each post so using the JSON type can significantly simplify the scheme design.

### Demo
Please take a look at the demo [here](https://productrank.herokuapp.com/). It's using heroku's free plan, so it need 5-10 second to active for your first visit.

#Getting Started

To get a clone running on your local machine for development and testing purposes. You need this: 

##Prerequisites

#### Redis
You need to install redis in your machine. Follow the guide [here](http://redis.io/topics/quickstart)

Make sure redis server is running
```
$ redis-server
```
#### Postgresql
You will also need to setup postgresql in your machine. You can find a good instruction [here](https://www.postgresql.org/download/)

#### Product Hunt Api key and Api secret
You will need your own Api key and Api secret. You can register and create your app [here](https://www.producthunt.com/v1/oauth/applications) and get your own key and secret.

##Install

After you clone and cd to the app. Run `bundle install` to get all gems and its dependency.

The app use figaro to store sensitive information in ENV, so you need to initialize figaro
```
bundle exec figaro install
```

Create a postgresql database named myapp_development

Put the following into `config/application.yml`

```
api_key: Your product hunt Api key
api_secret: Your product hunt Api secret
POSTGRES_USERNAME: Your postgresql username
POSTGRES_PASSWORD: Your postgresql password
```
Now you can initialize the database and start rails server. Make sure your redis server is running
```
bundle exec rake db:create
bundle exec rake db:seed
bundle exec rails s
```
Now you can visit the app at localhost:3000

The app also defined cron jobs that run every day at 12:30 am to store posts from yesterday into database.

You could run the following command to start the scheduled task 
```
whenever -iw
```

You could check if the scheduled task by

```
crontab -l
```