require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
 #make the web request
 char_movies = []
 movies_array = []
 for i in 1..9 do
   all_characters = RestClient.get("https://www.swapi.co/api/people/?page=" + i.to_s)
   character_hash = JSON.parse(all_characters)
   character_hash["results"].each { |character_data|
     if character_data["name"] == character
       char_movies = character_data["films"]
     end
   }
 end

   char_movies.each do |urls|
     all_movies = RestClient.get "#{urls}"
     movies_hash = JSON.parse(all_movies)
     movies_array << movies_hash["title"]
   end
   movies_array
end

#def character_movies_names(character_movies)
#  all movies = RestClient.get('http://www.swapi.co/api/films/')
#  movies_hash = JSON.parse(all_movies)
#  binding.pry
#  movie_name = movie_hash[]

#  end


#http://www.swapi.co/api/films/#{num}




 # iterate over the character hash to find the collection of `films` for the given
 #   `character`
 # collect those film API urls, make a web request to each URL to get the info
 #  for that film
 # return value of this method should be collection of info about each film.
 #  i.e. an array of hashes in which each hash reps a given film
 # this collection will be the argument given to `parse_character_movies`
 #  and that method will do some nice presentation stuff: puts out a list
 #  of movies by title. play around with puts out other info about a given film.

def parse_character_movies(films_hash)
   films_hash.each do |title|
     puts "Title: #{title}"
   end
 # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
 films_hash = get_character_movies_from_api(character)
 parse_character_movies(films_hash)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
