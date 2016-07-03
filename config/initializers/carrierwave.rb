CarrierWave.configure do |config|  
    config.storage = :aws
    config.aws_credentials = {
      :access_key_id      => Figaro.env.aws_access_key_id,
      :secret_access_key  => Figaro.env.aws_secret_access_key,
      region: 'eu-west-1'
    }
    config.aws_acl    = :public_read

    config.aws_bucket  = "pickem-#{Rails.env.to_s}"


  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end