require 'action_view'
require 'amp_helper/configuration'
require 'amp_helper/amp_image_tag_helper'
require 'carrierwave'
require 'fastimage'

require_relative 'uploaders/thumb_uploader'

ActionView::Base.send(:include, AmpImageTagHelper)

AmpHelper.configure do |config|
  # Configure ratina version name format For CarrierWave::Uploader
  # config.format_2x = '%s_2x'
end
