<?php
/**
 * @package FS_CURL
 * @subpackage FS_CURL_Configuration
 * voicemail.conf.php
 */
/**
 * @package  FS_CURL
 * @subpackage FS_CURL_Configuration
 * @license
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 * Writes out voicemail.conf XML
 * @see fs_configuration
 */
class voicemail_conf extends fs_configuration {

    public function voicemail_conf() {
        $this -> fs_configuration();
    }

    public function main() {
        $profiles = $this -> get_profiles();
        $this -> write_config($profiles);
    }

    /**
     * Get voicemail profiles from db
     * @return array
     */
    private function get_profiles() {
        $query = "SELECT * FROM voicemail_conf ORDER BY id";
        $profiles = $this -> db -> queryAll($query);
        return $profiles;
    }

    /**
     * Write XML for voicemail <settings>
     * @return void
     */
    private function write_settings($profile_id) {
        $query = sprintf('%s %s %s;'
            , "SELECT * FROM voicemail_settings "
            , "WHERE voicemail_id=$profile_id "
            , "ORDER BY voicemail_id, param_name"
        );
        $settings_array = $this -> db -> queryAll($query);
        $settings_count = count($settings_array);
        if (FS_PDO::isError($settings_array)) {
            $this -> comment($query);
            $this -> comment($this -> db -> getMessage());
            return ;
        }
        if ($settings_count < 1) {
            return ;
        }

        for ($i=0; $i<$settings_count; $i++) {
        //$this -> comment_array($settings_array[$i]);
            $this -> xmlw -> startElement('param');
            $this -> xmlw -> writeAttribute('name', $settings_array[$i]['param_name']);
            $this -> xmlw -> writeAttribute('value', $settings_array[$i]['param_value']);
            $this -> xmlw -> endElement();//</param>
        }
        $this -> write_email($profile_id);
    }

    /**
     * Write XML for voicemail email settings
     * @return void
     */
    private function write_email($profile_id) {
        $query = sprintf('%s %s %s;'
            , "SELECT * FROM voicemail_email "
            , "WHERE voicemail_id=$profile_id "
            , "ORDER BY voicemail_id, param_name"
        );
        $settings_array = $this -> db -> queryAll($query);
        $settings_count = count($settings_array);
        if (FS_PDO::isError($settings_array)) {
            $this -> comment($query);
            $this -> comment($this -> db -> getMessage());
            return ;
        }
        if ($settings_count < 1) {
            return ;
        }
        $this -> xmlw -> startElement('email');

        for ($i=0; $i<$settings_count; $i++) {
        //$this -> comment_array($settings_array[$i]);
            $this -> xmlw -> startElement('param');
            $this -> xmlw -> writeAttribute('name', $settings_array[$i]['param_name']);
            $this -> xmlw -> writeAttribute('value', $settings_array[$i]['param_value']);
            $this -> xmlw -> endElement();//</param>
        }
        $this -> xmlw -> endElement();
    }

    /**
     * Write the XML for the current profile in write_profiles
     * @return void
     */
    private function write_single_profile($profile) {
        $this -> xmlw -> startElement('profile');
        $this -> xmlw -> writeAttribute('name', $profile['vm_profile']);
        $this -> write_settings($profile['id']);
        $this -> xmlw -> endElement();
    }

    /**
     * Write the entire XML config for the voicemail module
     * Write XML by calling other methods to do specific areas of config
     * @return void
     */
    private function write_config($profiles) {
        $profile_count = count($profiles);
        $this -> xmlw -> startElement('configuration');
        $this -> xmlw -> writeAttribute('name', basename(__FILE__, '.php'));
        $this -> xmlw -> writeAttribute('description', 'voicemail Endpoint');
        $this -> xmlw -> startElement('profiles');
        for ($i=0; $i<$profile_count; $i++) {
            $this -> write_single_profile($profiles[$i]);
        }
        $this -> xmlw -> endElement();
        $this -> xmlw -> endElement();
    }
}

?>
