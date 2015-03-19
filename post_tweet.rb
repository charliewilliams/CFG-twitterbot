#post a tweet with image

def post_tweet(username, noun, imgURL)

	baseurl = "https://api.twitter.com"
	path    = "/1.1/statuses/update.json"
	address = URI("#{baseurl}#{path}")
	request = Net::HTTP::Post.new address.request_uri
	request.set_form_data(
	  "status" => "#{username}- Sorry you're feeling sad, here's a #{noun}! #{imgURL}",
	)

	# Set up HTTP.
	http             = Net::HTTP.new address.host, address.port
	http.use_ssl     = true
	http.verify_mode = OpenSSL::SSL::VERIFY_PEER

	# Issue the request.
	request.oauth! http, $consumer_key, $access_token
	http.start
	response = http.request request

    puts response.code
    body = JSON.parse(response.body)
    puts body

	if body['errors'] then

		puts response.code + ' ' + body['errors']

    else
	    puts response.code
	    puts body
	end

	response.code
end
