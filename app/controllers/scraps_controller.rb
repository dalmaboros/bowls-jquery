class ScrapsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_scrap, only: [:show, :edit, :update, :destroy]

  def new
    if params[:bowl_id]
      @bowl = Bowl.find(params[:bowl_id])
      if !@bowl
        redirect_to bowls_path, alert: "Bowl not found."
      else
        @scrap = Scrap.new(bowl_ids: [params[:bowl_id]])
      end
    else
      @scrap = Scrap.new
    end
  end

  def create
    if scrap_params[:bowl_ids]
      @bowl = Bowl.find_by(id: scrap_params[:bowl_ids][0])
      @scrap = @bowl.scraps.build(scrap_params)
    else
      @scrap = Scrap.new(scrap_params)
    end
    binding.pry

    if @scrap.save
      redirect_to @scrap
    else
      render :new
    end
  end

  def show
    if params[:bowl_id]
      @bowl = Bowl.find(params[:bowl_id])
      if !@bowl
        redirect_to bowls_path, alert: "bowl not found."
      elsif !@scrap.bowls.include? @bowl
        redirect_to scraps_path
      end
    else
      redirect_to scraps_path if @scrap.user != current_user
    end
  end

  def index
    @scraps = current_user.scraps.all
    @bowl = Bowl.find(params[:bowl_id]) if params[:bowl_id]
  end

  def edit
    redirect_to scraps_path if @scrap.user != current_user
    if params[:bowl_id]
      bowl = Bowl.find_by(id: params[:bowl_id])
      if bowl.nil?
        redirect_to bowls_path, alert: "Bowl not found."
      else
        @scrap = bowl.scraps.find_by(id: params[:id])
        redirect_to bowl_scraps_path(bowl), alert: "Scrap not found." if @scrap.nil?
      end
    else
      @scrap = Scrap.find(params[:id])
    end
  end

  def update
    if @scrap.update(scrap_params)
      @scrap.save
      redirect_to scrap_path(@scrap)
    else
      @scrap.restore_attributes(@scrap.errors.keys)
      render :edit
    end
  end

  def destroy
    @scrap.destroy
    redirect_to root_path
  end

  private

  def scrap_params
    params.require(:scrap).permit(:description, :category, :user_id, bowl_ids:[])
  end

  def set_scrap
    @scrap = Scrap.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "scrap #{params[:id]} not found"
      redirect_to scraps_path
  end

end
