<?php
/**
 * @package FS_CURL
 * @subpackage FS_CURL_Configuration
 * lcr.conf.php
 */
/**
 * @package  FS_CURL
 * @subpackage FS_CURL_Configuration
 * @license
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 * Writes out lcr.conf XML
 * @see fs_configuration
 */
class lcr_conf extends fs_configuration {
    public function lcr_conf() {
        $this->fs_configuration();
    }

    public function main() {
        $this->write_config();
    }

    private function write_config() {

        $this->xmlw->startElement('configuration');
        $this->xmlw->writeAttribute('name', basename(__FILE__, '.php'));
        $this->xmlw->writeAttribute('description', 'Dynamic ' . ucfirst(basename(__FILE__, '.conf.php')) . ' Configuration');

        $this->xmlw->startElement('settings');
        $query = sprintf('SELECT * FROM lcr_conf;');
        $settings_array = $this -> db -> queryAll($query);
        $settings_count = count($settings_array);
        if (FS_PDO::isError($settings_array)) {
            $this -> comment($query);
            $this -> comment($this -> db -> getMessage());
            return ;
        }
        for ($i = 0; $i < $settings_count; $i++) {
            $this->xmlw->startElement('param');
            $this->xmlw->writeAttribute('name', $settings_array[$i]['param_name']);
            $this->xmlw->writeAttribute('value', $settings_array[$i]['param_value']);
            $this->xmlw->endElement();
        }
        $this->xmlw->endElement(); // </settings>


        $profiles = $this->get_profiles();
        $this->write_profiles($profiles);

        $this->xmlw->endElement(); // </configuration>
    }

    private function get_profiles() {
        $query = sprintf(
            'SELECT *, lp.id AS lcr_id FROM lcr_profiles lp
                LEFT JOIN lcr_settings ls ON ls.lcr_id = lp.id
                ORDER BY lp.id;'
        );
        $settings_array = $this -> db -> queryAll($query);
        $settings_count = count($settings_array);
        if (FS_PDO::isError($settings_array)) {
            $this -> comment($query);
            $this -> comment($this -> db -> getMessage());
            return ;
        }

        $settings = array();
        for ($i = 0; $i < $settings_count; $i++) {
            $profile = $settings_array[$i]['profile_name'];
            $param = $settings_array[$i]['param_name'];
            $settings[$profile]['id'] = $settings_array[$i]['lcr_id'];
            $settings[$profile][$param] = $settings_array[$i]['param_value'];
        }
        return $settings;
    }

    private function write_profiles($settings_array) {
        $this->xmlw->startElement('profiles');

        
        foreach ($settings_array as $profile => $profile_data) {
            $this->xmlw->startElement('profile');
            $this->xmlw->writeAttribute('name', $profile);
            $this->debug($profile_data);
            foreach ($profile_data as $name => $value) {
                if (!$name) {
                    continue;
                }
                $this->xmlw->startElement('param');
                $this->xmlw->writeAttribute('name', $name);
                $this->xmlw->writeAttribute('value', $value);
                $this->xmlw->endElement();//</param>
            }
            $this->xmlw->endElement(); // </profile>
        }



        $this->xmlw->endElement(); // </profiles>
    }
}

