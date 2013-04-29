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
      
        __out.push('<div class="modal-header">\n    <a class="close" data-dismiss="modal">×</a>\n    <h3>Attach Artist or Track Object</h3>\n</div>\n<div class="modal-body">\n<ul class="nav nav-tabs">\n    <li class="active">\n        <a href="javascript:void(0)" data-target="#search" data-toggle="tab">Search</a>\n    </li>\n    <li>\n        <a href="javascript:void(0)" data-target="#genre" data-toggle="tab">Genre & Mood</a>\n    </li>\n</ul>\n\n<div class="tab-content">\n    <div class="tab-pane active" id="search">\n\n        <div class="control-group">\n            <label class="control-label" for="attachSearch">Search</label>\n            <div class="controls">\n                <input type="text" name="attachSearch" id="attachSearch">\n                <p class="help-block">Search for artist or track to attach.</p>\n            </div>\n        </div>\n        <div class="control-group">\n            <div class="controls form-inline">\n                <label for="artist">\n                    <input type="checkbox" name="artist" id="artist" checked="checked" value="1"> Artist\n                </label>\n                <label for="track">\n                    <input type="checkbox" name="track" id="track" checked="checked" value="1"> Track\n                </label>\n                <label for="featured">\n                    <input type="checkbox" name="featured" id="featured" checked="checked" value="1"> Featured Station\n                </label>\n                <label for="station">\n                    <input type="checkbox" name="station" id="station" checked="checked" value="1"> Station\n                </label>\n            </div>\n        </div>\n\n    </div>\n    <div class="tab-pane" id="genre">\n\n        <div class="control-group">\n            <label class="control-label" for="filter">Filter</label>\n            <div class="controls">\n                <input type="text" name="filter" id="filter">\n                <p class="help-block">Filter Genre and Mood list.</p>\n            </div>\n        </div>\n\n    </div>\n\n    <div style="text-align: center; padding: 10px;" class="hide thinking">\n        <img src="/static/img/spinner.gif" alt="Loading..."/>\n    </div>\n\n    <div id="attach-results">\n    </div>\n\n</div>\n\n</div>\n<div class="modal-footer">\n    <div class="btn-toolbar">\n        <a class="cancel pull-left" data-dismiss="modal">Cancel</a>\n        <!--<a class="btn btn-primary" id="publishModalSubmit">Attach</a>-->\n    </div>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

