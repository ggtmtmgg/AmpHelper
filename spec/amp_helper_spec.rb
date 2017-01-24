require 'spec_helper'
require 'amp_helper/amp_image_tag_helper'
require 'carrierwave'
require 'fastimage'

require_relative 'uploaders/thumb_uploader'

ActionView::Base.send(:include, AmpImageTagHelper)

describe AmpHelper do
  it 'has a version number' do
    expect(AmpHelper::VERSION).not_to be nil
  end


  describe 'amp_image_tag' do
    before :all do
      @image_url = 'http://placehold.it/350x150'
      @uploader = ThumbUploader.new
      @view = ActionView::Base.new
      @url_tag = '<amp-img alt="350x150" height="%d" src="http://placehold.it/'\
                 '350x150" width="%d" /></amp-img>'
      @uploader_tag = '<amp-img alt="Square 350x150" height="%d" src="http://p'\
                      'lacehold.it/square_350x150" width="%'\
                      'd" /></amp-img>'
      @uploader_retina_tag = '<amp-img alt="Square 350x150" height="%d" src="h'\
                             'ttp://placehold.it/square_350x150" srcset="http:'\
                             '//placehold.it/square_2x_350x150 2x" width="%d" '\
                             '/></amp-img>'
    end

    it 'passed url with width and height returns amp-img tag' do
      @view.amp_image_tag(@image_url, width: 20, height: 20).should(
        eq(@url_tag % [20, 20].reverse)
      )
    end

    it 'passed url with size returns amp-img tag' do
      @view.amp_image_tag(@image_url, size: '20x20').should(
        eq(@url_tag % [20, 20].reverse)
      )
    end

    it 'passed url returns amp-img tag' do
      @view.amp_image_tag(@image_url).should(
        eq(@url_tag % [350, 150].reverse)
      )
    end

    it 'passed uploader returns amp-img tag' do
      @view.amp_image_tag(@uploader).should(
        eq(@url_tag % [350, 150].reverse)
      )
    end

    it 'passed uploader with version returns amp-img tag' do
      @view.amp_image_tag(@uploader.square).should(
        eq(@uploader_tag % [20, 20].reverse)
      )
    end

    it 'passed uploader with version and format_2x returns amp-img tag' do
      @view.amp_image_tag(@uploader.square, format_2x: '%s_2x').should(
        eq(@uploader_retina_tag % [20, 20].reverse)
      )
    end

    describe 'setted config.format_2x' do
      before :all do
        AmpHelper.configure do |config|
          config.format_2x = '%s_2x'
        end
      end

      it 'passed uploader with version returns amp-img tag' do
        @view.amp_image_tag(@uploader.square).should(
          eq(@uploader_retina_tag % [20, 20].reverse)
        )
      end
    end
  end
end
