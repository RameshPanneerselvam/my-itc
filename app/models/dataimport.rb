class Dataimport
  include Mongoid::Document
  include Mongoid::Timestamps
  field :field_name
  field :field_value
  field :isactive
  field :classification_id, type: Integer
  field :parent_id, type: Integer

 def self.import_process(params)
      
      file=params[:datacapture][:file]
      data=Spreadsheet.open(open(file.tempfile))
      @file=[]
      @file=data.worksheet(0).map{|p| @file << p.to_a}
      @file=@file[0]
       field_names=@file[0]
       count=field_names.count
      @file.shift
      @file.map do |ff|
        t=0
        count.times do 
          Dataimport.create(:field_name=>field_names[t],:field_value=>ff[t],:classification_id=>params[:datacapture][:id].to_i,:parent_id=>@parent_id)
          if t==0
             @parent_id=Dataimport.last.id
             Dataimport.where(:parent_id=>nil).update_all(:parent_id=>@parent_id)
          end
          t=t+1
       end
       @parent_id=nil
      end
    end
end
