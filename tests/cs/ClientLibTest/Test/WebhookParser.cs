using System;
using ChargeBee.Api;
using ChargeBee.Models;

public class WebhookParser
{
    public void Configure()
    {
        /*
         * Setup your ChargeBee site and api key
         */
        ApiConfig.Configure("your-site", "your-api-key");
    }

    /*
     * Test method to demonstrate the webhook serialize method. ChargeBee fires the
     * configured webhook URL with the event data as JSON string on the request body.
     * More details at https://apidocs.chargebee.com/docs/api/events
     */
    public void TestDeserializeEvent()
    {
        /*
        * Passing a sample event json string as multiline string with prefix "@".
        * Event class has 
        */
       Event e = new Event(@"{
                            'id': 'ev_8bcWjOKHXcwL4',
                            'occurred_at': 1317407414,
                            'source': 'system',
                            'object': 'event',
                            'content': {
                                'customer': {
                                    'id': '8avWjOLGCcfp2',
                                    'first_name': 'Benjamin',
                                    'last_name': 'Ross',
                                    'email': 'Benjamin@test.com',
                                    'auto_collection': 'on',
                                    'created_at': 1317407413,
                                    'object': 'customer',
                                    'card_status': 'valid'
                                },
                                'card': {
                                    'customer_id': '8avWjOLGCcfp2',
                                    'status': 'valid',
                                    'gateway': 'chargebee',
                                    'iin': '411111',
                                    'last4': '1111',
                                    'card_type': 'visa',
                                    'expiry_month': 1,
                                    'expiry_year': 2016,
                                    'object': 'card',
                                    'masked_number': '************1111'
                                }
                            },
                            'event_type': 'card_added',
                            'webhook_status': 'not_configured'
                        }");
        //Get the event type. See the type of events supported at https://apidocs.chargebee.com/docs/api/events#event_types
        Console.Write(e.EventType.Value);

        //Get the event content to see the data about customer, subscription, card, invoice, etc.
        //Eg. Subscription s = e.Content.Subscription
        Console.Write (e.Content);
    }

    public static void Main(string[] args) 
    {
        WebhookParser wp = new WebhookParser();
        wp.Configure ();
        wp.TestDeserializeEvent();
    }

}
