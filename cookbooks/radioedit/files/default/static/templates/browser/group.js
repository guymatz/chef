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
      
        __out.push('<h');
      
        __out.push(__sanitize(this.level));
      
        __out.push('>\n    ');
      
        __out.push(this.description.short);
      
        __out.push('\n</h');
      
        __out.push(__sanitize(this.level));
      
        __out.push('>\n\n<p class="groupurl">\n    Grouped Under: ');
      
        __out.push(__sanitize(this.url));
      
        __out.push('\n</p>\n\n');
      
        if (this.description.long) {
          __out.push('\n    ');
          __out.push(this.description.long);
          __out.push('\n');
        }
      
        __out.push('\n\n<ul class="endpoints">\n    <li class="empty">\n        No Endpoints\n    </li>\n</ul>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

