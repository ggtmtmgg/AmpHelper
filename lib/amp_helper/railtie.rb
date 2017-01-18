require 'carrierwave'
require 'fastimage'
require 'amp_helper/amp_image_tag_helper'

module AmpHelper
  class Railtie < Rails::Railtie
    initializer 'image_tag.helper' do |app|
      ActionView::Base.send :include, AmpImageTagHelper
    end
  end
end
