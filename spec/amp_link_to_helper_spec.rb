require 'spec_helper'

describe AmpHelper do
  def a_tag(origin_url, link_url, title)
    "<a data-vars-link-url=\"#{origin_url}\" href=\"#{link_url}\">#{title}</a>"
  end

  describe 'amp_link_to' do
    before :all do
      @view = ActionView::Base.new
      @view.request = Request.new('https', 'ampbyexample.com')

      @title = 'link title'
      @url = 'https://ampbyexample.com/components/amp-form/preview/'
      @cache_url = 'https://ampbyexample-com.cdn.ampproject.org/c/s/ampbyexample.com/components/amp-form/preview/'
      @noamp_url = 'https://ampbyexample.com/error'
      @noamp_cache_url = 'https://ampbyexample-com.cdn.ampproject.org/c/s/ampbyexample.com/error'
    end

    describe 'with default configuration' do
      before :all do
        AmpHelper.configuration.enable_amp_link = true
        AmpHelper.configuration.confirm_cache_exist = false
      end

      it 'returns a cache link' do
        @view.link_to(@title, @url, amp: true).should(
          eq(a_tag(@url, @cache_url, @title))
        )
      end

      it 'passed a page url don\'t have AMP returns a cache link' do
        @view.link_to(@title, @noamp_url, amp: true).should(
          eq(a_tag(@noamp_url, @noamp_cache_url, @title))
        )
      end

      it 'passed { amp: false } returns an original link' do
        @view.link_to(@title, @url, amp: false).should(
          eq(a_tag(@url, @url, @title))
        )
      end

      describe 'given block' do
        it 'returns a cache link' do
          a_tag = @view.link_to(@url, amp: true) { @title }
          a_tag.should(
            eq(a_tag(@url, @cache_url, @title))
          )
        end
      end
    end

    describe 'with configuration.enable_amp_link = false' do
      before :all do
        AmpHelper.configuration.enable_amp_link = false
        AmpHelper.configuration.confirm_cache_exist = false
      end

      it 'returns an original link' do
        @view.link_to(@title, @url, amp: true).should(
          eq(a_tag(@url, @url, @title))
        )
      end

      it 'passed { amp: true } returns an original link' do
        @view.link_to(@title, @url, amp: true).should(
          eq(a_tag(@url, @url, @title))
        )
      end
    end

    describe 'with configuration.confirm_cache_exist = true' do
      before :all do
        AmpHelper.configuration.enable_amp_link = true
        AmpHelper.configuration.confirm_cache_exist = true
      end

      it 'returns a cache link' do
        @view.link_to(@title, @url, amp: true).should(
          eq(a_tag(@url, @cache_url, @title))
        )
      end

      it 'passed a page url don\'t have AMP returns an original link' do
        @view.link_to(@title, @noamp_url, amp: true).should(
          eq(a_tag(@noamp_url, @noamp_url, @title))
        )
      end
    end
  end
end
