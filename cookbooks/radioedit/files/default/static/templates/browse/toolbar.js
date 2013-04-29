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
      
        __out.push('<div class="btn-toolbar clearfix">\n    <div class="btn-group">\n        <a href="javascript:void(0)" class="btn ');
      
        __out.push(__sanitize(this.saveCls));
      
        __out.push('" id="btn-save"><i class="icon-save"></i> Save</a>\n    </div>\n    <div class="btn-group push-group">\n        <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">\n        <i class="icon-upload-alt"></i> Push\n        <span class="caret"></span>\n        </a>\n        <ul class="dropdown-menu">\n            <li>\n                <a class="pushNow" data-push="live" href="javascript:void(0)">live</a>\n            </li>\n            <li>\n                <a class="pushNow" data-push="staging" href="javascript:void(0)">staging</a>\n            </li>\n            <li>\n                <form action="javascript:void(0)">\n                    <div class="input-append">\n                        <input size="14" type="text" /><button class="btn pushNow" type="button">Push</button>\n                    </div>\n                </form>\n            </li>\n            <li class="divider"></li>\n            <li>\n                <a id="btn-push" href="javascript:void(0)">Schedule A Push</a>\n            </li>\n        </ul>\n    </div>\n\n    <div class="btn-group pull-right">\n        <!-- <button class="btn" data-callback="unDelete"><i class="icon-repeat"></i> Un-Delete</button>\n        <button class="btn" data-callback="delete" data-title="Confirm" data-content="Click this button again to confirm that you would like to delete this target. This target will become immutable and marked for deletion."><i class="icon-trash"></i> Delete</button>\n        -->\n    </div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

