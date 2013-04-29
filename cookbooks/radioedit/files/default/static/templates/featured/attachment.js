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
        var a, _i, _len, _ref;
      
        if (this.attachments && this.attachments.length) {
          __out.push('\n    <ul class="ui-sortable">\n        ');
          _ref = this.attachments;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            a = _ref[_i];
            __out.push('\n        <li data-index="');
            __out.push(__sanitize(a.cid));
            __out.push('">\n            <span class="remove"><a href="javascript:void(0)" class="remove"><i class="icon-remove-sign icon-large"></i></a></span>\n            <span class="thumb">\n                ');
            if (a.get('img')) {
              __out.push('\n                    <img src="');
              __out.push(__sanitize(a.get('img') + (/\?/.test(a.get('img')) ? '&' : '?') + 'ops=fit(25,25)'));
              __out.push('" alt="');
              __out.push(__sanitize(a.get('name')));
              __out.push('" height="25" width="25"/>\n                ');
            }
            __out.push('\n            </span>\n            <span class="type">');
            __out.push(__sanitize(a.get('for').capitalize()));
            __out.push('</span>\n            <span class="link">');
            __out.push(__sanitize(a.get('link')));
            __out.push('\n                ');
            if (0 && a.get('for') === 'web') {
              __out.push('\n                <a target="_blank" href="');
              __out.push(__sanitize(a.get('link')));
              __out.push('"><i class="icon-external-link"/></a>\n                ');
            }
            __out.push('\n            </span>\n            <span class="name">');
            __out.push(__sanitize(a.get('link_text')));
            __out.push('</span>\n            <span class="reorder"><i class="button-icon icon-reorder reorder" data-tip="Drag me to Sort" data-original-title=""></i></span>\n            <span class="description">');
            __out.push(__sanitize(a.get('description')));
            __out.push('</span>\n        </li>\n        ');
          }
          __out.push('\n    </ul>\n');
        }
      
        __out.push('\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

