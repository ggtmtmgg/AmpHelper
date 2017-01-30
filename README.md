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

### image_tag(source, options = {})

image_tag method creates a `<amp-img>` tag if it's passed `amp` option as true.  
Learn more about [amp-img tag](https://ampbyexample.com/components/amp-img/)

#### String Source

      $ image_tag('http://placehold.it/350x150', width: 20, height: 20, amp: true)
      #=> '<amp-img alt="350x150" height="20" src="http://placehold.it/350x150" width="20" /></amp-img>'

      $ image_tag('http://placehold.it/350x150', size: '20x20', amp: true)
      #=> '<amp-img alt="350x150" height="20" src="http://placehold.it/350x150" width="20" /></amp-img>'

      $ image_tag('http://placehold.it/350x150', amp: true)
      #=> '<amp-img alt="350x150" height="150" src="http://placehold.it/350x150" width="350" /></amp-img>'

#### Carrierwave Source

      $ image_tag(ThumbUploader.new.square, amp: true)
      #=> '<amp-img alt="Square 350x150" height="20" src="http://placehold.it/square_350x150" width="20" /></amp-img>'

#### Retina

      $ image_tag('http://placehold.it/350x150', srcset: 'http://placehold.it/700x300 2x', size: '20x20', amp: true)
      #=> '<amp-img alt="350x150" height="20" src="http://placehold.it/350x150" srcset="http://placehold.it/700x300 2x" width="20" /></amp-img>'

      $ image_tag(ThumbUploader.new.square, format_2x: '%s_2x', amp: true)
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

### link_to(name = nil, options = nil, html_options = nil, &block)

link_to method creates a `<a>` tag links to AMP cache if it's passed `amp` option as true.  
Learn more about [using AMP cache](https://ampbyexample.com/advanced/using_the_google_amp_cache/).

#### If indexed AMP cache is found

      $ link_to(@title, @path, amp: true)
      #=> "<a data-vars-link-url=\"https://ampbyexample.com/components/amp-form/preview/\" href=\"https://ampbyexample-com.cdn.ampproject.org/c/s/ampbyexample.com/components/amp-form/preview/\">link title</a>"

      $ link_to(@path, amp: true) { @title }
      #=> "<a data-vars-link-url=\"https://ampbyexample.com/components/amp-form/preview/\" href=\"https://ampbyexample-com.cdn.ampproject.org/c/s/ampbyexample.com/components/amp-form/preview/\">link title</a>"


#### If indexed AMP cache is **NOT** found

      $ link_to(@title, @path, amp: true)
      #=> "<a data-vars-link-url=\"https://ampbyexample.com/components/amp-form/preview/noamp\" href=\"https://ampbyexample.com/components/amp-form/preview/noamp\">link title</a>"

## amp-analytics conbination

As you can see, AmpHelper puts the `data-vars-link-url` option on `<a>` tags.
It's gonna help to tracking count of link clicking.

Learn more about [Variables as data attribute](https://github.com/ampproject/amphtml/blob/master/extensions/amp-analytics/analytics-vars.md#variables-as-data-attribute) for amp-analytics.

## Configure

### Configure ratina version name format For CarrierWave::Uploader

config/initializers/amp_helper.rb

    AmpHelper.configure do |config|
      # Enable amp image.
      # Default: true
      # config.enable_amp_image = true
      #
      # Configure ratina version name format For CarrierWave::Uploader
      # Default: nil
      # config.format_2x = '%s_2x'

      # Enable amp cache link.
      # Default: true
      # config.enable_amp_link = Rails.env.production?
    end

## Development

    bundle exec rspec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/amp_helper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
