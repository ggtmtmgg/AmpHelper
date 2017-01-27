require 'spec_helper'

describe AmpHelper do
  it 'has a version number' do
    expect(AmpHelper::VERSION).not_to be nil
  end

  describe 'amp_link_to' do
    before :all do
      @view = ActionView::Base.new
      @view.request = Request.new('https', 'ampbyexample.com')
    end

    describe 'with config.amp_link = true' do
      before :all do
        AmpHelper.configuration.amp_link = true
      end

      it 'returns a cache link' do
        title = 'link title'
        url = 'https://ampbyexample.com/components/amp-form/preview/'
        cache_url = 'https://ampbyexample-com.cdn.ampproject.org/c/s/ampbyexample.com/components/amp-form/preview/'
        @view.amp_link_to(title, url).should(
          eq("<a data-vars-link-url=\"#{url}\" href=\"#{cache_url}\">#{title}</a>")
        )
      end

      it 'passed no amp page returns an original link' do
        title = 'link title'
        url = 'https://ampbyexample.com/components/amp-form/preview/noamp'
        @view.amp_link_to(title, url).should(
          eq("<a data-vars-link-url=\"#{url}\" href=\"#{url}\">#{title}</a>")
        )
      end

      describe 'given block' do
        it 'returns a cache link' do
          title = 'link title'
          url = 'https://ampbyexample.com/components/amp-form/preview/'
          cache_url = 'https://ampbyexample-com.cdn.ampproject.org/c/s/ampbyexample.com/components/amp-form/preview/'
          a_tag = @view.amp_link_to(url) { title }
          a_tag.should(
            eq("<a data-vars-link-url=\"#{url}\" href=\"#{cache_url}\">#{title}</a>")
          )
        end
      end
    end

    describe 'with config.amp_link = false' do
      before :all do
        AmpHelper.configuration.amp_link = false
      end

      it 'returns an original link' do
        title = 'link title'
        url = 'https://ampbyexample.com/components/amp-form/preview'
        @view.amp_link_to(title, url).should(
          eq("<a data-vars-link-url=\"#{url}\" href=\"#{url}\">#{title}</a>")
        )
      end
    end
  end
end
