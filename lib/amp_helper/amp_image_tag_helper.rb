module AmpImageTagHelper
  def amp_image_tag(source, opts = {})
    has_dimensions = (opts[:width] && opts[:height]) || opts[:size]

    if !has_dimensions
      if source.kind_of?(CarrierWave::Uploader::Base) &&
         !source.class.processors.empty?
        opts[:width], opts[:height] = source.class.processors[0][1]
      else
        opts[:width], opts[:height] = FastImage.size(source.to_s)
      end
    end

    image_tag(source, opts).
      gsub(/^<img/, '<amp-img').
      gsub(/>$/, '></amp-img>').
      html_safe
  end
end
