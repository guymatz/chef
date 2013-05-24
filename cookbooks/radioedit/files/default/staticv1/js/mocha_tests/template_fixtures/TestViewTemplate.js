define(function(){
return function(__obj) {
    if (!__obj) __obj = {};
    var __out = [], __capture = function(callback) {
      var out = __out, result;
      __out = [];
      callback.call(this);
      result = __out.join('');
      __out = out;
      return __safe(result);
    }, __sanitize = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else if (typeof value !== 'undefined' && value != null) {
        return __escape(value);
      } else {
        return '';
      }
    }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
    __safe = __obj.safe = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else {
        if (!(typeof value !== 'undefined' && value != null)) value = '';
        var result = new String(value);
        result.ecoSafe = true;
        return result;
      }
    };
    if (!__escape) {
      __escape = __obj.escape = function(value) {
        return ('' + value)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;');
      };
    }
    (function() {
      (function() {
        var auction, _i, _len, _ref;
      
        __out.push('<div id=\'auction\'>\n    <h1 data-text=\'auction.title\'></h1>\n    <img data-src=\'auction.image_url\'>\n    <span data-text=\'auction.timeRemaining\'></span>\n\n    <div class=\'alert-box\' data-show=\'auction.endingSoon\'>\n        <p>Hurry up! This auction is ending soon.</p>\n    </div>\n\n    <dl>\n        <dt>Highest Bid:</dt>\n        <dd data-text=\'auction.bid\'></dd>\n        <dt>Bidder:</dt>\n        <input data-value=\'auction.bidder\' type=\'text\' />\n    </dl>\n    <ul>\n        ');
      
        _ref = this.auctionCollection.models;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          auction = _ref[_i];
          __out.push('\n            <li data-text=\'auctionCollection.');
          __out.push(__sanitize(auction.cid));
          __out.push('.title\'></li>\n            <li><input type="text" data-value="auctionCollection.');
          __out.push(__sanitize(auction.cid));
          __out.push('.title" /></li>\n        ');
        }
      
        __out.push('\n    </ul>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

