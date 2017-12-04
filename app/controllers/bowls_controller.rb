class BowlsController < ApplicationController
  before_action :set_bowl, only: [:show, :edit, :update, :destroy]

  def new
    #
  end
  
  def index
    Bowl.create(name: "My first bowl") if Bowl.all.empty?
    @bowls = Bowl.all
  end

  def show
    @scraps = @bowl.scraps
    @random = @scraps.sample
  end

  def edit
  end

  def update
    if @bowl.update(bowl_params)
      @bowl.save
      redirect_to bowl_path(@bowl)
    else
      @bowl.restore_attributes(@bowl.errors.keys)
      render :edit
    end
  end

  def destroy
    @bowl.destroy
    redirect_to bowls_url
  end

  private

  def bowl_params
    params.require(:bowl).permit(:name, :description, :scrap_ids)
  end

  def set_bowl
    @bowl = Bowl.find(params[:id])
  end

end
