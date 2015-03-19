#do image search of the word in $queryString

def image_search(queryString)

	query_url = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=#{queryString}"
	json = JSON.parse(open(query_url).read)
	url = json["responseData"]["results"][0]["url"]

	puts 'got a url! it is: ' + url

	#return the image URL to the calling script
	url

end
