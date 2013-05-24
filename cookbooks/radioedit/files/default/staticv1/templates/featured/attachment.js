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
        var a, i, _i, _len, _ref;
      
        if (this.attachments && this.attachments.length) {
          __out.push('\n<table width="100%" class="table table-bordered table-striped">\n    <thead>\n    <tr>\n        <th>Name</th>\n        <th>For</th>\n        <th>Link</th>\n        <th>Text</th>\n    </tr>\n    </thead>\n    <tbody>\n        ');
          i = 0;
          __out.push('\n        ');
          _ref = this.attachments;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            a = _ref[_i];
            __out.push('\n        <tr data-index="');
            __out.push(__sanitize(i));
            __out.push('">\n            <td style="vertical-align: middle;"><a href="#" data-callback="clearAttachment" data-args="');
            __out.push(__sanitize(i));
            __out.push('" data-tip="Remove"><i class="icon-remove-sign icon-large"></i></a> ');
            __out.push(__sanitize(a.name));
            __out.push('</td>\n            <td style="vertical-align: middle;">');
            __out.push(__sanitize(a["for"].capitalize()));
            __out.push('</td>\n            <td style="vertical-align: middle;"><input class="ghost" name="attachments.');
            __out.push(__sanitize(i));
            __out.push('.link" type="text" value="');
            __out.push(__sanitize(a.link));
            __out.push('"/></td>\n            <td style="vertical-align: middle;"><input class="ghost" name="attachments.');
            __out.push(__sanitize(i));
            __out.push('.link_text" type="text" value="');
            __out.push(__sanitize(a.link_text));
            __out.push('"/></td>\n        </tr>\n        ');
            i++;
            __out.push('\n        ');
          }
          __out.push('\n    </tbody>\n</table>\n');
        }
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

