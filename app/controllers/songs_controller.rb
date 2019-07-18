class SongsController < ApplicationController

	get "/songs" do
		@songs = Song.all
		erb :"/songs/index"
	end


	get "/songs/new" do
		@all_genres = Genre.all
		@all_artists = Artist.all

		erb :"/songs/new"
	end


	get "/songs/:id/edit" do
		#binding.pry
		@song = find_by_slug(params[:id])
		@all_genres = Genre.all
		@all_artists = Artist.all
		erb :"/songs/edit"
	end



	 patch "/songs/:id" do
	 	#binding.pry
      s = find_by_slug(params[:id])
      s.update(name: params["name"])

      if params[:artist_name]
			a = Artist.find_by(name: params[:artist_name])
			if a 
				s.artist_id = a.id
			else
				a = Artist.create(name: params[:artist_name])
				s.artist_id = a.id
			end
			s.save
		end
	
		params[:genres].each do |g|
		 	if !s.genres.include?( Genre.find(g))
		 		SongGenre.create(song_id: s.id, genre_id: g)
		 	end
		end
	 	#binding.pry

      redirect "/songs/#{slug(s.name)}"
    end




	post "/songs" do

		#binding.pry
		s = Song.create(name: params[:name])

		if params[:artist_name]
			a = Artist.find_by(name: params[:artist_name])
			if a 
				s.artist_id = a.id
			else
				a = Artist.create(name: params[:artist_name])
				s.artist_id = a.id
			end
			s.save
		end

		params[:genres].each do |g|
			SongGenre.create(song_id: s.id, genre_id: g)
		end

		redirect "/songs"
	end

	get "/songs/:id" do
		@song = find_by_slug(params[:id])
		@genres = @song.genres
		@artist = @song.artist
		@artist = Artist.new(name:"") if !@artist
		erb :"/songs/show"
	end


	def find_by_slug (slug_name)
		return Song.find_by(name: unslug(slug_name))

	end
end