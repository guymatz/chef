// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Router;
    Backbone = require('backbone');
    Router = (function(_super) {

      __extends(Router, _super);

      function Router() {
        return Router.__super__.constructor.apply(this, arguments);
      }

      Router.prototype.previousRoute = '';

      Router.prototype.routes = {
        ':object/:commit': 'modify',
        ':object/:commit/:draft': 'draft',
        ':path.': 'browse',
        ':object': 'commits'
      };

      Router.prototype.initialize = function() {
        this.on('all', this.storeLastRoute);
        return this.global.on('browse', this.triggerNavigateList, this);
      };

      Router.prototype.storeLastRoute = function() {
        return this.previousRoute = Backbone.history.fragment;
      };

      Router.prototype.triggerNavigateList = function(path, node) {
        return Backbone.history.navigate(path, {
          trigger: true
        });
      };

      return Router;

    })(Backbone.Router);
    return new Router();
  });

}).call(this);