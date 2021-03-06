// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Commit, Data, Index, Refs, RelationalModel, TestModel2, commitData, expect, populateResponse, _;
    RelationalModel = require('src/relational_model').RelationalModel;
    populateResponse = require('util/ResponseHelper').populateResponse;
    commitData = require('fixtures/commit');
    Backbone = require('backbone');
    _ = require('underscore');
    expect = chai.expect;
    Refs = (function(_super) {

      __extends(Refs, _super);

      function Refs() {
        return Refs.__super__.constructor.apply(this, arguments);
      }

      Refs.prototype.url = 'test';

      Refs.prototype.parse = function(resp, xhr) {
        var commitId, ref, _results;
        _results = [];
        for (ref in resp) {
          commitId = resp[ref];
          _results.push({
            id: ref,
            commitId: commitId
          });
        }
        return _results;
      };

      Refs.prototype.unParse = function() {
        var model, out, _i, _len, _ref;
        out = {};
        _ref = this.toJSON();
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          model = _ref[_i];
          out[model.id] = model.commitId;
        }
        return out;
      };

      return Refs;

    })(Backbone.Collection);
    Index = (function(_super) {

      __extends(Index, _super);

      function Index() {
        return Index.__super__.constructor.apply(this, arguments);
      }

      Index.prototype.relations = {
        refs: {
          type: 'collection',
          Class: Refs
        }
      };

      return Index;

    })(RelationalModel);
    Commit = (function(_super) {

      __extends(Commit, _super);

      function Commit() {
        return Commit.__super__.constructor.apply(this, arguments);
      }

      return Commit;

    })(Backbone.Model);
    Data = (function(_super) {

      __extends(Data, _super);

      function Data() {
        return Data.__super__.constructor.apply(this, arguments);
      }

      return Data;

    })(Backbone.Model);
    TestModel2 = (function(_super) {

      __extends(TestModel2, _super);

      function TestModel2() {
        return TestModel2.__super__.constructor.apply(this, arguments);
      }

      TestModel2.prototype.relations = {
        data: {
          Class: Data
        },
        index: {
          Class: Index
        }
      };

      TestModel2.prototype.url = '/blah';

      return TestModel2;

    })(RelationalModel);
    return describe('RelationalModel', function() {
      var data, model;
      model = data = null;
      beforeEach(function() {
        model = new TestModel2();
        model.fetch();
        return this.server.respond(populateResponse(commitData));
      });
      describe('nested model', function() {
        beforeEach(function() {
          return data = model.dataStore.get('data');
        });
        it("has a data model in it's data store", function() {
          return expect(data)["instanceof"](Data);
        });
        it('has a data model with the correct attributes', function() {
          return expect(data.attributes).deep.equal(commitData.data);
        });
        it('removes the nested attribute from the model when it is removed from data', function() {
          data.unset('description');
          return expect(model.get('data')).not.include.keys('description');
        });
        it('removes the attribute from the model when it is destroyed', function() {
          data.destroy();
          return expect(model.get('data')).undefined;
        });
        it('removes the model from the dataStore when it is destroyed', function() {
          data.destroy();
          return expect(model.dataStore.get('data')).undefined;
        });
        it('removes the model from the dataStore when it is unset in the parent', function() {
          model.unset('data');
          return expect(model.dataStore.get('data')).undefined;
        });
        it('adds the attribute to the model when it is added to data', function() {
          data.set({
            test: 'value'
          });
          return expect(model.get('data').test).equal('value');
        });
        it('keeps the same nested instance reference when refetching data', function() {
          model.fetch();
          this.server.respond(populateResponse(commitData));
          return expect(data.cid).equal(model.dataStore.get('data').cid);
        });
        it('triggers a change event when a nested model is changed', function() {
          var spy;
          spy = this.spy();
          model.on('change', spy);
          data.set({
            description: 'test'
          });
          return this.assertCalledOnce(spy);
        });
        it('shows the previous attributes when a nested model is changed', function(done) {
          var old;
          old = commitData.data.description;
          model.on('change', function() {
            expect(model.previous('data').description).equal(old);
            return done();
          });
          return data.set({
            description: 'test'
          });
        });
        return it('triggers a change event exactly once when setting an attribute on the parent', function() {
          var spy;
          spy = this.spy();
          model.on('change', spy).set('data', {
            description: 'blah'
          });
          this.assertCalledOnce(spy);
          return expect(data.attributes).deep.equal(model.get('data'));
        });
      });
      return describe('nested collection within nested model', function() {
        var index, refs;
        index = null;
        refs = null;
        beforeEach(function() {
          index = model.dataStore.get('index');
          return refs = index.dataStore.get('refs');
        });
        it('contains a nested collection', function() {
          return expect(index.dataStore.get('refs')).instanceOf(Backbone.Collection);
        });
        it('contains a nested collection parsed in the proper format', function() {
          return expect(index.dataStore.get('refs').toJSON()).deep.equal(Refs.prototype.parse(commitData.index.refs));
        });
        it('removes the data when a collection model is removed', function() {
          refs.remove(refs.at(0));
          return expect(_.keys(index.get('refs'))).deep.equal(_.keys(commitData.index.refs).slice(1));
        });
        it('changes the data when a collection model is changed', function() {
          refs.at(0).set('id', 'blah');
          return expect(_.keys(index.get('refs'))).deep.equal(['blah', 'Live', 'Staging', 'develop']);
        });
        it('changes the data when a collection model is destroyed', function() {
          refs.at(0).destroy();
          return expect(_.keys(index.get('refs'))).deep.equal(['Live', 'Staging', 'develop']);
        });
        it('adds the data when a collection model is added', function() {
          refs.create({
            id: 'testing',
            commitId: 'add'
          });
          return expect(_.keys(index.get('refs'))).deep.equal(['HEAD', 'Live', 'Staging', 'develop', 'testing']);
        });
        it('resets the data when a collection is reset', function() {
          refs.reset([
            {
              id: 'test',
              commitId: 'reset'
            }
          ]);
          return expect(index.get('refs')).deep.equal({
            test: 'reset'
          });
        });
        it('bubbles a collection change event to the base relational model', function() {
          var spy;
          spy = this.spy();
          model.on('change', spy);
          refs.at(0).set('id', 'blah');
          return this.assertCalledOnce(spy);
        });
        it('bubbles a namespaced collection change event to the base relational model', function() {
          var spy;
          spy = this.spy();
          model.on('change:index', spy);
          refs.at(0).set('id', 'blah');
          return this.assertCalledOnce(spy);
        });
        it('bubbles a collection change event to the index model', function() {
          var spy;
          spy = this.spy();
          index.on('change', spy);
          refs.at(0).set('id', 'blah');
          return this.assertCalledOnce(spy);
        });
        it('bubbles a namespaced collection change event to the index model', function() {
          var spy;
          spy = this.spy();
          index.on('change:refs', spy);
          refs.at(0).set('id', 'blah');
          return this.assertCalledOnce(spy);
        });
        it('contains a root method that returns the root', function() {
          return expect(refs.root()).equals(model);
        });
        return it('contains a parent property that returns the parent', function() {
          return expect(refs.parent).equals(index);
        });
      });
    });
  });

}).call(this);
