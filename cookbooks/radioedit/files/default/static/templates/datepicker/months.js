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
      
        __out.push('<div class="row">\n    <div class="currentYear span4">\n        <a class="switch" data-switch="year" data-date="');
      
        __out.push(__sanitize(this.date.valueOf()));
      
        __out.push('" href="javascript:void(0)">\n            ');
      
        __out.push(__sanitize(this.date.format('YYYY')));
      
        __out.push('\n        </a>\n    </div>\n    ');
      
        while (this.date.valueOf() < this.endOfYear.valueOf()) {
          __out.push('\n        <div class="switch month span1" data-switch="day" data-date="');
          __out.push(__sanitize(this.date.valueOf()));
          __out.push('">');
          __out.push(__sanitize(this.date.format('MMM')));
          __out.push('</div>\n        ');
          this.date.add('months', 1);
          __out.push('\n    ');
        }
      
        __out.push('\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

