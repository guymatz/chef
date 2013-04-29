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
        var parsedDate,
          _this = this;
      
        __out.push('<form class="form-inline dateRangeContainer">\n    <div>\n        <div class="input-append date">\n            ');
      
        parsedDate = function(date) {
          return __capture(function() {
            if (date === null) {
              return __out.push('&#8734;');
            } else {
              return __out.push(__sanitize(Date.create(date).toUTC().format('{MM}/{dd}/{yy}')));
            }
          });
        };
      
        __out.push('\n            <input class="span3" size="16" data-startdate="');
      
        __out.push(__sanitize(this.startDate));
      
        __out.push('" data-enddate="');
      
        __out.push(__sanitize(this.endDate));
      
        __out.push('" type="text" value="');
      
        __out.push(__sanitize(parsedDate(this.startDate)));
      
        __out.push(' - ');
      
        __out.push(__sanitize(parsedDate(this.endDate)));
      
        __out.push('" readonly="" /><button class="btn dateselect" type="button" data-callback="toggleDateRangeControl">\n                <i class="icon-calendar"></i>\n            </button>\n        </div>\n        <button class="btn ');
      
        if (this.startDate === null && this.endDate === null) {
          __out.push('disabled');
        }
      
        __out.push('" data-tip="Remove range start and end dates" data-callback="removeRange"> Remove Range</button>\n    </div>\n</form>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

