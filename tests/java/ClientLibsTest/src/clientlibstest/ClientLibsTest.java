/*
 * Copyright (c) 2016 ChargeBee Inc
 * All Rights Reserved.
 */

package clientlibstest;

import com.chargebee.Environment;
import com.chargebee.ListResult;
import com.chargebee.models.Subscription;

/**
 *
 * @author vaibhav
 */
public class ClientLibsTest {

 public static void main(String[] args) {
        try {
            test();
        } catch (Throwable th) {
            th.printStackTrace();
        } finally {
            System.exit(0);
        }

    }

    public static void test() throws Exception {
        System.setProperty("com.chargebee.api.domain.suffix", "localcb.in" + ":8080");
        System.setProperty("com.chargebee.api.protocol", "http");
        Environment.configure("mannar-test", "test___dev__vJQ7tJ3368ByoUKK81VbFwUPxdKymhxv");

        ListResult res = Subscription.list().status()
                .in(Subscription.Status.ACTIVE, Subscription.Status.CANCELLED)
                .limit(100)
                .request();
        System.out.println(res.size());
    }    
}
