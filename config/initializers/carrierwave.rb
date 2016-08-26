CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAIOA626CBSGAKREGA',
      :aws_secret_access_key  => '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',
      :region                 => 'ap-south-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = "documentservicealtius"
end