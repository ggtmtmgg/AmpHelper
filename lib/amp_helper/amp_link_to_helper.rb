module AmpLinkToHelper
  def amp_link_to(name = nil, options = nil, html_options = nil, &block)
    amp_link = AmpHelper.configuration.amp_link
    return link_to(name, options, html_options, &block) unless amp_link
    return link_to(cdn_url(name), options, html_options, &block) if block_given?
    link_to(name, cdn_url(options), html_options, &block)
  end

  private

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
