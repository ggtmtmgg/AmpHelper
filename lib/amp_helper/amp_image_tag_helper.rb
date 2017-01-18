module AmpImageTagHelper
  def amp_image_tag(source, opts = {})
    has_dimensions = (opts[:width] && opts[:height]) || opts[:size]
    opts[:width], opts[:height] = FastImage.size(source) unless has_dimensions
    image_tag(source, opts).
      gsub(/^<img/, '<amp-img').
      gsub(/>$/, '></amp-img>').
      html_safe
  end
end
