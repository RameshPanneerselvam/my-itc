class ProcessLog
  include Mongoid::Document
  include Mongoid::Timestamps
  field :activity_id, type: String
  field :user_id, type: String
  field :process_specific_id, type: String
  field :status, type: String
  field :isactive, type: String


def self.classification_process(params)
    ee=params[:group]
  ee.map do |folder|
    Folder.where(:id=>folder).update(:folder_status=>0)
  	img_id=Imagecurrentstatus.where(:folder_id=>folder).pluck(:image_id)
     n=ProcessLog.pluck(:process_specific_id)
     img_id=img_id-n
  	img_id.map do |img|
  		ProcessLog.create(:activity_id=>$classification_idd,:user_id=>params[:image][:id],:process_specific_id=>img)
      Imagecurrentstatus.where(:image_id=>img).update(:allocation_status=>1)
  	end
  end	
end


def self.digitization_process(params)
@f_id=params[:group]
@f_id.map do |folder1|
@g_id=Imagecurrentstatus.where(:folder_id=>folder1).where(:image_status=>"1").where(:allocation_status=>"0").pluck(:group_id).uniq
end
@g_id.map do |k|
  ProcessLog.create(:activity_id=>$digitization_id,:user_id=>params[:image][:id],:process_specific_id=>k)
      Imagecurrentstatus.where(:group_id=>k).update_all(:allocation_status=>1)
     end  
end

end 