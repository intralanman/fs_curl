<?php
/**
 * @package  FS_CURL
 * @todo i should probably add a condition_weight to order the conditions inside a given extension
 * fs_dialplan.php
 */
if (basename($_SERVER['PHP_SELF']) == basename(__FILE__)) {
    header('Location: index.php');
}

/**
 * @package FS_CURL
 * @license BSD
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 * Class for XML dialplan
 */
class fs_dialplan extends fs_curl {
    private $special_class_file;


    public function fs_dialplan()
    {
        self::__construct();
    }
    public function __construct() {
        $this -> fs_curl();
    }

    /**
     * This is the method that determines the XML output. Customized dialplans can
     * be easily created by adding a record to the dialplan_special table with the
     * appropriate values. The php class MUST contain a "main()" method. The method
     * should write directly to the xmlw obj that's pased or take care of writing
     * out the xml itself and exiting as to not return.
     *
     */
    public function main() {
        $this -> comment($this -> request);
        $context = $this -> request['Hunt-Context'];
        if ($this -> is_specialized_dialplan($context)) {
			$this->debug("$context should be handled in a specialized dialplan class file");
            if (!include_once($this -> special_class_file)) {
                $this -> file_not_found();
            }
            $class = sprintf('dialplan_%s', $context);
            if (!class_exists($class)) {
                $this -> comment("No Class of name $class");
                $this -> file_not_found();
            }
            $obj = new $class;
            /**
             * recieving method should take incoming parameter as &$something
             */
            $obj -> main($this);
        } else {
            $dp_array = $this -> get_dialplan($context);
            $this -> writeDialplan($dp_array);
        }
        $this -> output_xml();
    }

    public function is_specialized_dialplan($context) {
        $query = sprintf(
            "SELECT * FROM dialplan_special WHERE context='%s'", $context
        );
		$this -> debug($query);
        $res = $this -> db -> query($query);
        if (FS_PDO::isError($res)) {
            $this -> comment($query);
            $this -> comment($this -> db -> getMessage());
            $this -> file_not_found();
        }
	   
        if ($res -> numRows() == 1) {
			$this -> debug("numRows() == 1");
            $row = $res -> fetchRow();
			$this->debug($row);
            $this -> special_class_file = sprintf('dialplans/%s', $row['class_file']);
            return true;
        } else {
            return false;
        }
    }

    /**
     * This method will pull dialplan from database
     *
     * @param string $context context name for XML dialplan
     * @return array
     */
    private function get_dialplan($context) {
        $dp_array = array();
        $dpQuery = sprintf('SELECT
			%1$scontext%1$s,
			%1$sname%1$s as extension,
			%1$sapplication%1$s as application_name,
			%1$sdata%1$s as application_data,
			%1$sfield%1$s as condition_field,
			%1$sexpression%1$s as condition_expression,
			%1$scontinue%1$s as ext_continue,
			%1$stype%1$s
		FROM dialplan
			INNER JOIN dialplan_context USING(dialplan_id)
			INNER JOIN dialplan_extension USING(context_id)
			INNER JOIN dialplan_condition USING(extension_id)
			INNER JOIN dialplan_actions USING(condition_id)
		WHERE context = \'%2$s\'
		ORDER BY dialplan_context.weight,
                 dialplan_extension.weight,
                 dialplan_condition.weight,
                 dialplan_actions.weight'
            , DB_FIELD_QUOTE, $context
        );
        $this->debug($dpQuery);
        $res = $this -> db -> query($dpQuery);
        if (FS_PDO::isError($res)) {
            $this -> comment($this -> db -> getMessage());
            $this -> file_not_found();
        }
		if ($res -> numRows() < 1) { 
			$this -> debug("nothing to do, let's just return not found");
			$this -> file_not_found();
		}
        $condition_number = 0;
        while ($row = $res -> fetchRow()) {
            $ct = $row['context'];
            $et = $row['extension'];
            $ec = $row['ext_continue'];
            $app = $row['application_name'];
            $data = $row['application_data'];
            //$app_cdata = $row['app_cdata'];
            $type = $row['type'];
            $cf = $row['condition_field'];
            $ce = $row['condition_expression'];
            //$rcd = $row['re_cdata'];
            $cc = empty($row['cond_break']) ? '0' : $row['cond_break'];
            $dp_array[$ct]["$et;$ec"]["$cf;$ce;$cc"][] = array(
                'type'=>$type,
                'application'=>$app,
                'data'=>$data,
                'is_cdata'=>(empty($app_cdata) ? '' : $app_cdata)
            );
        }
        return $dp_array;
    }

