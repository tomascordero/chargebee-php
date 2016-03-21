# ChargeBee Python Client Library - Version 2

The python library for integrating with ChargeBee Recurring Billing and Subscription Management solution.

This library is applicable for Chargebee API version 2. Old library for version 1 can be found in [master](https://github.com/chargebee/chargebee-python/tree/chargebee-v1) branch.


## Installation

Install the latest version 2.x.x of the library with the following commands:

    $ pip install 'chargebee>=2,<3'
  
or
  
    $ easy_install --upgrade 'chargebee>=2,<3'



If you would prefer to install it from source, just checkout the latest version for 2.x.x by ```git checkout [latest release tag]``` and install with the following command:
  
    $ python setup.py install
  
## Documentation

See our [Python API Reference](https://apidocs.chargebee.com/docs/api?lang=python "API Reference").

## Usage

To create a new subscription:
  
    import chargebee
    chargebee.configure(api_key, site)

    res = chargebee.Subscription.create({
    "plan_id" : "basic"
    })

    print res.subscription

## License

See the LICENSE file.