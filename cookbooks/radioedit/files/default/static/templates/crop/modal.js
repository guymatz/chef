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
      
        __out.push('<form class="fileUploadForm" method="POST" action="');
      
        __out.push(__sanitize(this.action));
      
        __out.push('" enctype="multipart/form-data">\n<div class="modal-header">\n    <button type="button" class="close" data-dismiss="modal">×</button>\n    <h3>Update Image</h3>\n</div>\n<div class="modal-body">\n    <div class="progress-container hide">\n        <div class="progress progress-success" role="progressbar">\n            <div class="bar" style="width:0;"></div>\n        </div>\n        <div class="progress-extended">\n            <span class="percent"><i class="icon-upload"/> <span></span>%</span>\n            <span class="completion"><i class="icon-hdd"/> <span></span></span>\n            <span class="speed"><i class="icon-dashboard"/> <span></span></span>\n            <span class="duration"><i class="icon-time"/> <span></span></span>\n        </div>\n    </div>\n    <div class="cropImageContainer">\n        <p class="help-block">\n            <i class="icon-asterisk"/>\n            To improve the display of this image when shown at alternate resolutions and\n            with a crop applied, select an anchor point. You may select an anchor point by clicking\n            anywhere on the image. It should be considered the most interesting or important part\n            of the image.\n        </p>\n        <div class="the-image">\n            <div class="img-tag fade"></div>\n        </div>\n        <div style="text-align: center; padding: 10px;" class="thinking fade">\n            <img src="/static/img/spinner.gif" alt="Loading..."/>\n        </div>\n    </div>\n    <h3 style="color: #999;">\n        <i class="icon-asterisk"/> In addition to clicking the "Upload" button, you may drag files to this window.\n    </h3>\n</div>\n<div class="modal-footer">\n    <a href="javascript:void(0)" class="cancel pull-left" data-dismiss="modal">Cancel</a>\n    <a href="javascript:void(0)" class="btn btn-success disabled remove-anchor-button">Remove Anchor</a>\n    <span class="btn btn-success fileinput-button">\n        <i class="icon-arrow-up icon-white"></i>\n        <span>Upload Image</span>\n        <input type="file" name="file" />\n    </span>\n    <a href="javascript:void(0)" class="btn disabled update-button" data-loading-text="Saving..." >Update</a>\n</div>\n</form>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

