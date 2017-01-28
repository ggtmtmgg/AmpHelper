module AmpHelper
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :format_2x, :enable_amp_link

    def initialize
      @format_2x = nil
      @enable_amp_link = true
    end
  end
end
