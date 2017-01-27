module AmpLinkToHelper
  def amp_link_to(name = nil, options = nil, html_options = nil, &block)
    html_options = html_options.to_h
    block_given? ? set_amp_vars(name, html_options) : set_amp_vars(options, html_options)

    amp_link = AmpHelper.configuration.amp_link
    return link_to(name, options, html_options, &block) unless amp_link
    return link_to(cdn_url(name), options, html_options, &block) if block_given?
    link_to(name, cdn_url(options), html_options, &block)
  end

  private

  # Pass url to amp-analytics as 'linkUrl' variable.
  def set_amp_vars(options, html_options = nil)
    html_options['data-vars-link-url'] = url_for(options)
  end

  # If AMP cache exists, return cdn url.
  def cdn_url(options)
    url = URI(url_for(options))
    identify = ''
    identify += 's/' if request.scheme == 'https'
    identify += request.host
    identify += "#{url.path}#{url.query}"
    escaped_host = request.host.gsub('-', '--').gsub('.', '-')
    cache_url = "https://#{escaped_host}.cdn.ampproject.org/c/#{identify}"
    response_200?(cache_url) ? cache_url : url.to_s
  end

  def response_200?(url)
    Net::HTTP.get_response(URI(url)).code == '200'
  end
end
