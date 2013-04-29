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
      
        __out.push('<h3><i class="icon-comment-alt" /> Notes</h3>\n<p class="help-block">\n    Typically not displayed to the client these can be used to inform other curators as to the\n    organization or content of this <strong>Feature</strong>.\n</p>\n<textarea name="description" id="description">');
      
        __out.push(__sanitize(this.description));
      
        __out.push('</textarea>\n\n<hr/>\n\n<div class="btn-toolbar clearfix">\n    <div class="btn-group collapser">\n        <a class="btn" href="javascript:void(0)" id="new-slide"><i class="icon-plus"></i> Add Slide</a>\n    </div>\n    <div class="btn-group collapser">\n        <a class="btn active" href="javascript:void(0)" id="expand-slides">Expand Slides</a>\n        <a class="btn" href="javascript:void(0)" id="collapse-slides">Collapse Slides</a>\n    </div>\n</div>\n\n<hr/>\n\n<h3><i class="icon-list-ol" /> Slides (<span id="item-count">0</span>) <i class="icon-caret-down" /></h3>\n<p class="help-block">\n    Specify slides for the client to show. Each item in this list represents a single slide.\n</p>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

