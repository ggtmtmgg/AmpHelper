# This class is generated only for test
class ThumbUploader < CarrierWave::Uploader::Base
  storage :file
  version :square do
    process resize_to_fill: [20, 20]
  end
  version :square_2x do
    process resize_to_fill: [40, 40]
  end
  def default_url(*args)
    'http://placehold.it/' + [version_name, '350x150'].compact.join('_')
  end
end
