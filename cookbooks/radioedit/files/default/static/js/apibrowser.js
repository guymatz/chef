define(['src/setup', 'apibrowser/browser'], function(_, run) {
    $(function(){
        if (IHR.loggedIn()) {
            run();
        } else {
            $(IHR).on('authStatus', function(e, auth){
                if (auth.status == 'login') {
                    run();
                }
            });
        }

        $('body').tooltip({
            selector: '[data-tip]',
            title: function() {
                return $(this).data('tip');
            },
            delay: { show: 500, hide: 0 }
        });

    });
});
