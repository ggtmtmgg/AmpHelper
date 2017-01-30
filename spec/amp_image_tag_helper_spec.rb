require 'spec_helper'

describe AmpHelper do
  describe 'amp_image_tag' do
    before :all do
      @image_url = 'http://placehold.it/350x150'
      @uploader = ThumbUploader.new
      @view = ActionView::Base.new
      @url_tag = '<amp-img alt="350x150" height="%d" src="http://placehold.it/350x150" width="%d" /></amp-img>'
      @uploader_tag = '<amp-img alt="Square 350x150" height="%d" src="http://placehold.it/square_350x150" width="%'\
                      'd" /></amp-img>'
      @uploader_retina_tag = '<amp-img alt="Square 350x150" height="%d" src="http://placehold.it/square_350x150" srcset="http://placehold.it/square_2x_350x150 2x" width="%d" /></amp-img>'
      @original_tag = '<img alt="350x150" height="%d" src="http://placehold.it/350x150" width="%d" />'
    end

    it 'passed url with width and height returns amp-img tag' do
      @view.image_tag(@image_url, width: 20, height: 20, amp: true).should(
        eq(@url_tag % [20, 20].reverse)
      )
    end

    it 'passed url with { amp: false } returns img tag' do
      @view.image_tag(@image_url, width: 20, height: 20, amp: false).should(
        eq(@original_tag % [20, 20].reverse)
      )
    end

    it 'passed url with size returns amp-img tag' do
      @view.image_tag(@image_url, size: '20x20', amp: true).should(
        eq(@url_tag % [20, 20].reverse)
      )
    end

    it 'passed url returns amp-img tag' do
      @view.image_tag(@image_url, amp: true).should(
        eq(@url_tag % [350, 150].reverse)
      )
    end

    it 'passed uploader returns amp-img tag' do
      @view.image_tag(@uploader, amp: true).should(
        eq(@url_tag % [350, 150].reverse)
      )
    end

    it 'passed uploader with version returns amp-img tag' do
      @view.image_tag(@uploader.square, amp: true).should(
        eq(@uploader_tag % [20, 20].reverse)
      )
    end

    it 'passed uploader with version and format_2x returns amp-img tag' do
      @view.image_tag(@uploader.square, format_2x: '%s_2x', amp: true).should(
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
        @view.image_tag(@uploader.square, amp: true).should(
          eq(@uploader_retina_tag % [20, 20].reverse)
        )
      end
    end
    describe 'with configuration.enable_amp_image = false' do
      before :all do
        AmpHelper.configuration.enable_amp_image = false
      end

      it 'passed url with width and height returns img tag' do
        @view.image_tag(@image_url, width: 20, height: 20, amp: true).should(
          eq(@original_tag % [20, 20].reverse)
        )
      end
    end
  end
end
