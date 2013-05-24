define(function(){
    return function(__obj) {
        if (!__obj) __obj = {};
        var __out = [], __capture = function(callback) {
            var out = __out, result;
            __out = [];
            callback.call(this);
            result = __out.join('');
            __out = out;
            return __safe(result);
        }, __sanitize = function(value) {
            if (value && value.ecoSafe) {
                return value;
            } else if (typeof value !== 'undefined' && value != null) {
                return __escape(value);
            } else {
                return '';
            }
        }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
        __safe = __obj.safe = function(value) {
            if (value && value.ecoSafe) {
                return value;
            } else {
                if (!(typeof value !== 'undefined' && value != null)) value = '';
                var result = new String(value);
                result.ecoSafe = true;
                return result;
            }
        };
        if (!__escape) {
            __escape = __obj.escape = function(value) {
                return ('' + value)
                    .replace(/&/g, '&amp;')
                    .replace(/</g, '&lt;')
                    .replace(/>/g, '&gt;')
                    .replace(/"/g, '&quot;');
            };
        }
        (function() {
            (function() {

                __out.push('<table class="table-condensed">\n    <thead>\n    <tr>\n        <th colspan="7">');

                __out.push(__sanitize(this.date.format('{yyyy}')));

                __out.push(' - ');

                __out.push(__sanitize(this.nextDate.format('{yyyy}')));

                __out.push('</th>\n    </tr>\n    </thead>\n    <tbody>\n    <tr>\n        <td colspan="7">\n            ');

                while (this.date.valueOf() < this.nextDate.valueOf()) {
                    __out.push('\n                <span class="year');
                    __out.push(__sanitize(this.renderLoopHelper(this)));
                    __out.push(' toMonth" data-date="');
                    __out.push(__sanitize(this.date.format(Date.ISO8601_DATETIME)));
                    __out.push('">');
                    __out.push(__sanitize(this.date.format('{yyyy}')));
                    __out.push('</span>\n\n                ');
                    this.date.advance({
                        years: 1
                    });
                    __out.push('\n            ');
                }

                __out.push('\n        </td>\n\n    </tr>\n    </tbody>\n</table>\n');

            }).call(this);

        }).call(__obj);
        __obj.safe = __objSafe, __obj.escape = __escape;
        return __out.join('');
    }
});
