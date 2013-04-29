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
        var day, time, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _ref3;
      
        __out.push('<h3><i class="icon-picture" /> Activity Icon</h3>\n<p class="help-block">\n    Choose an icon to display for the activity.\n</p>\n<div class="activityicon form-inline"></div>\n<a class="btn" href="javascript:void(0)" id="add-icon">Add Icon</a>\n\n<hr/>\n\n<!-- Time Slot Availability Section -->\n<h3><i class="icon-time"></i> Time Slot Availability</h3>\n<table class="time-slots">\n  <thead>\n    <tr>\n      <th></th>\n      ');
      
        _ref = this.allDays;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          day = _ref[_i];
          __out.push('\n        <th>');
          __out.push(this.slugToTitle(day));
          __out.push('</th>\n      ');
        }
      
        __out.push('\n    </tr>\n  </thead>\n\n  <tbody>\n\n    ');
      
        _ref1 = this.allTimes;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          time = _ref1[_j];
          __out.push('\n      <tr>\n        <td class="time">');
          __out.push(this.slugToTitle(time));
          __out.push('</td>\n        ');
          _ref2 = this.allDays;
          for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
            day = _ref2[_k];
            __out.push('\n          <td>\n            <input type="checkbox"\n              data-day="');
            __out.push(day);
            __out.push('"\n              data-time="');
            __out.push(time);
            __out.push('"\n              ');
            if ((_ref3 = this.availability) != null ? _ref3[day][time] : void 0) {
              __out.push('checked');
            }
            __out.push('>\n          </td>\n        ');
          }
          __out.push('\n      </tr>\n    ');
        }
      
        __out.push('\n  </tbody>\n</table>\n\n\n<hr/>\n\n\n<div class="btn-toolbar clearfix">\n    <div class="btn-group">\n        <a class="btn" href="javascript:void(0)" id="new-slide"><i class="icon-plus"></i> Add Playlist</a>\n    </div>\n    <div class="btn-group collapser">\n        <a class="btn active" href="javascript:void(0)" id="expand-slides">Expand Playlists</a>\n        <a class="btn" href="javascript:void(0)" id="collapse-slides">Collapse Playlists</a>\n    </div>\n</div>\n\n<hr/>\n\n<h3><i class="icon-list-ol" /> Play Lists (<span id="item-count">0</span>) <i class="icon-caret-down" /></h3>\n<p class="help-block">\n    Specify slides for the client to show. Each item in this list represents a single slide.\n</p>\n\n<div class="list-container"></div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

