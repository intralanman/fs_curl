<?php
/**
 * @package FS_CURL
 * @subpackage FS_CURL_Configuration
 * easyroute.conf.php
 */
/**
 * @package  FS_CURL
 * @subpackage FS_CURL_Configuration
 * @license
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 * Writes out easyroute.conf XML
 * @see fs_configuration
 */
class easyroute_conf extends fs_configuration {
    public function easyroute_conf() {
        $this->fs_configuration();
    }

    public function main() {
        $config = $this->get_config();
        $this->write_config($config);
    }

    private function get_config() {
        $query = sprintf('SELECT * FROM easyroute_conf');
        $settings_array = $this -> db -> queryAll($query);
        $settings_count = count($settings_array);
        if (FS_PDO::isError($settings_array)) {
            $this -> comment($query);
            $this -> comment($this -> db -> getMessage());
            return ;
        }

        return $settings_array;
    }

    private function write_config($settings_array) {
        $this->xmlw->startElement('configuration');
        $this->xmlw->writeAttribute('name', basename(__FILE__, '.php'));
        $this->xmlw->writeAttribute('description', 'Dynamic ' . ucfirst(basename(__FILE__, '.conf.php')) . ' Configuration');
        $this->xmlw->startElement('settings');
        $settings_count = count($settings_array);
        if ($settings_count > 0) {
            for ($i=0; $i<$settings_count; $i++) {
                $this->xmlw->startElement('param');
                $this->xmlw->writeAttribute('name', $settings_array[$i]['param_name']);
                $this->xmlw->writeAttribute('value', $settings_array[$i]['param_value']);
                $this->xmlw->endElement();//</param>
            }
        }
        $this->xmlw->endElement(); // </settings>
        $this->xmlw->endElement();
    }
}



?>
