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
        var model, _i, _len, _ref;
      
        __out.push('<div class="status"></div>\n<form action="javascript:void(0)">\n    <div class="control-group">\n        <label>Data Type</label>\n        <div>\n            <select class="data_type" name="data_type">\n                ');
      
        _ref = this.models;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          model = _ref[_i];
          __out.push('\n                    <option value="');
          __out.push(__sanitize(model.id));
          __out.push('">');
          __out.push(__sanitize(model.get('name')));
          __out.push('</option>\n                ');
        }
      
        __out.push('\n            </select>\n        </div>\n    </div>\n    <div class="control-group">\n        ');
      
        if (this.path != null) {
          __out.push('\n            <label>Name</label>\n            <div>\n                <input data-path="');
          __out.push(__sanitize(this.path));
          __out.push('" class="name" name="name" value="" />\n            </div>\n        ');
        } else {
          __out.push('\n            <label>Resource Id</label>\n            <div>\n                <input class="resourceId" name="resourceId" value="" />\n            </div>\n        ');
        }
      
        __out.push('\n    </div>\n    <div class="control-group">\n        <div>\n            <button class="createObject btn"><i class="icon-plus"></i> Create</button>\n        </div>\n    </div>\n</form>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

