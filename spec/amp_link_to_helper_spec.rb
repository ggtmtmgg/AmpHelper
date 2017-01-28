require 'spec_helper'

describe AmpHelper do
  def a_tag(origin_url, link_url, title)
    "<a data-vars-link-url=\"#{origin_url}\" href=\"#{link_url}\">#{title}</a>"
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
          eq(a_tag(url, cache_url, title))
        )
      end

      it 'passed a page url don\'t have AMP returns an original link' do
        title = 'link title'
        url = 'https://ampbyexample.com/components/amp-form/preview/noamp'
        @view.amp_link_to(title, url).should(
          eq(a_tag(url, url, title))
        )
      end

      describe 'given block' do
        it 'returns a cache link' do
          title = 'link title'
          url = 'https://ampbyexample.com/components/amp-form/preview/'
          cache_url = 'https://ampbyexample-com.cdn.ampproject.org/c/s/ampbyexample.com/components/amp-form/preview/'
          a_tag = @view.amp_link_to(url) { title }
          a_tag.should(
            eq(a_tag(url, cache_url, title))
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
          eq(a_tag(url, url, title))
        )
      end
    end
  end
end
