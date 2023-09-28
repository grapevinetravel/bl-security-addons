# BL-security-aaddons

Basic security tools for satellites.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bl-security-addons'
```

And then execute:
```
$ bundle install
```

Add these environment variables to your ENV:
```ruby
gql_enabled_keys
jwt_security_enabled
req_url_whitelisted_enabled
jwt_allowed_keys
```
```jwt_security_enabled``` should be set to true in any case so it will return the valid status in headers.

```req_url_whitelisted_enabled``` can be set to true or false if we want to use this authentication feature.

Add this code in the class where you want to implemenet the authentication
``` ruby 
include BlSecurityAddons::Gatekeeper
````