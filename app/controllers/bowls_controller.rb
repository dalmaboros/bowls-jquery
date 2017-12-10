class BowlsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_bowl, only: [:show, :edit, :update, :destroy]

  def new
    @bowl = Bowl.new
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
    Bowl.create(name: "first_bowl", user: current_user) if current_user.bowls.all.empty?
    @bowls = current_user.bowls.all
  end

  def show
    if @bowl.user != current_user
      redirect_to bowls_path
    else
      @scraps = @bowl.scraps
      @random = @scraps.sample
    end
  end

  def edit
    redirect_to bowls_path if @bowl.user != current_user
  end

  def update
    if @bowl.user == current_user
      if @bowl.update(bowl_params)
        @bowl.save
        redirect_to bowl_path(@bowl)
      else
        @bowl.restore_attributes(@bowl.errors.keys)
        render :edit
      end
    end
  end

  def destroy
    if @bowl.user == current_user
      @bowl.destroy
      redirect_to bowls_url
    end
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
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "bowl #{params[:id]} not found"
      redirect_to bowls_path
  end

end
