// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var SEPARATOR, TargetsHierarchyCollection, TreeNode, models, _;
    models = require('src/models');
    _ = require('underscore');
    SEPARATOR = '.';
    TreeNode = (function() {

      TreeNode.prototype.data = {};

      TreeNode.prototype.value = null;

      TreeNode.prototype.parentNode = null;

      function TreeNode(parentNode, value, data) {
        if (parentNode == null) {
          parentNode = null;
        }
        if (value == null) {
          value = null;
        }
        if (data == null) {
          data = {};
        }
        this.data = data;
        this.value = value;
        this.parentNode = parentNode;
      }

      TreeNode.prototype.getParentValue = function() {
        var _ref;
        return (_ref = this.parentNode) != null ? _ref.value : void 0;
      };

      TreeNode.prototype.getFullPath = function() {
        var path, pointer;
        pointer = this;
        path = '';
        while (pointer.value != null) {
          path = "" + pointer.value + path;
          pointer = pointer.parentNode;
        }
        return path;
      };

      TreeNode.prototype.filter = function(regExp) {
        var clonedTreeNode,
          _this = this;
        clonedTreeNode = _.clone(this);
        clonedTreeNode.data = _(clonedTreeNode.data).filter(function(value, key) {
          return regExp.test(key);
        });
        return clonedTreeNode;
      };

      TreeNode.prototype.isLeaf = function() {
        return (this.value != null) && this.value.lastIndexOf(SEPARATOR) === -1;
      };

      TreeNode.prototype.getSubTree = function(path) {
        var endsInPeriod, index, isLastPart, newTree, part, regexp, subTree, treeParts, _i, _len;
        treeParts = path.split(SEPARATOR);
        endsInPeriod = _.isEmpty(treeParts[treeParts.length - 1]);
        subTree = this;
        if (endsInPeriod) {
          treeParts.pop();
        }
        for (index = _i = 0, _len = treeParts.length; _i < _len; index = ++_i) {
          part = treeParts[index];
          isLastPart = index === treeParts.length - 1;
          if ((isLastPart && endsInPeriod) || !isLastPart) {
            part += SEPARATOR;
          }
          newTree = subTree.data[part];
          if (isLastPart && _.isUndefined(newTree)) {
            regexp = (function() {
              try {
                return new RegExp("^" + part);
              } catch (e) {
                return new RegExp("^$");
              }
            })();
            subTree = subTree.filter(regexp);
          } else {
            subTree = newTree;
          }
        }
        return subTree;
      };

      return TreeNode;

    })();
    return TargetsHierarchyCollection = (function(_super) {

      __extends(TargetsHierarchyCollection, _super);

      function TargetsHierarchyCollection() {
        return TargetsHierarchyCollection.__super__.constructor.apply(this, arguments);
      }

      TargetsHierarchyCollection.prototype.tree = null;

      TargetsHierarchyCollection.prototype.initialize = function(models, options) {
        this.tree = new TreeNode();
        options = _.extend(options || {}, {
          "public": true,
          sort: 'name',
          limit: 0
        });
        TargetsHierarchyCollection.__super__.initialize.call(this, models, options);
      };

      TargetsHierarchyCollection.prototype.fetch = function(options) {
        var _this = this;
        return TargetsHierarchyCollection.__super__.fetch.call(this, options).done(function() {
          return _this.parseTree();
        });
      };

      TargetsHierarchyCollection.prototype.parseTree = function() {
        var namesList,
          _this = this;
        namesList = _.chain(this.models).pluck('attributes').pluck('name').value();
        _(namesList).each(function(entry) {
          var entryParts, nameSpace, part, pointer, target, _i, _len;
          entryParts = entry.split(SEPARATOR);
          target = entryParts.pop();
          pointer = _this.tree;
          for (_i = 0, _len = entryParts.length; _i < _len; _i++) {
            part = entryParts[_i];
            nameSpace = "" + part + ".";
            if (_.isUndefined(pointer.data[nameSpace])) {
              pointer.data[nameSpace] = new TreeNode(pointer, nameSpace);
            }
            pointer = pointer.data[nameSpace];
          }
          return pointer.data[target] = new TreeNode(pointer, target);
        });
      };

      return TargetsHierarchyCollection;

    })(models.TargetCollection);
  });

}).call(this);
