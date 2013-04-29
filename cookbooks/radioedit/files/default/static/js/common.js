require({
    baseUrl: '/static/js',
    paths: {
        'jquery': '../lib/jquery/jquery',
        'underscore': '../lib/underscore',
        'backbone': '../lib/backbone-0.9.2',
        'templates': '../templates',
        'eco': '../templates',
        'fileUpload': '../lib/jquery/fileUpload',
        'jquery.ui.widget': '../lib/jquery/jquery.ui.widget',
        'jquery.ui': '../lib/jquery/jquery-ui',
        'jquery.eventpri': '../lib/jquery/jquery.eventpri',
        'jquery.transit': '../lib/jquery/jquery.transit',
        'jquery.hotkeys': '../lib/jquery/jquery.hotkeys',
        'bootstrap': '../lib/bootstrap',
        'moment': '../lib/moment',
        'codemirror': '../lib/codemirror/codemirror',
        'codemirror_python': '../lib/codemirror/mode/python/python',
        'codemirror_sql': '../lib/codemirror/mode/mysql/mysql',
        'codemirror_yaml': '../lib/codemirror/mode/yaml/yaml',
        'backbone.layoutmanager': '../lib/backboneExtensions/backbone.layoutmanager',
        'timezone': '../lib/timezone/'
    },
    shim: {
        'jquery.transit': ['jquery'],
        'jquery.ui': ['jquery'],
        'jquery.ui.widget': ['jquery.ui'],
        'jquery.eventpri': ['jquery.ui.widget'],
        'jquery.hotkeys': ['jquery'],
        'bootstrap': ['jquery'],
        '../lib/bootstrap-notify/bootstrap-notify': ['bootstrap'],
        'fileUpload/jquery.fileupload': ['fileUpload/jquery.iframe-transport'],
        'codemirror_python': {
            deps: ['codemirror'],
            exports: 'CodeMirror'
        },
        'codemirror_sql': {
            deps: ['codemirror'],
            exports: 'CodeMirror'
        },
        'codemirror_yaml': {
            deps: ['codemirror'],
            exports: 'CodeMirror'
        },
        'underscore': {
            exports: '_'
        },
        'backbone': {
            deps: ['underscore', 'jquery'],
            exports: 'Backbone'
        },
        'auth': ['jquery'],
        '../lib/sugar': [],
        'backbone.layoutmanager': ['backbone']

    },
    deps: [
        'auth',
        'jquery.eventpri',
        '../lib/sugar',
        '../lib/bootstrap-notify/bootstrap-notify',
        '../lib/backboneExtensions/backbone.globaldispatch',
        '../lib/backboneExtensions/backbone.view.close',
        '../lib/backboneExtensions/backbone.sync.redirect'
    ]
});

