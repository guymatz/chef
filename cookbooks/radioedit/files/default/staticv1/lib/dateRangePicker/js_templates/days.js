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
                var dateType, day, weekDay, weekDays, _i, _j, _len, _ref;

                __out.push('<table class="table-condensed">\n    <thead>\n    <tr>\n        <th colspan="7" class="switch toMonth" data-date="');

                __out.push(__sanitize(this.date.format(Date.ISO8601_DATETIME)));

                __out.push('">');

                __out.push(__sanitize(this.date.format('{Month} {yyyy}')));

                __out.push('</th>\n    </tr>\n    </thead>\n    <tbody>\n            <tr>\n                ');

                weekDays = Date.getLocale().weekdays.slice(7);

                __out.push('\n                ');

                for (_i = 0, _len = weekDays.length; _i < _len; _i++) {
                    weekDay = weekDays[_i];
                    __out.push('\n                    <th class="dow">');
                    __out.push(__sanitize(weekDay.slice(0, 2).capitalize()));
                    __out.push('</th>\n                ');
                }

                __out.push('\n            </tr>\n            ');

                if (this.startDayOfMonth !== 0) {
                    __out.push('\n                <tr>\n                ');
                    for (day = _j = _ref = this.startDayOfMonth; _ref <= 0 ? _j < 0 : _j > 0; day = _ref <= 0 ? ++_j : --_j) {
                        __out.push('\n                    <td></td>\n                ');
                    }
                    __out.push('\n            ');
                }

                __out.push('\n\n            ');

                while (this.date.valueOf() < this.nextDate.valueOf()) {
                    __out.push('\n                ');
                    if (this.date.getDay() === 0) {
                        __out.push('<tr>');
                    }
                    __out.push('\n\n                ');
                    dateType = this.renderLoopHelper(this);
                    __out.push('\n\n                ');
                    if (this.date.is(this.today)) {
                        __out.push('\n                    ');
                        dateType += ' today';
                        __out.push('\n                ');
                    }
                    __out.push('\n\n                <td class="day');
                    __out.push(__sanitize(dateType));
                    __out.push('" data-date="');
                    __out.push(__sanitize(this.date.format(Date.ISO8601_DATETIME)));
                    __out.push('">');
                    __out.push(__sanitize(this.date.getDate()));
                    __out.push('</td>\n\n                ');
                    if (this.date.getDay() === 6) {
                        __out.push('</tr>');
                    }
                    __out.push('\n\n                ');
                    this.date.setDate(this.date.getDate() + 1);
                    __out.push('\n            ');
                }

                __out.push('\n\n        ');

                if (this.date.getDay() !== 6) {
                    __out.push('</tr>');
                }

                __out.push('\n    </tbody>\n</table>\n');

            }).call(this);

        }).call(__obj);
        __obj.safe = __objSafe, __obj.escape = __escape;
        return __out.join('');
    }
});
