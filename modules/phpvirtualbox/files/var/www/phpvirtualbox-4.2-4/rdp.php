<?php
/**
 * Simple RDP connection file generator
 *
 * @author Ian Moore (imoore76 at yahoo dot com)
 * @copyright Copyright (C) 2010-2012 Ian Moore (imoore76 at yahoo dot com)
 * @version $Id: rdp.php 421 2012-10-07 21:07:37Z imooreyahoo@gmail.com $
 * @package phpVirtualBox
 *
 */

# Turn off PHP notices
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_WARNING);

require_once(dirname(__FILE__).'/lib/utils.php');
$_GET = clean_request();

foreach(array('port','host','vm') as $g) {
	@$_GET[$g] = str_replace(array("\n","\r","\0"),'',@$_GET[$g]);
}


header("Content-type: application/x-rdp",true);
header("Content-disposition: attachment; filename=\"". str_replace(array('"','.'),'_',$_GET['vm']) .".rdp\"",true);


echo('
full address:s:'.@$_GET['host'].(@$_GET['port'] ? ':'.@$_GET['port'] : '').'
compression:i:1
displayconnectionbar:i:1
protocol:i:4
');
