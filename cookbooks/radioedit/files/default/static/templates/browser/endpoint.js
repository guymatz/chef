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
      
        __out.push('<span class="menu pull-right">\n    <a href="javascript:void(0)" data-action="hide"><i class="icon-chevron-up"/></a>\n    <a href="javascript:void(0)" data-action="show"><i class="icon-chevron-down"/></a>\n    <a href="javascript:void(0)" data-action="showAll"><i class="icon-resize-vertical"/></a>\n</span>\n\n\n<div class="endpointurl" data-action="epToggle">\n    <h2>\n        ');
      
        __out.push(this.url.html());
      
        __out.push('\n    </h2>\n</div>\n\n<div class="operations hide">\n    <p class="sample">\n        URL Sample: <span>');
      
        __out.push(__sanitize(this.urlBuilt));
      
        __out.push('</span>\n    </p>\n    ');
      
        __out.push(this.data.description.short);
      
        __out.push('\n    ');
      
        __out.push(this.data.description.long);
      
        __out.push('\n\n    <ul class="methods unstyled">\n    </ul>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

