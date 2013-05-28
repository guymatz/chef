// Generated by CoffeeScript 1.3.3
(function() {

  require.config({
    paths: {
      jquery: 'lib/jquery/jquery-1.7.2',
      underscore: 'lib/underscore',
      backbone: 'lib/backbone-0.9.2',
      handlebars: 'lib/handlebars',
      backboneViewClose: 'lib/backboneExtensions/backbone.view.close',
      backboneViewRivets: 'lib/backboneExtensions/backbone.view.rivets',
      text: 'lib/require/text',
      templates: 'templates',
      eco: 'templates_js',
      src: (window.TYPE != null) && window.TYPE === 'coverage' ? 'instrumented/static/js/src' : 'js/src',
      rivets: 'lib/rivets',
      multiDatePicker: 'lib/multiDatePicker',
      dateRangePicker: 'lib/dateRangePicker',
      fileUpload: 'lib/jquery/fileUpload',
      'jquery.ui.widget': 'lib/jquery/jquery.ui.widget',
      'jquery.ui': 'lib/jquery/jquery-ui-1.8.21.custom.min',
      'jquery.eventpri': 'lib/jquery/jquery.eventpri',
      bootstrap: 'lib/bootstrap',
      notify: 'lib/bootstrap-notify/bootstrap-notify',
      spec: (window.TEST_TYPE != null) && window.TEST_TYPE === 'jasmine' ? 'js/tests/spec' : 'js/mocha_tests/spec',
      fixtures: (window.TEST_TYPE != null) && window.TEST_TYPE === 'jasmine' ? 'js/tests/fixtures' : 'js/mocha_tests/fixtures',
      templateFixtures: 'js/mocha_tests/template_fixtures_js',
      'sinon-chai': 'js/mocha_tests/lib/sinon-chai',
      'JSCovReporter': 'js/mocha_tests/lib/JSCovReporter'
    },
    shim: {
      jquery: {
        exports: '$'
      },
      'jquery.ui.widget': ['jquery'],
      'jquery.ui': ['jquery'],
      'jquery.eventpri': ['jquery', 'jquery.ui.widget'],
      'bootstrap/bootstrap-button': ['jquery'],
      'bootstrap/bootstrap-dropdown': ['jquery'],
      'bootstrap/bootstrap-tooltip': ['jquery'],
      'bootstrap/bootstrap-modal': ['jquery'],
      'bootstrap/bootstrap-transition': ['jquery'],
      'bootstrap/bootstrap-popover': ['jquery', 'bootstrap/bootstrap-tooltip'],
      'bootstrap/bootstrap-tab': ['jquery'],
      'bootstrap/bootstrap-alert': ['jquery'],
      'fileUpload/jquery.fileupload-ui': ['fileUpload/jquery.iframe-transport'],
      'lib/chosen/chosen.jquery': ['jquery'],
      notify: ['jquery', 'bootstrap/bootstrap-alert'],
      'js/tests/lib/jquery.simulate': ['jquery'],
      underscore: {
        exports: '_'
      },
      backbone: {
        deps: ['underscore', 'jquery'],
        exports: 'Backbone'
      },
      handlebars: {
        exports: 'Handlebars'
      },
      'lib/jquery/quicksand': ['jquery'],
      rivets: {
        exports: 'rivets'
      },
      JSCovReporter: {
        deps: ['backbone', 'underscore'],
        exports: 'JSCovReporter'
      }
    },
    baseUrl: window.STATIC_URL,
    deps: [window.MAIN]
  });

}).call(this);