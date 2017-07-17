class CatsController < ApplicationController
  def index
    @cats = Cats.all
  end

  def show
    @cat = Cat.find(params[:id])
  end
end
