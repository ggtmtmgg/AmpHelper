# AmpHelper

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/amp_helper`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amp_helper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install amp_helper

## Usage


### Helpers

#### amp_image_tag(source, options)

##### Url with image's dimensions

    % amp_image_tag('http://sample.com/image.jpg', width: '40', height: '40')
    #=> '<amp-img alt="Image" height="40" src="http://sample.com/image.jpg" width="40" /></amp-img>'

##### Url without image's dimensions

It's going to access file dimensions.

    % amp_image_tag('http://sample.com/image.jpg')
    #=> '<amp-img alt="Image" height="400" src="http://sample.com/image.jpg" width="400" /></amp-img>'

##### Carrierwave

    % amp_image_tag(Article.find(1).thumb.icon.url, width: '30', height: '30')
    # => '<amp-img alt="Icon placeholder" height="30" src="https:g/s3-ap-northeast-1.amazonaws.com/foo/assets/placeholders/icon_placeholder.png" width="30" /></amp-img>'

## Development

    bundle exec rspec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/amp_helper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

