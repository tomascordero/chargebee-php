# ChargeBee .Net Client Library - Version 1

The .Net library for integrating with ChargeBee Recurring Billing and Subscription Management solution.

This library is applicable for Chargebee API version 1. <b>Library for version 2 can be found in [master](https://github.com/chargebee/chargebee-dotnet) branch</b>

## Installation

Install the latest version of the 1.x.x library with the following commands:

Use NuGet: [NuGet](https://nuget.org) is a package manager for Visual Studio.

To install the ChargeBee .Net Client Library, run the following command in the Package Manager Console:
	
	$ Install-Package ChargeBee -Vesrion 1.x.x

If you would prefer to build it from source, checkout latest version of 1.x.x release tag:
  
    $ git checkout [latest 1.x.x release tag]
  
## Documentation

See our [.Net API Reference](https://apidocs.chargebee.com/docs/api/v1/?lang=dotnet "API Reference").

## Usage

To create a new subscription:
  
    using ChargeBee.Api;
	using ChargeBee.Models;
	ApiConfig.Configure("site","api_key");
	EntityResult result = Subscription.Create()
                  .PlanId("basic")
				  .Request();
	Subscription subscription = result.Subscription;
	Customer customer = result.Customer;

## License

See the LICENSE file.
