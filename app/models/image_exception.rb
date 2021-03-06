class ImageException
  include Mongoid::Document
  include Mongoid::Timestamps
  field :remarks_id, type: Integer
  field :reason_for_exception, type: String
  field :group_id, type: Integer
  field :image_id, type: Integer
  field :image_id, type: Integer
  field :isactive, type: String

def self.skip_process(params,user_id)
	digitization_id=Activity.where(:activity_name=>"digitization").pluck(:id)[0]
  if params[:image_exception].keys[0] != "id"
      @remark=RemarkMaster.create(:remark_name=>params[:image_exception][:remarks_id])
      ImageException.create(:group_id=>$image_group_id,:remarks_id=>@remark.id,:reason_for_exception=>params[:image_exception][:reason_for_exception])
      Imagecurrentstatus.where(:group_id=>$image_group_id).where(:image_status=>1).update_all(:image_status=>9)
      ProcessLog.where(:process_specific_id=>$image_group_id).where(:user_id=>user_id).where(:activity_id=>digitization_id).update_all(:status=>9)
    else
      ImageException.create(:group_id=>$image_group_id,:remarks_id=>params[:image_exception][:id],:reason_for_exception=>params[:image_exception][:reason_for_exception])
      Imagecurrentstatus.where(:group_id=>$image_group_id).where(:image_status=>1).update_all(:image_status=>9)
      ProcessLog.where(:process_specific_id=>$image_group_id).where(:user_id=>user_id).where(:activity_id=>digitization_id).update_all(:status=>9)
    end
end

def self.skip_classification(params,classification_id,user_id)
  image_id=params[:format].to_i
   if params[:image_exception].keys[0] != "id"
      @remark=RemarkMaster.create(:remark_name=>params[:image_exception][:remarks_id])
      ImageException.create(:image_id=>image_id,:remarks_id=>@remark.id,:reason_for_exception=>params[:image_exception][:reason_for_exception])
      Imagecurrentstatus.where(:image_id=>image_id).where(:image_status=>0).where(:allocation_status=>1).update(:image_status=>9)
      ProcessLog.where(:activity_id=>classification_id).where(:process_specific_id=>image_id).where(:user_id=>user_id).update_all(:status=>9)
    else
      ImageException.create(:image_id=>image_id,:remarks_id=>params[:image_exception][:id],:reason_for_exception=>params[:image_exception][:reason_for_exception])
      Imagecurrentstatus.where(:image_id=>image_id).where(:image_status=>0).where(:allocation_status=>1).update(:image_status=>9)
      ProcessLog.where(:activity_id=>classification_id).where(:process_specific_id=>image_id).where(:user_id=>user_id).update(:status=>9)
    end
  end
end
