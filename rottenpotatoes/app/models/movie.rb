class Movie < ActiveRecord::Base
    def self.list_same_director_movies(director_name)
        return self.all.where(director: director_name)
    end
    
end
