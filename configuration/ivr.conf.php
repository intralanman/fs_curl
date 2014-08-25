<?php
/**
 * @package  FS_CURL
 * @subpackage FS_CURL_Configuration
 * ivr.conf.php
 */
/**
 * @package  FS_CURL
 * @subpackage FS_CURL_Configuration
 * @license
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 * Write XML for ivr.conf
*/
class ivr_conf extends fs_configuration {
    public function ivr_conf() {
        $this -> fs_configuration();
    }

    /**
     * This method will run all of the methods necessary to return
     * the XML for the ivr.conf
     * @return void
    */
    public function main() {
        $ivrs = $this -> get_ivr_array();
        $this -> write_config($ivrs);
    }

    /**
     * This method will fetch all of the ivr menus from the database
     * using the MDB2 pear class
     * @return array
    */
    private function get_ivr_array() {
        $query = "SELECT * FROM ivr_conf";
        $menus = $this -> db -> queryAll($query);
        return $menus;
    }

    /**
     * This method will write all of the entry elements with
     * their corresponding attributes
     * @return void
     */
    private function write_entries($ivr_id) {
        $query = sprintf(
        "SELECT * FROM ivr_entries WHERE ivr_id=$ivr_id ORDER BY digits"
        );
        $entries_array = $this -> db -> queryAll($query);
        if (FS_PDO::isError($entries_array)) {
            $this -> comment($query);
            $this -> comment($this -> db -> getMessage());
            return ;
        }
        $entries_count = count($entries_array);
        if ($entries_count < 1) {
            return ;
        }
        $entries_count = count($entries_array);
        for ($i=0; $i<$entries_count; $i++) {
            //$this -> comment_array($entries_array[$i]);
            $this -> xmlw -> startElement('entry');
            $this -> xmlw -> writeAttribute('action', $entries_array[$i]['action']);
            $this -> xmlw -> writeAttribute('digits', $entries_array[$i]['digits']);
            if (!empty($entries_array[$i]['params'])) {
                $this -> xmlw -> writeAttribute('params', $entries_array[$i]['params']);
            }
            $this -> xmlw -> endElement();//</param>
        }
    }

    /**
     * This method will evaluate the data from the db and
     * write attributes that need written
     * @return void
    */
    private function write_menu_attributes($menu_data) {
        $this -> xmlw -> writeAttribute('name', $menu_data['name']);
        $this -> xmlw -> writeAttribute('greet-long', $menu_data['greet_long']);
        $this -> xmlw -> writeAttribute('greet-short', $menu_data['greet_short']);
        $this -> xmlw -> writeAttribute('invalid-sound', $menu_data['invalid_sound']);
        $this -> xmlw -> writeAttribute('exit-sound', $menu_data['exit_sound']);
        $this -> xmlw -> writeAttribute('timeout', $menu_data['timeout']);
        $this -> xmlw -> writeAttribute('max-failures', $menu_data['max_failures']);
        if (!empty($menu_data['tts_engine'])) {
            $this -> xmlw -> writeAttribute('tts-engine', $menu_data['tts_engine']);
        }
        if (!empty($menu_data['tts_voice'])) {
            $this -> xmlw -> writeAttribute('tts-voice', $menu_data['tts_voice']);
        }
        //$this -> xmlw -> writeAttribute('', $menu_data['']);
    }

    /**
     * This method will do the writing of the "menu" elements
     * and call the write_entries method to do the writing of
     * individual menu's "entry" elements
     * @return void
    */
    private function write_config($menus) {
        $menu_count = count($menus);
        $this -> xmlw -> startElement('configuration');
        $this -> xmlw -> writeAttribute('name', basename(__FILE__, '.php'));
        $this -> xmlw -> writeAttribute('description', 'Sofia SIP Endpoint');
        $this -> xmlw -> startElement('menus');
        for ($i=0; $i<$menu_count; $i++) {
            $this -> xmlw -> startElement('menu');
            $this -> write_menu_attributes($menus[$i]);
            $this -> write_entries($menus[$i]['id']);
            $this -> xmlw -> endElement();
        }
        $this -> xmlw -> endElement();
        $this -> xmlw -> endElement();
    }
}
?>
