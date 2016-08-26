class RegionalsController < ApplicationController
  before_action :set_regional, only: [:show, :edit, :update, :destroy]

  # GET /regionals
  # GET /regionals.json
  def index
    @regionals = Regional.where(:id=>current_user.parent_id)
  end

  # GET /regionals/1
  # GET /regionals/1.json
  def show
   @user=User.new
  end

  # GET /regionals/new
  def new
    @regional = Regional.new
  end

  # GET /regionals/1/edit
  def edit
    @reg=Regional.find_by(:id=>params[:id])
    #@regional=[@reg,@reg.contact,@reg.address]
  end

  # POST /regionals
  # POST /regionals.json
  def create
    
    @regional = Regional.new(regional_params.map{|k,v| {k.to_sym =>  v.class == ActionController::Parameters ? [v.to_hash] : v.to_s}}.reduce({}, :merge))

    respond_to do |format|
      if @regional.save
        format.html { redirect_to @regional, notice: 'Regional was successfully created.' }
        format.json { render :show, status: :created, location: @regional }
      else
        format.html { render :new }
        format.json { render json: @regional.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regionals/1
  # PATCH/PUT /regionals/1.json
  def update
    respond_to do |format|
      if @regional.update(regional_params.keep_if{|p,q| q.class != ActionController::Parameters})
        @regional.address.update(regional_params[:address_attributes]) 
        @regional.contact.update(regional_params[:contact_attributes])
        format.html { redirect_to @regional, notice: 'Regional was successfully updated.' }
        format.json { render :show, status: :ok, location: @regional }
      else
        format.html { render :edit }
        format.json { render json: @regional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regionals/1
  # DELETE /regionals/1.json
  def destroy
    @regional.destroy
    respond_to do |format|
      format.html { redirect_to regionals_url, notice: 'Regional was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regional
      @regional = Regional.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def regional_params
      params.require(:regional).permit(:regional_name, :regional_code, :office_id, contact_attributes:[:landline,:extension,:mobilenumber1,:mobilenumber2,:email],address_attributes:[:address1,:address2,:city,:state,:country])
    end
end
