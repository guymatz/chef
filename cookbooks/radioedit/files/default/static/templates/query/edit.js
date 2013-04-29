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
      
        __out.push('/query/');
      
        __out.push(__sanitize(this.id));
      
        __out.push('" target="_blank">\n        <i data-tip="Copy this link to your Clipboard" class="icon-external-link"/>\n        ');
      
        __out.push(__sanitize(window.API_PREFIX));
      
        __out.push('/query/<span>');
      
        __out.push(__sanitize(this.id));
      
        __out.push('</span>\n    </a>\n</p>\n\n<hr/>\n\n<h3><i class="icon-filter" /> Map Resources</h3>\n<p class="help-block">\n    Select the resources that will be sent to your filter function. This allows you to select a single resource, many\n    resources or any valid glob/search string.\n</p>\n<div class="select">\n    <div class="entry form-inline section">\n        <input id="select-input" class="input-xlarge" placeholder="Query String"/>\n        <a class="btn" id="add-button"><i class="icon-plus"/> Add</a>\n    </div>\n\n    <div class="section">\n        <label>Resource Selection Preview</label>\n        <p class="help-block">\n            This is a preview of what will be sent to your reduce query. <strong>Folders will be excluded automatically.</strong>\n        </p>\n        <ul class="listing"></ul>\n    </div>\n\n    <div class="section">\n        <label>Resources</label>\n        <p class="help-block">\n            These resources will be sent to your filter query in the order in which they appear. You may sort them\n            to adjust the priority.\n        </p>\n        <ul class="current">\n            <li class="empty">No Resources Selected</li>\n        </ul>\n    </div>\n</div>\n\n<hr/>\n\n<h3><i class="icon-cogs" /> Reduce Query</h3>\n<p class="help-block">\n    Write a query to process the above selected resources.\n</p>\n<div class="query section">\n    <div id="query-editor" class="editor"></div>\n    <p>Custom Headers (not saved, for Test Query only)</p>\n    <div id="header-editor" class="editor"></div>\n    <a class="btn" id="test-button"><i class="icon-beaker"/> Test Query</a>\n');
      
        if (0) {
          __out.push('\n    <img src="/static/img/spinner.gif" alt="Loading..." />\n    <a class="btn btn-error disabled" id="test-button"><i class="icon-remove"/> Cancel</a>\n');
        }
      
        __out.push('\n</div>\n\n<hr/>\n\n<h3><i class="icon-rss" /> Result</h3>\n<p class="help-block">\n    The resulting JSON response from the API\n</p>\n<div class="results">\n    <li class="empty">No Results</li>\n</div>\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  } 
});

