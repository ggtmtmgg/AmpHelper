# AmpHelper

AmpHelper helps you generate html tags for AMP.
To know AmpHelper ability, just look Usage section.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amp_helper'
```

And then execute:

    $ bundle
    $ rails g amp_helper

## Helpers usage

### amp_image_tag(source, options = {})

#### String Source

      $ amp_image_tag('http://placehold.it/350x150', width: 20, height: 20)
      #=> '<amp-img alt="350x150" height="20" src="http://placehold.it/350x150" width="20" /></amp-img>'

      $ amp_image_tag('http://placehold.it/350x150', size: '20x20')
      #=> '<amp-img alt="350x150" height="20" src="http://placehold.it/350x150" width="20" /></amp-img>'

      $ amp_image_tag('http://placehold.it/350x150')
      #=> '<amp-img alt="350x150" height="150" src="http://placehold.it/350x150" width="350" /></amp-img>'

#### Carrierwave Source

      $ amp_image_tag(ThumbUploader.new.square)
      #=> '<amp-img alt="Square 350x150" height="20" src="http://placehold.it/square_350x150" width="20" /></amp-img>'

#### Retina

      $ amp_image_tag('http://placehold.it/350x150', srcset: 'http://placehold.it/700x300 2x', size: '20x20')
      #=> '<amp-img alt="350x150" height="20" src="http://placehold.it/350x150" srcset="http://placehold.it/700x300 2x" width="20" /></amp-img>'

      $ amp_image_tag(ThumbUploader.new.square, format_2x: '%s_2x')
      #=> '<amp-img alt="Square 350x150" height="20" src="http://placehold.it/square_350x150" srcset="http://placehold.it/square_2x_350x150 2x" width="20" /></amp-img>'


##### Example of CarrierWave::Uploader versions.

    class ThumbUploader < CarrierWave::Uploader::Base
      storage :file
      version :square do
        process resize_to_fill: [20, 20]
      end
      version :square_2x do
        process resize_to_fill: [40, 40]
      end
      def default_url(*args)
        'http://placehold.it/' + [version_name, '350x150'].compact.join('_')
      end
    end

## Configure

### Configure ratina version name format For CarrierWave::Uploader

config/initializers/amp_helper.rb

    AmpHelper.configure do |config|
      # Configure ratina version name format For CarrierWave::Uploader
      # config.format_2x = '%s_2x'
    end

## Development

    bundle exec rspec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/amp_helper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

