require 'csv'
class ImagesController < ApplicationController
skip_before_filter :verify_authenticity_token  

def image_browse
  if params[:format].present?
    $folder_id=params[:format]
    @show_upload=1
    
  else
    $folder_id=nil
  end
  Folder.where(:folder_name=>nil).delete_all
   @all_folder=Folder.all
   @image=Image.new
end

 def create_folder
    @folder=Folder.new(folder_params)
    @all=Folder.pluck(:folder_name)
    if @all.include?(@folder.folder_name)
      flash[:notice] = "Foldername is alredy exists..."
      redirect_to :action=>"image_browse" 
    else
     @folder.save
     @folder.update_attributes(:parent_folder_id=>$folder_id) 
      redirect_to :action=>"image_browse"
    end
  end


def save_image
    @imgg=image_params[:image_path]
    @imgg.each do |i|
      @image = Image.new(:image_path=>i)
     Folder.where(:id=>$folder_id).update(:folder_status=>nil)
     @image.save
      @id=@image.id
      Imagecurrentstatus.create(:image_id=>@id,:folder_id=>$folder_id,:image_status=>0,:allocation_status=>0,:group_id=>0,:classification_id=>0)      
    end 
    flash[:notice] = "Successflly Saved."
    redirect_to :action=>"image_browse"
end


def image_classification
  classification_id=Activity.where(:activity_name=>"classification").pluck(:id)[0]
  if params[:format].present?
    $folder_id=params[:format]
  end
  @all_image=[]
  @all_image1=[]
  image_id=ProcessLog.where(:activity_id=>classification_id).where(:user_id=>current_user.id).where(:status=>nil).pluck(:process_specific_id)
@image=Image.where(:id=>image_id[0])
  image_id.map do |ff|   
    if Imagecurrentstatus.where(:folder_id=>$folder_id).where(:image_id=>ff).to_a[0] != nil
    @all_image << Imagecurrentstatus.where(:folder_id=>$folder_id).where(:image_id=>ff).to_a[0].image_id
  end
  end
    @all_image.map do |k|
      unless Image.where(:id=>k).empty?
        @all_image1 << Image.where(:id=>k).to_a
      end
    end
     @all_image1=@all_image1.flatten!
  end 


def classification_update
  Imagecurrentstatus.grouping_process(params)
  redirect_to :action=>"image_classification"
