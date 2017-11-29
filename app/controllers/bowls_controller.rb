class BowlsController < ApplicationController
  before_action :set_bowl, only: [:show, :edit, :update, :destroy]

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
    @bowl.update(name: params[:bowl][:name], description: params[:bowl][:description])
    # redirect_to bowl_path(@bowl)

    if @bowl.valid?
      @bowl.save
      redirect_to bowl_path(@bowl)
    else
      render :edit
    end
  end

  def destroy
    @bowl.destroy
    redirect_to bowls_url
  end

  private

  def bowl_params
    #
  end

  def set_bowl
    @bowl = Bowl.find(params[:id])
  end

end
