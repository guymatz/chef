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
        var day, _i, _j, _len, _ref, _ref1;
      
        __out.push('<div class="month">\n    <div class="currentMonthYear">\n        <a class="switch" data-date="');
      
        __out.push(__sanitize(this.date.valueOf()));
      
        __out.push('" data-switch="month" href="javascript:void(0)">\n            ');
      
        __out.push(__sanitize(this.date.format('MMMM YYYY')));
      
        __out.push('\n        </a>\n    </div>\n    <div class="weekdays row">\n        ');
      
        _ref = this.weekdays;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          day = _ref[_i];
          __out.push('\n            <div class="span1 weekday">');
          __out.push(__sanitize(day));
          __out.push('</div>\n        ');
        }
      
        __out.push('\n    </div>\n    <div class="dates row">\n        ');
      
        while (this.date.valueOf() < this.endDate.valueOf()) {
          __out.push('\n            ');
          if (this.date.date() === 1) {
            __out.push('\n                <div class="row days">\n                ');
            for (day = _j = _ref1 = this.date.day(); _ref1 <= 0 ? _j < 0 : _j > 0; day = _ref1 <= 0 ? ++_j : --_j) {
              __out.push('\n                    <div class="span1 day"></div>\n                ');
            }
            __out.push('\n            ');
          } else if (this.date.day() === 0) {
            __out.push('\n                <div class="row days">\n            ');
          }
          __out.push('\n                    <div class="span1 day" data-date="');
          __out.push(__sanitize(this.date.valueOf()));
          __out.push('">\n                        <div class="span1 date');
          __out.push(__sanitize(this.supplementalClass(this.date)));
          __out.push('">');
          __out.push(__sanitize(this.date.date()));
          __out.push('</div>\n                        ');
          __out.push(this.supplementalRender(this.date));
          __out.push('\n                    </div>\n            ');
          if (this.date.day() === 6 || this.date.date() === this.daysInMonth) {
            __out.push('\n                </div>\n            ');
          }
          __out.push('\n            ');
          this.date.add('days', 1);
          __out.push('\n        ');
        }
      
        __out.push('\n    </div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

