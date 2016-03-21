# ChargeBee Ruby Client Library - Version 2

The ruby library for integrating with ChargeBee Recurring Billing and Subscription Management solution.

This library is applicable for Chargebee API version 2. Old library for version 1 can be found in [chargebee-v1](https://github.com/chargebee/chargebee-ruby/tree/chargebee-v1) branch.

## Installation

Install the latest version of the gem with the following command...
	
	$ sudo gem install chargebee -v '~>2'

## Documentation

For API reference see <a href="https://apidocs.chargebee.com/docs/api?lang=ruby"  target="_blank">here</a>

## Usage

To create a new subscription:
	
	ChargeBee.configure({:api_key => "your_api_key"}, {:site => "your_site"})
	result = ChargeBee::Subscription.create({
		:id => "sub_KyVqDh__dev__NTn4VZZ1", 
		:plan_id => "basic", 
	})
	subscription = result.subscription
	puts "created subscription is #{subscription}"

## License

See the LICENSE file.

