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

  def index
    @scraps = Scrap.all
    @bowl = Bowl.find(params[:bowl_id]) if params[:bowl_id]
  end

  def edit
    @scrap = Scrap.find(params[:id])
  end

  def update
    @scrap = Scrap.find(params[:id])
    @scrap.update(description: params[:scrap][:description], bowl_ids: params[:scrap][:bowl_ids])
    redirect_to scrap_path(@scrap)
  end

  def destroy
    Scrap.find(params[:id]).destroy
    redirect_to scraps_url
  end

  private

  def scrap_params
    params.require(:scrap).permit(:description, :category, :bowl_ids)
  end

end