end

  def attribute_creation
    if params[:format] != nil
      $classification_id=params[:format].to_i
    end
     if $classification_id==nil
       $classification_id=Classification.last.id
     end
      @field=FieldMaster.new
      @field_name1=FieldProcess.where(:tree_status=>0).any_of({classification_id: $classification_id},{classification_id: $classification_id.to_i})
      @check_box_classification=FieldProcess.where(:classification_id=>$classification_id).where(:subchild_flag=>0)
       @dropdownvalue=[]   
    dropdown_id=FieldProcess.where(:classification_id=>$classification_id).pluck(:id)
     dropdown_id.map { |ff| @dropdownvalue << Dropdownvalue.where(:field_process_id=>ff).to_a[0]  }
     @dropdownvalue=@dropdownvalue.compact
     @dropdown=Dropdownvalue.new
    end

  def create_attribute
    if params[:field_master].keys[0] != "id"
      if params[:field_master]["field_name"].split.count !=1
        a=params[:field_master]["field_name"].split[0].capitalize
        b=params[:field_master]["field_name"].split[1].capitalize
        field_name=a+b
      else
        field_name=params[:field_master]["field_name"]
      end
      @field=FieldMaster.create(:field_name=>field_name)
      FieldProcess.create(:field_type=>params["field_type"],:field_id=>@field.id,:specification=>params["specification"],:classification_id=>$classification_id,:tree_status=>0,:subchild_flag=>0)
      Dropdownvalue.where(:field_process_id=>nil).update_all(:field_process_id=>FieldProcess.last.id)
    else     
     FieldProcess.create(:field_type=>params["field_type"],:specification=>params["specification"],:field_id=>params[:field_master].values[0].to_i,:classification_id=>$classification_id,:tree_status=>0,:subchild_flag=>0)
     Dropdownvalue.where(:field_process_id=>nil).update_all(:field_process_id=>FieldProcess.last.id)
    end  
    flash[:notice] = "Successflly Saved."
    redirect_to :action=>"attribute_creation"
  end
 
  def child_attribute
    $classification_id= params[:classification]["id"]
    redirect_to :action=>"child_attribute_creation"
  end
  
  def child_attribute_creation
    $check_box_value=params[:field_name]
    @field_child=FieldMaster.new
      @field1=FieldProcess.where(:tree_status=>1).any_of({classification_id: $classification_id},{classification_id: $classification_id.to_i})
      @dropdownvalue=[]   
    dropdown_id=FieldProcess.where(:classification_id=>$classification_id).pluck(:id)
     dropdown_id.map { |ff| @dropdownvalue << Dropdownvalue.where(:field_process_id=>ff).to_a[0]  }
     @dropdown=Dropdownvalue.new
  end
 
  def create_child_attribute
    if params[:field_master].keys[0] != "id"
       if params[:field_master]["field_name"].split.count !=1
        a=params[:field_master]["field_name"].split[0].capitalize
        b=params[:field_master]["field_name"].split[1].capitalize
        field_name=a+b
       else
        field_name=params[:field_master]["field_name"]
       end
      @field=FieldMaster.create(:field_name=>field_name)
        @ff=FieldProcess.create(:field_type=>params["field_type"],:specification=>params["specification"],:field_id=>@field.id,:classification_id=>$classification_id,:tree_status=>1,:subchild_flag=>0)
       else
       FieldProcess.create(:field_type=>params["field_type"],:specification=>params["specification"],:field_id=>params[:field_master].values[0],:classification_id=>$classification_id,:tree_status=>1,:subchild_flag=>0)
       Dropdownvalue.where(:field_process_id=>nil).update_all(:field_process_id=>FieldProcess.last.id)
     end    
           unless $check_box_value.nil?
             $check_box_value.map do |k|
               FieldProcess.where(:field_id=>k).where(:tree_status=>0).update(:subchild_flag=>1)
             end
          end
       $check_box_value=nil
       flash[:notice] = "Successflly Saved."
       redirect_to :action=>"child_attribute_creation"
  end

  def classification_creation
    @classification=Classification.new 
    @all_classification=Classification.all
  end
    
  def create_classification
    @classification=Classification.new(classification_params)
      if @classification.save
        $classification_id=nil
        flash[:notice] = "Successflly Saved."
        redirect_to :action=>"attribute_creation"
      else
        flash[:notice] = "Sorry not Saved"
        render "classification_creation"
      end
   
  end

  def destroy_field
    @field1=FieldProcess.find params[:format]
  
    @field1.delete
  
    flash[:notice] = "Successflly Deleted."
  
    redirect_to :action=>"attribute_creation"
  end
def destroy_child_field
    @field1=FieldProcess.find params[:format]
  
    @field1.delete
  
    flash[:notice] = "Successflly Deleted."
  
    redirect_to :action=>"child_attribute_creation"
  end
  def destroy
    @folder=Folder.find params[:id]
    @folder.delete
    flash[:notice] = "Successflly Deleted."
    redirect_to :action=>"digitization"
  end

  def attribute_allocation
    $classification_id=params[:classification].values[0]
    redirect_to :action=>"attribute_creation"
  end
def allocation_classification
  $classification_idd=Activity.where(:activity_name=>"classification").pluck(:id)[0]
 @user=User.where(:office_id=>$office_id).where(:parent_id=>$branch_id) 
  @image=Image.new
 if params[:format].blank?
  @img=Imagecurrentstatus.where(:image_status=>0).where(:allocation_status=>0).where(:folder_id=>$folder_id).pluck(:image_id)
 else
  @img=Imagecurrentstatus.where(:image_status=>0).where(:allocation_status=>0).where(:folder_id=>params[:format]).pluck(:image_id)
end
Folder.where(:folder_name=>nil).delete
  @folder=Folder.where(:folder_status=>nil).to_a
end  

def allocated_classification
ProcessLog.classification_process(params)
redirect_to :action=>"allocation_classification"
end 

