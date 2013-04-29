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
      
        __out.push('<form data-id="');
      
        __out.push(__sanitize(this.cid));
      
        __out.push('">\n    <div class="titlebar clearfix">\n        <i class="button-icon icon-asterisk" data-type="checkbox" data-name="default" data-tip="Use when no other is selected" />\n        <i class="button-icon icon-trash" data-tip="Delete this Slide" />\n        <i class="button-icon icon-copy" data-tip="Clone this Slide" />\n        <i class="button-icon icon-reorder reorder" data-tip="Drag me to Sort" />\n    </div>\n    <div>\n        <div class="itemname">\n            <h3>\n                <input name="name" class="ghost" placeholder="Playlist Name" type="text" value=""/>\n            </h3>\n        </div>\n        <div class="controls">\n            <div class="descriptions help-block"></div>\n            <div class="attachments no-image"></div>\n            <p>\n                <a href="javascript:void(0)" class="attach">\n                    <i class="icon-paper-clip"/>\n                    Attach Items (Stations, Artists, Tracks, etc).\n                </a>\n            </p>\n        </div>\n    </div>\n</form>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

