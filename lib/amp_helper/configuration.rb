module AmpHelper
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :enable_amp_image, :format_2x, :enable_amp_link,
                  :confirm_cache_exist

    def initialize
      @enable_amp_image = true
      @format_2x = nil
      @enable_amp_link = true
      @confirm_cache_exist = false
    end
  end
end
