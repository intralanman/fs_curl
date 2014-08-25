<?php
  /**
   * FS_CURL was originally written using the MDB2 pear class for database interactions.
   * MDB2 was deprecated in favor or PHP's PDO.
   * 
   * This has been tested with MySQL but should work with many other RDBMSs
   * @author Michael Phillips <michael.j.phillips@gmail.com>
   * @license bsd http://www.opensource.org/licenses/bsd-license.php
   */
if (class_exists('PDO')) { 
	class FS_PDO extends PDO {
		/**
		 * Default fetch mode. Associative arrays seem to be used most often
		 */
		private $fetch_mode = PDO::FETCH_ASSOC;

		/**
		 * Basic counter for profiling the number of queries executed.
		 */	
		public $counter = 0;
	
		public function __construct($dsn, $login = NULL, $password = NULL, $options = NULL) {
			parent::__construct($dsn, $login, $password, $options);
			$this->setAttribute( PDO::ATTR_STATEMENT_CLASS, array( 'FS_PDOStatement', array() ) );
		}
	
		/**
		 * Set the fetch mode i.e. PDO::FETCH_ASSOC
		 * @param string $fetch_mode
		 */
		public function setFetchMode($fetch_mode) {
			$this->fetch_mode = $fetch_mode;
		}
	
		/**
		 * Return an associative array instead of a PDO statement object 
		 * @param string $query Query to be executed
		 * @return mixed Associative array result set
		 */ 
		public function queryAll($query) {
			$this->counter++;
			$res = $this->query($query);
			if(!$res) {
				return false;
			} else {
				return $res->fetchAll($this->fetch_mode);
			}		
		}
	
		/**
		 * Backwards compatibility for error checking with MDB2 
		 * @static
		 * @param string $result The return status of a previous query operation
		 * @return bool
		 */
		public static function isError($result) {
			if($result === false) {
				return true;
			} else {
				return false;
			}
		}
	
		/**
		 *  
		 * @param string $query Query to be executed
		 * @return PDOStatement 
		 */
		public function query($query) {
			$this->counter++; 
			return PDO::query($query);
		}
	
		/**
		 * Takes and array and converts to a string
		 * @return string $full_error A formated message 
		 */
		public function getMessage() {
			$full_error = "";
			foreach($this->errorInfo() as $error) {
				$full_error .= $error . "\n";	
			}
			return $full_error;
		}
	}

	/**
	 * PDOStatment was extended to provide backwards compatible functions such as 
	 * fetchRow and rowCount. At some point all references to numRow() should be 
	 * replaced with rowCount() 
	 */

	class FS_PDOStatement extends PDOStatement {

		protected function __construct() {

		}
	
		public function fetchRow() {
				
			return $this->fetch(PDO::FETCH_ASSOC);
		}
	
		public function numRows() {
			if (preg_match('/^select/i', $this->queryString)) {
				$results = $this->fetchAll();
				$this->execute();
				return count($results);
			} else {
				return $this->rowCount();
			}
		}
	}
 } else {
	trigger_error("PDO doesn't seem to be installed, make sure it's installed and loaded", E_USER_ERROR);
 }
