// Generated by CoffeeScript 1.3.3
(function() {

  define(function(require) {
    var dateRangePickerViews, models;
    dateRangePickerViews = require('dateRangePicker/views');
    models = require('dateRangePicker/models');
    return describe('The date range picker', function() {
      var date, dateRanges;
      date = Date.create().resetTime();
      dateRanges = {
        startDate: date.addMinutes(date.getTimezoneOffset() * -1).valueOf(),
        endDate: date.addMinutes(date.getTimezoneOffset() * -1).addDays(1).valueOf()
      };
      describe('container view', function() {
        var containerView;
        containerView = null;
        beforeEach(function() {
          containerView = new dateRangePickerViews.ContainerView(dateRanges).render();
          return $('body').append(containerView.el);
        });
        it('will show itself', function() {
          expect(containerView.$el.css('display')).toBe('none');
          containerView.show();
          return expect(containerView.$el.css('display')).not.toBe('none');
        });
        it('will destroy itself when it is hidden', function() {
          containerView.hide();
          return expect($('body').find("." + containerView.className).length).toBe(0);
        });
        it('will require a startDate and will not require an endDate', function() {
          var singleDateContainerView;
          expect(containerView.model).toEqual(jasmine.any(models.ChronologyModelDateRange));
          expect(function() {
            return new dateRangePickerViews.ContainerView();
          }).toThrow();
          expect(function() {
            return new dateRangePickerViews.ContainerView(dateRanges).close();
          }).not.toThrow();
          expect(function() {
            return new dateRangePickerViews.ContainerView({
              startDate: null,
              endDate: null
            }).close();
          }).not.toThrow();
          expect(function() {
            return new dateRangePickerViews.ContainerView({
              startDate: null
            }).close();
          }).not.toThrow();
          singleDateContainerView = new dateRangePickerViews.ContainerView({
            startDate: null
          });
          expect(singleDateContainerView.model).toEqual(jasmine.any(models.ChronologyModelSingleDate));
          expect(singleDateContainerView.model).not.toEqual(jasmine.any(models.ChronologyModelDateRange));
          return singleDateContainerView.close();
        });
        return afterEach(function() {
          if (containerView != null) {
            containerView.close();
          }
          return containerView = null;
        });
      });
      return describe('day view group', function() {
        var dayViewGroup;
        dayViewGroup = null;
        beforeEach(function() {
          return dayViewGroup = new dateRangePickerViews.DayViewGroup({
            model: new models.ChronologyModelDateRange(dateRanges)
          });
        });
        return afterEach(function() {
          if (dayViewGroup != null) {
            dayViewGroup.close();
          }
          return dayViewGroup = null;
        });
      });
    });
  });

}).call(this);
