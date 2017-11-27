class HomeController < ApplicationController

  def index
    @bowls = Bowl.all
    @scraps = Scrap.all
  end

end
