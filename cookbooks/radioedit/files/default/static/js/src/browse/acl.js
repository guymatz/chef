// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var $, AclCollection, AddPermissionView, AlertView, Backbone, BaseLayoutView, BaseModel, EditPermissionView, InheritedPermissionView, PermissionsView, PrincipalCollection, RelationalModel, ResourceModel, allowTemplate, denyTemplate, inheritedAclItemTemplate, permissionItemTemplate, permissionsTemplate, _, _ref;
    Backbone = require('backbone');
    _ = require('underscore');
    $ = require('jquery');
    RelationalModel = require('src/relational_model').RelationalModel;
    _ref = require('src/browse/base'), AlertView = _ref.AlertView, BaseModel = _ref.BaseModel;
    PrincipalCollection = require('src/browse/principal_collection').PrincipalCollection;
    permissionItemTemplate = require('eco/browse/acl/permission_item');
    inheritedAclItemTemplate = require('eco/browse/acl/inherited_acl_item');
    permissionsTemplate = require('eco/browse/acl/permissions');
    allowTemplate = require('eco/browse/acl/permission_icons/allow');
    denyTemplate = require('eco/browse/acl/permission_icons/deny');
    require('src/single_select_typeahead');
    require('backbone.layoutmanager');
    ResourceModel = (function(_super) {

      __extends(ResourceModel, _super);

      function ResourceModel() {
        return ResourceModel.__super__.constructor.apply(this, arguments);
      }

      ResourceModel.prototype.idAttribute = 'resource_id';

      ResourceModel.prototype.url = function() {
        return "" + window.API_PREFIX + "/" + this.id + "/acl";
      };

      ResourceModel.prototype.parse = function(resp, xhr) {
        if ((resp != null ? resp.length : void 0) > 0) {
          return {
            resource_id: resp[0],
            acl: resp[1]
          };
        } else {
          return resp;
        }
      };

      ResourceModel.prototype.getPermission = function(index) {
        if (index == null) {
          index = 0;
        }
        return _.clone(this.get('acl'))[index];
      };

      ResourceModel.prototype.getPermissions = function() {
        return _.clone(this.get('acl'));
      };

      ResourceModel.prototype.setPermission = function(permission) {
        var newLength, permissionsList;
        permissionsList = this.getPermissions();
        newLength = permissionsList.push(permission);
        if (this.set({
          acl: permissionsList
        }) !== false) {
          return this.trigger('permission.add', permission, newLength);
        }
      };

      ResourceModel.prototype.removePermission = function(index) {
        var permissionList, removed;
        if (index == null) {
          index = 0;
        }
        permissionList = this.getPermissions();
        removed = permissionList.splice(index, 1)[0];
        if (this.set({
          acl: permissionList
        }) !== false) {
          this.trigger('permission.remove', removed, index);
        }
        return removed;
      };

      ResourceModel.prototype.changePermission = function(index, permission) {
        var permissionsList;
        permissionsList = this.getPermissions();
        permissionsList[index] = permission;
        if (this.set({
          acl: permissionsList
        }) !== false) {
          return this.trigger('permission.change', permission, index);
        }
      };

      return ResourceModel;

    })(BaseModel);
    AclCollection = (function(_super) {

      __extends(AclCollection, _super);

      function AclCollection() {
        return AclCollection.__super__.constructor.apply(this, arguments);
      }

      AclCollection.prototype.model = ResourceModel;

      AclCollection.prototype.initialize = function(models, _arg) {
        this.resourceId = _arg.resourceId;
      };

      AclCollection.prototype.url = function() {
        return "" + window.API_PREFIX + "/" + this.resourceId + "/acl";
      };

      AclCollection.prototype.parse = function(resp, xhr) {
        return resp.acl;
      };

      return AclCollection;

    })(Backbone.Collection);
    BaseLayoutView = (function(_super) {

      __extends(BaseLayoutView, _super);

      function BaseLayoutView() {
        return BaseLayoutView.__super__.constructor.apply(this, arguments);
      }

      BaseLayoutView.prototype.fetch = function(path) {
        return path;
      };

      return BaseLayoutView;

    })(Backbone.LayoutView);
    PermissionsView = (function(_super) {

      __extends(PermissionsView, _super);

      function PermissionsView() {
        return PermissionsView.__super__.constructor.apply(this, arguments);
      }

      PermissionsView.prototype.template = permissionsTemplate;

      PermissionsView.prototype.initialize = function() {
        this.collection.on('reset', this.render, this);
        return this.alertView = new AlertView();
      };

      PermissionsView.prototype.beforeRender = function() {
        var index, permission, resource, resource_id, _i, _j, _len, _len1, _ref1, _ref2, _results;
        resource_id = this.collection.resourceId;
        this.currentResource = this.collection.where({
          resource_id: resource_id
        })[0] || new ResourceModel({
          resource_id: resource_id,
          acl: []
        });
        this.inheritedResources = this.collection.without(this.currentResource);
        this.insertView('.permissions', new AddPermissionView().on('add', this.addPermission, this));
        _ref1 = this.currentResource.get('acl');
        for (index = _i = 0, _len = _ref1.length; _i < _len; index = ++_i) {
          permission = _ref1[index];
          this.insertView('.permissions', new EditPermissionView({
            permission: permission,
            index: index
          }).on('removePermission', this.removePermission, this).on('changePermission', this.changePermission, this));
        }
        _ref2 = this.inheritedResources;
        _results = [];
        for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
          resource = _ref2[_j];
          _results.push((function() {
            var _k, _len2, _ref3, _results1;
            _ref3 = resource.get('acl');
            _results1 = [];
            for (_k = 0, _len2 = _ref3.length; _k < _len2; _k++) {
              permission = _ref3[_k];
              _results1.push(this.insertView('.inheritedPermissions', new InheritedPermissionView({
                resource_id: resource.id,
                permission: permission
              })));
            }
            return _results1;
          }).call(this));
        }
        return _results;
      };

      PermissionsView.prototype.afterRender = function() {
        return this.alertView.setElement(this.$('.status'));
      };

      PermissionsView.prototype.addPermission = function(permission) {
        var _this = this;
        this.currentResource.get('acl').push(permission);
        return this.currentResource.save(null, {
          wait: true,
          success: function() {
            var editPermissionView;
            editPermissionView = new EditPermissionView({
              permission: permission
            }).on('removePermission', _this.removePermission, _this).on('changePermission', _this.changePermission, _this);
            editPermissionView.$el.css({
              display: 'none'
            });
            _this.insertView('.permissions', editPermissionView).render();
            editPermissionView.$el.slideDown();
            _this.alertView.showAlert('success', 'Success', 'New permission added');
            return _this.getView().resetData();
          },
          error: function(model, jqXhr) {
            var error;
            _this.currentResource.get('acl').pop();
            _this.currentResource.errorHandler(_this.currentResource, jqXhr);
            error = _this.currentResource.errors.last();
            return _this.alertView.showAlert('error', error.get('status'), error.getExtendedMessage());
          }
        });
      };

      PermissionsView.prototype.removePermission = function(editPermissionView) {
        var oldPermission,
          _this = this;
        oldPermission = this.currentResource.get('acl').splice(editPermissionView.index, 1)[0];
        return this.currentResource.save(null, {
          wait: true,
          success: function() {
            editPermissionView.$el.slideUp().promise().done(function() {
              return editPermissionView.remove();
            });
            return _this.alertView.showAlert('success', 'Success', 'Permission removed');
          },
          error: function(model, jqXhr) {
            var error;
            _this.currentResource.get('acl').splice(editPermissionView.index, 0, oldPermission);
            _this.currentResource.errorHandler(_this.currentResource, jqXhr);
            error = _this.currentResource.errors.last();
            return _this.alertView.showAlert('error', error.get('status'), error.getExtendedMessage());
          }
        });
      };

      PermissionsView.prototype.changePermission = function(permission, index) {
        var oldPermission,
          _this = this;
        oldPermission = this.currentResource.get('acl').splice(index, 1, permission)[0];
        return this.currentResource.save(null, {
          wait: true,
          success: function() {
            return _this.alertView.showAlert('success', 'Success', 'Permission changed');
          },
          error: function() {
            var error;
            _this.currentResource.get('acl').splice(index, 1, oldPermission);
            _this.currentResource.errorHandler(_this.currentResource, jqXhr);
            error = _this.currentResource.errors.last();
            return _this.alertView.showAlert('error', error.get('status'), error.getExtendedMessage());
          }
        });
      };

      return PermissionsView;

    })(BaseLayoutView);
    AddPermissionView = (function(_super) {

      __extends(AddPermissionView, _super);

      function AddPermissionView() {
        return AddPermissionView.__super__.constructor.apply(this, arguments);
      }

      AddPermissionView.prototype.initialize = function() {
        return this.principalCollection = new PrincipalCollection();
      };

      AddPermissionView.prototype.permissionTemplates = {
        'true': allowTemplate,
        'false': denyTemplate
      };

      AddPermissionView.prototype.className = 'permissionItem';

      AddPermissionView.prototype.template = permissionItemTemplate;

      AddPermissionView.prototype.events = function() {
        return {
          'submit form': this.add,
          'click .permissionType i': this.switchPermission
        };
      };

      AddPermissionView.prototype.afterRender = function() {
        var _this = this;
        return this.$('.singleSelectTypeAhead').singleSelectTypeahead({
          source: function(query, process) {
            return _this.principalCollection.fetch({
              data: {
                q: query
              }
            }).done(function() {
              return process(_this.principalCollection.pluck('name'));
            });
          }
        });
      };

      AddPermissionView.prototype.serialize = function() {
        return {
          allow: true,
          permissionTemplates: this.permissionTemplates,
          type: 'add'
        };
      };

      AddPermissionView.prototype.add = function() {
        var data, principal;
        principal = this.$('.singleSelectTypeAhead span.badge').eq(0).text();
        if (principal === "") {
          return this.__manager__.parent.alertView.showAlert('error', 'Invalid', 'A valid principal must be chosen');
        } else {
          data = _.extend(this._gatherData(), {
            principal: principal
          });
          return this.trigger('add', data);
        }
      };

      AddPermissionView.prototype._gatherData = function() {
        var data;
        data = {};
        this.$('form input, form select').each(function() {
          var $this;
          $this = $(this);
          return data[$this.attr('name')] = $this.val();
        });
        return _.extend(data, {
          allow: this.$('.permissionType i').data('allow')
        });
      };

      AddPermissionView.prototype.resetData = function() {
        this.$('form')[0].reset();
        return this.switchPermission(true);
      };

      AddPermissionView.prototype.switchPermission = function(allowed) {
        if (!_.isBoolean(allowed)) {
          allowed = !this.$('.permissionType i').data('allow');
        }
        return this.$('.permissionType').html(this.permissionTemplates[allowed.toString()]);
      };

      return AddPermissionView;

    })(BaseLayoutView);
    EditPermissionView = (function(_super) {

      __extends(EditPermissionView, _super);

      function EditPermissionView() {
        return EditPermissionView.__super__.constructor.apply(this, arguments);
      }

      EditPermissionView.prototype.className = 'permissionItem edit';

      EditPermissionView.prototype.initialize = function(_arg) {
        this.permission = _arg.permission, this.index = _arg.index;
      };

      EditPermissionView.prototype.events = function() {
        return _.extend(EditPermissionView.__super__.events.call(this), {
          'submit form': this.removePermission,
          'change #permission': this.changePermission
        });
      };

      EditPermissionView.prototype.serialize = function() {
        return _.extend(EditPermissionView.__super__.serialize.call(this), _.clone(this.permission), {
          type: 'edit'
        });
      };

      EditPermissionView.prototype.removePermission = function() {
        return this.trigger('removePermission', this);
      };

      EditPermissionView.prototype.changePermission = function() {
        return this.trigger('changePermission', this._gatherData(), this.index);
      };

      EditPermissionView.prototype.switchPermission = function() {
        EditPermissionView.__super__.switchPermission.call(this);
        return this.changePermission();
      };

      return EditPermissionView;

    })(AddPermissionView);
    InheritedPermissionView = (function(_super) {

      __extends(InheritedPermissionView, _super);

      function InheritedPermissionView() {
        return InheritedPermissionView.__super__.constructor.apply(this, arguments);
      }

      InheritedPermissionView.prototype.className = 'inheritedPermissionItem';

      InheritedPermissionView.prototype.template = inheritedAclItemTemplate;

      InheritedPermissionView.prototype.initialize = function(_arg) {
        this.resource_id = _arg.resource_id, this.permission = _arg.permission;
      };

      InheritedPermissionView.prototype.serialize = function() {
        return _.extend({
          resource_id: this.resource_id
        }, _.clone(this.permission));
      };

      return InheritedPermissionView;

    })(BaseLayoutView);
    return {
      AclCollection: AclCollection,
      ResourceModel: ResourceModel,
      PermissionsView: PermissionsView
    };
  });

}).call(this);