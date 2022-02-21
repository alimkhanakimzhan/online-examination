<?php


Class _Db{
	private $user;
	private $pass;
	private $host;
	private $dbnm;
	private $cn;
	private $mysql_result;
	
	public function __construct()
	{
		$this->user = DB_USER;
		$this->pass = DB_PASS;
		$this->host = DB_HOST;
		$this->dbnm = DB_NAME;
		
	}

	public function connect(){
	//$dbConnection = mysql_pconnect( $myHostname, $myUsername, $myPassword  );
		$this->cn = mysql_connect( $this->host, $this->user, $this->pass ) or die('error connection');
		mysql_select_db ( $this->dbnm , $this->cn );
		//if ( !mysql_ping( $this->cn ) )
		//{
			//echo 'this';
		   //$this->cn = mysql_pconnect( $this->host, $this->user ) or die('error connection');
		   //mysql_select_db ( $this->dbname , $this->cn );
		//}

	}
	
	public function query( $str , $assoc_type = 'assoc' ){
		$this->connect();
		if( strpos(strtolower($str), 'select') === 0 ){
		
		$this->mysql_result = mysql_query( $str );
			if ( $this->mysql_result && mysql_error() == '' ){
					switch ( $assoc_type )
					{
						case 'assoc':
							while( $row= mysql_fetch_assoc( $this->mysql_result ) ) {
								$result[] =  $row;
							}
						break;
						
						case 'fetch_row':
							$result = mysql_fetch_row( $this->mysql_result );
						break;
					}
			}else{
				return mysql_error();
			}
		}else{
			mysql_query( $str );
		}
		if ( isset($result) ) return $result;
		
	}
	
	public function insert( $table, $values ) {
		$fields = implode(",", array_keys($values) );
		$val = implode("," , array_values($values) );
		//echo "INSERT INTO ".$table. "(".$fields.") VALUES (".$val .")";
		$this->query("INSERT INTO ".$table. "(".$fields.") VALUES (".$val .")");
	}
	/*
	public function update( $table, $values, $where = null ){
		for($fields = 0; $fields < count(array_keys($values)); $fields ++){
			$fields_val = isset( $fields_val ) ? $fields_val  . array_keys($values)[$fields] . '=' :   array_keys($values)[$fields] . '=';
			for($val = $fields; $val <= $fields; $val++){
				//$fields_val .= ( $val== count(array_keys($values)) - 1  ) ? array_values($values)[$val] : array_values($values)[$val] . ',';
			}
		}
		$this->query("UPDATE {$table} SET $fields_val {$where}");
	}
	*/
	public function delete( $table, $where = null ){
		$this->query("DELETE FROM {$table} {$where}");
	}

	public function fetch_all_rows( $sql, $assoc_type = 'assoc' ){
		return $this->query($sql, $assoc_type);
	}
}
?>