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
        var identifier, toggle, _ref, _ref1;
      
        __out.push('<div class="toggleContainer">\n    <div class="btn-group" data-toggle="buttons-radio">\n        ');
      
        _ref = this.toggles;
        for (identifier in _ref) {
          toggle = _ref[identifier];
          __out.push('\n            <button type="button" data-identifier="');
          __out.push(__sanitize(identifier));
          __out.push('" class="btn btn-mini">');
          __out.push(__sanitize(toggle.displayName));
          __out.push('</button>\n        ');
        }
      
        __out.push('\n        <button type="button" class="btn btn-mini all"><i class="icon-lock"></i></button>\n    </div>\n</div>\n<div class="textContainer">\n    <input type="text" id="psuedoField" />\n</div>\n<p class="characterCount">0</p>\n<div class="fieldsContainer">\n    ');
      
        _ref1 = this.toggles;
        for (identifier in _ref1) {
          toggle = _ref1[identifier];
          __out.push('\n        <input type="text" name="');
          __out.push(__sanitize(identifier));
          __out.push('" value="');
          __out.push(__sanitize(toggle.value));
          __out.push('" />\n    ');
        }
      
        __out.push('\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

