# MapMyFitness

The gem wraps the [MapMyFitness v7 API](https://developer.mapmyapi.com/). It needs an OAuth2 authorization token, which can be retrieved via the [MapMyFitness OAuth2 OmniAuth Strategy](/jcasimir/omniauth-mapmyfitness-oauth2/).

## Installation

Add this line to your application's Gemfile:

    gem 'mapmyfitness'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mapmyfitness

## Usage

So far, you can use the library to...

### Parse User Data

When you use the OmniAuth strategy to login with MapMyFitness v7 OAuth2 API, your callback URL will receive a large hash of data. The `User` class will parse it into an easy-to-use Ruby object instance. Starting in a `sessions_controller#create` which handles the callback:

```ruby
user_data = MapMyFitness::User.new(request.env["omniauth.auth"])
```

Then, if you'd like to save the data to your database, you could do something like this:

```ruby
user_data = MapMyFitness::User.new(request.env["omniauth.auth"])
@user = User.find_or_create_by_auth(user_data)
```

And down in the `User` model:

```ruby
  def self.find_or_create_by_auth(user_data)
    find_or_create_by_provider_and_uid(user_data.provider, 
                                       user_data.uid,
                                       username: user_data.username,
                                       email: user_data.email,
                                       token: user_data.token)
  end
```

### Fetch Workouts

Once you have a user OAuth2 token, then you can request the workouts for that user. For example:

```ruby
store = MapMyFitness::WorkoutStore.new(current_user.token)
store.workouts_by(current_user.uid)
```

The `token` is used to sign the request, while the `uid` identifies the user who owns the workout data.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
