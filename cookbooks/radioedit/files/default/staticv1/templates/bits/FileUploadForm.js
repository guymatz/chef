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
      
        __out.push('<div class="thumbnail">\n    <img src="');
      
        __out.push(__sanitize(this.imgSrc));
      
        __out.push('" alt=""/>\n</div>\n<div class="row">\n    <!-- The global progress information -->\n    <div class="span8 fileupload-progress fade">\n        <!-- The global progress bar -->\n        <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">\n            <div class="bar" style="width:0;"></div>\n        </div>\n        <!-- The extended global progress information -->\n        <div class="progress-extended">&nbsp;</div>\n    </div>\n</div>\n<div class="row">\n    <div class="imageUploadContainer well span8">\n        <div class="row">\n            <h3 class="span4">To upload drag file in or &rarr;</h3>\n            <form class="fileUploadForm span2" method="POST" action="');
      
        __out.push(__sanitize(this.action));
      
        __out.push('" enctype="multipart/form-data">\n                <div>\n                    <!-- The fileinput-button span is used to style the file input field as button -->\n                <span class="btn btn-success fileinput-button">\n                    <i class="icon-arrow-up icon-white"></i>\n                    <span>Upload Image</span>\n                    <input type="file" name="file" />\n                </span>\n                </div>\n                <div class="files"></div>\n            </form>\n        </div>\n    </div>\n</div>\n<div class="files"></div>');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

