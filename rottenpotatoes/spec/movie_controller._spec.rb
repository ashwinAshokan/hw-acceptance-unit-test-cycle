require 'rails_helper'

RSpec.describe Movie, :type => :model do
    it "find correct movies with the same director" do
        movies_list = [{id: 1,title: "Titanic",director: "James Cameroon"},{id: 2,title: "Avatar",director: "James Cameroon"},{id: 3,title: "Avengers", director: "Joe Russo"}]
        movies_list.each do |new_movie|
            Movie.create(new_movie)
        end

        movies = Movie.list_same_director_movies("James Cameroon")

        expect(movies.length()).to eq(2)
        
        expect(movies.pluck(:director)).to eq(["James Cameroon", "James Cameroon"])
    end

    it "find no movies with different director" do
        movies_list = [{id: 1,title: "Titanic",director: "James Cameroon"},{id: 2,title: "Avatar",director: "James Cameroon"},{id: 3,title: "Avengers", director: "Joe Russo"}]
        movies_list.each do |new_movie|
            Movie.create(new_movie)
        end

        movies = Movie.list_same_director_movies("Joe Russo")

        expect(movies.length()).to eq(1)

        expect(movies.pluck(:director)).not_to eq("James Cameroon")
    end


end 