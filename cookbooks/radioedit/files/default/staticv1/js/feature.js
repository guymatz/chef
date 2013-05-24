define(['src/list'], function(run) {
    console.log('main');
    $(function(){
        $('body').on('click', 'a.disabled', function(e){
            e.preventDefault();
        });

        $('body').tooltip({
            selector: '[data-tip]',
            title: function() {
                return $(this).data('tip');
            }
        });

        $('head').append(
            $('<style type="text/css">.panel {min-height: '+$(window).height()+'px;}</style>')
        );

        IHR.init(window.AUTH_SERVER);
        IHR.login("featuredcontent", function(obj) {
            if (obj.access_token) {

                window.TOKEN = obj;

                $.get("/api/v1/private/me/", function(obj) {
                    window.USER = obj;

                    $(".navbar .welcome").html(
                        '<p class="navbar-text">Welcome, <strong>' + (obj.username || obj.id) + '</strong> | '
                            + '<a id="sign_out" href="#">sign out</a></p>'
                    ).on('click', '#sign_out', function(event) {
                            event.preventDefault();
                            IHR.logout(function(result) {
                                window.location = '/';
                            });
                        });

                    run();
                });
            }
        });
    });
});


//require(['pageSetup', 'src/list'], function(a, run) {
//    $(function(){
//        $('body').on('click', 'a.disabled', function(e){
//            e.preventDefault();
//        });
//
//        $('body').tooltip({
//            selector: '[data-tip]',
//            title: function() {
//                return $(this).data('tip');
//            }
//        });
//
//        $('head').append(
//            $('<style type="text/css">.panel {min-height: '+$(window).height()+'px;}</style>')
//        );
//
//        IHR.init(window.AUTH_SERVER);
//        IHR.login("featuredcontent", function(obj) {
//            if (obj.access_token) {
//
//                window.TOKEN = obj;
//
//                $.get("/api/v1/private/me", function(obj) {
//                    window.USER = obj;
//
//                    $(".navbar .welcome").html(
//                        '<p class="navbar-text">Welcome, <strong>' + (obj.username || obj.id) + '</strong> | '
//                        + '<a id="sign_out" href="#">sign out</a></p>'
//                    ).on('click', '#sign_out', function(event) {
//                        event.preventDefault();
//                        IHR.logout(function(result) {
//                            window.location = '/';
//                        });
//                    });
//
//                    run();
//                });
//            }
//        });
//    });
//
//
//});
