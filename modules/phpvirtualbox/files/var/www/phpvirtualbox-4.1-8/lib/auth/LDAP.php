<?php
/*
 * $Id: LDAP.php 389 2012-08-16 12:18:20Z imooreyahoo@gmail.com $
 * Experimental!
 */
class phpvbAuthLDAP implements phpvbAuth {
	
	var $capabilities = array(
		'canChangePassword' => false,
		'canLogout' => true
	);
	
	var $config = array(
		'host' => '127.0.0.1', // LDAP server ip
		'bind_dn' => 'uid=%s, ou=admins, dc=internal, dc=local' // %s will be replaced with login username
	);
	
	function phpvbAuthLDAP($userConfig = null) {
		if($userConfig) $this->config = array_merge($this->config,$userConfig);
	}
	
	function login($username, $password)
	{
		global $_SESSION;
		
		$auth = ldap_connect($this->config['host']);
		
		if(!$auth) return false;
		
		ldap_set_option($auth,LDAP_OPT_PROTOCOL_VERSION, 3);
		
		if(!@ldap_bind($auth, sprintf($config['bind_dn'], $username), $password))
			return false;
		
		
		$_SESSION['valid'] = true;
		$_SESSION['user'] = $username;
		$_SESSION['authCheckHeartbeat'] = time();
		
	}
	
	
	function heartbeat($vbox)
	{
		global $_SESSION;

		$_SESSION['valid'] = true;
		$_SESSION['authCheckHeartbeat'] = time();
	}
	
	function changePassword($old, $new, &$response)
	{
	}
	
	function logout(&$response)
	{
		global $_SESSION;
		if(function_exists('session_destroy')) session_destroy();
		else unset($_SESSION['valid']);
		$response['data']['result'] = 1;
	}
	
	function listUsers()
	{
		
	}
	
	function updateUser($vboxRequest, $skipExistCheck)
	{
		
	}
	
	function deleteUser($user)
	{
		
	}
}
