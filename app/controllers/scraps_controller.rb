class ScrapsController < ApplicationController

  def new
    @scrap = Scrap.new
  end

  def create
    @scrap = Scrap.new(scrap_params)

    if @scrap.save
      redirect_to @scrap
    else
      render :new
    end
  end

  def show
    #
  end

  private

  def scrap_params
    params.require(:scrap).permit(:description, :category)
  end

end
