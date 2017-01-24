module AmpImageTagHelper
  def amp_image_tag(source, opts = {})
    has_dimensions = (opts[:width] && opts[:height]) || opts[:size]
    set_dimensions(source, opts) if !has_dimensions
    set_scrset(source, opts)
    image_tag_to_amp(image_tag(source, opts))
  end

  private

  def image_tag_to_amp(img_tag)
    img_tag.gsub(/^<img/, '<amp-img').gsub(/>$/, '></amp-img>').html_safe
  end

  def set_dimensions(source, opts)
    if source.kind_of?(CarrierWave::Uploader::Base) &&
       !source.class.processors.empty?
      opts[:width], opts[:height] = source.class.processors[0][1]
    else
      opts[:width], opts[:height] = FastImage.size(source.to_s)
    end
  end

  def set_scrset(source, opts)
    if source.kind_of?(CarrierWave::Uploader::Base) &&
       !source.class.processors.empty? &&
       format_2x = (opts.delete(:format_2x) || AmpHelper.configuration.format_2x)
      name_2x = format_2x % source.version_name
      opts[:srcset] = "#{source.parent_version.send(name_2x).url} 2x"
    end
  end
end
