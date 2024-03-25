public class HttpCallout {
    private String body;
    private String method;
    private String endpoint;
    private Integer timeout;
    private HttpRequest request;
    private Map<String, String> headers;

    public HttpCallout() {
        this.request = new HttpRequest();
        this.headers = new Map<String, String>();
    }

    public HttpCallout method(String method) {
        this.method = method;
        return this;
    }

    public HttpCallout endpoint(String endpoint) {
        this.endpoint = endpoint;
        return this;
    }

    public HttpCallout timeout(Integer timeout) {
        this.timeout = timeout;
        return this;
    }

    public HttpCallout body(String body) {
        this.body = body;
        return this;
    }

    public HttpCallout addHeader(String key, String value) {
        this.headers.put(key, value);
        return this;
    }

    public HttpCallout addHeader(Map<String, String> headers) {
        for (String headerKey : headers.keySet()) {
            this.headers.put(headerKey, headers.get(headerKey));
        }
        return this;
    }

    public HttpResponse send() {
        builder();

        return new Http().send(this.request);
    }
    
    private void builder() {
        if (String.isBlank(this.method)) {
            throw new HttpCalloutException('Method not found');
        }

        if (String.isBlank(this.endpoint)) {
            throw new HttpCalloutException('Endpoint not found');
        }

        if (this.timeout != null && this.timeout > 120000) {
            throw new HttpCalloutException('Maximum timeout exceeded');
        }

        this.request.setEndpoint(this.endpoint);
        this.request.setMethod(this.method);

        if (!String.isBlank(this.body)) {
            this.request.setBody(this.body);
        }

        if (this.timeout != null) {
            this.request.setTimeout(this.timeout);
        }

        if (!this.headers.isEmpty()) {
            for (String headerKey : headers.keySet()) {
                this.request.setHeader(headerKey, headers.get(headerKey));
            }
        }
    }

    public class HttpCalloutException extends Exception{}
}