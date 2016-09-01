class Imagecurrentstatus
  include Mongoid::Document
  include Mongoid::Timestamps
  field :image_status, type: Integer
  field :allocation_status, type: Integer
 field :group_id, type: Integer
  field :classification_id, type: Integer
  field :image_id, type: Integer
  field :isactive, type: String
  field :folder_id, type: Integer

  def self.grouping_process(params,user_id) 
    images=params[:images].keys
      group_count=0
      parent_id=0
    images.map do |img|
      unless params[:images][img].values[1].empty?
        group=params[:images][img].values[0].to_i
        category_id=params[:images][img].values[1]
        if group==1 && group_count==0
           group_count=group_count+1
           parent_id = img
        elsif group==1 && group_count==1
           group_count=group_count+1
        end
          if   group_count==0 && group==0
              Imagecurrentstatus.where(:image_id=>img).update(:classification_id=>category_id,:image_status=>1,:group_id=>img,:allocation_status=>0)
              ProcessLog.where(:user_id=>user_id).where(:activity_id=>$classification_idd).where(:process_specific_id=>img).update_all(:status=>0)
          elsif group_count==1 && group==1
            
               Imagecurrentstatus.where(:image_id=>img).update(:classification_id=>category_id,:image_status=>1,:group_id=>parent_id,:allocation_status=>0)
               ProcessLog.where(:user_id=>user_id).where(:activity_id=>$classification_idd).where(:process_specific_id=>img).update_all(:status=>0)
          elsif group_count=1 && group==0
               Imagecurrentstatus.where(:image_id=>img).update(:classification_id=>category_id,:image_status=>1,:group_id=>parent_id,:allocation_status=>0)
               ProcessLog.where(:user_id=>user_id).where(:activity_id=>$classification_idd).where(:process_specific_id=>img).update_all(:status=>0)
          else
               Imagecurrentstatus.where(:image_id=>img).update(:classification_id=>category_id,:image_status=>1,:group_id=>parent_id,:allocation_status=>0)
               ProcessLog.where(:user_id=>user_id).where(:activity_id=>$classification_idd).where(:process_specific_id=>img).update_all(:status=>0)
              group_count=0
          end
     end
   end
end
end
