<?php
/**
 * @package FS_CURL
 * @subpackage FS_CURL_Dialplan
 * @license
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
*/

/**
 * Switched to simple xml, pdo and new schemea.  Added several new supporint functions
 * @author Michael Phillips
 */

require_once('libs/fs_pdo.php');

/**
 * require global definitions for FS_CURL
 */
require_once('global_defines.php');

/**
 * Output the upload form
 * echo out the HTML for the upload form.
 * @return null
*/
function upload_form() {
    echo '<html>';
    echo '<h2>Select A File To Import</h2>';
    echo '<form method="post" action="' . $_SERVER['PHP_SELF'] . '" enctype="multipart/form-data">';
    echo '<input type="file" name="file">';
    echo '<input type="submit" name="confirmed">';
	echo '<p><input type="checkbox" name="clear_dialplan" value="true"> Clear all dialplan data before insert?</p>';
    echo '</form>';
    echo '</html>';
}

/**
 * Perform Insert Query
 * take MDB2 object and query as params and
 * perform query, setting error flag in the event
 * of a db error.
 * @return null
*/
function run_query($db, $query) {
    syslog(LOG_INFO, $query);
    $affected = $db -> exec($query);
    if (FS_PDO::isError($affected)) {
        if (!defined('UNSUCCESSFUL_QUERY')) {
            define('UNSUCCESSFUL_QUERY', true);
        }
        echo "$query<br>\n";
        echo $affected -> getMessage() . "\n";
    }
}

/**
 * Check uploaded file for obvious problems
 * This function checks the uploaded file's
 * size, type, length, etc to make sure it's
 * worth continuing with processing
 * @return bool
*/
function check_uploaded_file($file_array) {
    if (!is_uploaded_file($file_array['tmp_name'])) {
        echo "File NOT uploaded OK<br>";
        die(upload_form());
    } elseif ($file_array['size'] < 1) {
        echo "File was empty";
        die(upload_form());
    } elseif ($file_array['error'] > 0) {
        echo "Uploading file encountered error #" . $file_array['error'];
        die(upload_form());
    } elseif ($file_array['type'] != 'text/xml') {
        echo "Expected file of type 'text/xml', but got " . $file_array['type'];
        die(upload_form());
    } else {
        //echo "File seems uploaded OK<br>";
        return true;
    }
}


if (!array_key_exists('confirmed', $_REQUEST)) {
    die(upload_form());
}

/*
foreach ($_REQUEST as $key => $val) {
echo "$key => $val <br>\n";
}
if (is_array($_FILES) && count($_FILES)>0) {
echo "<h2>FILES is an array</h2>";
print_r($_FILES);
}
*/


// no need to do anything till we check that the file's ok
if (check_uploaded_file($_FILES['file'])) {
    $xml_file = $_FILES['file']['tmp_name'];
    //move_uploaded_file($tmp_file, $xml_file);
	//is_uploaded_file
	//echo filesize($xml_file);
    //echo $xml_file . "\n<br>";
    $xml_str = file_get_contents($xml_file);
}


try {
	$db = new FS_PDO(DEFAULT_DSN,DEFAULT_DSN_LOGIN, DEFAULT_DSN_PASSWORD);
} catch(Exception $e) {
		die($e->getMessage());
}

if($_POST['clear_dialplan']) {
	truncate_dialplan();
}

echo "<pre>";
$xml = simplexml_load_string($xml_str);
$num_of_conext = sizeof($xml->context);