    /**
     * Write XML dialplan from the array returned by get_dialplan
     * @see fs_dialplan::get_dialplan
     * @param array $dpArray Multi-dimentional array from which we write the XML
     * @todo this method should REALLY be broken down into several smaller methods
     *
     */
    private function writeDialplan($dpArray) {
    //print_r($dpArray);
        if (is_array($dpArray)) {
            $this -> xmlw -> startElement('section');
            $this -> xmlw -> writeAttribute('name', 'dialplan');
            $this -> xmlw -> writeAttribute('description', 'FreeSWITCH Dialplan');
            //$this -> comment('dpArray is an array');
            foreach ($dpArray as $context => $extensions_array) {
            //$this -> comment($context);
            //start the context
                $this -> xmlw -> startElement('context');
                $this -> xmlw -> writeAttribute('name', $context);
                if (is_array($extensions_array)) {
                    foreach ($extensions_array as $extension => $conditions) {
                    //start an extension
                        $ex_split = preg_split('/;/', $extension);
                        $this -> xmlw -> startElement('extension');
                        $this -> xmlw -> writeAttribute('name', $ex_split[0]);
                        if (strlen($ex_split[1]) > 0) {
                            $this -> xmlw -> writeAttribute('continue', $ex_split[1]);
                        }
                        $this -> debug($conditions);
                        foreach ($conditions as $condition => $app_array) {
                            $c_split = preg_split('/;/', $condition);
                            $this -> xmlw -> startElement('condition');
                            if (!empty($c_split[0])) {
                                $this -> xmlw -> writeAttribute('field', $c_split[0]);
                            }
                            if (!empty($c_split[1])) {
                                if (array_key_exists(3, $c_split)
                                    && $c_split[3] == true) {
                                    $this -> xmlw -> startElement('expression');
                                    $this -> xmlw -> writeCdata($c_split[1]);
                                    $this -> xmlw -> endElement();
                                } else {
                                    $this -> xmlw -> writeAttribute(
                                        'expression', $c_split[1]
                                    );
                                }
                            }
                            //$this -> debug($c_split[2]);
                            if ($c_split[2] != '0') {
                                $this -> xmlw -> writeAttribute(
                                    'break', $c_split[2]
                                );
                            }
                            //$this -> debug($app_array);
                            foreach ($app_array as $app) {
                                if (empty($app['application'])) {
                                    continue;
                                }
                                $this -> xmlw -> startElement($app['type']);
                                $this -> xmlw -> writeAttribute(
                                    'application', $app['application']
                                );
                                if (!empty($app['data'])) {
                                    if (array_key_exists('is_cdata', $app)
                                        && $app['is_cdata'] == true) {
                                        $this -> xmlw -> writeCdata($app['data']);
                                    } else {
                                        $this -> xmlw -> writeAttribute(
                                            'data', $app['data']
                                        );
                                    }
                                }
                                if ($app['application'] == 'set') {
                                    $this->xmlw->writeAttribute('inline', 'true');
                                }
                                $this -> xmlw -> endElement();
                            }
                            //</condition>
                            $this -> xmlw -> endElement();
                        }
                        // </extension>
                        $this -> xmlw -> endElement();
                    }
                }
                // </context>
                $this -> xmlw -> endElement();
            }
            // </section>
            $this -> xmlw -> endElement();
        }
    }
}
