define(['src/setup', 'src/browse'], function(_, run) {
    $(function(){
        $('body').on('click', 'a.disabled', function(e){
            e.preventDefault();
        });

        $('body').tooltip({
            selector: '[data-tip]',
            title: function() {
                return $(this).data('tip');
            },
            delay: { show: 500, hide: 0 }
        });

        $('head').append(
            $('<style type="text/css">.panel {min-height: '+$(window).height()+'px;}</style>')
        );

        if (IHR.loggedIn()) {
            run();
        } else {
            $(IHR).on('authStatus', function(e, auth) {
                if (auth.status === 'login') {
                    run();
                }
            });
        }

    });
});