def allocation_digitization
   $digitization_id=Activity.where(:activity_name=>"digitization").pluck(:id)[0]
  @image=Image.new
   @user=User.where(:office_id=>$office_id).where(:parent_id=>$branch_id)
@fold=Imagecurrentstatus.where(:image_status=>"1").where(:allocation_status=>"0").pluck(:folder_id).uniq
end  

def allocated_digitization
  ProcessLog.digitization_process(params)
  redirect_to :action=>"allocation_digitization"
end  

 
 
def digitization

   current_group=[]
   @all_image1=[]
  digitization_id=Activity.where(:activity_name=>"digitization").pluck(:id)[0]
  @classification=[]
  classification=[]
    if params[:format].present?
      $fol_id=params[:format]
    end
    if params[:classification].present?
      $classification_digitization_id=nil
      $classification_digitization_id=params[:classification]["id"]
    end
   @process_id=ProcessLog.where(:user_id=>current_user.id).where(:status=>nil).where(:activity_id=>digitization_id).pluck(:process_specific_id)
if @process_id != nil

      @process_id.map do |i|
          current_group << Imagecurrentstatus.where(:group_id=>i).where(:folder_id=>$fol_id).where(:image_status=>1).where(:classification_id=>$classification_digitization_id).to_a[0]
          classification << Imagecurrentstatus.where(:group_id=>i).where(:folder_id=>$fol_id).where(:image_status=>1).to_a[0]
      end
classification.compact!
classification=classification.pluck(:classification_id)
classification.uniq!
  classification.map { |i| @classification << Classification.where(:id=>i).to_a[0]  }
          current_group.compact!
          $count=current_group.count
if current_group != []
 
          
          $image_group_id=current_group[0].group_id
          image_id=Imagecurrentstatus.where(:group_id=>$image_group_id).pluck(:image_id)
          image_id.map { |i| @all_image1 << Image.where(:id=>i).to_a[0]  }
        end
end
if @all_image1 != []
  @all_image2=@all_image1[0]
end
 @image_exception=ImageException.new
 @headers=FieldProcess.where(:tree_status=>0).any_of({classification_id: $classification_digitization_id},{classification_id: $classification_digitization_id.to_i})
 @datacapture=Datacapture.where(:classification_id=>$classification_digitization_id).where(:capture_flag=>1).where(:user_id=>current_user.id)
 @select_classification=Classification.new

  end


   def save_remark
    ImageException.skip_process(params)
    redirect_to :action=>"digitization"
  end

  def create_digitization
    Datacapture.data_entry_process(params)
      redirect_to :action=>"digitization"    
  end



  def create_dropdownvalue
     params[:values].shift
     dropdownvalue=params[:values]
     dropdownvalue.map { |ff| Dropdownvalue.create(:dropdownvalues_name=>ff)  }
  end

 def create_child_dropdownvalue
   params[:values].shift
   dropdownvalue=params[:values]
   dropdownvalue.map { |ff| Dropdownvalue.create(:dropdownvalues_name=>ff)  }
  end

   
  
   
   def import_file
    @data=Datacapture.new
    @select_classification=Classification.new
    @classification=Classification.all
   end

    def import_data
    Dataimport.import_process(params)
    redirect_to :action=>"import_file"
   end
  
  def download_template
    field_names=[]
    template_name=Classification.where(:id=>params[:classification][:id]).pluck(:classification_name)
     field=FieldProcess.where(:classification_id=>params[:classification][:id]).not.where(:specification=>"D").pluck(:field_id)
     field.map { |i| field_names << FieldMaster.where(:id=>i).to_a[0].field_name  }
     CSV.open("#{Rails.root}/public/templates/template.csv","w", {:col_sep => "\t",:row_sep => "\r\n"}) do |csv|

     csv << field_names
  
  end
  
    redirect_to "/templates/template.csv"

  end


