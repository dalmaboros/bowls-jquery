class ScrapsController < ApplicationController

  def new
    @bowl = Bowl.find_by(id: params[:bowl_id])
    @scrap = Scrap.new(bowl_ids: [params[:bowl_id]])
  end

  def create
    if params[:scrap][:bowl_ids]
      @bowl = Bowl.find_by(id: params[:scrap][:bowl_ids][0])
      @scrap = @bowl.scraps.build(scrap_params)
    else
      @scrap = Scrap.new(scrap_params)
    end

    if @scrap.save
      redirect_to @scrap
    else
      render :new
    end
  end

  def show
    @scrap = Scrap.find(params[:id])
  end

  private

  def scrap_params
    params.require(:scrap).permit(:description, :category, :bowl_ids)
  end

end
