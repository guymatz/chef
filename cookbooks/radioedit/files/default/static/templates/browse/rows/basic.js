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
        var commit, d, ref, _ref;
      
        __out.push('<div class="wrapper clearfix">\n    <div class="type">\n        <span class="badge">');
      
        __out.push(__sanitize(this.data_type.capitalize()));
      
        __out.push('</span>\n    </div>\n    <div class="name">\n        <a href="#');
      
        __out.push(__sanitize(this._id));
      
        __out.push('/');
      
        __out.push(__sanitize(this.refs['HEAD']));
      
        __out.push('">\n            <i class="icon-file"></i> ');
      
        __out.push(__sanitize(this._id.split('.').pop()));
      
        __out.push('\n        </a>\n    </div>\n    ');
      
        if (this.commit != null) {
          __out.push('\n    <div class="modified">\n        ');
          d = Date.create(this.commit.ctime);
          __out.push('\n        ');
          if (d.isToday()) {
            __out.push('\n            ');
            __out.push(__sanitize(d.hoursAgo()));
            __out.push(' hours ago\n        ');
          } else if (d.isThisWeek()) {
            __out.push('\n            ');
            __out.push(__sanitize(d.format('{Dow} {hh}:{mm} {Tt}')));
            __out.push('\n        ');
          } else {
            __out.push('\n            ');
            __out.push(__sanitize(d.format('{Mon} {MM}')));
            __out.push('\n        ');
          }
          __out.push('\n        <span class="by">by</span> ');
          __out.push(__sanitize(this.commit.author.display_name));
          __out.push('\n    </div>\n    ');
        }
      
        __out.push('\n    <div class="refs">\n        ');
      
        _ref = this.refs;
        for (ref in _ref) {
          commit = _ref[ref];
          __out.push('\n        <span class="badge badge-info"><a href="#');
          __out.push(__sanitize(this._id));
          __out.push('/');
          __out.push(__sanitize(commit));
          __out.push('">');
          __out.push(__sanitize(ref));
          __out.push('</a></span>\n        ');
        }
      
        __out.push('\n    </div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

