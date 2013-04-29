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
        var model, _i, _len, _ref;
      
        __out.push('<table width="100%" class="table table-bordered table-striped">\n    <thead>\n    <tr>\n        <th></th>\n        <th>Type</th>\n        <th>Name</th>\n        <th>Id</th>\n    </tr>\n    </thead>\n    <tbody>\n    ');
      
        _ref = this.models;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          model = _ref[_i];
          __out.push('\n    <tr data-id="');
          __out.push(__sanitize(model.cid));
          __out.push('">\n        <td width="25">\n            <img src="');
          __out.push(__sanitize(model.getImg(25)));
          __out.push('" width="25" height="25" style="max-width: inherit;" alt="preview"/>\n        </td>\n        <td style="vertical-align: middle;">');
          __out.push(__sanitize(model.get('kind').capitalize()));
          __out.push('</td>\n        <td style="vertical-align: middle;"><a href="javascript:void(0)" id="');
          __out.push(__sanitize(model.cid));
          __out.push('" class="name">\n            ');
          __out.push(__sanitize(model.get('name')));
          __out.push('\n        </a></td>\n        <td style="vertical-align: middle;">');
          __out.push(__sanitize(model.get('slug') || model.get('id')));
          __out.push('</td>\n    </tr>\n    ');
        }
      
        __out.push('\n    </tbody>\n</table>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

