require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character) #make the web request
 char_movies = []
 movies_array = []
 unless char_movies.size > 0
   for i in 1..9 do
     all_characters = RestClient.get("https://www.swapi.co/api/people/?page=" + i.to_s)
     #binding.pry
     character_hash = JSON.parse(all_characters)
     character_hash["results"].each { |character_data|
       if character_data["name"] == character
         char_movies = character_data["films"]
       end
     }
   end
end
   char_movies.each do |urls|
     all_movies = RestClient.get "#{urls}"
     movies_hash = JSON.parse(all_movies)
     movies_array << movies_hash["title"]
   end
   movies_array
end

 # iterate over the character hash to find the collection of `films` for the given
 #   `character`
 # collect those film API urls, make a web request to each URL to get the info
 #  for that film
 # return value of this method should be collection of info about each film.
 #  i.e. an array of hashes in which each hash reps a given film
 # this collection will be the argument given to `parse_character_movies`
 #  and that method will do some nice presentation stuff: puts out a list
 #  of movies by title. play around with puts out other info about a given film.

 # some iteration magic and puts out the movies in a nice list
def parse_character_movies(films_array)
   films_array.each.with_index(1) { |title, index| puts "#{index}. #{title}" }
end

def show_character_movies(character)
 films_array = get_character_movies_from_api(character)
 parse_character_movies(films_array)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
