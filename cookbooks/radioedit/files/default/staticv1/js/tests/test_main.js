(function () {
    "use strict";

    define('common', [
        'notify',
        'jquery.eventpri',
        'bootstrap/bootstrap-button',
        'bootstrap/bootstrap-dropdown',
        'bootstrap/bootstrap-modal',
        'bootstrap/bootstrap-transition',
        'bootstrap/bootstrap-popover',
        'bootstrap/bootstrap-tab',
        'bootstrap/bootstrap-tooltip',
        'lib/json2',
        'lib/chosen/chosen.jquery',
        'lib/sugar-1.2.5.min',
        'backboneViewClose',
        'js/tests/lib/jquery.simulate'
    ]);

    define(function (require) {
        require('lib/backboneExtensions/backbone.view.actionPanel');
        require('common');
        require('spec/base');
        require('spec/models');
        require('spec/crop');
        require('spec/lib/multiDatePicker/CalendarView');
        require('spec/lib/multiDatePicker/MultiDatePickerView');
        require('spec/lib/multiDatePicker/ChronologyModel');
        require('spec/lib/dateRangePicker/views');
        require('spec/lib/dateRangePicker/models');
        require('spec/TargetsHierarchyCollection');

        var $ = require('jquery'),
            jasmineEnv = window.jasmine.getEnv(),
            log = function () {
                console && console.log && console.log.apply(console, arguments);
            },
            htmlReporter = new window.jasmine.HtmlReporter();

        $.fx.off = true;

        jasmineEnv.updateInterval = 1000;

        jasmineEnv.addReporter(htmlReporter);

        if (window.TYPE === 'test') {
            jasmineEnv.addReporter(new window.jasmine.ConsoleReporter(log, function () {}, true));
        } else if (window.TYPE === 'coverage') {
            jasmineEnv.addReporter(new window.jasmine.JSCoverageReporter());
        }

        jasmineEnv.specFilter = function (spec) {
            return htmlReporter.specFilter(spec);
        };

        function execJasmine() {
            jasmineEnv.execute();
        }

        execJasmine();
    });

}());
