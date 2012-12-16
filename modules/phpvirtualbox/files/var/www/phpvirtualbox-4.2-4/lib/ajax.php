<?php
/**
 * Main ajax interface between JavaScript ajax calls and PHP functions.
 * Accepts JSON or simple GET requests, and returns JSON data.
 * 
 * @author Ian Moore (imoore76 at yahoo dot com)
 * @copyright Copyright (C) 2010-2012 Ian Moore (imoore76 at yahoo dot com)
 * @version $Id: ajax.php 496 2012-11-02 13:04:44Z imooreyahoo@gmail.com $
 * @package phpVirtualBox
 * @see vboxconnector
 * @see vboxAjaxRequest
 * 
 * @global array $GLOBALS['response'] resopnse data sent back via json 
 * @name $response
*/

# Turn off PHP errors
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_WARNING);


//Set no caching
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
header("Cache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0");
header("Pragma: no-cache");

require_once(dirname(__FILE__).'/config.php');
require_once(dirname(__FILE__).'/utils.php');
require_once(dirname(__FILE__).'/vboxconnector.php');

// Init session
global $_SESSION;

/*
 * Clean request
 */
$vboxRequest = clean_request();

global $response;
$response = array('data'=>array('responseData'=>array()),'errors'=>array(),'persist'=>array(),'messages'=>array());

/*
 * Built-in requests
 */
$vbox = null; // May be set during request handling

/**
 * Main try / catch. Logic dictated by incoming 'fn' request
 * parameter.
 */
