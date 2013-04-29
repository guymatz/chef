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
      
        __out.push('<h3><i class="icon-cloud" /> API Access URI</h3>\n<p class="api-name">\n    <a href="');
      
        __out.push(__sanitize(window.API_PREFIX));
      
        __out.push('/datasource/');
      
        __out.push(__sanitize(this.id));
      
        __out.push('" target="_blank">\n        <i data-tip="Copy this link to your Clipboard" class="icon-external-link"/>\n        ');
      
        __out.push(__sanitize(window.API_PREFIX));
      
        __out.push('/datasource/<span>');
      
        __out.push(__sanitize(this.id));
      
        __out.push('</span>\n    </a>\n</p>\n\n<hr/>\n\n<h3><i class="icon-globe" /> External Datasource</h3>\n<p class="help-block">\n    Choose the data source that contains the data which you are interested in. That is the data source that the query\n    will execute on.\n</p>\n<div class="select">\n    <div class="entry form-inline section">\n        <select name="datasource" id="datasource" class="input-xxlarge">\n            <option value="">-- None --</option>\n            <optgroup label="SQL"></optgroup>\n            <optgroup label="MongoDB"></optgroup>\n        </select>\n    </div>\n</div>\n\n<hr/>\n\n<h3><i class="icon-cogs" /> Selection Query</h3>\n<p class="help-block">\n    Write a query to retrieve the data that you are looking for.\n</p>\n<div class="query section">\n    <div class="editor"></div>\n    <div class="form-inline section">\n        <label>Query String: </label>\n        <input id="default_querystring" name="default_querystring" class="input-xlarge" placeholder="a=b&c=d"/>\n        <p class="help-block">\n            If you have parameterized your query with (e.g. "WHERE name = :name") then you must supply the variables for\n            the test query as you would the actual API.\n        </p>\n    </div>\n    <div class="form-inline section">\n        <label>Default Row Limit: </label>\n        <input id="default_limit" name="default_limit" class="input-xlarge" placeholder="50" />\n        <p class="help-block">\n            Enter the default number of maximum rows that would be available if no override is provided in the querystring.\n        </p>\n    </div>\n    <a class="btn" id="test-button"><i class="icon-beaker"/> Preview Query</a>\n</div>\n\n<hr/>\n\n<h3><i class="icon-rss" /> Result</h3>\n<p class="help-block">\n    The resulting JSON response from the API\n</p>\n<div class="results">\n    <li class="empty">No Results</li>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

