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
        var field, param, params, schema, _i, _j, _len, _len1, _ref, _ref1, _ref2, _ref3, _ref4;
      
        __out.push('<div class="toggle-method">\n    <span class="synopsis pull-right">');
      
        __out.push(this.method.description.short);
      
        __out.push('</span>\n    <h3>');
      
        __out.push(__sanitize(this.method.verb));
      
        __out.push('</h3>\n</div>\n<div class="implementation hide">\n    ');
      
        if (this.method.description.long) {
          __out.push('\n        ');
          __out.push(this.method.description.long);
          __out.push('\n    ');
        }
      
        __out.push('\n\n    <div class="impdetail response">\n        <h4><i class="icon-caret-down"/> Successful Response Structure</h4>\n        ');
      
        if (this.method.contracts.response != null) {
          __out.push('\n            <div></div>\n        ');
        } else {
          __out.push('\n            ');
          if ((_ref = this.method.verb) === 'put' || _ref === 'post') {
            __out.push('\n            <p>The response is most likely a location header to the new resource.</p>\n            ');
          }
          __out.push('\n        ');
        }
      
        __out.push('\n    </div>\n\n    ');
      
        if ((_ref1 = this.method.verb) === 'put' || _ref1 === 'post') {
          __out.push('\n    <div class="impdetail request">\n        <h4><i class="icon-caret-down"/> Expected Request Structure</h4>\n        ');
          if (this.method.contracts.request != null) {
            __out.push('\n            <div></div>\n        ');
          } else {
            __out.push('\n            <p><strong>The request is not well defined for this method.</strong></p>\n        ');
          }
          __out.push('\n    </div>\n    ');
        }
      
        __out.push('\n\n    ');
      
        if (this.method.contracts.querystring != null) {
          __out.push('\n    ');
          schema = this.method.contracts.querystring;
          __out.push('\n    <div class="impdetail querystring collapsed">\n        <h4><i class="icon-caret-right"/> Querystring Inputs</h4>\n        <div>\n        <table class="table">\n            <thead>\n                <tr>\n                    <th>Name</th>\n                    <th>Value</th>\n                    <th>Required</th>\n                    <th>Type</th>\n                    <th>Description</th>\n                </tr>\n            </thead>\n            <tbody>\n            ');
          _ref2 = schema.children;
          for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
            field = _ref2[_i];
            __out.push('\n                <tr>\n                    <td>');
            __out.push(__sanitize(field.name));
            __out.push('</td>\n                    <td><input type="text" name="');
            __out.push(__sanitize(field.name));
            __out.push('" placeholder="');
            __out.push(__sanitize(field["default"]));
            __out.push('"></td>\n                    <td>');
            __out.push(__sanitize(field.required));
            __out.push('</td>\n                    <td>');
            __out.push(__sanitize(field.type));
            __out.push('</td>\n                    <td>');
            __out.push(__sanitize(field.description));
            __out.push('</td>\n                </tr>\n            ');
          }
          __out.push('\n            </tbody>\n        </table>\n        </div>\n    </div>\n    ');
        }
      
        __out.push('\n\n    ');
      
        if (this.endpoint.params.length > 0) {
          __out.push('\n    ');
          params = this.endpoint.params;
          __out.push('\n    <div class="impdetail params">\n        <h4><i class="icon-caret-down"/> URL Variables</h4>\n        <div>\n        <table class="table">\n            <thead>\n                <tr>\n                    <th>Name</th>\n                    <th>Value</th>\n                    <th>Pattern</th>\n                    <th>Description</th>\n                </tr>\n            </thead>\n            <tbody>\n            ');
          _ref3 = (function() {
            var _k, _len1, _results;
            _results = [];
            for (_k = 0, _len1 = params.length; _k < _len1; _k++) {
              param = params[_k];
              if (param.variable === true) {
                _results.push(param);
              }
            }
            return _results;
          })();
          for (_j = 0, _len1 = _ref3.length; _j < _len1; _j++) {
            param = _ref3[_j];
            __out.push('\n                <tr>\n                    <td>');
            __out.push(__sanitize(param.name));
            __out.push('</td>\n                    <td><input type="text" class="input-xxlarge" name="');
            __out.push(__sanitize(param.name));
            __out.push('"/></td>\n                    <td>');
            __out.push(__sanitize(param.pattern));
            __out.push('</td>\n                    <td>');
            __out.push(__sanitize(param.description));
            __out.push('</td>\n                </tr>\n            ');
          }
          __out.push('\n            </tbody>\n        </table>\n        </div>\n    </div>\n    ');
        }
      
        __out.push('\n\n    ');
      
        if ((_ref4 = this.method.verb) === 'get') {
          __out.push('\n        <button class="btn tryit" type="submit">Try It!</button>\n    ');
        }
      
        __out.push('\n\n    <div class="results hide ajax-output">\n        <h4>URL & Code</h4>\n        <code class="url"></code>\n\n        <h4>Headers</h4>\n        <code class="headers"></code>\n\n        <h4>Body</h4>\n        <div class="body jsonview"></div>\n    </div>\n\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

