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
        var bindTo, path, targetGroup, _i, _len, _ref;
      
        __out.push('<h1>Target Group Directory</h1>\n\n<ul class="targetGroupList">\n    ');
      
        _ref = this.targetGroupCollection.models;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          targetGroup = _ref[_i];
          __out.push('\n        ');
          path = "targetGroupCollection." + targetGroup.cid + ".";
          __out.push('\n        ');
          bindTo = function(property) {
            return "" + path + property;
          };
          __out.push('\n        <li>\n            <div class="row">\n                <div class="span6">\n                    <div class="row">\n                        <div class="span2">\n                            <p>\n                                <a href="#targetgroup/');
          __out.push(__sanitize(targetGroup.get('name')));
          __out.push('" data-text="');
          __out.push(__sanitize(bindTo('owner_id')));
          __out.push('"></a>\n                            </p>\n                            <p>\n                                <span>Limit </span><span class="badge badge-info" data-text="');
          __out.push(__sanitize(bindTo('limit')));
          __out.push('"></span>\n                            </p>\n                        </div>\n                        <div class="span4">\n                            <p><strong data-text="');
          __out.push(__sanitize(bindTo('name')));
          __out.push('"></strong></p>\n                            <p data-text="');
          __out.push(__sanitize(bindTo('description')));
          __out.push('"></p>\n                        </div>\n                    </div>\n                </div>\n                <div class="span5 well">\n                    <ul data-html="');
          __out.push(__sanitize(bindTo('targets')));
          __out.push(' | list"></ul>\n                </div>\n            </div>\n        </li>\n    ');
        }
      
        __out.push('\n</ul>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

