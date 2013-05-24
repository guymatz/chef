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
      
        __out.push('<div class="item ');
      
        if (!this.data.enabled) {
          __out.push('disabled');
        }
      
        __out.push('">\n    <form>\n        <div>\n            <h2>');
      
        __out.push(__sanitize(this.data.title));
      
        __out.push('</h2>\n            <div class="btn-toolbar clearfix">\n                <div class="btn-group">\n                    ');
      
        if (this.data.important) {
          __out.push('\n                        <a class="btn btn-mini btn-warning disabled" data-callback="important" data-args="n">Important</a>\n                    ');
        } else {
          __out.push('\n                        <a class="btn btn-mini disabled" data-callback="important" data-args="y">Make Important</a>\n                    ');
        }
      
        __out.push('\n                </div>\n            </div>\n            <p>\n                ');
      
        __out.push(__sanitize(this.data.subtitle));
      
        __out.push('\n            </p>\n            <div>\n                <div class="lefthand">\n                    <div class="attachments">\n                        ');
      
        if (this.data.attachments && this.data.attachments.length) {
          __out.push('\n                        <table width="100%" class="table table-bordered table-striped">\n                            <thead>\n                            <tr>\n                                <th>Name</th>\n                                <th>For</th>\n                                <th>Link</th>\n                                <th>Text</th>\n                            </tr>\n                            </thead>\n                            <tbody>\n                            ');
          _ref = this.data.attachments;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            a = _ref[_i];
            __out.push('\n                            <tr>\n                                <td style="vertical-align: middle;">');
            __out.push(__sanitize(a.name));
            __out.push('</td>\n                                <td style="vertical-align: middle;">');
            __out.push(__sanitize(a["for"].capitalize()));
            __out.push('</td>\n                                <td style="vertical-align: middle;">');
            __out.push(__sanitize(a.link));
            __out.push('</td>\n                                <td style="vertical-align: middle;">');
            __out.push(__sanitize(a.link_text));
            __out.push('</td>\n                            </tr>\n                            ');
          }
          __out.push('\n                            </tbody>\n                        </table>\n                        ');
        }
      
        __out.push('\n                    </div>\n                </div>\n                <div class="righthand">\n                    <a class="thumbnail" data-callback="cropImage">\n                        ');
      
        if (this.data.image_url) {
          __out.push('\n                        <img src="');
          __out.push(__sanitize(this.data.image_url));
          __out.push('?ops=fit(240,200)" width="240" height="200" alt="">\n                        ');
        }
      
        __out.push('\n                    </a>\n                </div>\n            </div>\n\n        </div>\n    </form>\n</div>');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

