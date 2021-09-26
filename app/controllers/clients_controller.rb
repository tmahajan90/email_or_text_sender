class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_url, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def update
    if @client.update(client_params)
      redirect_to clients_url, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @client.orders.where(status: true).count == 0
      @client.destroy
      redirect_to :root, notice: 'Client was successfully destroyed.'
    else
      flash[:alert] = 'Clients with active orders can not be deleted. Mark his/hers open orders as returned and try again.'
      redirect_to root_url
    end
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name, :email, :mobile_no, :address, :aadhaar_no, :pan_no)
    end
end