try {
	
	/* Check for password recovery file */
	if(file_exists(dirname(dirname(__FILE__)).'/recovery.php')) {
		throw new Exception('recovery.php exists in phpVirtualBox\'s folder. This is a security hazard. phpVirtualBox will not run until recovery.php has been renamed to a file name that does not end in .php such as <b>recovery.php-disabled</b>.',vboxconnector::PHPVB_ERRNO_FATAL);	
	}
	
	/* Check for PHP version */
	if (!version_compare(PHP_VERSION, '5.2.0', '>=')) {
		throw new Exception('phpVirtualBox requires PHP >= 5.2.0, but this server is running version '. PHP_VERSION .'. Please upgrade PHP.');
	}

	/* Check for function called */
	switch($vboxRequest['fn']) {
	
		/*
		 * Return phpVirtualBox's configuration data
		 */
		case 'getConfig':
			
			$settings = new phpVBoxConfigClass();
			$response['data']['responseData'] = get_object_vars($settings);
			$response['data']['responseData']['host'] = parse_url($data['location']);
			$response['data']['responseData']['host'] = $data['host']['host'];
			$response['data']['responseData']['phpvboxver'] = @constant('PHPVBOX_VER');
			
			// Session
			session_init();
			
			// Hide credentials
			unset($response['data']['responseData']['username']);
			unset($response['data']['responseData']['password']);
			foreach($response['data']['responseData']['servers'] as $k => $v)
				$response['data']['responseData']['servers'][$k] = array('name'=>$v['name']);
						
			// Are default settings being used?
			if(@$settings->warnDefault) {
				throw new Exception("No configuration found. Rename the file <b>config.php-example</b> in phpVirtualBox's folder to <b>config.php</b> and edit as needed.<p>For more detailed instructions, please see the installation wiki on phpVirtualBox's web site. <p><a href='http://code.google.com/p/phpvirtualbox/w/list' target=_blank>http://code.google.com/p/phpvirtualbox/w/list</a>.</p>",vboxconnector::PHPVB_ERRNO_FATAL);
			}
			
			// Vbox version			
			$vbox = new vboxconnector();
			$response['data']['responseData']['version'] = $vbox->getVersion();
			$response['data']['responseData']['hostOS'] = $vbox->vbox->host->operatingSystem;
			$response['data']['responseData']['DSEP'] = $vbox->getDsep();
			$response['data']['responseData']['groupDefinitionKey'] = ($settings->phpVboxGroups ? vboxconnector::phpVboxGroupKey : 'GUI/GroupDefinitions');
			
			$response['data']['success'] = 1;
			
			break;
	
		/*
		 * 
		 * USER FUNCTIONS FOLLOW
		 * 
		 */
			
		/*
		 * Pass login to authentication module.
		 */
		case 'login':
			
			
			// NOTE: Do not break. Fall through to 'getSession
			if(!$vboxRequest['u'] || !$vboxRequest['p']) {
				break;	
			}

			// Session
			session_init(true);
			
			$settings = new phpVBoxConfigClass();

			// Try / catch here to hide login credentials
			try {
				$settings->auth->login($vboxRequest['u'], $vboxRequest['p']);
			} catch(Exception $e) {
				throw new Exception($e->getMessage(), $e->getCode());
			}
			
			// We're done writing to session
			if(function_exists('session_write_close'))
				@session_write_close();
			
			
		
		/*
		 * Return $_SESSION data
		 */
		case 'getSession':
			
			session_init(true);

			$settings = new phpVBoxConfigClass();
			if(method_exists($settings->auth,'autoLoginHook'))
			{
				// Session
				
				$settings->auth->autoLoginHook();
				
			
			}

			// We're done writing to session
			if(function_exists('session_write_close'))
				@session_write_close();

			$response['data']['responseData'] = $_SESSION;
			$response['data']['success'] = 1;
			break;
			
		/*
		 * Change phpVirtualBox password. Passed to auth module's
		 * changePassword method.
		 */
		case 'changePassword':

			// Session
			session_init(true);
			
			$settings = new phpVBoxConfigClass();
			$response['data']['success'] = $settings->auth->changePassword($vboxRequest['old'], $vboxRequest['new']);

			// We're done writing to session
			if(function_exists('session_write_close'))
				@session_write_close();
			
			break;
		
		/*
		 * Get a list of phpVirtualBox users. Passed to auth module's
		 * getUsers method.
		 */
		case 'getUsers':

			// Session
			session_init();
			
			// Must be an admin
			if(!$_SESSION['admin']) break;
			
			$settings = new phpVBoxConfigClass();
			$response['data']['responseData'] = $settings->auth->listUsers();
			$response['date']['success'] = 1;
			
			break;
			
		/*
		 * Remove a phpVirtualBox user. Passed to auth module's
		 * deleteUser method.
		 */
		case 'delUser':

			// Session
			session_init();
			
			// Must be an admin
			if(!$_SESSION['admin']) break;
	
			$settings = new phpVBoxConfigClass();
			$settings->auth->deleteUser($vboxRequest['u']);
			
			$response['data']['success'] = 1;
			break;
			
		/*
		 * Edit a phpVirtualBox user. Passed to auth module's
		 * updateUser method.
		 */
		case 'editUser':

			$skipExistCheck = true;
			// Fall to addUser

		/*
		 * Add a user to phpVirtualBox. Passed to auth module's
		 * updateUser method.
		 */
		case 'addUser':
	
			// Session
			session_init();

			// Must be an admin
			if(!$_SESSION['admin']) break;
			
			$settings = new phpVBoxConfigClass();
			$settings->auth->updateUser($vboxRequest, @$skipExistCheck);
						
			$response['data']['success'] = 1;
			break;

		/*
		 * Log out of phpVirtualBox. Passed to auth module's
		 * logout method.
		 */
		case 'logout':
		
			// Session
			session_init(true);
				
			$vbox = new vboxconnector();
			$vbox->skipSessionCheck = true;
			
			$settings = new phpVBoxConfigClass();
			$settings->auth->logout($response);
				
			session_destroy();
			
			$response['data']['success'] = 1;
		
			break;
					
					
		/*
		 * If the above cases did not match, assume it is a request
		 * that should be passed to vboxconnector.
		 */
		default:
	
			$vbox = new vboxconnector();

			
			/*
			 * Every 1 minute we'll check that the account has not
			 * been deleted since login, and update admin credentials.
			 */
			if($_SESSION['user'] && ((intval($_SESSION['authCheckHeartbeat'])+60) < time())) {
				
				// init session and keep it open
				session_init(true);
				$vbox->settings->auth->heartbeat($vbox);
			
				// We're done writing to session
				if(function_exists('session_write_close'))
					@session_write_close();
								
			} else {
				
				// init session but close it
				session_init();
				
			}
			
			/*
			 *  Persistent request data
			 */
			if(is_array($vboxRequest['_persist'])) {
				$vbox->persistentRequest = $vboxRequest['_persist'];
			}
			
			
			/*
			 * Call to vboxconnector
			 */
			$vbox->$vboxRequest['fn']($vboxRequest,array(&$response));
			
			
			/*
			 * Send back persistent request in response
			*/
			if(is_array($vbox->persistentRequest) && count($vbox->persistentRequest)) {
				$response['data']['persist'] = $vbox->persistentRequest;
			}
			break;
			
	} // </switch()>

/*
 * Catch all exceptions and populate errors in the
 * JSON response data.
 */
} catch (Exception $e) {

	// Just append to $vbox->errors and let it get
	// taken care of below
	if(!$vbox || !$vbox->errors) {
		$vbox->errors = array();
	}
	$vbox->errors[] = $e;
}


// Add any messages
if($vbox && count($vbox->messages)) {
	foreach($vbox->messages as $m)
		$response['messages'][] = 'vboxconnector('.$vboxRequest['fn'] .'): ' . $m;
}
// Add other error info
if($vbox && $vbox->errors) {
	
	foreach($vbox->errors as $e) { /* @var $e Exception */ 
		
		ob_start();
		print_r($e);
		$d = ob_get_contents();
		ob_end_clean();
		
		# Add connection details to connection errors
		if($e->getCode() == vboxconnector::PHPVB_ERRNO_CONNECT && isset($vbox->settings))
			$d .= "\n\nLocation:" . $vbox->settings->location;
		
		$response['messages'][] = $e->getMessage().' ' . $details;
		
		$response['errors'][] = array(
			'error'=>$e->getMessage(),
			'details'=>$d,
			'errno'=>$e->getCode(),
			// Fatal errors halt all processing
			'fatal'=>($e->getCode()==vboxconnector::PHPVB_ERRNO_FATAL),
			// Connection errors display alternate servers options
			'connection'=>($e->getCode()==vboxconnector::PHPVB_ERRNO_CONNECT)
		);
	}
}

/*
 * Return response as JSON encoded data or use PHP's
 * print_r to dump data to browser.
 */
if(isset($vboxRequest['printr'])) print_r($response);
else echo(json_encode($response));

