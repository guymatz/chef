backend default {
    .host = "127.0.0.1";
    .port = "{{app_port}}";
}

sub vcl_recv {
    remove req.http.Authorization;
    remove req.http.Cookie;  # Removing cookie (shouldn't be one) from request.
    remove req.http.Vary;  # Removing vary, they're images... we're not varying on anything.
    remove req.http.Accept-Encoding;  # accept encoding doesn't make sense, we only serve binary. (no gzip)

    if (req.restarts == 0) {
        if (req.http.x-forwarded-for) {
            set req.http.X-Forwarded-For =
                req.http.X-Forwarded-For + ", " + client.ip;
        } else {
            set req.http.X-Forwarded-For = client.ip;
        }
    }

    if (req.request != "GET" &&
      req.request != "HEAD" &&
      req.request != "PUT" &&
      req.request != "POST" &&
      req.request != "TRACE" &&
      req.request != "OPTIONS" &&
      req.request != "DELETE") {
        /* Non-RFC2616 or CONNECT which is weird. */
        return (pipe);
    }

    if (req.request != "GET" && req.request != "HEAD") {
        /* We only deal with GET and HEAD by default */
        return (pass);
    }

    return (lookup);
}
