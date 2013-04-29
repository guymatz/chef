// Generated by CoffeeScript 1.4.0
(function() {

  define(function(require) {
    var XhrHelper;
    return XhrHelper = (function() {

      function XhrHelper() {}

      XhrHelper.prototype.setUp = function() {
        var _this = this;
        this.xhr = sinon.useFakeXMLHttpRequest();
        this.requests = [];
        return this.xhr.onCreate = function(requestXhr) {
          return _this.requests.push(requestXhr);
        };
      };

      XhrHelper.prototype.cleanUp = function() {
        this.xhr.restore();
        return this.requests = [];
      };

      return XhrHelper;

    })();
  });

}).call(this);
