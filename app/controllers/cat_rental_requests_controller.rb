class CatRentalRequestsController < ApplicationController
  def create
    @request = CatRentalRequest.create(request_params)
    if @request.save
      redirect_to cat_url(@request.cat)
    else
      flash.now[:errors] = @request.errors.full_messages
      render :new
    end
  end

  private

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end
end
