<?php
	/**
	 * @package    FS_CURL
	 * @subpackage FS_CURL_Directory
	 *             fs_directory.php
	 */
	if ( basename( $_SERVER['PHP_SELF'] ) == basename( __FILE__ ) ) {
		header( 'Location: index.php' );
	}

	/**
	 * @package    FS_CURL
	 * @subpackage FS_CURL_Directory
	 * @author     Raymond Chandler (intralanman) <intralanman@gmail.com>
	 * @license    BSD
	 * @version    0.1
	 *             Class for XML directory
	 */
	class fs_directory extends fs_curl {

		private $user;
		private $userid;
		private $users_vars;
		private $users_params;
		private $users_gateways;
		private $users_gateway_params;

		public function fs_directory() {
			$this->fs_curl();
			if ( array_key_exists( 'user', $this->request ) ) {
				$this->user = $this->request['user'];
			}
			$this->comment( "User is " . $this->user );
		}

		public function main() {
			$this->comment( $this->request );
			if ( array_key_exists( 'VM-Action', $this->request ) && $this->request['VM-Action'] == 'change-password'
			) {
				$this->update_pin( $this->request['VM-User'], $this->request['VM-User-Password'] );
			} else {
				if ( array_key_exists( 'domain', $this->request ) ) {
					$domains = $this->get_domains( $this->request['domain'] );
				} else {
					$domains = $this->get_domains();
				}

				$this->get_user_gateway_params();

				$this->xmlw->startElement( 'section' );
				$this->xmlw->writeAttribute( 'name', 'directory' );
				$this->xmlw->writeAttribute( 'description', 'FreeSWITCH Directory' );

				foreach ( $domains as $domain ) {
					$directory_array = $this->get_directory( $domain );
					$this->writedirectory( $directory_array, $domain );
				}

				$this->xmlw->endElement(); // </section>
				$this->output_xml();
			}
		}

		private function update_pin( $username, $new_pin ) {
			$this->debug( "update pin for $username to $new_pin" );
			$and = '';
			if ( array_key_exists( 'domain', $this->request ) ) {
				$and = sprintf( 'AND %1$sdomain%1$s = \'%2$s\')', DB_FIELD_QUOTE, $this->request['domain'] );
			}
			$query = sprintf( 'UPDATE %1$sdirectory_params%1$s
                            SET %1$sparam_value%1$s = \'%2$s\'
                            WHERE %1$sparam_name%1$s = \'vm-password\'
                                AND %1$sdirectory_id%1$s =
                                (SELECT %1$sid%1$s
                                    FROM %1$sdirectory%1$s
                                    WHERE %1$susername%1$s = \'%3$s\' %4$s', DB_FIELD_QUOTE, $new_pin, $username,
			                  $and );
			$this->debug( $query );
			$this->db->exec( $query );
			$this->debug( $this->db->errorInfo() );
		}

		/**
		 * This method will pull directory from database
		 * @return array
		 * @todo add GROUP BY to query to make sure we don't get duplicate users
		 */
		private function get_directory( $domain ) {
			$directory_array = array();
			$join_clause     = '';
			$where_array[]   = sprintf( "domain_id='%s'", $domain['id'] );
			if ( array_key_exists( 'user', $this->request ) ) {
				$where_array[] = sprintf( "username='%s'", $this->user );
			}
			if ( array_key_exists( 'group', $this->request ) ) {
				$where_array[] = sprintf( "group_name='%s'", $this->request['group'] );
				$join_clause   = "JOIN directory_group_user_map dgum ON d.id=dgum.user_id ";
				$join_clause .= "JOIN directory_groups dg ON dgum.group_id=dg.group_id ";
			}
			if ( ! empty ( $where_array ) ) {
				if ( count( $where_array ) > 1 ) {
					$where_clause = sprintf( 'WHERE %s', implode( ' AND ', $where_array ) );
				} else {
					$where_clause = sprintf( 'WHERE %s', $where_array[0] );
				}
			} else {
				$where_clause = '';
			}
			$query = sprintf( "SELECT * FROM directory d %s %s ORDER BY username", $join_clause, $where_clause );
			$this->debug( $query );
			$res = $this->db->queryAll( $query );
			if ( FS_PDO::isError( $res ) ) {
				$this->comment( $query );
				$this->comment( $this->db->getMessage() );
				$this->comment( $this->db->getMessage() );
				$this->file_not_found();
			}
			if ( ! empty ( $this->user ) ) {
				$this->userid = $res[0]['id'];
				$this->comment( sprintf( 'user id is: %d', $this->userid ) );
			}

			return $res;
		}

		/**
		 * This method will pull the params for every user in a domain
		 * @return array of users' params
		 */
		private function get_users_params() {
			$where = '';
			if ( ! empty ( $this->userid ) ) {
				$where = sprintf( 'WHERE directory_id = %d', $this->userid );
			}
			$query = sprintf( "SELECT * FROM directory_params %s;", $where );
			$res   = $this->db->queryAll( $query );
			if ( FS_PDO::isError( $res ) ) {
				$this->comment( $query );
				$this->comment( $this->db->getMessage() );
				$this->file_not_found();
			}

			$record_count = count( $res );
			for ( $i = 0; $i < $record_count; $i ++ ) {
				$di                           = $res[$i]['directory_id'];
				$pn                           = $res[$i]['param_name'];
				$this->users_params[$di][$pn] = $res[$i]['param_value'];
			}
		}

		/**
		 * Writes XML for directory user's <params>
		 * This method will pull all of the user params based on the passed user_id
		 *
		 * @param integer $user_id
		 *
		 * @return void
		 */
		private function write_params( $user_id ) {
			if ( ! is_array( $this->users_params ) ) {
				return;
			}
			if ( array_key_exists( $user_id, $this->users_params ) && is_array( $this->users_params[$user_id] )
			     && count( $this->users_params[$user_id] ) > 0
			) {
				$this->xmlw->startElement( 'params' );
				foreach ( $this->users_params[$user_id] as $pname => $pvalue ) {
					$this->xmlw->startElement( 'param' );
					$this->xmlw->writeAttribute( 'name', $pname );
					$this->xmlw->writeAttribute( 'value', $pvalue );
					$this->xmlw->endElement();
				}
				$this->xmlw->endElement();
			}
		}

		/**
		 * Get all the users' variables
		 */
		private function get_users_vars() {
			$where = '';
			if ( ! empty ( $this->userid ) ) {
				$where = sprintf( 'WHERE directory_id = %d', $this->userid );
			}
			$query = sprintf( "SELECT * FROM directory_vars %s;", $where );
			$this->debug( $query );
			$res = $this->db->queryAll( $query );
			if ( FS_PDO::isError( $res ) ) {
				$this->comment( $this->db->getMessage() );
				$this->file_not_found();
			}

			$record_count = count( $res );
			for ( $i = 0; $i < $record_count; $i ++ ) {
				$di                         = $res[$i]['directory_id'];
				$vn                         = $res[$i]['var_name'];
				$this->users_vars[$di][$vn] = $res[$i]['var_value'];
			}
		}

		/**
		 * Write all the <variables> for a given user
		 *
		 * @param integer $user_id
		 *
		 * @return void
		 */
		private function write_variables( $user_id ) {
			if ( ! is_array( $this->users_vars ) ) {
				return;
			}
			if ( array_key_exists( $user_id, $this->users_vars ) && is_array( $this->users_vars[$user_id] ) ) {
				$this->xmlw->startElement( 'variables' );
				foreach ( $this->users_vars[$user_id] as $vname => $vvalue ) {
					$this->xmlw->startElement( 'variable' );
					$this->xmlw->writeAttribute( 'name', $vname );
					$this->xmlw->writeAttribute( 'value', $vvalue );
					$this->xmlw->endElement();
				}
				$this->xmlw->endElement();
			}
		}

		/**
		 * get the users' gateways
		 */
		private function get_users_gateways() {
			$where = '';
			if ( ! empty ( $this->userid ) ) {
				$where = sprintf( 'WHERE directory_id = %d', $this->userid );
			}
			$query = sprintf( "SELECT * FROM directory_gateways %s;", $where );
			$this->debug( $query );
			$res = $this->db->queryAll( $query );
			if ( FS_PDO::isError( $res ) ) {
				$this->comment( $this->db->getMessage() );
				$this->file_not_found();
			}
			$record_count = count( $res );
			for ( $i = 0; $i < $record_count; $i ++ ) {
				$di                          = $res[$i]['directory_id'];
				$this->users_gateways[$di][] = $res[$i];
			}
		}

		/**
		 * Write all of the XML for the user's <gateways>
		 * This method takes the id of the user from the directory table and pulls
		 * all of the user's gateways. It then calls write_single_gateway for
		 * each of them to write out all of the params
		 *
		 * @param integer $user_id
		 *
		 * @return void
		 */
		private function write_gateways( $user_id ) {
			if ( is_array( $this->users_gateways ) && array_key_exists( $user_id, $this->users_gateways )
			     && is_array( $this->users_gateways[$user_id] )
			) {
				$this->xmlw->startElement( 'gateways' );
				$gateway_count = count( $this->users_gateways[$user_id] );
				for ( $i = 0; $i < $gateway_count; $i ++ ) {
					$this->xmlw->startElement( 'gateway' );
					$this->xmlw->writeAttribute( 'name', $this->users_gateways[$user_id][$i]['gateway_name'] );

					$this->write_user_gateway_params( $this->users_gateways[$user_id][$i]['id'] );
					$this->xmlw->endElement();
				}
				$this->xmlw->endElement();
			}
		}

		/**
		 * get users' gateway params
		 */
		private function get_user_gateway_params() {
			$query = sprintf( "SELECT * FROM directory_gateway_params;" );
			$res   = $this->db->queryAll( $query );
			if ( FS_PDO::isError( $res ) ) {
				$this->comment( $this->db->getMessage() );
				$this->file_not_found();
			}
			$param_count = count( $res );
			for ( $i = 0; $i < $param_count; $i ++ ) {
				$dgwid                                      = $res[$i]['id'];
				$pname                                      = $res[$i]['param_name'];
				$pvalue                                     = $res[$i]['param_value'];
				$this->users_gateway_params[$dgwid][$pname] = $pvalue;
			}
		}

		/**
		 * Write out the <params> XML for each user-specific gateway
		 *
		 * @param integer $d_gw_id id from directory_gateways
		 *
		 * @return void
		 */
		private function write_user_gateway_params( $d_gw_id ) {
			if ( is_array( $this->users_gateway_params[$d_gw_id] )
			     && count( $this->users_gateway_params[$d_gw_id] ) > 0
			) {
				foreach ( $this->users_gateway_params[$d_gw_id] as $pname => $pvalue ) {
					$this->xmlw->startElement( 'param' );
					$this->xmlw->writeAttribute( 'name', $pname );
					$this->xmlw->writeAttribute( 'value', $pvalue );
					$this->xmlw->endElement();
				}
			}
		}

		/**
		 * This method will write out XML for global directory params
		 *
		 */
		function write_global_params( $domain ) {
			$query = sprintf( 'SELECT * FROM directory_global_params WHERE domain_id = %d', $domain['id'] );
			$res   = $this->db->queryAll( $query );
			if ( FS_PDO::isError( $res ) ) {
				$this->comment( $query );
				$error_msg = sprintf( "Error while selecting global params - %s", $this->db->getMessage() );
				trigger_error( $error_msg );
			}
			$param_count = count( $res );
			$this->xmlw->startElement( 'params' );
			for ( $i = 0; $i < $param_count; $i ++ ) {
				if ( empty ( $res[$i]['param_name'] ) ) {
					continue;
				}
				$this->xmlw->startElement( 'param' );
				$this->xmlw->writeAttribute( 'name', $res[$i]['param_name'] );
				$this->xmlw->writeAttribute( 'value', $res[$i]['param_value'] );
				$this->xmlw->endElement();
			}
			$this->xmlw->endElement();
		}

		/**
		 * This method will write out XML for global directory variables
		 *
		 */
		function write_global_vars( $domain ) {
			$query = sprintf( 'SELECT * FROM directory_global_vars WHERE domain_id = %d', $domain['id'] );
			$res   = $this->db->queryAll( $query );
			if ( FS_PDO::isError( $res ) ) {
				$this->comment( $query );
				$error_msg = sprintf( "Error while selecting global vars - %s", $this->db->getMessage() );
				trigger_error( $error_msg );
			}
			$param_count = count( $res );
			$this->xmlw->startElement( 'variables' );
			for ( $i = 0; $i < $param_count; $i ++ ) {
				if ( empty ( $res[$i]['var_name'] ) ) {
					continue;
				}
				$this->xmlw->startElement( 'variable' );
				$this->xmlw->writeAttribute( 'name', $res[$i]['var_name'] );
				$this->xmlw->writeAttribute( 'value', $res[$i]['var_value'] );
				$this->xmlw->endElement();
			}
			$this->xmlw->endElement();
		}

		function get_domains( $domain = NULL ) {
			$where = '';
			if ( $domain ) {
				$where = sprintf( "WHERE domain_name='%s'", $domain );
			}

			$query = "SELECT * FROM directory_domains $where;";
			$this->debug( $query );
			$res = $this->db->queryAll( $query );
			if ( FS_PDO::isError( $res ) ) {
				$this->comment( $query );
				$this->comment( $this->db->getMessage() );
				$this->comment( $this->db->getMessage() );
				$this->file_not_found();
			}

			return $res;
		}

		/**
		 * Write XML directory from the array returned by get_directory
		 * @see fs_directory::get_directory
		 *
		 * @param array $directory Multi-dimentional array from which we write the XML
		 *
		 * @return void
		 */
		private function writedirectory( $directory, $domain ) {
			$directory_count = count( $directory );

			$this->get_users_params();
			$this->get_users_vars();
			$this->get_users_gateways();

			$this->xmlw->startElement( 'domain' );
			$this->xmlw->writeAttribute( 'name', $domain['domain_name'] );
			$this->write_global_params( $domain );
			$this->write_global_vars( $domain );

			$this->xmlw->startElement( 'groups' );
			$this->xmlw->startElement( 'group' );
			if ( array_key_exists( 'group', $this->request ) ) {
				$this->xmlw->writeAttribute( 'name', $this->request['group'] );
			} else {
				$this->xmlw->writeAttribute( 'name', 'default' );
			}
			$this->xmlw->startElement( 'users' );
			for ( $i = 0; $i < $directory_count; $i ++ ) {
				$cacheable = 0;
				$username  = $directory[$i]['username'];
				$mailbox   = empty ( $directory[$i]['mailbox'] ) ? $username : $directory[$i]['mailbox'];
				$this->xmlw->startElement( 'user' );
				$this->xmlw->writeAttribute( 'id', $username );
				if ( array_key_exists( 'cache', $directory[$i] ) ) {
					$cacheable = $directory[$i]['cache'];
				}
				$this->xmlw->writeAttribute( 'cacheable', $cacheable );
				$this->xmlw->writeAttribute( 'mailbox', $mailbox );

				$this->write_params( $directory[$i]['id'] );
				$this->write_variables( $directory[$i]['id'] );
				$this->write_gateways( $directory[$i]['id'] );
				$this->xmlw->endElement();
			}
            $this->xmlw->endElement(); // </users>
			$this->xmlw->endElement(); // </group>
			$this->xmlw->endElement(); // </groups>
			$this->xmlw->endElement(); // </domain>
		}
	}

