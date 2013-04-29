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
        var item, name, node, objectParts, _i, _len, _ref, _ref1;
      
        __out.push('<div data-callback="navigateTo" data-args="#target/');
      
        __out.push(__sanitize(this.attributes._id));
      
        __out.push('/');
      
        __out.push(__sanitize(this.attributes.commit._id));
      
        __out.push('">\n    <div class="editor pull-left">\n        <a href="#target/');
      
        __out.push(__sanitize(this.attributes._id));
      
        __out.push('/');
      
        __out.push(__sanitize(this.attributes.commit._id));
      
        __out.push('">');
      
        __out.push(__sanitize(this.attributes.commit.author_id));
      
        __out.push('</a>\n    </div>\n    <div class="pull-left">\n        <ul class="thumbnails pull-right">\n            ');
      
        _ref = this.attributes.commit.data.items;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          __out.push('\n            <li>\n                <a href="#" class="thumbnail">\n                    <img src="');
          __out.push(__sanitize(item.image_url));
          __out.push('?ops=fit(60,50)" width="60" height="50" alt="">\n                </a>\n            </li>\n            ');
        }
      
        __out.push('\n        </ul>\n        <div class="description">\n            <p>\n                ');
      
        objectParts = this.attributes.commit.resource_id.split('.');
      
        __out.push('\n                ');
      
        node = objectParts.pop();
      
        __out.push('\n                ');
      
        name = objectParts.join('.');
      
        __out.push('\n                <span style="color: black;">');
      
        __out.push(__sanitize(name));
      
        __out.push('</span>:<strong>');
      
        __out.push(__sanitize(node));
      
        __out.push('</strong>\n                &mdash; ');
      
        __out.push(__sanitize((_ref1 = this.attributes.commit.data.description) != null ? _ref1.truncate(100, false) : void 0));
      
        __out.push('\n            </p>\n            ');
      
        if (!this.attributes.commit.data.enabled) {
          __out.push('<span class="label label-inverse">Disabled</span>');
        }
      
        __out.push('\n        </div>\n    </div>\n    <div>\n        <div class="mtime pull-left">\n            ');
      
        __out.push(__sanitize(new Date(this.attributes.commit.ctime).toDateString().split(' ').slice(1, 3).join(' ')));
      
        __out.push('\n        </div>\n        <div class="count">\n            <a href="#" rel="tooltip" title="There are ');
      
        __out.push(__sanitize(this.attributes.commit.data.items.length));
      
        __out.push(' content items in this target"><span class="badge">');
      
        __out.push(__sanitize(this.attributes.commit.data.items.length));
      
        __out.push('</span></a>\n        </div>\n    </div>\n    <div class="clearfix"></div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

