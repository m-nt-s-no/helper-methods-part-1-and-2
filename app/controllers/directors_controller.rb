class DirectorsController < ApplicationController
  def new
    @director = Director.new
  end

  def index
    matching_directors = Director.all
    @directors = matching_directors.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @directors
      end

      format.html do
        render template: "directors/index"
      end
    end
  end

  def show
    @director = Director.find(params.fetch(:id))
  end

  def create
    director_attributes = params.require(:director).permit(:name, :date_of_birth, :bio)
    @director = Director.new(director_attributes)

    if @director.valid?
      @director.save
      redirect_to directors_url, notice: "director created successfully."
    else
      render template: "directors/new"
    end
  end

  def edit
    @director = Director.find(params.fetch(:id))
  end

  def update
    director_attributes = params.require(:director).permit(:name, :date_of_birth, :bio)
    director = Director.find(params.fetch(:id))
    director.update(
      name: director_attributes[:name], 
      date_of_birth: director_attributes[:date_of_birth], 
      bio: director_attributes[:bio]
      )

    if director.valid?
      director.save
      redirect_to director_url, notice: "director updated successfully."
    else
      redirect_to director_url, alert: "director failed to update successfully."
    end
  end

  def destroy
    director = Director.find(params.fetch(:id))
    director.destroy

    redirect_to directors_url, notice: "director deleted successfully."
  end
end
