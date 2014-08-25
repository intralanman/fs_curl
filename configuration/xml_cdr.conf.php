<?php
/**
 * @package FS_CURL
 * @subpackage FS_CURL_Directory
 * xml_cdr.conf.php
 */
/**
 * @package  FS_CURL
 * @subpackage FS_CURL_Configuration
 * @license
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 * Class for writing xml_cdr.conf XML
*/
class xml_cdr_conf extends fs_configuration {
	function xml_cdr_conf() {
		$this->fs_configuration();
	}

	function main() {
		$params = $this->get_settings();
		$this->write_settings($params);
	}

	function get_settings() {
		return array(
		'url'=>'http://' . $_SERVER['HTTP_HOST'] . '/' . $_SERVER['PHP_SELF']
		, 'encode'=>'true'
		);
	}

	function write_settings($params) {
		$this->xmlw->startElement('configuration');
		$this->xmlw->writeAttribute('name', basename(__FILE__, '.php'));
		$this->xmlw->writeAttribute('description', 'CDRs via XML Post');
		$this->xmlw->startElement('settings');
		while (list($name, $value) = each($params)) {
			$this->xmlw->startElement('param');
			$this->xmlw->writeAttribute('name', $name);
			$this->xmlw->writeAttribute('value', $value);
			$this->xmlw->endElement();
		}
		$this->xmlw->endElement();
		$this->xmlw->endElement();
	}
}

?>
