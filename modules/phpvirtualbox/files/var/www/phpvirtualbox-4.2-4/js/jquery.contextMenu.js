/* jQuery Context Menu Plugin

Version 1.01

Cory S.N. LaViska
A Beautiful Site (http://abeautifulsite.net/)

More info: http://abeautifulsite.net/2008/09/jquery-context-menu-plugin/

//
// Terms of Use
//
// This plugin is dual-licensed under the GNU General Public License
//   and the MIT License and is copyright A Beautiful Site, LLC.
//

This jQuery plugin now hardly resembles the original.

$Id: jquery.contextMenu.js 496 2012-11-02 13:04:44Z imooreyahoo@gmail.com $


*/
if(jQuery)( function() {
	
	$.extend($.fn, {
		
		contextMenu: function(o, callback) {
			// Defaults
			if( o.menu == undefined ) return false;
			if( o.inSpeed == undefined ) o.inSpeed = 150;
			if( o.outSpeed == undefined ) o.outSpeed = 75;
			// 0 needs to be -1 for expected results (no fade)
			if( o.inSpeed == 0 ) o.inSpeed = -1;
			if( o.outSpeed == 0 ) o.outSpeed = -1;
			if( o.button == undefined) o.button = 2;
			if( o.clickthrough == undefined) o.clickthrough = false;
			
			// Loop each context menu
			$(this).each( function() {
				
				var el = $(this);								
				var menu = $('#'+o.menu);
								
				// Simulate a true click
				$(this).mousedown( function(e) {
					
					if( $(el).hasClass('disabled') ) return true;
					if(!( e.button == o.button || (o.button == 0 && e.button == 1 && $.browser.msie))) return;
					if(o.clickthrough) $(el).trigger('click');
					var evt = e;
					evt.stopPropagation();
					
					$(this).mouseup( function(e) {
						
						e.stopPropagation();
						
						var srcElement = $(this);
						$(this).unbind('mouseup');
						
						if( evt.button == o.button || (o.button == 0 && evt.button == 1 && $.browser.msie)) {
						
							// Menu setup function
							if(o.menusetup) {
								o.menusetup(el);
							}
							// Hide context menus that may be showing
							$("ul.contextMenu").hide();
							
							showMenu(srcElement, menu, o.mode, e);
																					
							$(document).one('mouseup', function() {
								$(menu).fadeOut(o.outSpeed);
								$("ul.contextMenu").hide();
							});
						}
					});
				});

				/*
				 * Initialize menu items
				 * 
				 */
				var menuItems = function(menu, srcElement, level) {
					
					// When items are selected
					$(menu).addClass('contextMenu').data({'level':level}).disableSelection().children('li').unbind('mouseup').bind('mouseup', function(e) {
						
						if($(this).hasClass('disabled')) {
							return;							
						} 
						
						$("ul.contextMenu").hide();
						
						// Callback
						if( callback ) {
							var aElm = $(this).children('a');
							if($(aElm)[0]) {
								callback( aElm.attr('href').substr(1), $(srcElement), null, aElm);
							} else {
								$(this).children('.vboxMenuAcceptClick').click();
							}
						}
						

					}).hover( function(e, li) {
						
						$('#vboxPane').trigger('contextMenuShowLevel',
								{'level':$(this).parent().data('level'), 'id':$(this).parent().attr('id')}
						);

						$(menu).find('LI.hover').removeClass('hover');
						if($(this).hasClass('disabled')) return;
							
						$(this).addClass('hover');
						
						var subMenuId = $(this).data('subId');
						if(subMenuId) showMenu($(this),$('#'+subMenuId),'submenu',e);
						
					},function() {
						
						$(menu).find('LI.hover').removeClass('hover');
						
					}).children('a').unbind('click').bind('click',function(e){
						e.preventDefault();
						return false;
					});
					
					// Sub menu initialization
					$(menu).children('li').children('ul').each(function() {
						
						var plink = $(this).siblings('a').first();
						var subId = $(this).attr('id');
						if(!subId) {
							var href = plink.attr('href').replace('#','');
							subId = href + '-Submenu';
							$(this).attr('id', subId);
						}
						$(this).addClass('contextMenu contextSubMenu').data({'level':level+1}).parent().addClass('contextMenuParent').data({'subId':subId,'level':level});
						var html = plink.html();
						plink.html('<table class="vboxInvisible" style="width:100%"><tr><td style="text-align:left">'+html+'</td><td style="text-align:right; width: 22px;"><img src="images/rightArrow.png" /></td></tr></table>');
						
						// Hide menus trigger
						var smenu = this;
						$('#vboxPane').bind('contextMenuShowLevel',function(e,c){
							if($(smenu).data('level') >= c.level && $(smenu).attr('id') != c.id)
								$(smenu).hide();
						});
						
						// Reloop through setup
						menuItems($(this), srcElement, ++level);
						
						$(this).detach().appendTo($('#vboxPane'));
						

					});
					
					
				};

				
				/*
				 * 
				 * Activate menu items
				 * 
				 */
				
				var showMenu = function(srcElement, menu, mode, e) {
					
					// Check menu
					if(!$(menu)[0]) {
						return;
					}
					
					// Hide all other menus at this level
					$('#vboxPane').trigger('contextMenuShowLevel', {'level':$(menu).data('level'), 'id':$(menu).attr('id')});
					
					// Detect mouse position
					var d = {};
					
					var x = null;
					var y = null;
					
					if(mode == 'menu') {
				 		x = $(srcElement).offset().left;
			 			y = $(srcElement).offset().top + $(srcElement).outerHeight();		
					} else if(mode == 'submenu') {
						y = $(srcElement).offset().top;									
				 		x = $(srcElement).offset().left + $(srcElement).outerWidth();
					} else {
						
						if( self.innerHeight ) {
							d.pageYOffset = self.pageYOffset;
							d.pageXOffset = self.pageXOffset;
							d.innerHeight = self.innerHeight;
							d.innerWidth = self.innerWidth;
						} else if( document.documentElement &&
							document.documentElement.clientHeight ) {
							d.pageYOffset = document.documentElement.scrollTop;
							d.pageXOffset = document.documentElement.scrollLeft;
							d.innerHeight = document.documentElement.clientHeight;
							d.innerWidth = document.documentElement.clientWidth;
						} else if( document.body ) {
							d.pageYOffset = document.body.scrollTop;
							d.pageXOffset = document.body.scrollLeft;
							d.innerHeight = document.body.clientHeight;
							d.innerWidth = document.body.clientWidth;
						}

						$(menu).css({'left':0,'top':0});

						(e.pageX) ? x = e.pageX : x = e.clientX + d.scrollLeft;
						(e.pageY) ? y = e.pageY : y = e.clientY + d.scrollTop;
						
					
					}
					
					// shift left if submenu
					if($(menu).data('level')) x-=3;
					
					//adjust to ensure menu is inside viewable screen
					var right = x + $(menu).outerWidth();
					var bottom = y + $(menu).outerHeight();
					
					var windowWidth = $(window).width() + $(window).scrollLeft()-5;
					var windowHeight = $(window).height() + $(window).scrollTop()-5;
					
					x = (right > windowWidth) ? x - (right - windowWidth) : x;
					y = (bottom > windowHeight) ? y - (bottom - windowHeight) : y;

					
					$(menu).one('menuLoaded',function(){
						menuItems(menu, srcElement);
					});
					
					// Check for callback if nothing is present
					if($(menu).children().length == 0 && $(menu).data('callback')) {
						
						
						var m = window[$(menu).data('callback')](menu);
						
						// New menu returned?
						if(m) {
							$(m).addClass('contextSubMenu contextMenuLevel' + ($(menu).data('level')+1)).data('level',($(menu).data('level')+1));
							// Hide menus trigger
							$('#vboxPane').bind('contextMenuShowLevel',function(e,c){
								if($(m).data('level') >= c.level && $(m).attr('id') != c.id) $(m).hide();
							});
					
							menuItems(m, srcElement, $(menu).data('level')+1);
							
							showMenu(srcElement, m, 'submenu', e);
							
							return;
						}
					} else {
						menuItems(menu, srcElement, $(menu).data('level'));
					}
					
					// Menu  show
					$(menu).css({ top: y, left: x}).show();//.fadeIn(o.inSpeed);
					
					
				};
				
				// Setup menu 
				menuItems(menu, el, 0);
				
				
				// Disable browser context menu (requires both selectors to work in IE/Safari + FF/Chrome)
				$(el).add($('UL.contextMenu')).bind('contextmenu', function() { return false; });
				
			});
			return $(this);
		},
		
		// Disable context menu items on the fly
		disableContextMenuItems: function(o) {
			if( o == undefined ) {
				// Disable all
				$(this).find('LI').addClass('disabled');
				return( $(this) );
			}
			$(this).each( function() {
				if( o != undefined ) {
					var d = o.split(',');
					for( var i = 0; i < d.length; i++ ) {
						$(this).find('A[href="' + d[i] + '"]').closest('li').addClass('disabled');
						
					}
				}
			});
			return( $(this) );
		},
		
		// Enable context menu items on the fly
		enableContextMenuItems: function(o) {
			if( o == undefined ) {
				// Enable all
				$(this).find('LI.disabled').removeClass('disabled');
				return( $(this) );
			}
			$(this).each( function() {
				if( o != undefined ) {
					var d = o.split(',');
					for( var i = 0; i < d.length; i++ ) {
						$(this).find('A[href="' + d[i] + '"]').closest('li').removeClass('disabled');
						
					}
				}
			});
			return( $(this) );
		},
		
		// Disable context menu(s)
		disableContextMenu: function() {
			$(this).each( function() {
				$(this).addClass('disabled');
			});
			return( $(this) );
		},
		
		// Enable context menu(s)
		enableContextMenu: function() {
			$(this).each( function() {
				$(this).removeClass('disabled');
			});
			return( $(this) );
		},
		
		// Destroy context menu(s)
		destroyContextMenu: function() {
			// Destroy specified context menus
			$(this).each( function() {
				// Disable action
				$(this).unbind('mousedown').unbind('mouseup');
			});
			return( $(this) );
		}
		
	});
})(jQuery);