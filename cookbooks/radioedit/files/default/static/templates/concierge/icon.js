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
      
        __out.push('<div>\n    <table>\n        <tr>\n            <td rowspan="5"><img src="');
      
        __out.push(__sanitize(this.model.image_url));
      
        __out.push('?ops=fit(100,100)"/></td>\n        </tr>\n        <tr>\n            <td>');
      
        __out.push(__sanitize(this.model.img_url));
      
        __out.push('</td>\n        </tr>\n        <tr>\n            <td>');
      
        __out.push(__sanitize(this.model.img_meta.mime_type));
      
        __out.push('</td>\n        </tr>\n        <tr>\n            <td>');
      
        __out.push(__sanitize(this.model.img_meta.dimensions[0]));
      
        __out.push(' X ');
      
        __out.push(__sanitize(this.model.img_meta.dimensions[1]));
      
        __out.push('</td>\n        </tr>\n        <tr>\n            <td>\n                <a href="javascript:void(0)" class="remove-icon">Remove Icon</a>\n                <div class="tagging">\n                    <label>Device Targets <a href="javaScript:void(0)" data-tip="This is a tag field. <br /><br /> Enter a tag, then press <pre>space</pre> or <pre>return</pre> to add. <br /><br /> Press <pre>backspace</pre> or <pre>click</pre> the x to remove a tag."><i class="icon-info-sign"></i></a></label>\n                </div>\n            </td>\n        </tr>\n    </table>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

