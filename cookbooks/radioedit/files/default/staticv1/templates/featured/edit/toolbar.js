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
      
        __out.push('<div class="btn-toolbar clearfix">\n    <div class="btn-group">\n        <button class="btn ');
      
        if (this.dirty) {
          __out.push('btn-primary');
        }
      
        __out.push('" data-callback="save"><i class="icon-download-alt"></i> Save</button>\n    </div>\n\n    <div class="btn-group">\n        <button class="btn" data-tip="Add Item to this Target" data-callback="addItem"><i class="icon-plus"></i> New Item</button>\n    </div>\n\n    <div class="btn-group dropdown publishDropdown" data-tip="Choose Publish Target">\n        <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">\n            <i class="icon-cog"></i>\n            Publish\n            <span class="caret"></span>\n        </a>\n        <ul class="dropdown-menu">\n            <li><a href="#" data-callback="publish" data-args="live">Live <i data-callback="publishWithDate" data-args="live" class="icon-calendar"></i></a></li>\n            <li><a href="#" data-callback="publish" data-args="staging">Staging <i data-callback="publishWithDate" data-args="staging" class="icon-calendar"></i></a></li>\n            <li class="divider"></li>\n            <li>\n                <form class="tagForm form-inline">\n                    <div class="control-group">\n                        <input type="text" value="" />\n                        <div class="btn-group">\n                          <button class="btn">Go</button>\n                          <button class="btn calendar"><i class="icon-calendar"></i></button>\n                        </div>\n                    </div>\n                </form>\n            </li>\n        </ul>\n    </div>\n\n    ');
      
        if (this.targetBelongsToOtherUser) {
          __out.push('\n        <div class="btn-group">\n            <button class="btn" data-tip="Copy Working Copy of To Your User and Edit" data-callback="createWorkingCopy"><i class="icon-edit"></i> Copy & Edit</button>\n        </div>\n    ');
        }
      
        __out.push('\n\n    <div class="btn-group pull-right">\n        ');
      
        if (this.model.meta.deleted) {
          __out.push('\n            <button class="btn" data-callback="unDelete"><i class="icon-repeat"></i> Un-Delete</button>\n        ');
        } else {
          __out.push('\n            <button class="btn" data-callback="delete" data-title="Confirm" data-content="Click this button again to confirm that you would like to delete this target. This target will become immutable and marked for deletion."><i class="icon-trash"></i> Delete</button>\n        ');
        }
      
        __out.push('\n    </div>\n\n    <div class="btn-group pull-right">\n        <a class="btn ');
      
        if (!this.model.enabled) {
          __out.push('active');
        }
      
        __out.push('" data-callback="enable" data-args="n"><i class="icon-eye-close"></i> Disabled</a>\n        <a class="btn ');
      
        if (this.model.enabled) {
          __out.push('active');
        }
      
        __out.push('" data-callback="enable" data-args="y"><i class="icon-eye-open"></i> Enabled</a>\n    </div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

