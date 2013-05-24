require({
    paths: {
        'jquery': '../lib/jquery/jquery-1.7.2',
        'underscore': '../lib/underscore',
        'backbone': '../lib/backbone-0.9.2',
        'handlebars': '../lib/handlebars',
        'text': '../lib/require/text',
        'templates': '../templates',
        'eco': '../templates',
        'multiDatePicker': '../lib/multiDatePicker',
        'dateRangePicker': '../lib/dateRangePicker',
        'fileUpload': '../lib/jquery/fileUpload',
        'jquery.ui.widget': '../lib/jquery/jquery.ui.widget',
        'jquery.ui': '../lib/jquery/jquery-ui-1.8.21.custom.min',
        'jquery.eventpri': '../lib/jquery/jquery.eventpri',
        'bootstrap': '../lib/bootstrap',
        'notify': '../lib/bootstrap-notify/bootstrap-notify',
        'rivets': '../lib/rivets'
    },
    shim: {
        'jquery': {
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
        '../lib/chosen/chosen.jquery': ['jquery'],
        'notify': ['jquery', 'bootstrap/bootstrap-alert'],
        'underscore': {
            exports: '_'
        },
        'backbone': {
            deps: ['underscore', 'jquery'],
            exports: 'Backbone'
        },
        'handlebars': {
            exports: 'Handlebars'
        },
        //'../lib/jquery/quicksand': ['jquery'],
        'rivets': {
            exports: 'rivets'
        }
    },
    deps: [
        'auth',
        'notify',
        'jquery.eventpri',
        'bootstrap/bootstrap-button',
        'bootstrap/bootstrap-dropdown',
        'bootstrap/bootstrap-tooltip',
        'bootstrap/bootstrap-modal',
        'bootstrap/bootstrap-transition',
        'bootstrap/bootstrap-popover',
        'bootstrap/bootstrap-tab',
        '../lib/json2',
        '../lib/chosen/chosen.jquery',
        '../lib/sugar-1.2.5.min',
        '../lib/backboneExtensions/backbone.view.close',
        '../lib/backboneExtensions/backbone.view.rivets'
        //require('lib/jquery/quicksand');
        //require('lib/dragdrop');
    ]
});

require(['jquery'], function() {
    $.ajaxSetup({
        beforeSend: function(xhr, settings) {
            if(SEND_AUTH !== false && !settings.crossDomain) {
                settings.url += (/\?/.test(settings.url) ? '&' : '?') + "access_token=" + TOKEN.access_token;
//                xhr.withCredentials = true;
//                xhr.setRequestHeader('Authorization', 'Bearer ' + TOKEN.access_token_base64)
            }
        }
    });

    console.log('initialized');
});
