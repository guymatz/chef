// Generated by CoffeeScript 1.4.0
(function() {

  define(function(require) {
    var populateResponse, _;
    _ = require('underscore');
    populateResponse = function(responseBody, status, headers) {
      if (responseBody == null) {
        responseBody = {};
      }
      if (status == null) {
        status = 200;
      }
      if (headers == null) {
        headers = {};
      }
      headers = _.extend({
        'Content-Type': 'application/json'
      }, headers);
      return [status, headers, JSON.stringify(responseBody)];
    };
    return {
      populateResponse: populateResponse
    };
  });

}).call(this);
