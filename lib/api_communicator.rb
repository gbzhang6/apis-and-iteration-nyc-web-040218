require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
 char_movies = []
 movies_array = []

 for i in 1..9
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
 # some iteration magic and puts out the movies in a nice list
def parse_character_movies(films_array)
   films_array.each.with_index(1) { |title, index| puts "#{index}. #{title}" }
end

def show_character_movies(character)
 films_array = get_character_movies_from_api(character)
 parse_character_movies(films_array)
end
