// Generated by CoffeeScript 1.3.3
(function() {

  define(function(require) {
    var $, Backbone, crop, models, targetItemModelFixture, _;
    Backbone = require('backbone');
    _ = require('underscore');
    crop = require('src/crop');
    targetItemModelFixture = require('fixtures/targetItemModel');
    models = require('src/models');
    $ = require('jquery');
    return describe('The Image Upload Anchor Module\'s', function() {
      var targetItemImageModel, targetItemModel;
      targetItemModel = null;
      targetItemImageModel = null;
      beforeEach(function() {
        targetItemModel = new models.TargetItemModel(targetItemModelFixture);
        return targetItemImageModel = new models.TargetItemImageModel(targetItemModel.get('img_meta'));
      });
      describe('ImageUploadAnchorView', function() {
        var imageUploadAnchorView;
        imageUploadAnchorView = null;
        beforeEach(function() {
          imageUploadAnchorView = new crop.ImageUploadAnchorView({}, targetItemModel);
          return $('body').append(imageUploadAnchorView.el);
        });
        describe('Initialize', function() {
          return it('will require a Model on initialization', function() {
            expect(function() {
              return new crop.ImageUploadAnchorView({});
            }).toThrow();
            return expect(function() {
              return new crop.ImageUploadAnchorView({}, targetItemModel).close();
            }).not.toThrow();
          });
        });
        describe('Render', function() {
          it('will set the current view to a FileUploadView', function() {
            return expect(imageUploadAnchorView.currentView instanceof crop.FileUploadView);
          });
          return it('will have an upload button to upload images', function() {
            return expect(imageUploadAnchorView.$el.find('.fileUploadForm input').length).toBe(1);
          });
        });
        describe('File Upload', function() {
          beforeEach(function() {
            return jasmine.Ajax.useMock();
          });
          return it('will change the crop images after file upload', function() {
            var file;
            expect(imageUploadAnchorView.$el.find('.cropImageContainer .thumbnail img').attr('src')).toBe(targetItemImageModel.getOriginalImageUrl());
            file = new WebKitBlobBuilder();
            file.append(['a']);
            imageUploadAnchorView.currentSubView.uploader.fileupload('send', {
              files: [file.getBlob()]
            });
            mostRecentAjaxRequest().response({
              status: 200,
              responseText: '{"name":"picture1.jpg","size":902604,' + '"url":"\/static\/img\/glyphicons-halflings-white.png",' + '"thumbnail_url":"\/\/example.org\/thumbnails\/picture1.jpg",' + '"delete_url":"","delete_type":"DELETE"}'
            });
            return imageUploadAnchorView.$el.find('.imageContainer img').each(function(index) {
              return expect($(this).attr('src')).toBe('\/static\/img\/glyphicons-halflings-white.png');
            });
          });
        });
        return afterEach(function() {
          return $('.modal').modal('hide');
        });
      });
      return describe('Anchor View\'s', function() {
        var anchorImage;
        anchorImage = "\/static\/img\/glyphicons-halflings.png";
        describe('Get image dimensions', function() {
          var actualDimensions, anchorDimensions, callback;
          anchorDimensions = null;
          actualDimensions = null;
          callback = null;
          beforeEach(function() {
            var _this = this;
            callback = {
              imageDimensionsCallback: function(dimensions) {
                return actualDimensions = dimensions;
              }
            };
            return spyOn(callback, 'imageDimensionsCallback').andCallThrough();
          });
          it('will find the dimensions for the passed in image url.', function() {
            runs(function() {
              return crop.AnchorView.getTrueImageDimensions(anchorImage, callback.imageDimensionsCallback);
            });
            waitsFor(function() {
              return callback.imageDimensionsCallback.callCount > 0;
            }, 'Waiting for image to be loaded', 1000);
            return runs(function() {
              return expect(actualDimensions).toEqual({
                width: 469,
                height: 159
              });
            });
          });
          return it('will use a closure to store image state', function() {
            var anchorView;
            anchorView = new crop.AnchorView({
              model: targetItemImageModel
            });
            return _(2).times(function() {
              runs(function() {
                return anchorView.getAnchorImageDimensions(anchorImage, callback.imageDimensionsCallback);
              });
              waitsFor(function() {
                return callback.imageDimensionsCallback.callCount > 0;
              }, 'Waiting for image to be loaded', 1000);
              return runs(function() {
                return expect(actualDimensions).toEqual({
                  width: 469,
                  height: 159
                });
              });
            });
          });
        });
        return describe('Mark Anchor Point method', function() {
          var anchorView;
          anchorView = null;
          beforeEach(function() {
            anchorView = new crop.AnchorView({
              model: targetItemImageModel
            });
            return anchorView.render().$el.appendTo('body');
          });
          it('will mark where the image is clicked both on screen and in the model', function() {
            var anchorPoint, anchorViewOffset, event, expectedLeftPosition, expectedTopPosition, imageElement, imageOffset,
              _this = this;
            spyOn(anchorView, 'getAnchorImageDimensions').andCallThrough();
            imageElement = anchorView.$el.find('img');
            anchorViewOffset = anchorView.$el.offset();
            imageOffset = imageElement.offset();
            event = new jQuery.Event('click');
            event.pageX = imageOffset.left + 10;
            event.pageY = imageOffset.top + 10;
            imageElement.trigger(event);
            anchorPoint = anchorView.$el.find('.anchorPoint');
            expectedLeftPosition = event.pageX - (imageOffset.left - parseInt(imageElement.css('margin-left')));
            expectedTopPosition = event.pageY - imageOffset.top;
            expect(anchorPoint.length).toBe(1);
            expect(anchorPoint.css('left')).toBe("" + (expectedLeftPosition - (anchorPoint.outerWidth() / 4)) + "px");
            expect(anchorPoint.css('top')).toBe("" + (expectedTopPosition - (anchorPoint.outerHeight() / 4)) + "px");
            return anchorView.on('anchorPicked', function() {
              return expect(anchorView.model.get('ops')["default"]).toEqual([['anchor', [expectedLeftPosition, expectedTopPosition]]]);
            }).off('anchorPicked');
          });
          return afterEach(function() {
            return anchorView.close();
          });
        });
      });
    });
  });

}).call(this);