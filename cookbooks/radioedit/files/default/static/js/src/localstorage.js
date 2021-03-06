// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, LocalCollection, LocalModel, LocalStorage, S4, getValue, storage, uuid, _;
    Backbone = require('backbone');
    _ = require('underscore');
    storage = window.localStorage;
    S4 = function() {
      return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    };
    uuid = function() {
      return S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4();
    };
    getValue = function(object, prop) {
      if (!(object && object[prop])) {
        return null;
      }
      if (_.isFunction(object[prop])) {
        return object[prop]();
      } else {
        return object[prop];
      }
    };
    window.addEventListener('storage', function() {
      return drafts.fetch();
    });
    LocalStorage = (function() {

      function LocalStorage() {}

      LocalStorage.prototype.read = function(url, model) {
        var i, key, response, value, _i, _ref;
        value = storage.getItem(url);
        if (value != null) {
          return JSON.parse(value);
        }
        response = [];
        if (storage.length > 0) {
          for (i = _i = 0, _ref = storage.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
            key = storage.key(i);
            if (key.slice(0, url.length) === url) {
              response.push(JSON.parse(storage.getItem(key)));
            }
          }
        }
        return response;
      };

      LocalStorage.prototype.update = function(url, model) {
        return storage.setItem(url, JSON.stringify(model.toJSON()));
      };

      LocalStorage.prototype.create = function(url, model) {
        if (!(model.id != null)) {
          model.id = uuid();
          model.set(model.idAttribute, model.id);
          url = model.url();
        }
        return storage.setItem(url, JSON.stringify(model.toJSON()));
      };

      LocalStorage.prototype["delete"] = function(url, model) {
        return storage.removeItem(url);
      };

      LocalStorage.prototype.sync = function(method, model, options, error) {
        var resp, store, url;
        store = new LocalStorage();
        if (options.url != null) {
          url = options.url;
        } else {
          url = getValue(model, 'url');
          if (!url) {
            throw new Error('You need a URL');
          }
        }
        resp = store[method].call(store, url, model);
        if (resp) {
          return options.success(resp, 200, null);
        } else {
          return options.error("Local Record Not Found");
        }
      };

      return LocalStorage;

    })();
    LocalModel = (function(_super) {

      __extends(LocalModel, _super);

      function LocalModel() {
        return LocalModel.__super__.constructor.apply(this, arguments);
      }

      LocalModel.prototype.sync = LocalStorage.prototype.sync;

      return LocalModel;

    })(Backbone.Model);
    LocalCollection = (function(_super) {

      __extends(LocalCollection, _super);

      function LocalCollection() {
        return LocalCollection.__super__.constructor.apply(this, arguments);
      }

      LocalCollection.prototype.sync = LocalStorage.prototype.sync;

      return LocalCollection;

    })(Backbone.Collection);
    return {
      LocalStorage: LocalStorage,
      LocalModel: LocalModel,
      LocalCollection: LocalCollection
    };
  });

}).call(this);
