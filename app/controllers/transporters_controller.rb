class TransportersController < ApplicationController
  before_action :set_transporter, only: [:show, :edit, :update, :destroy]

  # GET /transporters
  # GET /transporters.json
  def index
    @transporters = Transporter.where(:warehouse_id=>current_user.parent_id)
  end

  # GET /transporters/1
  # GET /transporters/1.json
  def show
    @user=User.new
  end

  # GET /transporters/new
  def new
    @transporter = Transporter.new
  end

  # GET /transporters/1/edit
  def edit
  end

  # POST /transporters
  # POST /transporters.json
  def create
    @transporter = Transporter.new(transporter_params.map{|k,v| {k.to_sym =>  v.class == ActionController::Parameters ? [v.to_hash] : v.to_s}}.reduce({}, :merge))

    respond_to do |format|
      if @transporter.save
        format.html { redirect_to @transporter, notice: 'Transporter was successfully created.' }
        format.json { render :show, status: :created, location: @transporter }
      else
        format.html { render :new }
        format.json { render json: @transporter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transporters/1
  # PATCH/PUT /transporters/1.json
  def update
    respond_to do |format|
      if @transporter.update(transporter_params.keep_if{|p,q| q.class != ActionController::Parameters}) 
        @transporter.address.update(transporter_params[:address_attributes]) 
        @transporter.contact.update(transporter_params[:contact_attributes])
        format.html { redirect_to @transporter, notice: 'Transporter was successfully updated.' }
        format.json { render :show, status: :ok, location: @transporter }
      else
        format.html { render :edit }
        format.json { render json: @transporter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transporters/1
  # DELETE /transporters/1.json
  def destroy
    @transporter.destroy
    respond_to do |format|
      format.html { redirect_to transporters_url, notice: 'Transporter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transporter
      @transporter = Transporter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transporter_params
      params.require(:transporter).permit(:transporter_name, :transporter_code, :warehouse_id,:warehouse_code, :office_id, contact_attributes:[:landline,:extension,:mobilenumber1,:mobilenumber2,:email],address_attributes:[:address1,:address2,:city,:state,:country])
    end
end
