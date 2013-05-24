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
        var target, _i, _len, _ref;
      
        __out.push('<h3>Order Targets</h3>\n<ul id="sortable" class="nav nav-tabs nav-stacked">\n    ');
      
        _ref = this.targetGroup.get('targets');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          target = _ref[_i];
          __out.push('\n        <li data-target="');
          __out.push(__sanitize(target));
          __out.push('" ><a href="javascript:void(0)">');
          __out.push(__sanitize(target));
          __out.push('<i data-callback="removeTarget" class="icon-remove"></i></a></li>\n    ');
        }
      
        __out.push('\n</ul>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

