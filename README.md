# Salesforce - Simple Apex Rest Callout Pattern
Builder Design pattern to create flexible class to generate HttpRequest and do callouts.

### Example
```
HttpCallout callout = new HttpCallout()
    .endpoint('https://salesforce.com/endpoint')
    .method('POST')
    .body('body')
    .addHeader('Content-Type', 'application/json');
        
HttpResponse response = callout.send();
```

### Description of methods
```
method(String method)
Specifies the endpoint for the request - Required
```

```
endpoint(String endpoint)
Sets endpoint for the request - Required
```

```
timeout(Integer timeout)
Sets timeout for the request. If not specified it use default Salesforce value
```

```
body(String body)
Sets body for the request
```

```
addHeader(String key, String value)
Adds a header to the request
```

```
addHeader(Map<String, String> headers)
Adds one or more headers
```

```
send()
Performs the construction and makes callout
```