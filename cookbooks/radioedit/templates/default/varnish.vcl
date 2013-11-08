backend default {
    .host = "127.0.0.1";
    .port = "<%= node[:radioedit][:nginx][:port] %>";
}
sub vcl_hash {
    hash_data(req.url);
    if (req.http.host) {
        hash_data(req.http.host);
    } else {
        hash_data(server.ip);
    }
    if (req.http.X-LocalTime) {
        hash_data(regsub(req.http.X-LocalTime, ":\d+:\d+", ""));
    }
    return (hash);
}
