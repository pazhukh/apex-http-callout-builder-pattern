@isTest
private class HttpCalloutTest {
    
    @isTest
    static void HttpCalloutTestSuccess() {
        Test.setMock(HttpCalloutMock.class, new HttpCalloutTestMock());

        HttpCallout callout = new HttpCallout()
            .method('POST')
            .endpoint('http://www.salesforce.com')
            .timeout(1000)
            .addBody('keyBody1', 'valueBody1')
            .addBody(new Map<String, String>{'keyBody2' => 'valueBody2'})
            .addHeader('keyHeader1', 'valueHeader1')
            .addHeader(new Map<String, String>{'keyHeader2' => 'valueHeader2'});

        Test.startTest();
            HttpResponse response = callout.send();
        Test.stopTest();

        Assert.areEqual('OK', response.getStatus());
        Assert.areEqual(200, response.getStatusCode());
    }

    @isTest
    static void HttpCalloutTestMethodNotFound() {
        Test.setMock(HttpCalloutMock.class, new HttpCalloutTestMock());

        HttpCallout callout = new HttpCallout()
            .endpoint('http://www.salesforce.com')
            .timeout(1000);

        try {
            callout.send();
        } catch (Exception e) {
            Assert.areEqual('Method not found', e.getMessage());
        }
    }

    @isTest
    static void HttpCalloutTestEndpointNotFound() {
        Test.setMock(HttpCalloutMock.class, new HttpCalloutTestMock());

        HttpCallout callout = new HttpCallout()
            .method('POST')
            .timeout(1000);

        try {
            callout.send();
        } catch (Exception e) {
            Assert.areEqual('Endpoint not found', e.getMessage());
        }
    }

    @isTest
    static void HttpCalloutTestTimeoutExceeded() {
        Test.setMock(HttpCalloutMock.class, new HttpCalloutTestMock());

        HttpCallout callout = new HttpCallout()
            .method('POST')
            .endpoint('http://www.salesforce.com')
            .timeout(121000);

        try {
            callout.send();
        } catch (Exception e) {
            Assert.areEqual('Maximum timeout exceeded', e.getMessage());
        }
    }
}