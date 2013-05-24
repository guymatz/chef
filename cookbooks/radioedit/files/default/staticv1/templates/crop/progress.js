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
      
        __out.push('<div class="progress progress-step">\n    <div class="step step-full" data-step="upload">1</div>\n    <div class="step step-empty" data-step="anchor" style="left:100%">2</div>\n    <div class="bar" style="width:0;"></div>\n</div>\n<div class="row">\n    <div class="step-name span2">upload</div>\n    <div class="step-name span2 offset8 lastStep">anchor</div>\n</div>\n<div class="cropperContainer">\n    <div class="leftChevron span1 disabled" data-callback="step" data-args="upload">\n        <i class="icon-chevron-left"></i>\n    </div>\n    <div class="rightChevron span1" data-callback="step" data-args="anchor">\n        <i class="icon-chevron-right"></i>\n    </div>\n    <div class="cropImageContainer span8"></div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

