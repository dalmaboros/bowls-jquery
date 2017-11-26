class BowlsController < ApplicationController

  def index
    @bowls = Bowl.all
  end

  def show
    @bowl = Bowl.find(params[:id])
  end

end
