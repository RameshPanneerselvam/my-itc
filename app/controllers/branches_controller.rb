class BranchesController < ApplicationController
  before_action :set_branch, only: [:show, :edit, :update, :destroy]

  # GET /branches
  # GET /branches.json
  def index
    @branches = Branch.where(:regional_id=>current_user.parent_id)
  end

  # GET /branches/1
  # GET /branches/1.json
  def show
    @user=User.new
  end

  # GET /branches/new
  def new

    @branch = Branch.new
  end

  # GET /branches/1/edit
  def edit
  end



  # POST /branches
  # POST /branches.json
  def create
    @branch = Branch.new(branch_params.map{|k,v| {k.to_sym =>  v.class == ActionController::Parameters ? [v.to_hash] : v.to_s}}.reduce({}, :merge))

    respond_to do |format|
      if @branch.save
        format.html { redirect_to @branch, success: 'Branch was successfully created.' }
        format.json { render :show, status: :created, location: @branch }
      else
        format.html { render :new }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branches/1
  # PATCH/PUT /branches/1.json
  def update
    respond_to do |format|
      if @branch.update(branch_params.map{|k,v| {k.to_sym => v.to_s}.except!(:contact_attributes,:address_attributes) }.reduce({}, :merge)) && @branch.address.update(branch_params[:address_attributes]) && @branch.contact.update(branch_params[:contact_attributes])
        format.html { redirect_to @branch, notice: 'Branch was successfully updated.' }
        format.json { render :show, status: :ok, location: @branch }
      else
        format.html { render :edit }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1
  # DELETE /branches/1.json
  def destroy
    @branch.destroy
    respond_to do |format|
      format.html { redirect_to branches_url, danger: 'Branch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def branch_params
      params.require(:branch).permit(:branch_name, :branch_code, :regional_id, :office_id, contact_attributes:[:landline,:extension,:mobilenumber1,:mobilenumber2,:email],address_attributes:[:address1,:address2,:city,:state,:country])
    end
end
