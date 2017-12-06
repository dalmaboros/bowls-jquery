class BowlsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_bowl, only: [:show, :edit, :update, :destroy]

  def new
    # if !user_signed_in?
    #   redirect_to root_path
    # else
      @bowl = Bowl.new
    # end
  end

  def create
    @bowl = Bowl.create(bowl_params)

    if @bowl.save
      redirect_to @bowl
    else
      render :new
    end
  end

  def index
    # if !user_signed_in?
    #   redirect_to root_path
    # else
      Bowl.create(name: "My first bowl", user: current_user) if current_user.bowls.all.empty?
      @bowls = current_user.bowls.all
    # end
  end

  def show
    if !user_signed_in?
      redirect_to root_path
    else
      @scraps = @bowl.scraps
      @random = @scraps.sample
    end
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
    params.require(:bowl).permit(:name, :description, :scrap_ids, :user_id)
  end

  def set_bowl
    if !user_signed_in?
      redirect_to root_path
    else
      @bowl = Bowl.find(params[:id])
    end
  end

end
