class ScrapsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_scrap, only: [:show, :edit, :update, :destroy]
  before_action :set_bowl, only: [:new, :edit, :show, :index]

  def new
    if @bowl
      binding.pry
      @scrap = Scrap.new(bowl_ids: [@bowl.id])
    else
      @scrap = Scrap.new
    end
  end

  def create
    @scrap = Scrap.new(scrap_params)
    if @scrap.save
      redirect_to scrap_path(@scrap)
    else
      render :new
    end
  end

  def show
    if @scrap.user != current_user
      redirect_to scraps_path, alert: "scrap not found."
    elsif @bowl
      if !@scrap.bowls.include? @bowl
        redirect_to scraps_path, alert: "scrap not in that bowl."
      end
    end
  end

  def index
    if !@bowl
      @scraps = current_user.scraps.all
    else
      @scraps = @bowl.scraps
    end
  end

  def edit
    redirect_to scraps_path if @scrap.user != current_user
    redirect_to scraps_path, alert: "scrap not in that bowl." if !@scrap.bowls.include? @bowl
    if !@bowl.nil?
      redirect_to bowl_scraps_path(@bowl), alert: "scrap not found." if @scrap.nil?
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
    redirect_to scraps_path
  end

  def no_bowls
    @scraps = current_user.scraps.no_bowls
    render :index
  end

  private

  def scrap_params
    params.require(:scrap).permit(:description, :category, :user_id, bowl_ids:[], bowls_attributes: [:name, :user_id])
  end

  def set_scrap
    @scrap = Scrap.find_by_id(params[:id])
    if !@scrap
      redirect_to scraps_path, alert: "scrap not found."
    end
  end

  def set_bowl
    if params[:bowl_id]
      @bowl = Bowl.find_by_id(params[:bowl_id])
      if !@bowl || @bowl.user != current_user
        redirect_to bowls_path, alert: "bowl not found."
      end
    end
  end

end
