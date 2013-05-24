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
      
        __out.push('<div class="modal-header">\n    <a class="close" data-dismiss="modal">×</a>\n    <h3>Attach Artist or Track Object</h3>\n</div>\n<div class="modal-body">\n    <div class="clearfix">\n        <div class="control-group" style="float: left; width: 40%;">\n            <label class="control-label" for="attachSearch">Search</label>\n            <div class="controls">\n                <input type="text" name="attachSearch" id="attachSearch">\n                <p class="help-block">Search for artist or track to attach.</p>\n            </div>\n        </div>\n\n        <div class="control-group"  style="float: left; width: 10%; text-align: center; margin: 25px 0;">\n            <h3>OR</h3>\n        </div>\n\n        <div class="control-group"  style="float: left; width: 40%;">\n            <label class="control-label">Custom</label>\n            <div class="controls">\n                <button class="btn" type="text" name="attachCustom" id="attachCustom">Add Custom</button>\n                <p class="help-block">Add a custom attachment that you can edit.</p>\n            </div>\n        </div>\n    </div>\n\n\n    <div style="text-align: center; padding: 10px;" class="hide thinking">\n        <img src="/static/img/spinner.gif" alt="Loading..."/>\n    </div>\n\n    <div id="attach-results">\n    </div>\n</div>\n<div class="modal-footer">\n    <div class="btn-toolbar">\n        <a class="cancel pull-left" data-dismiss="modal">Cancel</a>\n        <!--<a class="btn btn-primary" id="publishModalSubmit">Attach</a>-->\n    </div>\n</div>');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

