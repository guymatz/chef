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
      
        __out.push('<div class="modal fade hide ');
      
        __out.push(__sanitize(this.extraClasses));
      
        __out.push('">\n    <div class="modal-header">\n        <button type="button" class="close" data-dismiss="modal">×</button>\n        <h3>');
      
        __out.push(__sanitize(this.headerText));
      
        __out.push('</h3>\n    </div>\n    <div class="modal-body">\n        ');
      
        __out.push(this.bodyHtml);
      
        __out.push('\n    </div>\n    <div class="modal-footer">\n        ');
      
        __out.push(this.footerHTML);
      
        __out.push('\n        <button class="btn" data-dismiss="modal">');
      
        __out.push(__sanitize(this.closeText != null ? this.closeText : 'Close'));
      
        __out.push('</button>\n        <button class="btn btn-primary" data-loading-text="Saving..." >');
      
        __out.push(__sanitize(this.saveText != null ? this.saveText : 'Save Changes'));
      
        __out.push('</button>\n    </div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

