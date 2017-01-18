# This class is generated only for test
class ThumbUploader < CarrierWave::Uploader::Base
  storage :file
  version :square do
    process resize_to_fill: [20, 20]
  end
  def default_url(*args)
    'http://placehold.it/350x150'
  end
end
