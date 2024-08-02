class DashboardsController < ApplicationController
  def index
    @clients_count = current_user.clients.count
    @groups_count = current_user.groups.count
    @campaigns_count = current_user.campaigns.count
  end
end
