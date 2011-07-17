			
		
			var qs = new Querystring();

			var uid = qs.get("id", "");
			
			var api_key = '';
			var baseurl = '';
			var azure = '';
			
			var host = window.location.host;
			if (host.indexOf('.dev') > -1) {
				api_key = '9aadd2a49b99775d3f25ef024703e252';
				baseurl = 'http://facebook.dev';
				azure = 'http://pringlesoversharers.cloudapp.net';
			} else if (host.indexOf('pandg.wunder') > -1) {
				api_key = '845564eba76584e3c7c0e59d303454f2';
				baseurl = 'http://pandg.wundermaninteractive.com/oversharersqa';
				azure = 'http://pringlesoversharers.cloudapp.net';
			} else if (host.indexOf('oversharers.staging2.') > -1) {
				api_key = '4a8f91a9090eb4b8d710d3d1124b8c9f';
				baseurl = 'http://pandg.oversharers.staging2.wundermaninteractive.com';
				azure = 'http://pringlesoversharers.cloudapp.net';
            } else if (host.indexOf('oversharers.staging.') > -1) {
				api_key = '4b0f5ac0d4c2dc2cabb88077ac1f4ff2';
				baseurl = 'http://pandg.oversharers.staging.wundermaninteractive.com';
				azure = 'http://pringlesoversharers.cloudapp.net';
            } else {
				api_key = '922991cfa0a366c101c9f0981c79f0ed';
				baseurl = 'http://www.helptheoversharers.com';
				azure = 'http://pringlesoversharers.cloudapp.net';
			}
			
			
			//fetches the flash movie
			function thisMovie(movieName) {
			    if (navigator.appName.indexOf("Microsoft") != -1) {
			        return window[movieName];
			    } else {
			        return document[movieName];
			    }
			}
			
		
			FB_RequireFeatures(["Api"], function() {
				FB.Facebook.init(api_key, '/xd_receiver.htm');
			});
			
			//called from flash to get a facebook session and pass back to flash
			function initFacebookJS(){
				FB.Bootstrap.requireFeatures(["Connect"], function() {
					FB.Connect.requireSession(function(exception) {
						//define your flashVars
						//Pull out the current session data from Facebook
						var sessionData = FB.Facebook.apiClient.get_session();
						var flashvars = {as_swf_name:"flashContent", session_key:sessionData.session_key, secret:sessionData.secret};
						//locate movie and call initFacebookFlash callback in there
						thisMovie(flashvars.as_swf_name).initFacebookFlash(flashvars);
					});
				});
			}
			
			var params = {bgcolor:"#FFFFFF", wmode: "opaque", allowscriptaccess: "always"};
			var attributes = {id:"flash", name:"flashContent"};
			swfobject.addLoadEvent(function(){
				
			
				swfobject.embedSWF("application.swf", "container", "100%", "600", "10.0.0", "", {uid: uid, api_key: api_key, baseurl: baseurl, azure: azure}, params, attributes, swfObjectCb);
				swffit.fit("flash",950,590);
			});
			
			function swfObjectCb(e) {
				//document.getElementById('container').style.visibility = 'visible';
			}