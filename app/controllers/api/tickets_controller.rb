class Api::TicketsController < ApiController
  include ResourceApi

  respond_to :json

  private

  def resource_class
    Ticket
  end

  def resource_params
    params.require(:ticket).permit(:title, :description)
  end
end
