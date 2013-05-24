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
      
        __out.push('<div class="item ');
      
        if (!this.data.enabled) {
          __out.push('disabled');
        }
      
        __out.push('">\n    <form>\n        <div>\n            <h2><input class="ghost" name="title" type="text" value="');
      
        __out.push(__sanitize(this.data.title));
      
        __out.push('"/></h2>\n            <div class="btn-toolbar clearfix">\n                <div class="btn-group">\n                    <a class="btn btn-mini');
      
        __out.push(__sanitize(this.first));
      
        __out.push('" data-callback="move" data-args="up"><i class="icon icon-arrow-up icon-large"></i></a>\n                    <a class="btn btn-mini');
      
        __out.push(__sanitize(this.last));
      
        __out.push('" data-callback="move" data-args="down"><i class="icon icon-arrow-down icon-large"></i></a>\n                </div>\n                <div class="btn-group">\n                    ');
      
        if (this.data.important) {
          __out.push('\n                        <a class="btn btn-mini btn-warning" data-callback="important" data-args="n">Important</a>\n                    ');
        } else {
          __out.push('\n                        <a class="btn btn-mini" data-callback="important" data-args="y">Make Important</a>\n                    ');
        }
      
        __out.push('\n                </div>\n\n                <div class="btn-group">\n                    <a class="btn btn-mini" data-callback="addArtist">Attach</a>\n                </div>\n\n                <div class="btn-group">\n                    <a class="btn btn-mini" data-callback="clearAttachments">Clear Attachments</a>\n                </div>\n\n                <div class="btn-group pull-right">\n                    <a class="btn btn-mini" data-callback="delete" data-title="Confirm" data-content="Click this button again to remove this item from the target. This action will happen immediately, and is irreversable."><i class="icon-trash icon-large"></i> Delete</a>\n                </div>\n\n                <div class="btn-group pull-right">\n                    <a class="btn btn-mini ');
      
        if (!this.data.enabled) {
          __out.push('active');
        }
      
        __out.push('" data-callback="enable" data-args="n"><i class="icon-eye-close icon-large"></i> Disabled</a>\n                    <a class="btn btn-mini ');
      
        if (this.data.enabled) {
          __out.push('active');
        }
      
        __out.push('" data-callback="enable" data-args="y"><i class="icon-eye-open icon-large"></i> Enabled</a>\n                </div>\n            </div>\n            <p>\n                <input type="text" class="ghost" name="subtitle" value="');
      
        __out.push(__sanitize(this.data.subtitle));
      
        __out.push('"/>\n            </p>\n            <div>\n                <div class="lefthand">\n                    <div class="attachments"></div>\n                </div>\n                <div class="righthand">\n                    <a class="thumbnail" data-callback="cropImage">\n                        ');
      
        if (this.data.image_url) {
          __out.push('\n                            <img src="');
          __out.push(__sanitize(this.data.image_url));
          __out.push('?ops=fit(240,200)" width="240" height="200" alt="">\n                        ');
        }
      
        __out.push('\n                    </a>\n                </div>\n            </div>\n\n\n        </div>\n    </form>\n</div>');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

