require 'carrierwave'
require 'fastimage'
require 'amp_helper/configuration'
require 'amp_helper/amp_image_tag_helper'
require 'amp_helper/amp_link_to_helper'

module AmpHelper
  class Railtie < Rails::Railtie
    initializer 'amp_helper' do |app|
      ActionView::Base.send :include, AmpImageTagHelper
      ActionView::Base.send :include, AmpLinkToHelper
    end

    generators do
      require 'amp_helper/generator.rb'
    end
  end
end
