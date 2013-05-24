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
      
        __out.push('<div class="span11">\n    <h1>Target Combinator</h1>\n    <div class="pickerContainer"></div>\n    <div class="input-prepend">\n        <span class="add-on"><i class="icon-search"></i></span><input class="span10" id="nameSpaceAutocomplete" type="text" value="" placeholder="Search For Target" />\n    </div>\n    <form class="form-horizontal targetGroupForm">\n        <fieldset>\n            <legend>Create Target Group</legend>\n            <div class="control-group">\n                <label class="control-label" for="name">Name</label>\n                <div class="controls">\n                    <input type="text" class="input-xlarge" name="name" id="name" value="" />\n                </div>\n            </div>\n            <div class="control-group">\n                <label class="control-label" for="description">Description</label>\n                <div class="controls">\n                    <input type="text" class="input-xlarge" name="description" id="description" value="" />\n                </div>\n            </div>\n            <div class="control-group">\n                <label class="control-label" for="limit">Limit</label>\n                <div class="controls">\n                    <input type="text" class="input-xlarge" name="limit" id="limit" value="" />\n                </div>\n            </div>\n            <div class="sorterContainer well"></div>\n            <div class="form-actions">\n                <button type="submit" class="btn btn-primary">Save</button>\n                <button class="btn">Cancel</button>\n            </div>\n        </fieldset>\n    </form>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

