(function() {
    "use strict";
    var IHR = {
        iFrames: {},

        getRoot: function() {
            return document.getElementById('ihr-root');
        },

        createIFrame: function(id, url, callback) {
            var iFrame = document.createElement('iframe'),
                listener = function(event) {
                    console.log('auth.js message=', event.data, 'origin=', event.origin);
                    if (event.source === iFrame.contentWindow) {
                        var message = event.data;
                        if (callback) {
                            callback(message);
                        }
                    }
                };

            window.addEventListener("message", listener);

            iFrame.src = url;
            iFrame.id = id;
            this.getRoot().appendChild(iFrame);
        },

        init: function(authServerUrl) {
            this.authServerUrl = authServerUrl || "http://auth.iheart.com/";
        },

        login: function(client_id, callback) {
            this.createIFrame('auth_iframe', this.authServerUrl + 'xd_gateway?client_id=featuredcontent&redirect_uri=' + encodeURIComponent(window.location), callback);
        },

        logout: function(callback) {
            this.createIFrame('auth_iframe', this.authServerUrl + 'auth/sign_out', callback);
        }

    };
    window.IHR = IHR;
})();