<?php
/**
 * @package FS_CURL
 * @subpackage FS_CURL_Directory
 * console.conf.php
 */
if (basename($_SERVER['PHP_SELF']) == basename(__FILE__)) {
    header('Location: index.php');
}

/**
 * @package FS_CURL
 * @subpackage FS_CURL_Configuration
 * @license
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 * @todo make this configurable via db rather than hardcoded.
 * File containing the base class for all curl XML output
*/
class console_conf extends fs_configuration {
    function console_conf() {
        $this -> fs_configuration();
    }

    /**
     * Currently this method does pretty much everything
     */
    function main() {
        $this -> xmlw -> startElement('configuration');
        $this -> xmlw -> writeAttribute('name', basename(__FILE__, '.php'));
        $this -> xmlw -> writeAttribute('description', 'Console configuration');

        $this -> xmlw -> startElement('mappings');
	
	$this -> xmlw -> startElement('map');
        $this -> xmlw -> writeAttribute('name', 'all');
        $this -> xmlw -> writeAttribute('value', 'notice,warning,error,crit,alert,info,debug');
	$this -> xmlw -> endElement();

        $this -> xmlw -> endElement();




        $this -> xmlw -> startElement('settings');

	$this -> xmlw -> startElement('param');
        $this -> xmlw -> writeAttribute('name', 'colorize');
        $this -> xmlw -> writeAttribute('value', 'true');
	$this -> xmlw -> endElement();

	$this -> xmlw -> startElement('param');
        $this -> xmlw -> writeAttribute('name', 'loglevel');
        $this -> xmlw -> writeAttribute('value', 'debug');
	$this -> xmlw -> endElement();

	$this -> xmlw -> endElement();




        $this -> xmlw -> endElement();
    }
}
?>
