class CampaignsController < ApplicationController
  before_action :set_campaign, only: %i[ show edit update destroy ]
  before_action :set_users
  before_action :set_group_clients, only: [:new, :edit]

  # GET /campaigns or /campaigns.json
  def index
    @selected_user_id = params[:campaign][:user_id] if params[:campaign]
    if current_user.admin?
      @campaigns = @selected_user_id.present? ? Campaign.where(user_id: @selected_user_id) : []
    else
      @campaigns = current_user.campaigns
    end
  end

  # GET /campaigns/1 or /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
    if @campaign.sent? || @campaign.failed?
      respond_to do |format|
        format.html { redirect_to campaigns_url, alert: "Cannot edit a campaign that is already sent or failed." }
        format.json { render json: { error: "Cannot edit a campaign that is already sent or failed." }, status: :forbidden }
      end
      return
    end
  end

  # POST /campaigns or /campaigns.json
  def create
    @campaign = Campaign.new(campaign_params)
    if current_user.admin?
      @campaign.user_id = current_user.id
    else
      @campaign.user_id = current_user.id
    end

    @campaign.status = :scheduled

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to campaigns_url, notice: "Campaign was successfully created." }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1 or /campaigns/1.json
  def update
    # Prevent update if the status is 'sent' or 'failed'
    if @campaign.sent? || @campaign.failed?
      respond_to do |format|
        format.html { redirect_to campaigns_url, alert: "Cannot update a campaign that is already sent or failed." }
        format.json { render json: { error: "Cannot update a campaign that is already sent or failed." }, status: :forbidden }
      end
      return
    end

    @campaign.status = :scheduled

    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to campaigns_url, notice: "Campaign was successfully updated." }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1 or /campaigns/1.json
  def destroy
    if @campaign.sent? || @campaign.failed?
      respond_to do |format|
        format.html { redirect_to campaigns_url, alert: "Cannot delete a campaign that is already sent or failed." }
        format.json { render json: { error: "Cannot delete a campaign that is already sent or failed." }, status: :forbidden }
      end
      return
    end

    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: "Campaign was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_users
      @users = User.all if current_user.admin?
    end

    def set_group_clients
      @groups = current_user.groups
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      if current_user.admin?
        @campaign = Campaign.find(params[:id])
      else
        @campaign = current_user.campaigns.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def campaign_params
      params.require(:campaign).permit(:subject, :group_id, :body, :send_at, :status)
    end
end
