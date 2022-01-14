# BaiduTranslate

BaiduTranslate provides a lightweight wrapper for the Baidu Translate API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'baidu_translate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install baidu_translate

## Usage

1. Register to Baidu Translate API at http://api.fanyi.baidu.com/

2. Initialize BaiduTranslate using your AppID and Key.

	```ruby
	BaiduTranslate.setup(APP_ID, KEY)
	```

3. Translate your strings
	```ruby
	BaiduTranslate.translate('Apple', :en, :zh)
	# => "苹果"
	```

4. Check http://api.fanyi.baidu.com/api/trans/product/apidoc/ for the list of available languages and their codes and a list of possible errors.

## Contributing

Bug reports and pull requests are welcome!


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

