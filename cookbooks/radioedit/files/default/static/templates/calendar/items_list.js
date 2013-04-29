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
        var index, item, _i, _len, _ref;
      
        __out.push('<h3><i class="icon-list-ol"></i> Schedules <i class="icon-caret-down"></i></h3>\n<ul>\n    <li class="grey">\n        <div class="item addSchedule">\n            <p class="scheduleRef"><input class="ghost" name="ref" placeholder="Ref" data-provide="typeahead" data-source="');
      
        __out.push(__sanitize(this.commonTags));
      
        __out.push('" /></p>\n            <div class="scheduleDate">\n                <input class="ghost date" name="date" placeholder="');
      
        __out.push(__sanitize(this.today));
      
        __out.push('" disabled />\n                <span class="calendarIcon"><i class="icon-calendar"></i></span>\n                @\n                <input class="ghost time" name="time" placeholder="00:00" />\n            </div>\n            <div class="buttons">\n                <div class="btn-group scheduleStatus disabled" data-toggle="buttons-radio">\n                    <button type="button" data-commit="');
      
        __out.push(__sanitize(this.commitId));
      
        __out.push('" class="active btn btn-mini">On</button>\n                    <button type="button" data-commit="null" class="btn btn-mini">Off</button>\n                </div>\n                <button class="btn add btn-mini btn-success"><i class="icon-plus-sign"></i> Add</button>\n            </div>\n        </div>\n    </li>\n    ');
      
        _ref = this.schedule;
        for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
          item = _ref[index];
          __out.push('\n        <li class="');
          __out.push(__sanitize(this.colors[item.ref]));
          __out.push('">\n            <div class="item editItem" data-index="');
          __out.push(__sanitize(index));
          __out.push('">\n                <p class="scheduleRef"><strong>');
          __out.push(__sanitize(item.ref));
          __out.push('</strong></p>\n                <span class="scheduleDate">');
          __out.push(__sanitize(this.moment(item.time).utc().format("MMM Do YYYY hh:mm A ZZ")));
          __out.push('</span>\n                <div class="buttons">\n                    <div class="btn-group scheduleStatus disabled" data-toggle="buttons-radio">\n                        <button type="button" data-commit="');
          __out.push(__sanitize(this.commitId));
          __out.push('" class="');
          if (item.commit != null) {
            __out.push('active');
          }
          __out.push(' btn btn-mini">On</button>\n                        <button type="button" data-commit="null" class="');
          if (item.commit == null) {
            __out.push('active');
          }
          __out.push(' btn btn-mini">Off</button>\n                    </div>\n                    <button class="btn delete btn-mini btn-danger"><i class="icon-remove-sign"></i> Delete</button>\n                </div>\n            </div>\n        </li>\n    ');
        }
      
        __out.push('\n</ul>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

