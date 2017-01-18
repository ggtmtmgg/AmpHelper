require 'spec_helper'
require 'amp_helper/amp_image_tag_helper'
require 'fastimage'

ActionView::Base.send(:include, AmpImageTagHelper)

describe AmpHelper do
  it 'has a version number' do
    expect(AmpHelper::VERSION).not_to be nil
  end


  describe 'amp_image_tag' do
    before :all do
      @image_url = 'http://placehold.it/350x150'
      @view = ActionView::Base.new
      @img_tag = '<amp-img alt="350x150" height="%d" src="http://placehold.it/'\
                 '350x150" width="%d" /></amp-img>'
    end

    it 'url with width and height returns amp-img tag' do
      @view.amp_image_tag(@image_url, width: 20, height: 20).should(
        eq(@img_tag % [20, 20].reverse)
      )
    end

    it 'url with size returns amp-img tag' do
      @view.amp_image_tag(@image_url, size: '20x20').should(
        eq(@img_tag % [20, 20].reverse)
      )
    end

    it 'url without dimensions returns amp-img tag' do
      @view.amp_image_tag(@image_url).should(
        eq(@img_tag % [350, 150].reverse)
      )
    end
  end
end
