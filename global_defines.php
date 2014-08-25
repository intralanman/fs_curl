<?php
/**
 * @package FS_CURL
 * @license
 * @author Raymond Chandler (intralanman) <intralanman@gmail.com>
 * @version 0.1
 */

if (basename($_SERVER['PHP_SELF']) == basename(__FILE__)) {
    header('Location: index.php');
}

/**
 * Defines the default dsn for the FS_PDO class
 */
define('DEFAULT_DSN', 'pgsql:dbname=freeswitch;host=127.0.0.1');
/**
 * Defines the default dsn login for the PDO class
 */
define('DEFAULT_DSN_LOGIN', 'freeswitch');
/**
 * Defines the default dsn password for the PDOclass
 */
define('DEFAULT_DSN_PASSWORD', 'Fr33Sw1tch');
/**
 * Generic return success
 */
define('FS_CURL_SUCCESS', 0);
/**
 * Generic return success
 */
define('FS_SQL_SUCCESS', '00000');
/**
 * Generic return warning
 */
define('FS_CURL_WARNING', 1);
/**
 * Generic return critical
 */
define('FS_CURL_CRITICAL', 2);

/**
 * determines how the error handler handles warnings
 */
define('RETURN_ON_WARN', true);

/**
 * Determines whether or not users should be domain specific
 * If GLOBAL_USERS is true, user info will be returned for whatever
 * domain is passed.....
 * NOTE: using a1 hashes will NOT work with this setting
 */
define('GLOBAL_USERS', false);

/**
 * Define debug level... should not be used in production for performance reasons
 */
//define('FS_CURL_DEBUG', 9);
/**
 * define how debugging should be done (depends on FS_CURL_DEBUG)
 * 0 syslog
 * 1 xml comment
 * 2 file (named in FS_DEBUG_FILE), take care when using this option as there's currently nothing to watch the file's size
 */
define('FS_DEBUG_TYPE', 0);

/**
 * File to use for debugging to file
 */
define('FS_DEBUG_FILE', '/tmp/fs_curl.debug');




//define('', '');
?>