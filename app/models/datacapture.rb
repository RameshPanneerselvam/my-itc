class Datacapture
  include Mongoid::Document
  include Mongoid::Timestamps
  field :field_name
  field :field_value
  field :classification_id
  field :capture_flag
  field :group_id
  field :isactive
  field :user_id
  

  def self.data_entry_process(params)
 digitization_id=Activity.where(:activity_name=>"digitization").pluck(:id)[0]
    $head.map do |field|
      Datacapture.create(:field_name=>field[0],:field_value=>params[field[0]],:classification_id=>$classification_digitization_id,:group_id=>$image_group_id,:capture_flag=>1,:user_id=>$user_id)
      Imagecurrentstatus.where(:group_id=>$image_group_id).update_all(:image_status=>2)
      ProcessLog.where(:user_id=>$user_id).where(:activity_id=>digitization_id).where(:process_specific_id=>$image_group_id).update_all(:status=>1)       
    end
  end
def self.subchild_process(params) 

  datacapture_id=$datacapture_id
  data_keys=params.keys
  
  if params.include?("commit")

    data_keys.shift(2)
    data_keys.pop(3)
  else
    data_keys.shift(2)
    data_keys.pop(2)
  end
  @total_params=[]

  data_keys.map do |i|
    if @total_params == []
      @childdatum=Childdatum.create(:field_name=>i,:field_value=>params[i],:datacapture_id=>datacapture_id)
      @childdatum.update(:parent_id=>@childdatum.id)
    else
      @childdatum=Childdatum.create(:field_name=>i,:field_value=>params[i],:datacapture_id=>datacapture_id,:parent_id=>@total_params[0])
    end
    @total_params << @childdatum.id
  end
  
end
   def self.data_update(params)
      field_names=[]
      field_id=FieldProcess.where(:classification_id=>$classification_digitization_id.to_i).where(:tree_status=>0).pluck(:field_id)
      field_id.map { |i| field_names << FieldMaster.where(:id=>i).to_a[0].field_name }
      slice_count=field_names.count
      data=params[:values]
      data=data.each_slice(slice_count).to_a
      index=0
       data.each do |dat|
        group_id=$group_id[index]
        Datacapture.where(:group_id=>group_id)  .delete_all
        k=0
         dat.map do |ff| 
           Datacapture.create(:group_id=>group_id,:field_name=>field_names[k],:field_value=>ff,:capture_flag=>2,:classification_id=>$classification_digitization_id)
           k=k+1
         end
         ProcessLog.where(:process_specific_id=>group_id).update(:status=>2)
         index=index+1
      end
    end

end