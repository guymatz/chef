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
        var fullPath, nameSpace, value, _ref,
          __hasProp = {}.hasOwnProperty;
      
        __out.push('<div class="well well-large">\n    <h3>Select Targets</h3>\n    <div class="combinatorPickerContainer">\n        <ul class="nav nav-pills nav-stacked">\n            ');
      
        if (this.subTree.isLeaf()) {
          __out.push('\n                <li>\n                    <a href="#" data-callback="selectItem" data-args="');
          __out.push(__sanitize(this.subTree.getFullPath()));
          __out.push('">\n                        <span>');
          __out.push(__sanitize(this.subTree.getFullPath()));
          __out.push('</span>\n                    </a>\n                </li>\n            ');
        } else {
          __out.push('\n                ');
          _ref = this.subTree.data;
          for (nameSpace in _ref) {
            if (!__hasProp.call(_ref, nameSpace)) continue;
            value = _ref[nameSpace];
            __out.push('\n                    ');
            fullPath = value.getFullPath();
            __out.push('\n                    <li>\n                        <a href="#" data-callback="selectItem" data-args="');
            __out.push(__sanitize(fullPath));
            __out.push('">\n                            <span>');
            __out.push(__sanitize(fullPath));
            __out.push('</span>\n                        </a>\n                    </li>\n                ');
          }
          __out.push('\n            ');
        }
      
        __out.push('\n        </ul>\n    </div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

