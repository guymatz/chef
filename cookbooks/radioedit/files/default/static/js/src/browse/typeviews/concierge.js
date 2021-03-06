// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; },
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var $, AttachmentEditDialog, AttachmentsView, Backbone, CON, ConciergeView, IconView, IconsView, PlaylistView, PlaylistsView, Tag, TagField, ToggleField, attachTemplate, crop, editTemplate, iconTemplate, mapper, playlistTemplate, populateFormFields, tagFieldTemplate, tagTemplate;
    CON = require('src/const');
    Backbone = require('backbone');
    $ = require('jquery');
    mapper = require('src/browse/mapper').mapper;
    crop = require('src/crop');
    ToggleField = require('src/toggle_field').ToggleField;
    AttachmentEditDialog = require('src/browse/attachment-edit');
    require('backbone.layoutmanager');
    require('src/single_select_typeahead');
    editTemplate = require('eco/concierge/edit');
    playlistTemplate = require('eco/concierge/playlist');
    iconTemplate = require('eco/concierge/icon');
    attachTemplate = require('eco/featured/attachment');
    tagFieldTemplate = require('eco/concierge/tag_field');
    tagTemplate = require('eco/concierge/tag');
    populateFormFields = function(model, element, stopOn) {
      var inputs, k, v, _ref, _results;
      _ref = model.attributes;
      _results = [];
      for (k in _ref) {
        if (!__hasProp.call(_ref, k)) continue;
        v = _ref[k];
        inputs = $('input,select,textarea,i.button-icon', element).filter("[name=" + k + "],[data-name=" + k + "]");
        if (inputs.is(':checkbox')) {
          _results.push(inputs.each(function() {
            var input, _ref1;
            input = $(this);
            if (_ref1 = input.val(), __indexOf.call(v, _ref1) >= 0) {
              return input.attr('checked', 'checked');
            } else {
              return input.removeAttr('checked');
            }
          }));
        } else if (inputs.is(':text')) {
          _results.push(inputs.each(function() {
            return $(this).val(v);
          }));
        } else if (inputs.is('i.button-icon')) {
          _results.push(inputs.each(function() {
            return $(this).toggleClass('active', v);
          }));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };
    Backbone.LayoutManager.configure({
      fetch: function(path) {
        return path;
      }
    });
    AttachmentsView = (function(_super) {

      __extends(AttachmentsView, _super);

      function AttachmentsView() {
        return AttachmentsView.__super__.constructor.apply(this, arguments);
      }

      AttachmentsView.prototype.template = attachTemplate;

      AttachmentsView.prototype.className = 'mform';

      AttachmentsView.prototype.events = {
        'click a.remove': 'removeStation',
        "click": "click",
        'sortupdate': 'sortupdate'
      };

      AttachmentsView.prototype._modelForElement = function(element) {
        var cid;
        cid = $(element).closest('li[data-index]').data('index');
        return this.collection.getByCid(cid);
      };

      AttachmentsView.prototype.initialize = function(options) {
        return this.collection.on("add remove change", this.render, this);
      };

      AttachmentsView.prototype.removeStation = function(e) {
        e.stopPropagation();
        return this.collection.remove(this._modelForElement(e.target));
      };

      AttachmentsView.prototype.click = function(e) {
        var dialog, model;
        model = this._modelForElement(e.target);
        dialog = new AttachmentEditDialog({
          model: model
        });
        return dialog.show();
      };

      AttachmentsView.prototype.serialize = function() {
        return {
          attachments: this.collection.models
        };
      };

      AttachmentsView.prototype.sortupdate = function(event, ui) {
        var cid, newArray, newOrder, _i, _len;
        event.stopPropagation();
        newOrder = this.$el.find('li[data-index]').map(function() {
          return $(this).data('index');
        });
        newArray = [];
        for (_i = 0, _len = newOrder.length; _i < _len; _i++) {
          cid = newOrder[_i];
          newArray.push(this.collection.getByCid(cid));
        }
        return this.collection.reset(newArray);
      };

      AttachmentsView.prototype.afterRender = function() {
        return this.$('.ui-sortable').sortable('destroy').sortable({
          axis: 'y',
          handle: '.button-icon.reorder',
          containment: '.ui-sortable'
        });
      };

      return AttachmentsView;

    })(Backbone.LayoutView);
    PlaylistView = (function(_super) {

      __extends(PlaylistView, _super);

      function PlaylistView() {
        return PlaylistView.__super__.constructor.apply(this, arguments);
      }

      PlaylistView.prototype.template = playlistTemplate;

      PlaylistView.prototype.tagName = 'li';

      PlaylistView.prototype.className = "mform";

      PlaylistView.prototype.events = {
        'click a.attach': 'attach',
        'click i.button-icon[data-type=checkbox]': 'iconCheck',
        'click i.button-icon.icon-trash': 'delete',
        'click .button-icon.icon-copy': 'copy',
        'input input[type=text]': 'update'
      };

      PlaylistView.prototype.initialize = function() {
        var _this = this;
        this.stations = new Backbone.Collection(this.model.get('stations'), {
          model: Backbone.Model.extend({
            idAttribute: 'link'
          })
        });
        return this.stations.on('change add remove reset', function() {
          return _this.model.set('stations', _this.stations.toJSON());
        });
      };

      PlaylistView.prototype.update = function(e) {
        var $el, name;
        $el = $(e.target);
        name = $el.attr('name');
        if (name == null) {
          return;
        }
        e.stopPropagation();
        return this.model.set(name, $el.val());
      };

      PlaylistView.prototype["delete"] = function(e) {
        $('[data-tip]').tooltip('hide');
        return this.model.collection.remove(this.model);
      };

      PlaylistView.prototype.copy = function(e) {
        return this.trigger('copy', this.model);
      };

      PlaylistView.prototype.iconCheck = function(e) {
        var el;
        e.stopPropagation();
        el = $(e.target).toggleClass('active');
        return this.model.set(el.data('name'), el.hasClass('active'));
      };

      PlaylistView.prototype.attach = function(e) {
        var _this = this;
        return this.global.trigger(CON.EVENT_CATALOG, function(catalogItem, links) {
          var item;
          item = {
            id: catalogItem.get('id'),
            kind: catalogItem.get('kind'),
            name: catalogItem.get('name'),
            img: catalogItem.get('img'),
            link_text: "Play " + (catalogItem.get('name')),
            description: catalogItem.get('description')
          };
          _this.views['.attachments'].collection.add([
            _.extend({}, item, {
              "for": 'web',
              link: links[0]
            }), _.extend({}, item, {
              "for": 'device',
              link: links[1]
            })
          ]);
          return _this.views['.attachments'].render();
        });
      };

      PlaylistView.prototype.beforeRender = function() {
        var toggles;
        toggles = {
          toggles: {
            description_web: {
              displayName: 'Web',
              value: this.model.get('description_web')
            },
            description_mobile: {
              displayName: 'Mobile',
              value: this.model.get('description_mobile')
            }
          }
        };
        return this.setViews({
          '.attachments': new AttachmentsView({
            collection: this.stations
          }),
          '.descriptions': new ToggleField(toggles)
        });
      };

      PlaylistView.prototype.afterRender = function() {
        this.views['.attachments'].$('.ui-sortable').sortable({
          axis: 'y',
          handle: '.button-icon.reorder'
        });
        return populateFormFields(this.model, this.el);
      };

      PlaylistView.prototype.serialize = function() {
        return {
          cid: this.model.cid
        };
      };

      PlaylistView.prototype.cleanup = function() {
        return this.stations.off();
      };

      return PlaylistView;

    })(Backbone.LayoutView);
    PlaylistsView = (function(_super) {

      __extends(PlaylistsView, _super);

      function PlaylistsView() {
        return PlaylistsView.__super__.constructor.apply(this, arguments);
      }

      PlaylistsView.prototype.tagName = 'ul';

      PlaylistsView.prototype.attributes = {
        "class": 'unstyled edit-list playlists mform'
      };

      PlaylistsView.prototype.events = {
        'sortupdate': 'sortUpdated'
      };

      PlaylistsView.prototype.initialize = function() {
        var _this = this;
        this.collection.on('add remove', this.render, this);
        return this.collection.on('change:default', function(model, value) {
          var changed, i, _i, _len, _ref;
          if (value === true) {
            changed = false;
            _ref = _this.collection.models;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              i = _ref[_i];
              if (i.cid !== model.cid && i.get('default') === true) {
                i.set({
                  "default": false
                });
                changed = true;
              }
            }
            if (changed) {
              _this.render();
              return $('.tooltip').remove();
            }
          }
        });
      };

      PlaylistsView.prototype.beforeRender = function() {
        var model, view, _i, _len, _ref, _results,
          _this = this;
        _ref = this.collection.models;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          model = _ref[_i];
          view = new PlaylistView({
            model: model
          });
          view.on('copy', function(model) {
            _this.collection.add(model.clone());
            return $('.tooltip').remove();
          });
          _results.push(this.insertView(view));
        }
        return _results;
      };

      PlaylistsView.prototype.afterRender = function() {
        return this.$el.sortable('destroy').disableSelection().sortable({
          axis: 'y',
          containment: '.view',
          placeholder: 'ui-state-highlight',
          forcePlaceholderSize: true,
          opacity: 0.6,
          handle: '.button-icon.reorder',
          scroll: true,
          tolerance: 'pointer',
          cursor: 'ns-resize'
        });
      };

      PlaylistsView.prototype.sortUpdated = function(event, ui) {
        var cid, sortOrder;
        sortOrder = this.$('li > form[data-id]').map(function() {
          return $(this).data('id');
        });
        return this.collection.reset((function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = sortOrder.length; _i < _len; _i++) {
            cid = sortOrder[_i];
            _results.push(this.collection.getByCid(cid));
          }
          return _results;
        }).call(this));
      };

      return PlaylistsView;

    })(Backbone.LayoutView);
    TagField = (function(_super) {

      __extends(TagField, _super);

      function TagField() {
        return TagField.__super__.constructor.apply(this, arguments);
      }

      TagField.prototype.template = tagFieldTemplate;

      TagField.prototype.tagName = 'ul';

      TagField.prototype.className = 'tagFieldContainer';

      TagField.prototype.initialize = function(_arg) {
        this.tags = _arg.tags;
        return this.tags || (this.tags = []);
      };

      TagField.prototype.events = function() {
        return {
          'keydown .tagField input': this.handleKeydown,
          'click': this.focusField
        };
      };

      TagField.prototype.beforeRender = function() {
        var value, _i, _len, _ref, _results;
        _ref = this.tags;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          value = _ref[_i];
          _results.push(this.insertView(new Tag({
            value: value
          })));
        }
        return _results;
      };

      TagField.prototype.handleKeydown = function(event) {
        var _ref, _ref1;
        if ((_ref = event.which) === 13 || _ref === 32) {
          this.addTag();
          return false;
        } else if (((_ref1 = event.which) === 8 || _ref1 === 46) && this.$('input').val().trim().length === 0) {
          this.removeTag();
          return false;
        }
      };

      TagField.prototype.removeTag = function() {
        var _ref;
        return (_ref = this.getViews().last().value()) != null ? _ref.removeTag() : void 0;
      };

      TagField.prototype.addTag = function() {
        var $input, exists, value;
        $input = this.$('input');
        value = $input.val().trim();
        exists = false;
        this.$('li.tag').each(function() {
          if (value === $(this).text().trim()) {
            return exists = true;
          }
        });
        if (value.length === 0 || exists) {
          return;
        }
        this.insertView(new Tag({
          value: value
        })).render();
        $input.val('');
        return this.$el.trigger('addTag', {
          value: value
        });
      };

      TagField.prototype.focusField = function(event) {
        if ($(event.target).is(this.$el)) {
          return this.$('input').focus();
        }
      };

      TagField.prototype.serialize = function() {
        return {
          tags: this.tags
        };
      };

      return TagField;

    })(Backbone.LayoutView);
    Tag = (function(_super) {

      __extends(Tag, _super);

      function Tag() {
        return Tag.__super__.constructor.apply(this, arguments);
      }

      Tag.prototype.template = tagTemplate;

      Tag.prototype.tagName = 'li';

      Tag.prototype.className = 'tag';

      Tag.prototype.events = function() {
        return {
          'click .icon-remove-sign': this.removeTag
        };
      };

      Tag.prototype.serialize = function() {
        return {
          value: this.options.value
        };
      };

      Tag.prototype.removeTag = function() {
        this.$el.trigger('removeTag', {
          value: this.$el.text().trim()
        });
        return this.remove();
      };

      Tag.prototype.append = function(root, child) {
        return root.find('li.tagField').before(child);
      };

      return Tag;

    })(Backbone.LayoutView);
    IconView = (function(_super) {

      __extends(IconView, _super);

      function IconView() {
        return IconView.__super__.constructor.apply(this, arguments);
      }

      IconView.prototype.template = iconTemplate;

      IconView.prototype.tagName = 'li';

      IconView.prototype.attributes = {
        "class": 'mform'
      };

      IconView.prototype.events = {
        'click .remove-icon': 'remove',
        'addTag .tagFieldContainer': 'addTarget',
        'removeTag .tagFieldContainer': 'removeTarget'
      };

      IconView.prototype.remove = function(e) {
        return this.model.collection.remove(this.model.cid);
      };

      IconView.prototype.beforeRender = function() {
        return this.insertView('.tagging', new TagField({
          tags: this.model.get('target')
        }));
      };

      IconView.prototype.addTarget = function(e, data) {
        var target;
        target = this.model.get('target').concat([data.value]);
        return this.model.set({
          target: target
        });
      };

      IconView.prototype.removeTarget = function(e, data) {
        var target;
        target = _(this.model.get('target')).without(data.value);
        return this.model.set({
          target: target
        });
      };

      IconView.prototype.serialize = function() {
        return {
          model: this.model.toJSON()
        };
      };

      return IconView;

    })(Backbone.LayoutView);
    IconsView = (function(_super) {

      __extends(IconsView, _super);

      function IconsView() {
        return IconsView.__super__.constructor.apply(this, arguments);
      }

      IconsView.prototype.tagName = 'ul';

      IconsView.prototype.attributes = {
        "class": 'unstyled mform'
      };

      IconsView.prototype.initialize = function() {
        var _this = this;
        this.collection.on('all', function() {
          return console.log(arguments);
        });
        return this.collection.on('add remove', this.render, this);
      };

      IconsView.prototype.beforeRender = function() {
        var model, _i, _len, _ref, _results;
        _ref = this.collection.models;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          model = _ref[_i];
          _results.push(this.insertView(new IconView({
            model: model
          })));
        }
        return _results;
      };

      return IconsView;

    })(Backbone.LayoutView);
    ConciergeView = (function(_super) {

      __extends(ConciergeView, _super);

      function ConciergeView() {
        return ConciergeView.__super__.constructor.apply(this, arguments);
      }

      ConciergeView.prototype.template = editTemplate;

      ConciergeView.prototype.attributes = {
        "class": "concierge view mform"
      };

      ConciergeView.prototype.events = {
        'click #new-slide': 'add',
        'click #add-icon': 'addIcon',
        'click .collapser .btn': 'toggleCollapse',
        'change .time-slots input[type=checkbox]': 'clickTimeSlot'
      };

      ConciergeView.prototype.serialize = function() {
        var allDays, allTimes, slugToTitle;
        allDays = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
        allTimes = ['early_morning', 'morning', 'afternoon', 'evening', 'late_evening'];
        slugToTitle = function(str) {
          str = str.replace('_', ' ');
          return str.replace(/\w\S*/g, function(txt) {
            return txt.substr(0, 1).toUpperCase() + txt.substr(1).toLowerCase();
          });
        };
        return _.extend({}, this.model.toJSON(), {
          allDays: allDays,
          allTimes: allTimes,
          slugToTitle: slugToTitle
        });
      };

      ConciergeView.prototype.initialize = function() {
        var _this = this;
        this.icons = new Backbone.Collection(this.model.get('icons'), {
          model: Backbone.Model.extend({
            idAttribute: 'image_url'
          })
        });
        this.icons.on('change add remove reset', function() {
          return _this.model.set('icons', _this.icons.toJSON());
        });
        this.playlists = new Backbone.Collection(this.model.get('playlists'));
        return this.playlists.on('change add remove reset', function() {
          _this.model.set('playlists', _this.playlists.toJSON());
          return _this.$('#item-count').html(_this.playlists.length);
        });
      };

      ConciergeView.prototype.clickTimeSlot = function(e) {
        var $currentTarget, availability, checked, day, time;
        e.stopPropagation();
        $currentTarget = $(e.currentTarget);
        checked = $currentTarget.is(':checked');
        day = $currentTarget.data('day').toLowerCase();
        time = $currentTarget.data('time').toLowerCase().replace(' ', '_');
        availability = this.model.get('availability');
        if (!(availability != null)) {
          availability = {};
        }
        if (!(availability[day] != null)) {
          availability[day] = {};
        }
        availability[day][time] = checked;
        return this.model.set({
          availability: availability,
          _: +(new Date)
        });
      };

      ConciergeView.prototype.add = function() {
        return this.playlists.add(new Backbone.Model());
      };

      ConciergeView.prototype.addIcon = function(e) {
        var cropTabView,
          _this = this;
        cropTabView = new crop.ImageUploadAnchorView({
          model: this.model.get('img_meta')
        });
        return cropTabView.on('finished', function(img_meta, image_url) {
          return _this.icons.add({
            img_meta: img_meta,
            image_url: image_url,
            target: ['web']
          });
        });
      };

      ConciergeView.prototype.toggleCollapse = function(e) {
        var el, panels;
        el = $(e.target);
        panels = this.$('.list-container .controls');
        if (el.attr('id') === 'collapse-slides') {
          panels.hide();
        } else {
          panels.show();
        }
        this.$('.collapser .btn').removeClass('active');
        return el.addClass('active');
      };

      ConciergeView.prototype.beforeRender = function(e) {
        this.setView('div.list-container', new PlaylistsView({
          collection: this.playlists
        }));
        return this.setView('div.activityicon', new IconsView({
          collection: this.icons
        }));
      };

      ConciergeView.prototype.afterRender = function() {
        populateFormFields(this.model, this.el);
        return this.$('#item-count').html(this.playlists.length);
      };

      ConciergeView.prototype.cleanup = function() {
        return this.playlists.off();
      };

      return ConciergeView;

    })(Backbone.LayoutView);
    mapper.register(mapper.MODIFY, CON.TYPE_CONCIERGE, ConciergeView);
    return {
      ConciergeView: ConciergeView,
      PlaylistView: PlaylistView
    };
  });

}).call(this);
