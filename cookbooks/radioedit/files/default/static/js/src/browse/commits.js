// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var $, Backbone, CollapsibleRowView, CommitsView, RowView, ToggleView, commitsTemplate, rowTemplate, toggleTemplate, _;
    require('backbone.layoutmanager');
    Backbone = require('backbone');
    $ = require('jquery');
    _ = require('underscore');
    commitsTemplate = require('eco/browse/commits');
    rowTemplate = require('eco/browse/row');
    toggleTemplate = require('eco/browse/toggle');
    ToggleView = (function(_super) {

      __extends(ToggleView, _super);

      function ToggleView() {
        return ToggleView.__super__.constructor.apply(this, arguments);
      }

      ToggleView.prototype.template = toggleTemplate;

      ToggleView.prototype.events = {
        'change #toggleRows': 'changeToggle'
      };

      ToggleView.prototype.fetch = function(path) {
        return path;
      };

      ToggleView.prototype.changeToggle = function(event) {
        var $target;
        $target = $(event.target);
        return this.global.trigger("toggle:" + this.__manager__.parent.cid, {
          show: $target.filter(':checked').length === 1
        });
      };

      return ToggleView;

    })(Backbone.LayoutView);
    CommitsView = (function(_super) {

      __extends(CommitsView, _super);

      function CommitsView() {
        return CommitsView.__super__.constructor.apply(this, arguments);
      }

      CommitsView.prototype.className = 'browse-content';

      CommitsView.prototype.initialize = function() {
        if (this.collection == null) {
          throw new Error('A collection is required for CommitsView');
        }
        this.collection.on('reset', this.render, this).refsFetch();
        return this.setView('.displayControlContainer', new ToggleView());
      };

      CommitsView.prototype.template = commitsTemplate;

      CommitsView.prototype.fetch = function(path) {
        return path;
      };

      CommitsView.prototype.beforeRender = function() {
        var _this = this;
        return this.collection.each(function(model, index) {
          var arg, data, rowClass, _i, _len, _ref, _results;
          arg = {
            resourceId: model.get('commit').resource_id,
            isHead: index === 0
          };
          if (model.refs().length) {
            _ref = model.refs();
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              data = _ref[_i];
              _results.push(_this.insertView('.body', new RowView(_.extend(arg, {
                data: data
              }))));
            }
            return _results;
          } else {
            data = {
              commit: model.commitId(),
              publisher: model.author()._id,
              timestamp: model.get('commit').ctime
            };
            rowClass = arg.isHead ? RowView : CollapsibleRowView;
            return _this.insertView('.body', new rowClass(_.extend(arg, {
              data: data
            })));
          }
        });
      };

      return CommitsView;

    })(Backbone.LayoutView);
    RowView = (function(_super) {

      __extends(RowView, _super);

      function RowView() {
        return RowView.__super__.constructor.apply(this, arguments);
      }

      RowView.prototype.template = rowTemplate;

      RowView.prototype.attributes = function() {
        return {
          "class": 'row'
        };
      };

      RowView.prototype.events = {
        'click': 'rowClicked'
      };

      RowView.prototype.initialize = function() {
        var _ref;
        return _ref = this.options, this.data = _ref.data, this.resourceId = _ref.resourceId, this.isHead = _ref.isHead, _ref;
      };

      RowView.prototype.rowClicked = function() {
        return Backbone.history.navigate("" + this.resourceId + "/" + this.data.commit, true);
      };

      RowView.prototype.fetch = function(path) {
        return path;
      };

      RowView.prototype.serialize = function() {
        return _.extend(this.data, {
          isHead: this.isHead
        });
      };

      return RowView;

    })(Backbone.LayoutView);
    CollapsibleRowView = (function(_super) {

      __extends(CollapsibleRowView, _super);

      function CollapsibleRowView() {
        return CollapsibleRowView.__super__.constructor.apply(this, arguments);
      }

      CollapsibleRowView.prototype.collapsedClass = 'collapsed';

      CollapsibleRowView.prototype.wasRendered = false;

      CollapsibleRowView.prototype.attributes = function() {
        var attrs;
        attrs = CollapsibleRowView.__super__.attributes.call(this);
        attrs["class"] || (attrs["class"] = '');
        attrs["class"] += ' collapsible';
        return attrs;
      };

      CollapsibleRowView.prototype.beforeRender = function() {
        if ((this.__manager__.parent != null) && !this.wasRendered) {
          return this.global.on("toggle:" + this.__manager__.parent.cid, this.toggleState, this);
        }
      };

      CollapsibleRowView.prototype.rowClicked = function() {
        if (this.$el.hasClass(this.collapsedClass)) {
          return this.toggleState({
            show: true
          });
        } else {
          return CollapsibleRowView.__super__.rowClicked.call(this);
        }
      };

      CollapsibleRowView.prototype.toggleState = function(_arg) {
        var show;
        show = _arg.show;
        if (show) {
          return this.expand();
        } else {
          return this.collapse();
        }
      };

      CollapsibleRowView.prototype.afterRender = function() {
        var wasRendered;
        return wasRendered = true;
      };

      CollapsibleRowView.prototype.expand = function() {
        return this.$el.removeClass(this.collapsedClass);
      };

      CollapsibleRowView.prototype.collapse = function() {
        return this.$el.addClass(this.collapsedClass);
      };

      CollapsibleRowView.prototype.cleanup = function() {
        return this.global.off(null, null, this);
      };

      return CollapsibleRowView;

    })(RowView);
    return {
      CommitsView: CommitsView,
      RowView: RowView,
      CollapsibleRowView: CollapsibleRowView,
      ToggleView: ToggleView
    };
  });

}).call(this);