$dialplan_id = insert_dialplan();
foreach($xml->children() as $context => $context_children) {
	//echo $context . " => " . $context_children->attributes()->name . "\n";
	$context_id = insert_dialplan_context($dialplan_id, $context_children->attributes()->name);

	foreach($context_children as $extension => $extension_children) {
		//echo "\t" . $extension . " => name: " . $extension_children->attributes()->name . "  continue: " . $extension_children->attributes()->continue . "\n" ;
		if($extension == 'extension') { //verify again bad input
			$extension_id = insert_dialplan_extension($context_id, $extension_children->attributes()->name, $extension_children->attributes()->continue);
		}
		foreach($extension_children as $condition => $condition_children) {
			//echo "\t\t" . $condition . " => " . $condition_children->attributes()->field . ", expression; " .$condition_children->attributes()->expression . "\n";
			$condition_id = insert_dialplan_condition($extension_id, $condition_children->attributes()->field, $condition_children->attributes()->expression);
			foreach($condition_children as $action => $action_childress) {
				//echo "\t\t\t" . $action . " => " . $action_childress->attributes()->application . ", expression; " .$action_childress->attributes()->data . "\n";
				if($action == ('action' || 'anti-action')) { //verify again bad input
					insert_dialplan_actions($condition_id, $action_childress->attributes()->application , $action_childress->attributes()->data, $action);
				} else {
					echo "bad xml $action";
				}// end if
			} //end foreach
		} //end foreach
	}// end foreach
} // end foreach

echo "</pre>";

function insert_dialplan($domain = 'freeswitch' , $ip_address = '127.0.0.1') {
	global $db;
	$sql = sprintf("INSERT INTO dialplan (`domain`, `ip_address`) VALUES ('%s', '%s')", $domain, $ip_address);
	$db->query($sql);
	return $db->lastInsertId() ;
}

function insert_dialplan_context($dialplan_id, $context) {
	global $db;
	$sql = sprintf("INSERT INTO dialplan_context (`dialplan_id`, `context`, `weight`) VALUES (%d, '%s', %d)", $dialplan_id, $context, get_next_weight('context'));
	$db->query($sql);
	return $db->lastInsertId() ;
}

function insert_dialplan_extension($context_id, $name, $continue) {
	global $db;
	$sql = sprintf("INSERT INTO dialplan_extension (`context_id`, `name`, `continue`, `weight`) VALUES (%d, '%s', '%s', %d)", $context_id, $name, $continue, get_next_weight('extension'));
	get_next_weight('extension');
	$db->query($sql);
	return $db->lastInsertId() ;
}

function insert_dialplan_condition($extension_id, $field, $expression) {
	global $db;
	$sql = sprintf("INSERT INTO dialplan_condition (`extension_id`, `field`, `expression`, `weight`) VALUES (%d, '%s', '%s', %d)", $extension_id, addslashes($field), addslashes($expression),get_next_weight('condition') );
	//echo $sql . "\n";
	$db->query($sql);
	return $db->lastInsertId() ;
}

function insert_dialplan_actions($condition_id, $application , $data, $type) {
	global $db;
	$sql = sprintf("INSERT INTO dialplan_actions(`condition_id`, `application`, `data`, `type`, `weight`) VALUES (%d, '%s', '%s', '%s', %d)", $condition_id, addslashes($application), addslashes($data), $type, get_next_weight('actions'));
	$db->query($sql);
	return $db->lastInsertId() ;
}

function get_next_weight($table) { //used for weighting system
	global $db;
	$sql = sprintf("SELECT MAX(weight) as max FROM dialplan_%s", $table);
	$res = $db->queryAll($sql);
	return ($res[0]['max'] + 10);
}

function truncate_dialplan() {
	global $db;
	$db->query('TRUNCATE dialplan_extension');
	$db->query('TRUNCATE dialplan');
	$db->query('TRUNCATE dialplan_context');
	$db->query('TRUNCATE dialplan_condition');
	$db->query('TRUNCATE dialplan_actions');
}

if (defined(UNSUCCESSFUL_QUERY) && UNSUCCESSFUL_QUERY == true) {
    echo "<h2>Some Queries Were Not Successful</h2>";
} else {
    echo "<h2>File Successfully Imported</h2>";
}
upload_form();

//printf("<pre>%s</pre>", print_r($xml_obj, true);
?>