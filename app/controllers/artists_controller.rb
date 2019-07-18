class ArtistsController < ApplicationController

	get "/artists" do
		@artists = Artist.all
		erb :"/artists/index"
	end

	get "/artists/:id" do
		@artist = find_by_slug(params[:id]) #Artist.find(params[:id])
		@songs = @artist.songs
		@genres = @artist.genres
		erb :"/artists/show"
	end

	def find_by_slug (slug_name)
		return Artist.find_by(name: unslug(slug_name))

	end
end
