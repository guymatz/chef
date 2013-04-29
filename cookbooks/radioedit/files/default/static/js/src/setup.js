require(['auth', 'jquery'], function() {
    $(function(){

        IHR.init(window.AUTH_SERVER);

        IHR.login("featuredcontent", function(obj) {
            if (obj.access_token) {
                //window.TOKEN = obj;
            }
        });

        $(IHR).on('authStatus', function(e, auth){
            if (auth.status == 'login') {
                $.ajaxSetup({
                    beforeSend: function(xhr, settings) {
                        if(SEND_AUTH !== false && !settings.crossDomain) {
                            settings.url += (/\?/.test(settings.url) ? '&' : '?') + "access_token=" + auth.session.access_token;
                            //xhr.withCredentials = true;
                            //xhr.setRequestHeader('Authorization', 'Bearer ' + TOKEN.access_token_base64)
                        }
                    }
                });

                $.get("/api/v2/utils/me/").success(function(obj){
                    window.USER = obj;
                    $(".navbar .welcome").html(
                        '<p class="navbar-text">Welcome, <strong>' + (window.USER.first_name || window.USER.display_name || window.USER.id) + '</strong> | '
                            + '<a id="sign_out" href="#">sign out</a></p>'
                    )
                });
            }

        });

        $('body').on('click', '#sign_out', function(e) {
            e.preventDefault();
            IHR.logout(function(result) {
                window.location = '/';
            });
        });
    });
});
