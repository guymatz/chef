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
        var _ref;
      
        __out.push('<form data-id="');
      
        __out.push(__sanitize(this.cid));
      
        __out.push('">\n    <div class="titlebar clearfix">\n        ');
      
        if (this.attributes.important) {
          __out.push('\n        <i class="button-icon icon-star important" data-tip="Indicate this Slide is more Important than Others" />\n        ');
        } else {
          __out.push('\n        <i class="button-icon icon-star-empty important" data-tip="Indicate this Slide is more Important than Others" />\n        ');
        }
      
        __out.push('\n        <i class="button-icon icon-ban-circle enable" data-tip="Prevent this Slide from appearing on the Client" />\n        <i class="button-icon icon-trash" data-tip="Delete this Slide" />\n        <i class="button-icon icon-copy" data-tip="Clone this Slide" />\n        <i class="button-icon icon-reorder reorder" data-tip="Drag me to Sort" />\n    </div>\n    <div>\n        <div class="itemname">\n            <h3>\n                <input name="internal_name" class="ghost" type="text" placeholder="Name for Internal Use"\n                       value="');
      
        __out.push(__sanitize(this.attributes.internal_name));
      
        __out.push('"/>\n            </h3>\n        </div>\n        <div class="controls">\n            <div class="lefthand">\n                <p>\n                    <input name="title" class="ghost" placeholder="Title Text" type="text" value="');
      
        __out.push(__sanitize(this.attributes.title));
      
        __out.push('"/>\n                </p>\n                <p class="help-block">\n                    <input name="subtitle" class="ghost" type="text" placeholder="Subtitle Text Usually Appears Smaller"\n                           value="');
      
        __out.push(__sanitize(this.attributes.subtitle));
      
        __out.push('"/>\n                </p>\n\n                <div class="attachments"></div>\n                <p>\n                <a href="javascript:void(0)" class="attach">\n                    <i class="icon-paper-clip"/>\n                    Attach Items (Stations, Artists, Tracks, etc).\n                </a>\n                or\n                <a href="javascript:void(0)" class="attach-custom">\n                    <i class="icon-link"/>\n                    Attach Custom Link.\n                </a>\n                </p>\n            </div>\n            <div class="righthand">\n                <a href="javascript:void(0)" class="image">\n                    ');
      
        if (((_ref = this.attributes.img_meta) != null ? _ref.image_id : void 0) != null) {
          __out.push('\n                    <img src="');
          __out.push(__sanitize(this.image_url));
          __out.push('?ops=fit(160,120)" width="160" height="120" alt=""/>\n                    ');
        }
      
        __out.push('\n                </a>\n            </div>\n        </div>\n    </div>\n</form>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

