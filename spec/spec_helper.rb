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
end
