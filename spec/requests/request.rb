class Request
  attr_accessor :scheme, :host
  def initialize(scheme, host)
    @scheme = scheme
    @host = host
  end
end
