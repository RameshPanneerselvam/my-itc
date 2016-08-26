class PagemastersController < ApplicationController
  before_action :set_pagemaster, only: [:show, :edit, :update, :destroy]

  # GET /pagemasters
  # GET /pagemasters.json
  def index
    @pagemasters = Pagemaster.all
  end

  # GET /pagemasters/1
  # GET /pagemasters/1.json
  def show
  end

  # GET /pagemasters/new
  def new
    @pagemaster = Pagemaster.new
  end

  # GET /pagemasters/1/edit
  def edit
  end
  def pagesetting_page
    @pagesetting=PageSetting.new
  end
  def pagesetting
    if PageSetting.where(:user_id=>params[:page_setting][:user_id].to_i).present?
      PageSetting.where(:user_id=>params[:page_setting][:user_id].to_i).update(:page_id=>params[:pages])
      redirect_to :action => "pagesetting_page"
    else
      PageSetting.create(:user_id=>params[:page_setting][:user_id].to_i,:page_id=>params[:pages])
      redirect_to :action => "pagesetting_page"
    end
  end
  # POST /pagemasters
  # POST /pagemasters.json
  def create
    @pagemaster = Pagemaster.new(pagemaster_params)

    respond_to do |format|
      if @pagemaster.save
        format.html { redirect_to @pagemaster, notice: 'Pagemaster was successfully created.' }
        format.json { render :show, status: :created, location: @pagemaster }
      else
        format.html { render :new }
        format.json { render json: @pagemaster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pagemasters/1
  # PATCH/PUT /pagemasters/1.json
  def update
    respond_to do |format|
      if @pagemaster.update(pagemaster_params)
        format.html { redirect_to @pagemaster, notice: 'Pagemaster was successfully updated.' }
        format.json { render :show, status: :ok, location: @pagemaster }
      else
        format.html { render :edit }
        format.json { render json: @pagemaster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagemasters/1
  # DELETE /pagemasters/1.json
  def destroy
    @pagemaster.destroy
    respond_to do |format|
      format.html { redirect_to pagemasters_url, notice: 'Pagemaster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pagemaster
      @pagemaster = Pagemaster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pagemaster_params
       #params.require(:pagemaster).permit(:
      params.fetch(:pagemaster, {})
    end
end
