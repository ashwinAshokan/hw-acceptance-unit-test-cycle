require 'rails_helper'

#This has rspec file to verify the controller methods
#First Spec: Checks if by clicking the FindSimilarMovies if it routes to view "Similar Movies With the director"
#Second Spec: If no similar directors the route should render the default view if there are no Similar Movies or No Director

describe MoviesController, :type => :request do
    
    context "When provided with movie with no director" do
        it " Should route back to the default \movies page" do
            movies_list = [{id: 1,title: "Titanic",director: ""},{id: 2,title: "Avatar",director: "James Cameroon"},{id: 3,title: "Avengers", director: "Joe Russo"}]
            movies_list.each do |movie|
                Movie.create(movie)
            end
            
            
            movie_id =  Movie.find_by(title: "Titanic").id.to_s
            
            get ("/movies/"+movie_id+"/same_director")
            expect(response).to redirect_to('/movies') 
        end 
    end 
    
    context "When provided with similar movies" do
        it "Should route to similar_movie webpage with similar movies" do
            
            movies_list = [{id: 1,title: "Titanic",director: "James Cameroon"},{id: 2,title: "Avatar",director: "James Cameroon"},{id: 3,title: "Avengers", director: "Joe Russo"}]
            movies_list.each do |movie|
                Movie.create(movie)
            end
            
            movie_id =  Movie.find_by(title: "Titanic").id.to_s
            
 
            
            get ("/movies/"+movie_id+"/same_director")
            expect(response).to render_template("same_director") 
        end
    end

    context "When Starting from homepage" do
        
        it " Should route properly based on the API calls " do
            movies_list = [{id: 1,title: "Titanic",director: "James Cameroon", release_date: "2004-12-12"}]
            movies_list.each do |movie|
                Movie.create(movie)
            end
            
            
            
            put "/movies/1", "movie": {"title": "movie_2"}
            expect(response).to redirect_to("/movies/1")

            get "/movies/1/edit"
            expect(response).to render_template("edit")
            
            
            get "/movies"
            expect(response).to render_template("index");
            
            get ("/movies/"+"1"+"/same_director")
            expect(response).to render_template("same_director") 
            
            
            get ("/movies/1/edit")
            expect(response).to render_template("edit")
            
            
            delete ("/movies/1")
            expect(response).to redirect_to("/movies")
            
            end
        end

end 