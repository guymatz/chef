(function() {
    "use strict";
    var IHR = {};

    IHR.iFrames = {};

    IHR.session = {};

    IHR.getRoot = function() {
        return document.getElementById('ihr-root');
    };

    IHR.getSessionStatus = function() {
        return IHR.session;
    };

    IHR.loggedIn = function() {
        return IHR.session.hasOwnProperty('access_token');
    };

    IHR.createIFrame = function(id, url, callback) {
        var iFrame = document.createElement('iframe'),
            listener = function(event) {
                //console.log('auth.js message=', event.data, 'origin=', event.origin);
                if (event.source === iFrame.contentWindow) {
                    IHR.session = event.data;

                    if (callback) {
                        callback(IHR.getSessionStatus());
                    }

                    $(IHR).trigger('authStatus', {status: 'login', session: IHR.getSessionStatus()});
                }
            };

        window.addEventListener("message", listener);

        iFrame.src = url;
        iFrame.id = id;
        this.getRoot().appendChild(iFrame);
    };

    IHR.init = function(authServerUrl) {
        this.authServerUrl = authServerUrl || "http://auth.iheart.com/";
    };

    IHR.login = function(client_id, callback) {
        this.createIFrame('auth_iframe', this.authServerUrl + 'xd_gateway?client_id=featuredcontent&redirect_uri=' + encodeURIComponent(window.location), callback);
    };

    IHR.logout = function(callback) {
        this.createIFrame('auth_iframe', this.authServerUrl + 'auth/sign_out', callback);
    };

    window.IHR = IHR;
})();