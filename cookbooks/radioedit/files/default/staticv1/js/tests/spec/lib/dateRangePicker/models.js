// Generated by CoffeeScript 1.3.3
(function() {

  define(function(require) {
    var changeToUTCMidnight, models, _;
    models = require('dateRangePicker/models');
    _ = require('underscore');
    changeToUTCMidnight = function(date) {
      return date.clone().resetTime().addMinutes(date.getTimezoneOffset() * -1);
    };
    return describe('The date range picker chronology model', function() {
      describe('date range', function() {
        var chronologyModelDateRange, date, dateRanges;
        chronologyModelDateRange = null;
        date = Date.create('April 5 2012');
        dateRanges = {
          startDate: changeToUTCMidnight(date).valueOf(),
          endDate: changeToUTCMidnight(date.addMonths(4)).valueOf()
        };
        beforeEach(function() {
          return chronologyModelDateRange = new models.ChronologyModelDateRange(dateRanges);
        });
        it('will convert the startDate and endDate to midnight UTC.', function() {
          var endDate, startDate;
          startDate = chronologyModelDateRange.get('startDate');
          endDate = chronologyModelDateRange.get('endDate');
          expect(chronologyModelDateRange.get('startDate').getUTCOffset()).toBe('+0000');
          expect(chronologyModelDateRange.get('endDate').getUTCOffset()).toBe('+0000');
          expect(startDate.getHours()).toBe(0);
          expect(startDate.getMinutes()).toBe(0);
          expect(endDate.getHours()).toBe(0);
          return expect(endDate.getMinutes()).toBe(0);
        });
        it('will set the date to the start date or the end date or to the beginning of the month if both are null', function() {
          var emptyModelValue, emptyStartDateValue;
          expect(chronologyModelDateRange.get('date').valueOf()).toBe(Date.create(dateRanges.startDate).toUTC().beginningOfMonth().valueOf());
          emptyStartDateValue = new models.ChronologyModelDateRange(_.pick(dateRanges, 'endDate')).get('date').valueOf();
          expect(emptyStartDateValue).toBe(Date.create(dateRanges.endDate).toUTC().beginningOfMonth().valueOf());
          emptyModelValue = new models.ChronologyModelSingleDate({
            startDate: null,
            endDate: null
          }).get('date').valueOf();
          return expect(emptyModelValue).toBe(Date.create().toUTC().beginningOfMonth().valueOf());
        });
        it('will return the start date and end date in milliseconds or nulls', function() {
          var dateList, valueOfEmptyModel;
          dateList = chronologyModelDateRange.getActiveDateList();
          expect(dateList).toEqual({
            startDate: models.ChronologyModelSingleDate.asUTCDateinMilliSeconds(Date.create(dateList.startDate).toUTC()),
            endDate: models.ChronologyModelSingleDate.asUTCDateinMilliSeconds(Date.create(dateList.endDate).toUTC())
          });
          valueOfEmptyModel = new models.ChronologyModelDateRange({
            startDate: null,
            endDate: null
          }).getActiveDateList();
          return expect(valueOfEmptyModel).toEqual({
            startDate: null,
            endDate: null
          });
        });
        it('will set the correct date', function() {
          var expectedRange, newActiveDate;
          newActiveDate = changeToUTCMidnight(Date.create('June 1 1954'));
          expect(chronologyModelDateRange.getActiveDateList()).toEqual(dateRanges);
          chronologyModelDateRange.setActiveDate(newActiveDate);
          expectedRange = _.clone(dateRanges);
          expectedRange.startDate = newActiveDate.valueOf();
          expectedRange.endDate = null;
          expect(chronologyModelDateRange.getActiveDateList()).toEqual(expectedRange);
          chronologyModelDateRange.setActiveDate(newActiveDate);
          expectedRange.endDate = newActiveDate.valueOf();
          expect(chronologyModelDateRange.getActiveDateList()).toEqual(expectedRange);
          chronologyModelDateRange.setActiveDate(newActiveDate);
          expectedRange.startDate = null;
          return expect(chronologyModelDateRange.getActiveDateList()).toEqual(expectedRange);
        });
        return afterEach(function() {
          return chronologyModelDateRange = null;
        });
      });
      return describe('single date', function() {
        var chronologyModelSingleDate, startDateList;
        chronologyModelSingleDate = null;
        startDateList = {
          startDate: changeToUTCMidnight(Date.create('June 14 2012')).valueOf()
        };
        beforeEach(function() {
          return chronologyModelSingleDate = new models.ChronologyModelSingleDate(startDateList);
        });
        it('will convert the startDate to midnight UTC', function() {
          var startDate;
          startDate = chronologyModelSingleDate.get('startDate');
          expect(chronologyModelSingleDate.get('startDate').getUTCOffset()).toBe('+0000');
          expect(chronologyModelSingleDate.get('startDate').isUTC()).toBeTruthy();
          expect(startDate.getHours()).toBe(0);
          return expect(startDate.getMinutes()).toBe(0);
        });
        it('will set the date to the start date or to the beginning of the month if start date is null', function() {
          var emptyTestModel;
          expect(chronologyModelSingleDate.get('date').valueOf()).toBe(Date.create(startDateList.startDate).toUTC().beginningOfMonth().valueOf());
          emptyTestModel = new models.ChronologyModelSingleDate({
            startDate: null
          }).get('date').valueOf();
          return expect(emptyTestModel).toBe(Date.create().toUTC().beginningOfMonth().valueOf());
        });
        it('will return the start date in milliseconds or null', function() {
          var dateList, valueOfEmptyModel;
          dateList = chronologyModelSingleDate.getActiveDateList();
          expect(dateList.startDate).toBe(models.ChronologyModelSingleDate.asUTCDateinMilliSeconds(Date.create(startDateList.startDate).toUTC()));
          valueOfEmptyModel = new models.ChronologyModelSingleDate({
            startDate: null
          }).getActiveDateList().startDate;
          return expect(valueOfEmptyModel).toBeNull();
        });
        it('will set the correct date', function() {
          var newActiveDate;
          newActiveDate = changeToUTCMidnight(Date.create('June 1 1954'));
          expect(chronologyModelSingleDate.get('startDate').valueOf()).toBe(Date.create(startDateList.startDate).toUTC().valueOf());
          chronologyModelSingleDate.setActiveDate(newActiveDate);
          return expect(chronologyModelSingleDate.get('startDate').valueOf()).toBe(newActiveDate.toUTC().valueOf());
        });
        return afterEach(function() {
          return chronologyModelSingleDate = null;
        });
      });
    });
  });

}).call(this);
