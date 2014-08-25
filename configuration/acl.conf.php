<?php
/**
 * @package  FS_CURL
 * @subpackage FS_CURL_Configuration
 * acl.conf.php
 */

/**
 * @package  FS_CURL
 * @subpackage FS_CURL_Configuration
 * @license
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 * Class to write the XML for acl.conf
 */
class acl_conf extends fs_configuration {

    public function acl_conf() {
        $this -> fs_configuration();
    }

    public function main() {
        $acl = $this -> get_acl();
        $this -> write_acl($acl);
    }

    /**
     * Write individual node elements with their attributes
     *
     * @param array $node_attributes
     */
    private function write_node($node_attributes) {
        $this -> xmlw -> startElement('node');
        $this -> xmlw -> writeAttribute('type', $node_attributes['type']);
        $this -> xmlw -> writeAttribute('cidr', $node_attributes['cidr']);
        $this -> xmlw -> endElement();
    }

    /**
     * Fetch the ACL data from the database
     *
     * @return array $acl_data
     */
    private function get_acl() {
        $query = sprintf(
        'SELECT * FROM acl_lists al JOIN acl_nodes an ON an.list_id=al.id;'
        );
        $acl_data = $this -> db -> queryAll($query);
        if (FS_PDO::isError($profiles)) {
            $this -> comment($query);
            $this -> comment($this -> db -> getMessage());
            return array();
        }
        return $acl_data;
    }

    /**
     * Write ACL data out
     *
     * @param array $acl
     */
    private function write_acl($acl) {
        $this -> xmlw -> startElement('configuration');
        $this -> xmlw -> writeAttribute('name', 'acl.conf');
        $this -> xmlw -> writeAttribute('description', 'Access Control Lists');
        $this -> xmlw -> startElement('network-lists');
        $node_count = count($acl);
        for ($i=0; $i<$node_count; $i++) {
            $last = $i - 1;
            $next = $i + 1;
            if ($last < 0 || $acl[$last]['acl_name'] != $acl[$i]['acl_name']) {
            	$this -> xmlw -> startElement('list');
            	$this -> xmlw -> writeAttribute('name', $acl[$i]['acl_name']);
            	$this -> xmlw -> writeAttribute(
            	'default', $acl[$i]['default_policy']
            	);
            }
            $this -> write_node($acl[$i]);
            if ((!array_key_exists($next, $acl))
            || $acl[$next]['acl_name'] != $acl[$i]['acl_name']) {
            	$this -> xmlw -> endElement();
            }
        }
        $this -> xmlw -> endElement();
        $this -> xmlw -> endElement();
    }
}
?>
