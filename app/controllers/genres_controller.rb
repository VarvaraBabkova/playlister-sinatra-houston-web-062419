class GenresController < ApplicationController

	get "/genres" do
		@genres = Genre.all
		erb :"/genres/index"
	end

	get "/genres/:id" do
		@genre = find_by_slug(params[:id])
		@songs = @genre.songs
		@artists = @genre.artists
		erb :"/genres/show"
	end
	def find_by_slug (slug_name)
		return Genre.find_by(name: unslug(slug_name))

	end
end