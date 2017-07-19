class CatsController < ApplicationController
  before_action :ensure_owner, only: [:edit, :update]

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now = @cat.errors.full_messages
      render :edit
    end
  end

  def update
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end

  def ensure_owner
    @cat = current_user.cats.where(id: params[:id])
    redirect_to cats_url unless @cat
  end
end
