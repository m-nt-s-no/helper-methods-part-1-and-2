class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def index
    matching_movies = Movie.all
    @movies = matching_movies.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html do
        render template: "movies/index"
      end
    end
  end

  def show
    @movie = Movie.find(params.fetch(:id))
  end

  def create
    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)

    if @movie.valid?
      @movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render template: "movies/new"
    end
  end

  def edit
    @movie = Movie.find(params.fetch(:id))
  end

  def update
    movie_attributes = params.require(:movie).permit(:title, :description)
    movie = Movie.find(params.fetch(:id))
    movie.update(title: movie_attributes[:title], description: movie_attributes[:description])

    if movie.valid?
      movie.save
      redirect_to movie_url, notice: "Movie updated successfully."
    else
      redirect_to movie_url, alert: "Movie failed to update successfully."
    end
  end

  def destroy
    movie = Movie.find(params.fetch(:id))
    movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
