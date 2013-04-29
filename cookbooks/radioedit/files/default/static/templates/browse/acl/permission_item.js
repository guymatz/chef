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
        var _base, _name;
      
        __out.push('<div class="permissionType">\n    ');
      
        __out.push(typeof (_base = this.permissionTemplates)[_name = this.allow.toString()] === "function" ? _base[_name]() : void 0);
      
        __out.push('\n</div>\n<form action="javascript:void(0);">\n    <div class="formElementsContainer">\n        <div class="principal">\n            <label for="principal">Principal: </label>\n            <ul class="singleSelectTypeAhead">\n                <li><input ');
      
        if (this.type === 'edit') {
          __out.push('disabled ');
        }
      
        __out.push('class="ghost" id="principal" name="principal" placeholder="Principal" value="');
      
        __out.push(__sanitize(this.principal));
      
        __out.push('" /></li>\n            </ul>\n        </div>\n        <div class="permission">\n            <label for="permission">Permission: </label>\n            <select id="permission" name="permission">\n                <option value="read" ');
      
        if (this.permission === 'read') {
          __out.push('selected="selected"');
        }
      
        __out.push('>Read</option>\n                <option value="write" ');
      
        if (this.permission === 'write') {
          __out.push('selected="selected"');
        }
      
        __out.push('>Write</option>\n                <option value="delete" ');
      
        if (this.permission === 'delete') {
          __out.push('selected="selected"');
        }
      
        __out.push('>Delete</option>\n                <option value="publish" ');
      
        if (this.permission === 'publish') {
          __out.push('selected="selected"');
        }
      
        __out.push('>Publish</option>\n            </select>\n        </div>\n    </div>\n    <div class="buttonContainer">\n        ');
      
        if (this.type === 'add') {
          __out.push('\n            <button class="btn add btn-success"><i class="icon-plus-sign"></i> Add</button>\n        ');
        } else {
          __out.push('\n            <button class="btn delete btn-danger"><i class="icon-minus-sign"></i> Delete</button>\n        ');
        }
      
        __out.push('\n    </div>\n</form>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

