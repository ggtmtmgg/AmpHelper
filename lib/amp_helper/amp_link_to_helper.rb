module AmpLinkToHelper
  def self.included(base)
    base.module_eval do
      alias_method :original_link_to, :link_to
      alias_method :link_to, :amp_link_to
    end
  end

  def amp_link_to(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    html_options ||= {}
    set_analytics_vars(options, html_options)
    options = cdn_url(options) if html_options.delete(:amp) && AmpHelper.configuration.enable_amp_link
    options, name, block = html_options, options, name if block_given?
    original_link_to(name, options, html_options, &block)
  end

  private

  # Pass url to amp-analytics as 'linkUrl' variable.
  def set_analytics_vars(options, html_options)
    html_options['data-vars-link-url'] = url_for(options)
  end

  # If AMP cache exists, return cdn url.
  def cdn_url(options)
    uri = URI(url_for(options))
    identify = ''
    identify += 's/' if request.scheme == 'https'
    identify += "#{request.host}#{uri.path}#{uri.query}"
    escaped_host = request.host.gsub('-', '--').gsub('.', '-')
    cache_url = "https://#{escaped_host}.cdn.ampproject.org/c/#{identify}"
    validate_amp_cache(cache_url) ? cache_url : uri.to_s
  end

  def validate_amp_cache(url)
    return true unless AmpHelper.configuration.confirm_cache_exist
    Net::HTTP.get_response(URI(url)).code == '200'
  end
end
