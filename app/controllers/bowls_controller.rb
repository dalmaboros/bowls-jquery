class BowlsController < ApplicationController
  before_action :set_bowl, only: [:show, :edit, :update, :destroy]

  def new
    @bowl = Bowl.new
  end

  def create
    # @user = User.find_by(bowl_params[:user_id])
    # @bowl = @user.bowls.build(bowl_params.except(:user_id))
    binding.pry
    @bowl = Bowl.create(bowl_params)
    binding.pry
    if @bowl.save
      redirect_to @bowl
    else
      render :new
    end
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
    params.require(:bowl).permit(:name, :description, :scrap_ids, :user_id)
  end

  def set_bowl
    @bowl = Bowl.find(params[:id])
  end

end
