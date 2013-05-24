/**
 * Copyright (c) 2012 Matthias Melitzer
 */
(function (window, $j, undefined) {

    var statics = {
        eventNamespace: 'priorityHandler',
        priorityData: 'POI.priority',
        handlerNS: 'handlerQueue',
        capturedEventNames: {},
        originalDispatchMethod: undefined,
        max_priority: 10,
        min_priority: -10,
        peek: 'justPeeking'
    };

    $j.widget("POI.onPriority", {
        // These options will be used as defaults
        options: {
            events: undefined,
            selector: undefined,
            data: undefined,
            fn: undefined,
            priority: 0,
            max_priority: statics.max_priority,
            min_priority: statics.min_priority
        },

        //runs only once/DOM element
        _create: function() {
            //capture for other events which don't need ordering
            if (!statics.originalDispatchMethod) {
                statics.originalDispatchMethod = $j.event.dispatch;
                this._replaceDispatchMethod();
            }
        },

        //runs each time the plugin is called which might be mutliple times/DOM element
        //Event-map isn't supported yet
        _init: function () {
            var options = this.options,
                eventNames, i;

            eventNames = this._parseEventNames(options.events, options.selector);
            for(i = 0; i<eventNames.length;i++){
                var name = eventNames[i];

                //only bind if not already bound to make sure the event bubbles all the way
                if (!statics.capturedEventNames[name]) {
                    statics.capturedEventNames[name] = {};
                    $j(window).on(name + "." + statics.eventNamespace, function(){
                        //no action necessary, only to ensure that event bubbling is over
                    });
                }
            };

            if(options.priority > statics.max_priority || options.priority < statics.min_priority)
            {
                throw "The priority can only be set between "+statics.max_priority+" and "+statics.min_priority+".";
            }
            options.data = (options.data || {});
            options.data[statics.priorityData] = options.priority;

            this.element.on(options.events, options.selector, options.data, options.fn);
        },

        /*********************************************************************************
         *
         * 							jQuery private methods
         *
         *********************************************************************************/
        _hoverHack: function( events ) {
            var rhoverHack = /(?:^|\s)hover(\.\S+)?\b/;
            return jQuery.event.special.hover ? events : events.replace( rhoverHack, "mouseenter$1 mouseleave$1" );
        },

        /*********************************************************************************
         *
         * 							jQuery private methods
         *
         *********************************************************************************/

        //partially taken from jQuery
        _parseEventNames: function(types, selector){
            var rtypenamespace = /^([^\.]*)?(?:\.(.+))?$/,
                t, tns, type, result = [];

            // Handle multiple events separated by a space
            // jQuery(...).bind("mouseover mouseout", fn);
            types = jQuery.trim(this._hoverHack(types)).split(" ");
            for (t = 0; t < types.length; t++) {
                tns = rtypenamespace.exec(types[t]) || [];
                type = tns[1];
                // If event changes its type, use the special event handlers for the changed type
                special = jQuery.event.special[type] || {};
                // If selector defined, determine special event api type, otherwise given type
                type = (selector ? special.delegateType : special.bindType) || type;
                result[t] = type;
            }
            return result;
        },

        /**
         * Method has to be overwritten as we want to encapsulate the event
         * handling chain, first the priority of events is taken into account,
         * secondly the regular bubbling hierarchy is used. Most of the code is
         * copied directly from jQuery, the only adaptions are regarding resorting
         * the handler's based on a priority and the wrapping of the event bubbling
         * to ensure all handler's are included.
         **/
        _replaceDispatchMethod: function() {
            var _quickIs = function( elem, m ) {
                var attrs = elem.attributes || {};
                return ((!m[1] || elem.nodeName.toLowerCase() === m[1]) &&
                    (!m[2] || (attrs.id || {}).value === m[2]) &&
                    (!m[3] || m[3].test( (attrs[ "class" ] || {}).value ))
                    );
            };

            //CAREFUL: this isn't ourself here, rather it's the element
            $j.event.dispatch = function(event){

                //event isn't interested in ordering by priority
                if (statics.capturedEventNames[event.type] === undefined) {
                    return statics.originalDispatchMethod ? statics.originalDispatchMethod.apply(this, arguments) : null;
                }

                // Make a writable $j.Event from the native event object
                event = $j.event.fix(event || window.event);
                var handlers = (($j._data(this, "events") || {})[event.type] || []),
                    delegateCount = handlers.delegateCount,
                    args = [].slice.call(arguments, 0),
                    run_all = !event.exclusive && !event.namespace,
                    special = $j.event.special[event.type] || {},
                    handlerQueue = [], i, j, cur, jqcur, ret, selMatch, matched, matches, handleObj, sel, related;

                // Use the fix-ed $j.Event rather than the (read-only) native event
                args[0] = event;
                event.delegateTarget = this;
                // Call the preDispatch hook for the mapped type, and let it bail if desired
                if (special.preDispatch && special.preDispatch.call(this, event) === false) {
                    return;
                }
                // Determine handlers that should run if there are delegated events
                // Avoid non-left-click bubbling in Firefox (#3861)
                if (delegateCount && !(event.button && event.type === "click")) {
                    // Pregenerate a single $j object for reuse with .is()
                    jqcur = $j(this);
                    jqcur.context = this.ownerDocument || this;
                    for (cur = event.target; cur != this; cur = cur.parentNode || this) {
                        // Don't process events on disabled elements (#6911, #8165)
                        if (cur.disabled !== true) {
                            selMatch = {};
                            matches = [];
                            jqcur[0] = cur;
                            for (i = 0; i < delegateCount; i++) {
                                handleObj = handlers[i];
                                sel = handleObj.selector;
                                if (selMatch[sel] === undefined) {
                                    selMatch[sel] = (handleObj.quick ? _quickIs(cur, handleObj.quick) : jqcur.is(sel));
                                }
                                if (selMatch[sel]) {
                                    matches.push(handleObj);
                                }
                            }
                            if (matches.length) {
                                handlerQueue.push({
                                    elem: cur,
                                    matches: matches
                                });
                            }
                        }
                    }
                }
                // Add the remaining (directly-bound) handlers
                if (handlers.length > delegateCount) {
                    handlerQueue.push({
                        elem: this,
                        matches: handlers.slice(delegateCount)
                    });
                }

                //has to exist as we have an exit clause on top of the function
                statics.capturedEventNames[event.type][statics.handlerNS] = statics.capturedEventNames[event.type][statics.handlerNS] || [];

                if(!!handlerQueue.length) {
                    statics.capturedEventNames[event.type][statics.handlerNS].push(handlerQueue);
                }

                if(this === window)
                {
                    var accumulatedHandlers = _.flatten(statics.capturedEventNames[event.type][statics.handlerNS]),
                        sortedHandlers = [], sortedElement, sortedMatch, sortedMatches, requireResort = false;

                    //from now on we work with the sorted copy or if it wasn't necessary just with a local copy
                    delete statics.capturedEventNames[event.type][statics.handlerNS];

                    //check if our handler is the only one registered, if so, ignore
                    if (accumulatedHandlers.length === 1 						//only one level is interested in the event
                        && accumulatedHandlers[0].matches.length === 1 			//only one handler (that's us)
                        && accumulatedHandlers[0].matches[0].namespace === statics.eventNamespace)	//make sure it's our handler
                    {
                        //no sorting or handling necessary
                        return;
                    }

                    //iterate over all levels
                    for (i = 0; i < accumulatedHandlers.length; i++) {
                        sortedElement = accumulatedHandlers[i].elem;
                        sortedMatches = accumulatedHandlers[i].matches;
                        for (j = 0; j < sortedMatches.length; j++) {
                            sortedMatch = sortedMatches[j];
                            if(sortedMatch.data && sortedMatch.data[statics.priorityData]){
                                requireResort = true;
                            }
                            sortedHandlers.push({
                                elem: sortedElement,
                                matches: sortedMatch
                            });
                        }
                    }

                    if(!!sortedHandlers.length && requireResort){
                        function sortByPriority(a,b){
                            var aPrio = (a.matches.data || {})[statics.priorityData] || 0,
                                bPrio = (b.matches.data || {})[statics.priorityData] || 0;
                            //revert order if prio is not 0, keep prio for 0
                            if (aPrio || bPrio) {
                                return aPrio > bPrio ? -1 : 1;
                            }
                            return aPrio >= bPrio ? -1 : 1;
                        };
                        sortedHandlers.sort(sortByPriority);
                    }

                    //used when peeking to get the highest priority
                    if(sortedHandlers[0].matches.namespace.indexOf(statics.peek)!==-1)
                    {
                        var matched = sortedHandlers[0];
                        args.push(sortedHandlers.slice(1));
                        return matched.matches.handler.apply(matched.elem, args);
                    }

                    // Run delegates first; they may want to stop propagation beneath us
                    for (i = 0; i < sortedHandlers.length; i++) {
                        matched = sortedHandlers[i];
                        //uncommented as bubbling doesn't really match our concept of priorities
                        //stop bubbling only if the context switches
//						if(event.isPropagationStopped() && lastContext && lastContext != matched.elem){
//							//we don't allow preventing bubbling when specifying a priority
//							currentPriority = (event.data || {})[statics.priorityData]||0;
//
//							if (!currentPriority) {
//								return;
//							}
//						}
//						lastContext = matched.elem;
                        event.currentTarget = matched.elem;
                        if(matched.matches){
                            if (event.isImmediatePropagationStopped()) {
                                return;
                            }
                            handleObj = matched.matches;
                            // Triggered event must either 1) be non-exclusive and have no namespace, or
                            // 2) have namespace(s) a subset or equal to those in the bound event (both can have no namespace).
                            if (run_all || (!event.namespace && !handleObj.namespace) || event.namespace_re && event.namespace_re.test(handleObj.namespace)) {
                                event.data = handleObj.data;
                                event.handleObj = handleObj;
                                ret = (($j.event.special[handleObj.origType] || {}).handle || handleObj.handler).apply(matched.elem, args);
                                if (ret !== undefined) {
                                    event.result = ret;
                                    if (ret === false) {
                                        event.preventDefault();
                                        event.stopPropagation();
                                    }
                                }
                            }
                        }
                    }
                    // Call the postDispatch hook for the mapped type
                    if (special.postDispatch) {
                        special.postDispatch.call(this, event);
                    }
                    return event.result;
                }
                // Call the postDispatch hook for the mapped type
                if (special.postDispatch) {
                    special.postDispatch.call(this, event);
                }
            }
        },

        _setOption: function (key, value) {
            switch (key) {
                case "max_priority":
                    if(value<this.options.min_priority){
                        throw "The max. priority can't be lower than the min. priority";
                    }
                    statics.max_priority = value;
                    break;
                case "min_priority":
                    if(value>this.options.max_priority){
                        throw "The min. priority can't be higher than the max. priority";
                    }
                    statics.min_priority = value;
                    break;
            }
            // In jQuery UI 1.8, you have to manually invoke the _setOption method from the base widget
            $j.Widget.prototype._setOption.apply(this, arguments);
            // In jQuery UI 1.9 and above, you use the _super method instead
            // this._super("_setOption", key, value);
        },

        // Use the destroy method to clean up any modifications your widget has made to the DOM
        destroy: function () {
            // In jQuery UI 1.8, you must invoke the destroy method from the base widget
            $.Widget.prototype.destroy.call(this);
            // In jQuery UI 1.9 and above, you would define _destroy instead of destroy and not call the base method
        }
    });

    $j.POI = $j.POI || {};

    $j.extend($j.POI, {
        peek: function(eventName, selector, lowest){
            if (typeof eventName !== 'string') {
                return;
            }
            var element, returnQueue = [];
            if (typeof selector === 'string' || !(selector instanceof $j)) {
                element = $j(selector);
            }
            element = element || selector;
            if (!element || (element && element.length === 0)) {
                throw "No elements were found with the provided selector";
            }
            $j(window).onPrio(eventName + "." + statics.peek, function(event, data){
                $j(window).off("." + statics.peek);
                returnQueue = data || returnQueue;
            }, statics.max_priority);
            element.trigger(eventName + "." + statics.peek);
            if (lowest) {
                return ((((returnQueue || [])[returnQueue.length - 1] || {}).matches || {}).data || {})['POI.priority'] || 0;
            }
            return ((((returnQueue || [])[0] || {}).matches || {}).data || {})['POI.priority'] || 0;
        }
    });

    function registerHandler(types, selector, data, fn, firstOrLast){
        //taken from jQuery.fn.on
        var origFn, type;
        // Types can be a map of types/handlers
        if (typeof types === "object") {
            // ( types-Object, selector, data )
            if (typeof selector !== "string") { // && selector != null
                // ( types-Object, data )
                data = data || selector;
                selector = undefined;
            }
            for (type in types) {
                registerHandler.call(this, type, selector, data, types[type], firstOrLast);
            }
            return this;
        }
        if (data == null && fn == null) {
            // ( types, fn )
            fn = selector;
            data = selector = undefined;
        } else if (fn == null) {
            if (typeof selector === "string") {
                // ( types, selector, fn )
                fn = data;
                data = undefined;
            } else {
                // ( types, data, fn )
                fn = data;
                data = selector;
                selector = undefined;
            }
        }
        if (fn === false) {
            fn = returnFalse;
        } else if (!fn) {
            return this;
        }
        return this.each(function(){
            if(typeof firstOrLast === 'boolean'){
                var sel = selector || this;
                priority = firstOrLast ? $j.POI.peek(types, sel, firstOrLast)-1 : $j.POI.peek(types, sel, firstOrLast)+1;
                if (priority > statics.max_priority) {
                    statics.max_priority = priority+5;
                }
                else if (priority < statics.min_priority) {
                    statics.min_priority = priority-5;
                }
            }
            $j(this).onPriority({'events':types, 'selector':selector, 'data':data, 'fn':fn, 'priority':priority});
        });
    }

    $j.fn.addFirst = function(types, selector, data, fn){
        return registerHandler.call(this, types, selector, data, fn, false);
    }

    $j.fn.addLast = function(types, selector, data, fn){
        return registerHandler.call(this, types, selector, data, fn, true);
    }

    /**
     * Just for convenience to allow calling in natural fashion instead of object literal
     * @param {Object} event see jQuery on method
     * @param {Object} selector see jQuery on method
     * @param {Object} data see jQuery on method
     * @param {Object} handler see jQuery on method
     * @param {Object} priority a priority between 10 and -10
     */
    $j.fn.onPrio = function(types, selector, data, fn, priority){
        /**
         * influenced by jQuery.on
         */
        var type;
        // Types can be a map of types/handlers
        if (typeof types === "object") {
            // (types-Object, priority)
            if(typeof selector === "number"){
                priority = selector;
                selector = data = undefined;
            }
            // ( types-Object, selector, priority )
            else if (typeof selector === "string" && typeof data === "number") {
                priority = data;
                data = undefined;
            }
            // ( types-Object, data, priority )
            else if (typeof selector !== "string" && typeof data === "number") {
                priority = data;
                data = selector;
                selector = undefined;
            }
            // ( types-Object, selector, data, priority )
            else if (typeof fn === "number") {
                priority = fn;
            }
            for (type in types) {
                this.onPrio(type, selector, data, types[type], priority);
            }
            return this;
        }
        //function(types, selector, data, fn, priority)
        if (!fn && fn != 0 && !priority) {
            // (types, fn, priority)
            fn = selector;
            priority = data;
            data = selector = undefined;
        }
        else if (!priority) {
            if (typeof selector === "string") {
                // ( types, selector, fn )
                priority = fn;
                fn = data;
                data = undefined;
            } else {
                // ( types, data, fn )
                priority = fn;
                fn = data;
                data = selector;
                selector = undefined;
            }
        }
        if (fn === false) {
            fn = returnFalse;
        } else if (!fn) {
            return this;
        }
        return this.each(function(){
            $j(this).onPriority({'events':types, 'selector':selector, 'data':data, 'fn':fn, 'priority':priority});
        });
    };
})(window, jQuery);