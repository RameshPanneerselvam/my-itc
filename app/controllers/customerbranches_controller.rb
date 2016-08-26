class CustomerbranchesController < ApplicationController
  before_action :set_customerbranch, only: [:show, :edit, :update, :destroy]

  # GET /customerbranches
  # GET /customerbranches.json
  def index
    @customerbranches = Customerbranch.where(:customer_id=>current_user.parent_id)
  end

  # GET /customerbranches/1
  # GET /customerbranches/1.json
  def show
    @user=User.new
  end

  # GET /customerbranches/new
  def new
    @customerbranch = Customerbranch.new
  end

  # GET /customerbranches/1/edit
  def edit
  end


  # POST /customerbranches
  # POST /customerbranches.json
  def create
    @customerbranch = Customerbranch.new(customerbranch_params.map{|k,v| {k.to_sym =>  v.class == ActionController::Parameters ? [v.to_hash] : v.to_s}}.reduce({}, :merge))

    respond_to do |format|
      if @customerbranch.save
        format.html { redirect_to @customerbranch, notice: 'Customerbranch was successfully created.' }
        format.json { render :show, status: :created, location: @customerbranch }
      else
        format.html { render :new }
        format.json { render json: @customerbranch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customerbranches/1
  # PATCH/PUT /customerbranches/1.json
  def update
    respond_to do |format|

    if @customerbranch.update(customerbranch_params.keep_if{|p,q| q.class != ActionController::Parameters}) 
      @customerbranch.address.update(customerbranch_params[:address_attributes])
      @customerbranch.contact.update(customerbranch_params[:contact_attributes])

        format.html { redirect_to @customerbranch, notice: 'Customerbranch was successfully updated.' }
        format.json { render :show, status: :ok, location: @customerbranch }
      else
        format.html { render :edit }
        format.json { render json: @customerbranch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customerbranches/1
  # DELETE /customerbranches/1.json
  def destroy
    @customerbranch.destroy
    respond_to do |format|
      format.html { redirect_to customerbranches_url, notice: 'Customerbranch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customerbranch
      @customerbranch = Customerbranch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customerbranch_params
      params.require(:customerbranch).permit(:customer_name, :customerbranch_code, :customer_id, :customer_code, :office_id, contact_attributes:[:landline,:extension,:mobilenumber1,:mobilenumber2,:email],address_attributes:[:address1,:address2,:city,:state,:country])
    end
end
