class CatRentalRequestsController < ApplicationController
  before_action :ensure_cat_owner, only: [:approve, :deny]

  def create
    @request = CatRentalRequest.create(request_params)
    if @request.save
      redirect_to cat_url(@request.cat)
    else
      flash.now[:errors] = @request.errors.full_messages
      render :new
    end
  end

  def approve
    @request.approve!
    redirect_to cat_url(@request.cat)
  end

  def deny
    @request.deny!
    redirect_to cat_url(@request.cat)
  end

  private

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end

  def ensure_cat_owner
    @request = current_user.cats.requests.where(id: params[:request_id])
    redirect_to cats_url unless @request
  end
end
