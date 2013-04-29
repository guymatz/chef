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
      
        __out.push('<div class="aclItem">\n    <div class="span-2">\n        <input class="ghost" name="Principal" placeholder="Principal" />\n    </div>\n    <div class="span-1">\n        <div class="btn-group" data-toggle="buttons-radio">\n          <button type="button" class="active btn btn-mini"><i class="icon-ok-circle"></i> Can</button>\n          <button type="button" class="btn btn-mini"><i class="icon-ban-circle"></i> Cannot</button>\n        </div>\n    </div>\n    <div class="span-2">\n        <select id="Principal" name="Principal" >\n            <option value="read">Read</option>\n            <option value="write">Write</option>\n            <option value="delete">Delete</option>\n            <option value="publish">Publish</option>\n        </select>\n    </div>\n    <div class="span-1">\n        <button class="btn add btn-mini btn-success"><i class="icon-plus-sign"></i> Add</button>\n    </div>\n</div>\n<h3>Interited Permissions</h3>\n<div class="inherited">\n    <div class="aclItem">\n        <div class="span-1">\n               John\n        </div>\n        <div class="span-1">\n            cannot\n        </div>\n        <div class="span-2">\n            delete\n        </div>\n    </div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

