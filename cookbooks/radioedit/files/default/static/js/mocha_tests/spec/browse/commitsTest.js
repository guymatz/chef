// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Blob, CollapsibleRowView, Commits, CommitsView, RowView, TestParent, ToggleView, expect, shared, _ref, _ref1;
    Backbone = require('backbone');
    require('backbone.layoutmanager');
    _ref = require('src/browse/models'), Commits = _ref.Commits, Blob = _ref.Blob;
    _ref1 = require('src/browse/commits'), CommitsView = _ref1.CommitsView, RowView = _ref1.RowView, CollapsibleRowView = _ref1.CollapsibleRowView, ToggleView = _ref1.ToggleView;
    expect = chai.expect;
    TestParent = (function(_super) {

      __extends(TestParent, _super);

      function TestParent() {
        return TestParent.__super__.constructor.apply(this, arguments);
      }

      TestParent.prototype.template = function() {
        return function() {
          return '<div class="partial"></div><div class="anotherPartial"></div>';
        };
      };

      TestParent.prototype.fetch = function(path) {
        return path;
      };

      return TestParent;

    })(Backbone.LayoutView);
    describe('CommitsView', function() {
      beforeEach(function() {
        this.collection = new Commits([], {
          resourceId: 'a'
        });
        this.stub(this.collection, 'refsFetch');
        return this.stub(this.collection, 'each');
      });
      afterEach(function() {
        return delete this.collection;
      });
      describe('initialize', function() {
        return it('throws an error if a collection is not passed', function() {
          return expect(function() {
            return new CommitsView();
          }).throws(Error);
        });
      });
      return describe('render', function() {
        beforeEach(function() {
          return this.model = new Blob({
            index: {},
            commit: {
              _id: "268114fb794c46bea87873f96c5b8f216864a6e7",
              author: {
                _id: "dummy:jgrund",
                display_name: "jgrund",
                email_address: null,
                first_name: "jgrund",
                last_name: "jgrund"
              },
              ctime: 1346879650736.4668,
              parents: ["0cefe8a705fa43cb198c2e8b6d25c9670abcdf41"],
              refs: [
                {
                  commit: "268114fb794c46bea87873f96c5b8f216864a6e7",
                  publisher: "dummy:jgrund",
                  ref: "Staging",
                  timestamp: 1346880603559.458
                }, {
                  commit: "268114fb794c46bea87873f96c5b8f216864a6e7",
                  publisher: "dummy:jgrund",
                  ref: "Live",
                  timestamp: 1346880605786.712
                }, {
                  commit: "268114fb794c46bea87873f96c5b8f216864a6e7",
                  publisher: "dummy:jgrund",
                  ref: "dsadsad",
                  timestamp: 1346880608134.1501
                }
              ],
              resource_id: "dolor.dolor"
            }
          });
        });
        afterEach(function() {
          return delete this.model;
        });
        it('renders a checkbox', function() {
          this.collection.each.yields(this.model);
          this.view = new CommitsView({
            collection: this.collection
          });
          this.view.render();
          expect(this.view.$el).have('input');
          return expect(this.view.$('input')).attr('type', 'checkbox');
        });
        describe('with refs', function() {
          beforeEach(function() {
            this.collection.each.yields(this.model, 0);
            this.view = new CommitsView({
              collection: this.collection
            });
            this.view.render();
            this.rows = this.view.$('.body div.row');
            this.firstRow = this.rows.eq(0);
            this.firstRowCells = this.firstRow.find('div');
            this.firstRowCellsText = this.firstRowCells.text();
            return this.secondRow = this.rows.eq(1);
          });
          afterEach(function() {
            this.view.remove();
            delete this.view;
            delete this.rows;
            delete this.firstRow;
            delete this.firstRowCells;
            delete this.firstRowCellsText;
            return delete this.secondRow;
          });
          it('renders the refs', function() {
            return expect(this.rows).length(3);
          });
          return it('renders the first row date', function() {
            return expect(this.firstRowCellsText).string(new Date(this.model.refs()[0].timestamp).format());
          });
        });
        describe('HEAD', function() {
          it('renders HEAD with color', function() {
            this.collection.each.yields(this.model, 0);
            this.view = new CommitsView({
              collection: this.collection
            });
            this.view.render();
            return expect(this.view.$('.badge'))["class"]('badge-info');
          });
          return it('renders history without color', function() {
            this.collection.each.yields(this.model, 1);
            this.view = new CommitsView({
              collection: this.collection
            });
            this.view.render();
            return expect(this.view.$('.badge')).not["class"]('badge-info');
          });
        });
        return describe('collapsible row', function() {
          beforeEach(function() {
            this.model.get('commit').refs = [];
            this.collection.each.yields(this.model);
            this.view = new CommitsView({
              collection: this.collection
            });
            this.view.render();
            this.rows = this.view.$('.body div.row');
            this.firstRow = this.rows.eq(0);
            this.firstRowCells = this.firstRow.find('div');
            return this.firstRowCellsText = this.firstRowCells.text();
          });
          afterEach(function() {
            this.view.remove();
            delete this.view;
            delete this.rows;
            delete this.firstRow;
            delete this.firstRowCells;
            return delete this.firstRowCellsText;
          });
          it('renders a collapsible row', function() {
            return expect(this.rows.length).equal(1);
          });
          it('renders a collapsible row class', function() {
            return expect(this.firstRow.hasClass('collapsible'))["true"];
          });
          it('renders the commit', function() {
            return expect(this.firstRowCellsText).string(this.model.commitId());
          });
          it('renders the author', function() {
            return expect(this.firstRowCellsText).string(this.model.author()._id);
          });
          return it('renders the date', function() {
            return expect(this.firstRowCellsText).string(new Date(this.model.get('commit').ctime).format());
          });
        });
      });
    });
    shared = {
      rendersRows: function() {
        return it('renders a row with the data', function() {
          var cells;
          cells = this.view.$('div');
          expect(cells.eq(0).text()).equal(this.data.commit);
          expect(cells.eq(2).text()).equal(this.data.publisher);
          return expect(cells.eq(3).text()).equal(new Date(this.data.timestamp).format());
        });
      },
      toggle: function() {
        beforeEach(function() {
          Backbone.history.navigate('somewhere');
          return this.stub = sinon.stub(Backbone.history, '_updateHash');
        });
        afterEach(function() {
          this.stub.restore();
          return delete this.stub;
        });
        return it('routes to the commit when clicked', function() {
          this.view.$el.click();
          this.assertCalledOnce(this.stub);
          return expect(this.stub.args[0][1]).equal("" + this.resourceId + "/" + this.data.commit);
        });
      }
    };
    describe('RowView', function() {
      beforeEach(function() {
        this.rowClass = RowView;
        this.data = {
          commit: "16fea58bc357ecdd0771905c3f6cb703fa49232f",
          publisher: "system:system",
          ref: "live",
          timestamp: 1346867930770.27
        };
        this.resourceId = 'some/random/path';
        this.view = new this.rowClass({
          data: this.data,
          resourceId: this.resourceId
        });
        this.view.render();
        return $('.testFixtures').append(this.view.el);
      });
      afterEach(function() {
        this.view.remove();
        delete this.rowClass;
        delete this.data;
        delete this.view;
        return delete this.resourceId;
      });
      describe('render', function() {
        return shared.rendersRows();
      });
      return describe('toggle', function() {
        return shared.toggle();
      });
    });
    describe('CollapsibleRowView', function() {
      beforeEach(function() {
        var isHead;
        this.data = {
          commit: "16fea58bc357ecdd0771905c3f6cb703fa49232f",
          publisher: "system:system",
          timestamp: 1346867930770.27
        };
        this.resourceId = 'some/random/path';
        this.rowClass = CollapsibleRowView;
        isHead = true;
        return this.view = new this.rowClass({
          data: this.data,
          resourceId: this.resourceId,
          isHead: isHead
        });
      });
      afterEach(function() {
        this.view.remove();
        delete this.view;
        delete this.data;
        return delete this.rowClass;
      });
      describe('render', function() {
        beforeEach(function() {
          return this.view.render();
        });
        shared.rendersRows();
        it('shows the ref as HEAD', function() {
          return expect(this.view.$('.badge')).text('HEAD');
        });
        it('shows the row as collapsible', function() {
          return expect(this.view.$el)["class"]('collapsible');
        });
        return it('renders with the row expanded', function() {
          return expect(this.view.$el).not["class"]('collapsed');
        });
      });
      describe('toggle', function() {
        beforeEach(function() {
          this.view.render();
          return this.fixturesContainer.append(this.view.el);
        });
        return shared.toggle();
      });
      return describe('global toggle', function() {
        return it('listens for a toggle event', function() {
          var testParent, toggleView;
          toggleView = new ToggleView();
          testParent = new TestParent();
          this.fixturesContainer.append(testParent.$el);
          testParent.setViews({
            '.partial': this.view,
            '.anotherPartial': toggleView
          }).render();
          toggleView.$('input').click();
          return expect(this.view.$el)["class"]('collapsed');
        });
      });
    });
    return describe('ToggleView', function() {
      beforeEach(function() {
        return this.toggleView = new ToggleView();
      });
      it('renders a checked checkbox', function() {
        var input;
        this.toggleView.render();
        expect(this.toggleView.$el).have('input');
        input = this.toggleView.$('input');
        expect(input).attr('type', 'checkbox');
        return expect(input).checked;
      });
      it('emits a global event namespaced to it\'s parent when clicked', function() {
        var testListener, testParent, testStub, toggleView;
        toggleView = this.toggleView;
        testStub = this.stub();
        testParent = new TestParent();
        testParent.setView('.partial', toggleView);
        this.fixturesContainer.append(testParent.$el);
        testParent.render();
        testListener = new Backbone.View();
        testListener.global.on("toggle:" + testParent.cid, testStub);
        this.toggleView.$('input').click();
        return this.assertCalledWith(testStub, {
          show: false
        });
      });
      return afterEach(function() {
        this.toggleView.remove();
        return delete this.toggleView;
      });
    });
  });

}).call(this);
