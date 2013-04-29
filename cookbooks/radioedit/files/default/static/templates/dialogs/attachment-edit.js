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
      
        __out.push('<div class="modal-header">\n    <a class="close" data-dismiss="modal">×</a>\n    <h3>Attachment</h3>\n</div>\n<div class="modal-body">\n\n    <img src="');
      
        __out.push(__sanitize(this.img));
      
        __out.push('?ops=max(250,250)" alt="');
      
        __out.push(__sanitize(this.name));
      
        __out.push('" width="250" height="250">\n\n    <div class="control-group">\n        <label class="control-label" for="link">Link</label>\n        <div class="controls">\n            <input type="text" name="link" id="link" value="');
      
        __out.push(__sanitize(this.link));
      
        __out.push('">\n            <p class="help-block">Action link for this attachment</p>\n        </div>\n    </div>\n    <div class="control-group">\n        <label class="control-label" for="link_text">Name</label>\n        <div class="controls">\n            <input type="text" name="link_text" id="link_text" value="');
      
        __out.push(__sanitize(this.link_text));
      
        __out.push('">\n            <p class="help-block">Name to display for this attachment</p>\n        </div>\n    </div>\n    <div class="control-group">\n        <label class="control-label" for="description">Description</label>\n        <div class="controls">\n            <input type="text" name="description" id="description" value="');
      
        __out.push(__sanitize(this.description));
      
        __out.push('">\n            <p class="help-block">Artist, track, or station description</p>\n        </div>\n    </div>\n\n</div>\n<div class="modal-footer">\n    <div class="btn-toolbar">\n        <a class="cancel pull-left" data-dismiss="modal">Cancel</a>\n        <a class="btn btn-primary" id="save">Save</a>\n    </div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

