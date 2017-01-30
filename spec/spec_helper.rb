require 'action_view'
require 'amp_helper/configuration'
require 'amp_helper/amp_image_tag_helper'
require 'amp_helper/amp_link_to_helper'
require 'carrierwave'
require 'fastimage'

require_relative 'uploaders/thumb_uploader'
require_relative 'requests/request'

ActionView::Base.send(:include, AmpImageTagHelper)
ActionView::Base.send(:include, AmpLinkToHelper)

AmpHelper.configure do |config|
  # Configure ratina version name format For CarrierWave::Uploader
  # Default: nil
  # config.format_2x = '%s_2x'

  # Enable amp cache link.
  # Default: true
  # config.enable_amp_link = Rails.env.production?
end
