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
      
        __out.push('<nav>\n    <div class="logo">\n        FPO Nav Header and Logo\n    </div>\n\n    <div class="announcements_link">\n    </div>\n\n    <div class="global_links">\n        <a class="create" href="javascript:void(0)">Create</a>\n    </div>\n\n    <div class="current_user">\n    </div>\n\n    <!--<div id="main-search">\n        <i class="icon-search"></i>\n        <input type="text" data-behavior="placeholder" placeholder="Search Things...">\n    </div>-->\n</nav>\n\n<div id="browser">\n    <div class="breadcrumbContainer"></div>\n    <div>\n        <div class="nav">\n            <h3>\n                Browse Hierarchy\n            </h3>\n            <div id="browser-tree"></div>\n\n            <div id="drafts" class="hide">\n                <h3>\n                    Drafts\n                </h3>\n                <div id="draft-list"></div>\n            </div>\n\n            <div class="header clearfix hide">\n                <select style="width: 150px;">\n                    <option>All Data</option>\n                    <!--<option>My Data</option>-->\n                </select>\n            </div>\n\n        </div>\n        <div class="contentContainer">\n            <div class="content"></div>\n        </div>\n    </div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

