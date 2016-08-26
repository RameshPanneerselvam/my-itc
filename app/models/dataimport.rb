class Dataimport
  include Mongoid::Document
  include Mongoid::Timestamps
  field :field_name
  field :field_value
  field :isactive
  field :classification_id

  def self.import_process(params)
      field_names=[]
      field=FieldProcess.where(:classification_id=>params[:datacapture][:id]).pluck(:field_id)
      field.map { |i| field_names << FieldMaster.where(:id=>i).to_a[0].field_name  }
      count=field_names.count
      file=params[:datacapture][:file]
      data=CSV.read(file.tempfile)
      data.each_with_index do |ff,i|
        next if i==0
        t=0
        count.times do 
          ff=ff[0].split("\t")
          Dataimport.create(:field_name=>field_names[t],:field_value=>ff[t],:classification_id=>params[:datacapture][:id])
          t=t+1
       end
      end
  end
end
