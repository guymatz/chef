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
        var tag, version, _i, _j, _len, _len1, _ref, _ref1;
      
        __out.push('<div class="clearfix">\n    <div class="pull-right" style="margin-top: 5px;">\n        <select id="versionselect" data-placeholder="Select a Version..." class="chzn-select" style="width:250px;" tabindex="2">\n            <option value=""></option>\n            ');
      
        _ref = this.versions;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          version = _ref[_i];
          __out.push('\n                <option value="');
          __out.push(__sanitize(version.id));
          __out.push('">');
          __out.push(__sanitize(version.get('version_tags')));
          __out.push(': ');
          __out.push(__sanitize(Date.create(version.get('meta').mtime).format('{d} {Month}, {yyyy}')));
          __out.push('</option>\n            ');
        }
      
        __out.push('\n        </select>\n    </div>\n    <div>\n        <h1>\n            <span style="font-weight: normal;">Content Target &mdash;</span>\n            <span style="color: #999;"></span>');
      
        __out.push(__sanitize(this.name));
      
        __out.push('\n        </h1>\n    </div>\n</div>\n\n<p>\n    ');
      
        _ref1 = this.tags;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          tag = _ref1[_j];
          __out.push('\n        <span class="badge badge-info">');
          __out.push(__sanitize(tag));
          __out.push('</span>\n    ');
        }
      
        __out.push('\n</p>');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

