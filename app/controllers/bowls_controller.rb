class BowlsController < ApplicationController

  def index
    Bowl.create(name: "My first bowl") if Bowl.all.empty?
    @bowls = Bowl.all
  end

  def show
    @bowl = Bowl.find(params[:id])
    @scraps = @bowl.scraps
  end

  def edit
    @bowl = Bowl.find(params[:id])
  end

  def update
    @bowl = Bowl.find(params[:id])
  end

  def destroy
    Bowl.find(params[:id]).destroy
    redirect_to bowls_url
  end

end
