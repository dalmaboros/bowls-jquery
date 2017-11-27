class BowlsController < ApplicationController

  def index
    Bowl.create(name: "My first bowl") if Bowl.all.empty?
    @bowls = Bowl.all
  end

  def show
    @bowl = Bowl.find(params[:id])
  end

  def edit
    @bowl = Bowl.find(params[:id])
  end

end
