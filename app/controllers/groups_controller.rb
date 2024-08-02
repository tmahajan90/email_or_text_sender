class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :set_users

  # GET /groups or /groups.json
  def index
    @selected_user_id = params[:group][:user_id] if params[:group]
      if current_user.admin?
        @groups = (params[:group] && params[:group][:user_id]&.present?) ? Group.where(user_id: params[:group][:user_id]) : []
      else
        @groups = current_user.groups
      end
  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_url, notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to groups_url, notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    if @group.destroy
      respond_to do |format|
        format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to groups_url, alert: @group.errors.full_messages.to_sentence }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_users
      @users = User.all if current_user.admin?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_group
      if current_user.admin?
        @group = Group.find(params[:id])
      else
        @group = current_user.groups.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name, :user_id)
    end
end