def document_allocate_digitization
   @user=User.where(:office_id=>$office_id).where(:parent_id=>$branch_id)
  if params[:format].present?
     $para_fmt=params[:format] 
     
     $tot_document=Imagecurrentstatus.where(:folder_id=>$para_fmt).where(:image_status=>1).pluck(:group_id).uniq.count
   end
   $gro_id=Imagecurrentstatus.where(:folder_id=>$para_fmt).where(:image_status=>1).where(:allocation_status=>0).pluck(:group_id).uniq
   @doc=Imagecurrentstatus.where(:folder_id=>$para_fmt).where(:image_status=>1).where(:allocation_status=>1).pluck(:group_id).uniq
   @doc_count=@doc.count
   @remaining=$gro_id.count
   @us_id=[]
   @doc.map do |r|
    @us_id << ProcessLog.where(:process_specific_id=>r).where(:activity_id=>$digitization_id).pluck(:user_id)[0]
  end
  end
 

def document_allocated_digitization
   document_count=params[:d_count].to_i
   @doc_user_id=params[:image][:id]
   @s_doc=$gro_id.shift(document_count)
 @s_doc.map do |kk|
      ProcessLog.create(:activity_id=>$digitization_id,:user_id=>@doc_user_id,:process_specific_id=>kk)
      Imagecurrentstatus.where(:group_id=>kk).update_all(:allocation_status=>1)
 end
  redirect_to :action=>"document_allocate_digitization"
 end

def self_audit
    if params[:id].present?
      $classification_digitization_id=Classification.where(:id=>params[:id])
    end
  @datacapture=Datacapture.new
  @old_data=Datacapture.where(:classification_id=>$classification_digitization_id).where(:capture_flag=>1)
  $group_id=@old_data.pluck(:group_id).uniq!
  @headers=FieldProcess.where(:tree_status=>0).any_of({classification_id: $classification_digitization_id},{classification_id: $classification_digitization_id.to_i})
  
end

def update_classification
  Datacapture.data_update(params)
  redirect_to :action=>"self_audit"
end

def exception_details
 @exception=[]
 @image=[]
   @image_exception=ImageException.all
   @image_exception.map do |ff|
    image_id = Imagecurrentstatus.where(:group_id=>ff.group_id).where(:image_status=>9).pluck(:image_id)
    image_id.map { |i| @image << Image.where(:id=>i).to_a }
   end
   @image.flatten!
   @image.map do |image|
    @warehuse_name=Warehouse.where(:id=>image.warehouse_id).pluck(:warehuse_name)[0]
    @issue_date=ImageException.where(:group_id=>Imagecurrentstatus.where(:image_id=>image.id).pluck(:group_id)[0]).pluck(:created_at)[0]
    @remark_name= RemarkMaster.where(:id=>ImageException.where(:group_id=>Imagecurrentstatus.where(:image_id=>image.id).pluck(:group_id)[0]).pluck(:remarks_id)[0]).pluck(:remark_name)[0]
    @reason=ImageException.where(:group_id=>Imagecurrentstatus.where(:image_id=>image.id).pluck(:group_id)[0]).pluck(:reason_for_exception)[0]
    #@image_path=image.image_path
    @folder_name=Folder.where(:id=>Imagecurrentstatus.where(:image_id=>image.id).pluck(:folder_id)[0]).pluck(:folder_name)[0]
    @uploaded_date=Image.where(:id=>image.id).pluck(:created_at)[0]
    @exception << [@warehuse_name,@issue_date,@remark_name,@reason,image,@folder_name,@uploaded_date]
   end  

end

def sub_data
  
  $datacapture_id=params[:format]
  @sub_datacapture=Childdatum.where(:datacapture_id=>$datacapture_id)

  end
def subchild_update

     
     if params.include?(:commit)
      Datacapture.subchild_process(params) 
      
        redirect_to :action=>"digitization" , :format  => Imagecurrentstatus.find_by(:group_id=>$image_group_id).folder_id.to_i
     else
      Datacapture.subchild_process(params) 
        redirect_to :action=>"sub_data" , :format  => $datacapture_id
     end
end


private
  def image_params
    params.require(:image).permit!
  end
  def folder_params
    params.require(:folder).permit!
  end

  def field_params
    params.require(:field_mmaster).permit!
  end

  def classification_params
    params.require(:classification).permit!
  end

   def dropdownvalue_params
       params.require(:dropdownvalue).permit!
    end
    
end
