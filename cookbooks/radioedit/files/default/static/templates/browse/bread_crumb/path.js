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
        var divider, lead, part, _i, _len, _ref,
          _this = this;
      
        divider = function(separator) {
          return __capture(function() {
            __out.push('\n   <span class="divider">');
            __out.push(__sanitize(separator));
            return __out.push('</span>\n');
          });
        };
      
        __out.push('\n\n<a href="#"><strong>Home</strong></a>');
      
        __out.push(__sanitize(divider("/")));
      
        __out.push('\n');
      
        lead = [];
      
        __out.push('\n');
      
        _ref = this.path;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          part = _ref[_i];
          __out.push('\n    ');
          lead.push(part);
          __out.push('\n\n    ');
          if (lead.length !== this.path.length) {
            __out.push('\n        <a href="#');
            __out.push(__sanitize(lead.join('.')));
            __out.push('.">');
            __out.push(__sanitize(part));
            __out.push('</a>');
            __out.push(__sanitize(divider("/")));
            __out.push('\n    ');
          } else {
            __out.push('\n        ');
            __out.push(__sanitize(part));
            __out.push('\n    ');
          }
          __out.push('\n');
        }
      
        __out.push('\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

