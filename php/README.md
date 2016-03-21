# ChargeBee PHP Client Library - Version 1

The php library for integrating with ChargeBee Recurring Billing and Subscription Management solution.

This library is applicable for Chargebee API version 1. Library for version 2 can be found in [master](https://github.com/chargebee/chargebee-php) branch.

## Installation

```ChargeBee``` is available on [Packagist](https://packagist.org/packages/chargebee/chargebee-php) and can be installed using [Composer](https://getcomposer.org/)

<pre><code>composer require chargebee/chargebee-php:'>=2, &lt;3'</code></pre>

or 
Download the php library version 1.x.x from https://github.com/chargebee/chargebee-php/tags. Extract the library into the
php include path.

Then, require the library as 
<pre><code>
 require_once(dirname(__FILE__) . 'path_to ChargeBee.php');
</code></pre>

## Documentation

  * <a href="https://apidocs.chargebee.com/docs/api/v1/?lang=php" target="_blank">API Reference</a>

## Usage

To create a new subscription:

<pre><code>
require 'ChargeBee.php';
ChargeBee_Environment::configure("your_site", "{your_site_api_key}");
$result = ChargeBee_Subscription::create(array(
  "id" => "__dev__KyVqH3NW3f42fD", 
  "planId" => "starter", 
  "customer" => array(
    "email" => "john@user.com", 
    "firstName" => "John", 
    "lastName" => "Wayne"
  )
));
$subscription = $result->subscription();
$customer = $result->customer();
$card = $result->card();
</code></pre>

## License

See the LICENSE file.

