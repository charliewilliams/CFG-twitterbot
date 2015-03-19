
## Example Twitterbot to run on Heroku and auto-tweet your friends in certain circumstances.
## Demo code by Charlie Williams, based in part on the Codecademy Twitter API demo.
## Where possible code is available under an MIT license.

# Load the twitter keys from the external file 'keys.rb'
require './keys'

# Note: If you have checked this code out, you'll need to make that file
# and copy your own Twitter app keys into it.

# WARNING: Do not commit your own 'keys.rb' file to git or push it to github
# or else anyone can use the keys to hijack your app.

require 'rubygems'
require 'oauth'
require 'json'
require 'open-uri'
require './twitter_search'
require './image_search'
require './post_tweet'

# Set up OAuth
$consumer_key = OAuth::Consumer.new($twitter_api_key, $twitter_api_secret)
$access_token = OAuth::Token.new($twitter_access_token, $twitter_access_secret)

queryString = ARGV[0]

if !queryString then
	queryString = 'micropig'
end

puts 'running with query: ' + queryString

tweets = twitter_search(queryString)

#return early if we don't have any tweets
if !tweets then
	puts 'No tweets loaded!'
	return
end

url = image_search(queryString)

if !url then
	puts 'No url found!'
	return
end

#iterate through all the tweets and respond to them
# for tweet in tweets
tweet = tweets[0]

	username = tweet["user"]["screen_name"]
	puts username

	success = post_tweet(username, queryString, url)

	puts 'tweet post result: ' + success
# end

puts 'Done'
