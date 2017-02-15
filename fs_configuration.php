<?php
/**
 * @package  FS_CURL
 * fs_configuration.php
 */
if (basename($_SERVER['PHP_SELF']) == basename(__FILE__)) {
    header('Location: index.php');
}

/**
 * @package FS_CURL
 * @license BSD
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 * Class for all module configurations
 * @return object
*/
class fs_configuration extends fs_curl {
    /**
     * Class Instantiation
     * This method will instantiate all other objects upon which it relies.
     * @return void
    */

    public function fs_dialplan()
    {
        self::__construct();
    }

    function  __construct() {
        $this -> fs_curl();
        $conf_file = $this->request['key_value'];
        $this->debug("RECEIVED REQUEST FOR $conf_file");
        $mod_name = sprintf('mod_%s', str_replace('.conf', '', $conf_file));
        $this -> comment("module name is $mod_name");
        if (!($this -> is_mod_enabled($mod_name))
        && !($this -> is_modless_conf($this -> request['key_value']))) {
            $this -> comment('module not enabled and not modless config file');
            $this -> file_not_found();
        }
        $this -> xmlw -> startElement('section');
        $this -> xmlw -> writeAttribute('name', 'configuration');
        $this -> xmlw -> writeAttribute(
        'description', 'FreeSWITCH Configuration'
        );
    }

    /**
     * Enabled module checker
     * This method will check if a module is enabled before
     * returning the XML for the module. If the module's not
     * enabled, the file_not_found method will be called.
     * @param string $mod_name name of module to check
     * @return bool
    */
    function is_mod_enabled($mod_name) {
        $query = sprintf('%s %s'
        , "SELECT * FROM post_load_modules_conf"
        , "WHERE module_name='$mod_name' AND load_module=1"
        );
        $res = $this -> db -> query($query);
        if ($this->db->errorCode() !== FS_SQL_SUCCESS) {
            $this -> comment($query);
            $this -> comment($this->db->errorCode());
            return true; //default allow policy
            return false; //comment previous line to default deny
        } elseif ($res -> rowCount() == 1) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * Allow config files that aren't tied to any module
     *
     * @param string $conf
     * @return bool
     */
    private function is_modless_conf($conf) {
        $this -> comment("conf is $conf");
        $query = sprintf(
        "SELECT COUNT(*) cnt FROM modless_conf WHERE conf_name = '$conf';"
        );
        $res = $this -> db -> query($query);
        if (FS_PDO::isError($res)) {
            $this -> comment($query);
            $this -> comment($res -> getMessage());
            return true; //default allow policy
            return false; //comment previous line to default deny
        }
        $row = $res -> fetchRow();
        //$this -> comment($row['cnt']);
        return $row['cnt'];
    }
}

