class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.where(:office_id=>current_user.office_id)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    
  end

  # GET /users/1/edit
  def edit
  end
    def user_dashboard
    digitization_id=Activity.where(:activity_name=>"digitization").pluck(:id)[0]
    classification_id=Activity.where(:activity_name=>"classification").pluck(:id)[0]
    off_id=current_user.office_id#User.where(:id=>current_user.id).pluck(:office_id)[0]
    name=OfficeType.where(:id=>off_id).pluck(:type_name)[0]
    if name == "Branch"

    $branch_id=current_user.parent_id#User.where(:id=>current_user.id).pluck(:parent_id)[0]
    $office_id=current_user.office_id#User.where(:id=>current_user.id).pluck(:office_id)[0]
    $warehouse_id=nil
    #elsif name == "Warehouse"
    #$warehouse_id=User.where(:id=>current_user.id).pluck(:parent_id)[0]
    #$branch_id=Warehouse.where(:id=>$warehouse_id).pluck(:branch_id)[0]
     #$office_id=User.where(:id=>current_user.id).pluck(:office_id)[0]
     end
       

   @user=User.new
  @v1=ProcessLog.where(:user_id=>current_user.id).where(:activity_id=>classification_id).pluck(:process_specific_id)
  @v2=[]
  @v1.map do |i|
  @v2 << Imagecurrentstatus.where(:image_id=>i).where(:image_status=>0).where(:allocation_status=>1).pluck(:folder_id)[0]
  end
  @c1=ProcessLog.where(:user_id=>current_user.id).where(:activity_id=>digitization_id).pluck(:process_specific_id)
  @c2=[]
  @c1.map do |i|
  @c2 << Imagecurrentstatus.where(:group_id=>i).where(:image_status=>1).where(:allocation_status=>1).pluck(:folder_id)[0]
  end
   @v3=@v2.compact.uniq
  @c3=@c2.compact.uniq
  
 end 

 def user_report
  $from=params[:from]
  $to=params[:to]
  $classification_idd=Activity.where(:activity_name=>"classification").pluck(:id)[0]
  $digitization_id=Activity.where(:activity_name=>"digitization").pluck(:id)[0]
 @class_id=ProcessLog.where(:user_id=>current_user.id).where(:activity_id=>$classification_idd).where(:status=>0).where(:updated_at=>(params[:from])..(params[:to])).pluck(:process_specific_id)
 @digi_id= ProcessLog.where(:user_id=>current_user.id).where(:status=>1).where(:activity_id=>2).where(:updated_at=>(params[:from])..(params[:to])).pluck(:process_specific_id)
@ff_id=[]
@class_id.map do |i|
  @ff_id <<Imagecurrentstatus.where(:image_id=>i).pluck(:folder_id)[0]
 end 
@ff1_id=[]
 @digi_id.map do |j|
  @ff1_id <<Imagecurrentstatus.where(:group_id=>j).pluck(:folder_id)[0]
 end 
 if @ff_id.present?
  $ff_id=@ff_id
  $ff_id.uniq!
  else
    $ff_id=@ff_id
    $ff_id= nil
end
 if @ff1_id.present?
  $ff1_id=@ff1_id
 $ff1_id.uniq!
 else
  $ff1_id=@ff1_id
  $ff1_id=nil
end
flash[:warning] = "Successflly Updated."
redirect_to :action=>"user_dashboard"
 end
   

def branch_dashboard
  @user1=User.new
@branch=Branch.all
end 

def branch_report
 $folder1=Folder.where(:branch_id=>$branch_id).pluck(:id)
 $params1=params[:from]
 $params2=params[:to]
 $params3= params[:user][:id]
 flash[:success] = "Successflly Updated."
 redirect_to :action=>"branch_dashboard"
end  
    
  # POST /users
  # POST /users.json
  def create

    @user = User.new(user_params.map{|k,v| {k.to_sym =>  v.class == ActionController::Parameters ? [v.to_hash] : v.to_s}}.reduce({}, :merge))

    respond_to do |format|
      if @user.save
       Usermailer1Mailer.mail1(@user).deliver
        format.html { redirect_to @user, success: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params.keep_if{|p,q| q.class != ActionController::Parameters})
        @user.address.update(user_params[:address_attributes])
       @user.contact.update(user_params[:contact_attributes])
        format.html { redirect_to @user, warning: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, danger: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :user_name, :password, :usertype, :role, :office_id, :parent_id, :parent_code, contact_attributes:[:landline,:extension,:mobilenumber1,:mobilenumber2,:email],address_attributes:[:address1,:address2,:city,:state,:country])
    end
end
