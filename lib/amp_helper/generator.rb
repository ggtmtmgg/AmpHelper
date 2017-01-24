module AmpHelper
  class AmpHelperGenerator < Rails::Generators::Base
    desc 'Initialize AmpHelper'
    def create_initializer_file
      initializer 'amp_helper.rb' do
        <<-FILE.strip_heredoc
          AmpHelper.configure do |config|
            # Configure ratina version name format For CarrierWave::Uploader
            # config.format_2x = '%s_2x'
          end
        FILE
      end
    end
  end
end
