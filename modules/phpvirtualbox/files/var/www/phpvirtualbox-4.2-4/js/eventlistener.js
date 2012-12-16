/**
 * 
 * @fileOverview Event listener singleton
 * @author Ian Moore (imoore76 at yahoo dot com)
 * @version $Id: eventlistener.js 489 2012-10-27 11:11:08Z imooreyahoo@gmail.com $
 * @copyright Copyright (C) 2010-2012 Ian Moore (imoore76 at yahoo dot com)
 */

/**
 * vboxEventListener
 * 
 * Polls vboxwebsrv for pending events and triggers
 * events on $('#vboxPane')
 * 
 * @namespace vboxEventListener
 */
var vboxEventListener = {
	
	// Not initially running
	_running : false,
	
	// persistent request data
	_persist: {},

	// List of machines to subscribe to at runtime
	_subscribeList : [],
	
	// Watchdog to make sure vboxEventListener is still
	// running and attempting to get events
	_watchdog : {
		lastRun : 0,
		timer : window.setInterval(function() {
			if(vboxEventListener._running && 
					((new Date().getTime()/1000) - vboxEventListener._watchdog.lastRun > 20000)) {
				phpVirtualBoxFailure();
				window.clearInterval(vboxEventListener._watchdog.timer);
			} 
		}, 20000) // 20 seconds
	},
		
	// Since VirtualBox handles to event listener objects are persistent,
	// calls using the same handle should be synchronous
	_requestQueue : {
		
		requests : [],
		running: false,
		
		// Add a request to the queue
		addReq : function(q) {
			
			var d = $.Deferred();
			
			vboxEventListener._requestQueue.requests.push({'request':q,'deferred':d});
			vboxEventListener._requestQueue.run();
			
			return d.promise();
		},
		
		// Run through the queue
		run : function() {
			
			// Already running through queue
			if(vboxEventListener._requestQueue.running) return;
			
			vboxEventListener._requestQueue.running = true;
			vboxEventListener._requestQueue.runReq();
			
		},
		
		// Run a single request, removing it from the queue
		runReq : function() {
			var r = vboxEventListener._requestQueue.requests.shift();
			if(r) {
				$.when(r.request())
					.done(r.deferred.resolve)
					.always(vboxEventListener._requestQueue.runReq);
			} else {
				vboxEventListener._requestQueue.running = false;
			}
		}
		
	},
	
	/**
	 *  Start event listener loop
	 *  @param {Array} vmlist - list of VM ids to subscribe to
	 */
	start : function(vmlist) {
		
		// Already started?
		if(vboxEventListener._running) return;
		
		vboxEventListener._running = true;
		
		var started = $.Deferred();
		
		// Subscribe to events and start main loop
		$.when(vboxAjaxRequest('subscribeEvents',{vms:vmlist})).done(function(d) {
			vboxEventListener._persist = d.persist;
			$.when(vboxEventListener._getEvents()).then(function(){
				started.resolve();
			});
		});
		
		return started.promise();
		
	},
	
	/**
	 * Subscribe to a single machine's events. This should happen
	 * 
	 * @param {String} vmid - ID of VM to subscribe to
	 */
	subscribeVMEvents : function(vmid) {
		
		// Push into list
		vboxEventListener._subscribeList.push(vmid);
		
		// Add subscription request to queue
		return vboxEventListener._requestQueue.addReq(function(){
			
			if(!vboxEventListener._subscribeList.length) return;
			
			var vms = vboxEventListener._subscribeList;
			vboxEventListener._subscribeList = [];
			
			return vboxAjaxRequest('machineSubscribeEvents', {'vms':vms,'_persist':vboxEventListener._persist});
			
		});
		
	},
	
	/**
	 *  Stop event listener loop and unsubscribe from events
	 */
	stop : function() {
		
		if(!vboxEventListener._running)
			return;
		
		window.clearTimeout(vboxEventListener._running);
		vboxEventListener._running = false;
		
		// Unsubscribe from events. Returns a deferred object
		return vboxEventListener._requestQueue.addReq(function(){
			return vboxAjaxRequest('unsubscribeEvents', {'_persist':vboxEventListener._persist});
		});
		
	},
	
	/**
	 * Main loop - get pending events
	 */
	_getEvents : function(){

		// Don't do anything if we aren't running anymore
		if(!vboxEventListener._running) return;
		
		// Add to queue
		return vboxEventListener._requestQueue.addReq(function(){
			
			return $.when(new Date().getTime(), vboxAjaxRequest('getEvents',{'_persist':vboxEventListener._persist})).then(function(lastTime,d) {
				
				// Don't do anything if this is not running
				if(!vboxEventListener._running) return;
				
				// Check for valid result
				if(!d.success) {
					if(vboxEventListener._running)
						phpVirtualBoxFailure();
					return;
				}
				
				
				// Check key to make sure this isn't a stale
				// response from a previously selected server
				if(!d.key || (d.key != $('#vboxPane').data('vboxConfig').key)) return;
				
				// Tell the watch dog that we were run
				vboxEventListener._watchdog.lastRun = (new Date().getTime() / 1000);
				
				// Always set persistent request data
				vboxEventListener._persist = d.persist;
				
				// Loop through each event triggering changes
				if(d.responseData && d.responseData.length) {
									
					// Trigger each event individually
					for(var i = 0; i < d.responseData.length; i++) {
	
						// Trigger raw vbox events
						$('#vboxPane').trigger('vbox' + d.responseData[i].eventType, [d.responseData[i]]);
						
					}
					
					// Trigger event list queue
					$('#vboxPane').trigger('vboxEvents', [d.responseData]);
					
				}
				
				// Wait at most 3 seconds
				var wait = 3000 - ((new Date().getTime()) - lastTime);
				if(wait <= 0) vboxEventListener._getEvents();
				else vboxEventListener._running = window.setTimeout(vboxEventListener._getEvents, wait);
				
			});

		});
	}
};

// Stop event listener on window unload
$(document).ready(function() {
	$(window).bind('unload',function() {
		vboxEventListener.stop();
	});	
});
