class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  # GET /warehouses
  # GET /warehouses.json
  def index
    @warehouses = Warehouse.where(:branch_id=>current_user.parent_id)
  end

  # GET /warehouses/1
  # GET /warehouses/1.json
  def show
    @user=User.new
  end

  # GET /warehouses/new
  def new
    @warehouse = Warehouse.new
  end

  # GET /warehouses/1/edit
  def edit
  end

  # POST /warehouses
  # POST /warehouses.json
  def create
    @warehouse = Warehouse.new(warehouse_params.map{|k,v| {k.to_sym =>  v.class == ActionController::Parameters ? [v.to_hash] : v.to_s}}.reduce({}, :merge))

    respond_to do |format|
      if @warehouse.save
        format.html { redirect_to @warehouse, success: 'Warehouse was successfully created.' }
        format.json { render :show, status: :created, location: @warehouse }
      else
        format.html { render :new }
        format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /warehouses/1
  # PATCH/PUT /warehouses/1.json
  def update
    respond_to do |format|
      if @warehouse.update(warehouse_params.keep_if{|p,q| q.class != ActionController::Parameters}) 
        @warehouse.address.update(warehouse_params[:address_attributes])
       @warehouse.contact.update(warehouse_params[:contact_attributes])
        format.html { redirect_to @warehouse, warning: 'Warehouse was successfully updated.' }
        format.json { render :show, status: :ok, location: @warehouse }
      else
        format.html { render :edit }
        format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warehouses/1
  # DELETE /warehouses/1.json
  def destroy
    @warehouse.destroy
    respond_to do |format|
      format.html { redirect_to warehouses_url, danger: 'Warehouse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warehouse
      @warehouse = Warehouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warehouse_params
      params.require(:warehouse).permit(:warehouse_name, :warehouse_code, :branch_id, :branch_code, :office_id, contact_attributes:[:landline,:extension,:mobilenumber1,:mobilenumber2,:email],address_attributes:[:address1,:address2,:city,:state,:country])
    end
end
