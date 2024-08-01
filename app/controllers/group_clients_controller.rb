class GroupClientsController < ApplicationController
    before_action :set_group
  
    def index
      @clients = Client.all
      @group_clients = @group.clients
    end
  
    def create
      client_ids = params[:group][:client_ids].split(',').map(&:to_i)
      @group.client_ids = client_ids
      if @group.save
        redirect_to group_group_clients_path(@group), notice: 'Clients were successfully updated.'
      else
        render :index
      end
    end
  
    private
  
    def set_group
      @group = Group.find(params[:group_id])
    end
  end
  