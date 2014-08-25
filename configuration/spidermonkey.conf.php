<?php
/**
 * @package FS_CURL
 * @subpackage FS_CURL_Directory
 * spidermonkey.conf.php
 */
/**
 * @package  FS_CURL
 * @subpackage FS_CURL_Configuration
 * @license
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 * @todo make configuration get pulled from db? maybe just use defines if there's not evern gonna be too many options
 * Class for writing spidermonkey.conf XML
*/
class spidermonkey_conf extends fs_configuration {

    function spidermonkey_conf() {
        $this -> fs_configuration();
    }

    function main() {
        $params = $this -> get_params();
        $this -> write_params($params);
    }

    private function get_params() {
        return array(
        'mod_spidermonkey_teletone',
        'mod_spidermonkey_odbc',
        'mod_spidermonkey_core_db'
        );
    }

    private function write_params($modules) {
        $this -> xmlw -> startElement('configuration');
        $this -> xmlw -> writeAttribute('name', basename(__FILE__, '.php'));
        $this -> xmlw -> writeAttribute('description', 'JavaScript Plug-In Configuration');
        $this -> xmlw -> startElement('modules');
        $module_count = count($modules);
        for ($i=0; $i<$module_count; $i++) {
            $this -> xmlw -> startElement('load');
            $this -> xmlw -> writeAttribute('module', $modules[$i]);
            $this -> xmlw -> endElement();
        }
        $this -> xmlw -> endElement();
        $this -> xmlw -> endElement();
    }
}

?>