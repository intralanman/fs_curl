<?php
/**
 * @package  FS_CURL
 * @subpackage FS_CURL_Configuration
 * local_stream.conf.php
 */

/**
 * @package  FS_CURL
 * @subpackage FS_CURL_Configuration
 * @license
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 * Class to write the XML for local_stream.conf
 */
class local_stream_conf extends fs_configuration {

    public function local_stream_conf() {
        $this -> fs_configuration();
    }

    public function main() {
        $directories = $this -> get_directories();
        $this -> write_directories($directories);
    }

    private function write_settings($profile_id) {
        $query = sprintf('%s %s %s;'
        , "SELECT * FROM local_stream_settings "
        , "WHERE stream_id=$profile_id "
        , "ORDER BY stream_id, param_name"
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
        $this -> xmlw -> startElement('settings');

        for ($i=0; $i<$settings_count; $i++) {
            $this -> xmlw -> startElement('param');
            $this -> xmlw -> writeAttribute('name', $settings_array[$i]['param_name']);
            $this -> xmlw -> writeAttribute('value', $settings_array[$i]['param_value']);
            $this -> xmlw -> endElement();//</param>
        }
        $this -> write_email($profile_id);
        $this -> xmlw -> endElement();
    }

    private function get_directories() {
        $query = sprintf('SELECT * FROM local_stream_conf;');
        $profiles = $this -> db -> queryAll($query);
        if (FS_PDO::isError($profiles)) {
            $this -> comment($query);
            $this -> comment($this -> db -> getMessage());
            return array();
        }
        return $profiles;
    }

    private function write_directories($directories) {
        $directory_count = count($directories);
        for ($i=0; $i<$directory_count; $i++) {
            $this -> write_settings($directories[$i]);
        }
    }
}
?>
